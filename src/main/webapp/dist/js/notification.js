/**
 * ODA 알림 페이지 무한 스크롤 스크립트
 */
let notiPage = 1;
let isNotiLoading = false;
let hasNextNoti = true;

$(function() {
    // 1. Sentinel(감시자) 요소 감지 설정
    const sentinel = document.querySelector('#notiSentinel');
    
    const observer = new IntersectionObserver((entries) => {
        // Sentinel이 화면에 보이고, 로딩 중이 아니며, 다음 데이터가 있을 때만 실행
        if (entries[0].isIntersecting && !isNotiLoading && hasNextNoti) {
            loadMoreNoti();
        }
    }, { 
        root: document.querySelector('.feed-scroll-container'), // 스크롤 컨테이너 지정
        threshold: 0.1 
    });

    if (sentinel) observer.observe(sentinel);
});

// [핵심] 서버에서 추가 데이터를 받아오는 함수
function loadMoreNoti() {
    isNotiLoading = true;
    $('#notiLoader').show(); // 로딩 스피너 표시

    $.ajax({
        // 변수 없이 경로 직접 주입
        url: '/oda/notification/loadAllNotiList',
        type: 'POST',
        data: { page: notiPage + 1 }, // 다음 페이지 번호 전송
        dataType: 'json',
        success: function(data) {
            if (data.status === "success") {
                const list = data.list;
                
                if (list && list.length > 0) {
                    notiPage++; // 성공적으로 불러오면 페이지 번호 증가
                    appendNotiItems(list); // 리스트 그리기 함수 호출
                    
                    // 데이터가 10개 미만이면 다음 데이터가 없다고 판단
                    if (list.length < 10) hasNextNoti = false; 
                } else {
                    hasNextNoti = false;
                    $('#notiSentinel').hide();
                }
            }
            $('#notiLoader').hide();
            isNotiLoading = false;
        },
        error: function() {
            $('#notiLoader').hide();
            isNotiLoading = false;
        }
    });
}

// 데이터를 화면에 추가하는 함수
function appendNotiItems(list) {
    const $listContainer = $('#fullNotiList');
    let html = "";

    list.forEach(dto => {
        const isUnread = dto.checked === false || dto.checked === 0;
        const statusClass = isUnread ? 'unread' : 'read';
        
        let profileHtml = "";
        const fromUser = dto.fromUserInfo || { userNickname: 'U', profile_photo: null, userId: '' };
        
        if (fromUser.profile_photo) {
            profileHtml = `<img src="${fromUser.profile_photo}" data-user-id="${fromUser.userId}" class="noti-avatar-img app-user-trigger">`;
        } else {
            const initial = fromUser.userNickname.charAt(0).toUpperCase();
            profileHtml = `
                <div class="noti-avatar-img d-flex align-items-center justify-content-center text-white fw-bold app-user-trigger" 
                     data-user-id="${fromUser.userId}"
                     style="background: linear-gradient(135deg, #6366f1, #a855f7); font-size: 1.2rem; border: none;">
                    ${initial}
                </div>`;
        }
        
		let iconHtml = "";
		switch (dto.type) {
		    case 'POST_LIKE':
		        iconHtml = `<i class="fa-solid fa-heart" style="color: #f43f5e; font-size: 13px;"></i>`;
		        break;
		    case 'REPOST': // REPOST 분기 추가
		        iconHtml = `<i class="fa-solid fa-retweet" style="color: #10b981; font-size: 13px;"></i>`;
		        break;
		    case 'FOLLOW':
		        iconHtml = `<i class="fa-solid fa-user-plus" style="color: #6366f1; font-size: 11px;"></i>`;
		        break;
		    case 'COMMENT':
		        iconHtml = `<i class="fa-solid fa-comment-dots" style="color: #10b981; font-size: 11px;"></i>`;
		        break;
		    case 'REPLY':
		        iconHtml = `<i class="fa-solid fa-reply" style="color: #3b82f6; font-size: 11px;"></i>`;
		        break;
		    default:
		        iconHtml = `<i class="fa-solid fa-bell" style="color: #0ea5e9; font-size: 11px;"></i>`;
		}

        const commentPreviewHtml = (dto.type === 'COMMENT' || dto.type === 'REPLY') && dto.commentInfo && dto.commentInfo.content
            ? `<div class="noti-comment-preview mt-1" style="font-size: 0.8rem; color: #a8a8b3; font-style: italic; display: flex; gap: 4px; max-width: 100%;">
                <span style="flex-shrink: 0;">ㄴ</span>
                <span class="text-truncate" style="opacity: 0.9;">"${dto.commentInfo.content}"</span>
               </div>`
            : "";

        const postTitleHtml = dto.targetPost && dto.targetPost.title 
            ? `<div class="noti-post-quote text-truncate" style="font-size: 0.75rem; color: rgba(255, 255, 255, 0.35); margin-top: 4px;">
                <span style="font-size: 0.65rem; margin-right: 4px; border: 1px solid rgba(255,255,255,0.15); padding: 0px 3px; border-radius: 3px;">원문</span>
                ${dto.targetPost.title}
               </div>` 
            : "";

        html += `
            <div id="noti-${dto.notiId}"
                class="full-noti-item ${statusClass}"
                onclick="handleNotiPageClick(event, this, '${dto.notiId}', '${dto.type}', '${dto.targetPost ? dto.targetPost.postId : 0}', '${dto.commentInfo ? dto.commentInfo.commentId : 0}')">

                <div class="noti-avatar-box">
                    ${profileHtml}
                    <div class="noti-type-icon-badge" style="display: flex; align-items: center; justify-content: center;">
                        ${iconHtml}
                    </div>
                </div>

                <div class="noti-content-area">
                    <div class="noti-text">
                        <span class="noti-user-name" style="font-weight: bold;">${fromUser.userNickname}</span>님이 ${dto.content}
                    </div>
                    ${postTitleHtml}
                    ${commentPreviewHtml}
                    <div class="noti-time-text">${dto.createdDate}</div>
                </div>

                ${isUnread ? '<div class="unread-glow-dot"></div>' : ''}

                <button class="btn-delete-noti"
                    onclick="event.stopPropagation(); removeNotiPage('${dto.notiId}', this);">
                    <span class="material-symbols-outlined" style="font-size: 18px;">close</span>
                </button>
            </div>`;
    });

    $listContainer.append(html);
}