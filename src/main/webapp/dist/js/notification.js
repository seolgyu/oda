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
        url: window.contextPath + '/notification/loadAllNotiList',
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
        
        // 1. 프로필 처리 (그라데이션 또는 이미지)
        let profileHtml = "";
        if (dto.fromUserInfo && dto.fromUserInfo.profile_photo) {
            profileHtml = `<img src="${dto.fromUserInfo.profile_photo}" class="noti-avatar-img">`;
        } else {
            const nickname = dto.fromUserInfo ? dto.fromUserInfo.userNickname : 'U';
            const initial = nickname.charAt(0).toUpperCase();
            profileHtml = `
                <div class="noti-avatar-img d-flex align-items-center justify-content-center text-white fw-bold" 
                     style="background: linear-gradient(135deg, #6366f1, #a855f7); font-size: 1.5rem; border: none;">
                    ${initial}
                </div>`;
        }
        
        // 2. [수정됨] 아이콘 및 색상 분기 처리 로직 복구
        let iconName = "notifications";
        let iconColor = "text-info";
        
        if (dto.type === 'POST_LIKE') {
            iconName = "favorite";
            iconColor = "text-danger";
        } else if (dto.type === 'FOLLOW') {
            iconName = "person_add";
            iconColor = "text-primary";
        } else if (dto.type === 'COMMENT') {
            iconName = "chat_bubble";
            iconColor = "text-success";
        }

        const nickname = dto.fromUserInfo ? dto.fromUserInfo.userNickname : '알 수 없음';
        const quoteHtml = (dto.targetPost && dto.targetPost.title) 
                          ? `<div class="noti-post-quote text-truncate">"${dto.targetPost.title}"</div>` 
                          : '';

        // 3. 최종 HTML 조립
        html += `
            <div id="noti-${dto.notiId}"
                class="full-noti-item ${statusClass}"
                onclick="handleNotiPageClick(event, this, '${dto.notiId}', '${dto.type}', '${dto.targetPost ? dto.targetPost.postId : 0}')">

                <div class="noti-avatar-box">
                    ${profileHtml}
                    <div class="noti-type-icon-badge">
                        <span class="material-symbols-outlined ${iconColor}"
                            style="font-size: 16px; font-variation-settings: 'FILL' 1;">${iconName}</span>
                    </div>
                </div>

                <div class="noti-content-area">
                    <div class="noti-text">
                        <b>${nickname}</b>님이 ${dto.content}
                    </div>
                    ${quoteHtml}
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