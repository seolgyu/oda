<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<style>
.notification-floating-layer {
    position: fixed;
    top: 75px;      /* 헤더(60px)에서 15px 정도 떨어뜨려 '떠 있는 느낌' 부여 */
    right: 20px;
    width: 480px;   
    background: rgba(25, 25, 25, 0.98);
    backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.12);
    
    /* [수정] 네 모서리 모두 둥글게 */
    border-radius: 16px !important; 
    
    z-index: 999;   /* 헤더보다 한 단계 낮게 */
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6);

    /* 애니메이션 초기 상태 (헤더 뒤쪽 위로 숨김) */
    opacity: 0;
    visibility: hidden;
    transform: translateY(-120%); 
    
    /* 사라질 때: 부드러운 슬라이딩 후 visibility 처리 */
    transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1), 
                opacity 0.3s ease, 
                visibility 0s linear 0.4s;
}

/* [나타날 때: 헤더 뒤에서 슥 내려옴] */
.notification-floating-layer.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0); 
    transition: transform 0.4s cubic-bezier(0.165, 0.84, 0.44, 1), 
                opacity 0.4s ease, 
                visibility 0s linear 0s;
}

/* 3. 알림 아이템 스타일 (위아래 패딩 py-2 급 조절) */
.noti-item { 
    border-bottom: 1px solid rgba(255, 255, 255, 0.05); 
    cursor: pointer; 
    transition: background 0.2s;
    position: relative;
    padding: 0.5rem 1rem !important; 
    will-change: transform, opacity;
}
.noti-item:last-child { border-bottom: none; } /* 마지막 아이템 선 제거 */
.noti-item:hover { background: rgba(255, 255, 255, 0.05); }
.noti-item.unread { background: rgba(99, 102, 241, 0.05); }

/* 알림 내부 프로필 원형 이미지 */
.noti-avatar-img {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    border: 1px solid rgba(255, 255, 255, 0.1);
    background-size: cover;
    background-position: center;
    flex-shrink: 0;
}

/* 안읽음 점 */
.unread-dot-indicator {
    width: 8px; height: 8px; background: #6366f1; border-radius: 50%; flex-shrink: 0;
}

/* 스크롤바 커스텀 */
.custom-scrollbar::-webkit-scrollbar { width: 4px; }
.custom-scrollbar::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.15); border-radius: 10px;
}

/* 알림 버튼을 감싸는 컨테이너 */
.noti-btn-wrapper {
    position: relative;
    display: inline-block;
    vertical-align: middle;
}

.noti-badge-circle {
    position: absolute;
    top: -2px;
    right: -4px;
    
    background-color: #FF3B30;
    color: #FFFFFF !important;
    
    font-size: 11px; /* 숫자가 잘 보이도록 살짝 키움 */
    font-weight: 600;
    line-height: 1;
    
    /* 유동적 너비 설정 */
    min-width: 16px;          /* 숫자 1개일 때의 최소 폭 */
    height: 16px;             /* 전체적인 높이를 살짝 줄여 슬림하게 */
    padding: 0 4px;           /* 좌우 여백 */
    
    /* 얇은 테두리 적용 */
    border: 1px solid #FFFFFF; /* 2px에서 1px로 변경 */
    border-radius: 10px;      /* 캡슐 모양 유지 */
    
    display: none;            /* 초기 상태 숨김 (JS에서 제어) */
    align-items: center;
    justify-content: center;
    
    box-sizing: border-box;
    z-index: 10;
    white-space: nowrap;      /* 숫자 줄바꿈 방지 */
    
    /* 그림자를 살짝 주면 테두리가 얇아도 배경과 잘 분리됩니다 */
    box-shadow: 0 1px 2px rgba(0,0,0,0.2);
}

/* 배지 컨테이너 (기존 디자인 유지) */
.noti-type-badge {
    position: absolute;
    bottom: -3px;
    right: -3px;
    z-index: 5;
    
    width: 22px;
    height: 22px;
    background: #191919; 
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1.5px solid #191919; 
    box-shadow: 0 2px 4px rgba(0,0,0,0.5);
}

/* 폰트어썸 아이콘 전용 스타일 */
.noti-type-badge i {
    font-size: 11px !important; /* 폰트어썸은 작아도 존재감이 확실합니다 */
    display: flex;
    align-items: center;
    justify-content: center;
    line-height: 1;
}

/* [추가] 회원가입 버튼 동적 디자인 */
/* 1. 공통 뼈대 (수치 강제 고정) */
.btn-login-sync, 
.btn-signup-dynamic {
    all: unset;
    box-sizing: border-box;
    height: 36px !important;
    padding: 0 25px !important;
    font-family: 'Pretendard', sans-serif !important;
    font-size: 0.95rem !important;
    font-weight: 800 !important;
    letter-spacing: -0.02em !important;
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
    border-radius: 100px !important;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    z-index: 1;
    transition: all 0.4s ease !important; /* 크기 변화(scale) 없음 */
}

/* 2. 로그인 버튼: [기본: 진짜 보라색] -> [호버: 반투명 다크(회원가입 기본형)] */
.btn-login-sync {
    background-color: #7C3AED !important; /* 진짜 보라색 */
    border: 1px solid transparent !important;
    color: #ffffff !important;
    min-width: 100px;
}

.btn-login-sync:hover {
    background-color: rgba(255, 255, 255, 0.08) !important; /* 회원가입 평소 배경 */
    border: 1px solid rgba(255, 255, 255, 0.2) !important;  /* 회원가입 평소 테두리 */
    color: #ffffff !important;
}

/* 3. 회원가입 버튼: [기본: 반투명 다크] -> [호버: 확장 및 그라데이션] */
.btn-signup-dynamic {
    background-color: rgba(255, 255, 255, 0.08) !important;
    border: 1px solid rgba(255, 255, 255, 0.2) !important;
    color: #fff !important;
    min-width: 115px;
}

.btn-signup-dynamic:hover {
    min-width: 280px; 
    border-color: rgba(139, 92, 246, 0.6) !important;
    box-shadow: 0 0 25px rgba(124, 58, 237, 0.4);
}

/* --- [중요] 애니메이션 필수 구조 --- */

/* 슬롯머신 텍스트 래퍼 */
.btn-text-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    height: 100%;
    transition: transform 0.6s cubic-bezier(0.6, -0.2, 0.2, 1.2) !important;
}

.btn-text-wrapper span {
    display: block;
    height: 36px;
    line-height: 34px !important;
    white-space: nowrap;
    text-align: center;
    width: 100%;
}

/* 위쪽 대기 중인 영문 문구 */
.text-hover {
    position: absolute;
    bottom: 100%; /* 부모 래퍼 기준으로 위로 100% 밀어냄 */
    left: 0;
    right: 0;
    opacity: 0;
    font-size: 0.95rem;
}

/* 호버 시 래퍼 전체를 아래로 36px 이동 (슬롯머신 효과) */
.btn-signup-dynamic:hover .btn-text-wrapper {
    transform: translateY(36px); /* 버튼 높이만큼 정확히 아래로 */
}

.btn-signup-dynamic:hover .text-hover {
    opacity: 1;
}

.btn-signup-dynamic:hover .text-default {
    opacity: 0;
}

/* 화려한 성운 그라데이션 배경 */
.btn-signup-dynamic::before {
    content: '';
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    background: linear-gradient(90deg, #7C3AED, #A855F7, #EC4899, #7C3AED);
    background-size: 200% auto; /* 200%로 설정하여 이동 공간 확보 */
    z-index: -1;
    opacity: 0;
    transition: opacity 0.4s;
}

.btn-signup-dynamic:hover::before {
    opacity: 1;
    animation: cosmicFlow 2.2s linear infinite;
}

@keyframes cosmicFlow {
    0% { background-position: 0% center; }
    100% { background-position: 200% center; }
}
</style>
<header class="app-header">
	<a href="${pageContext.request.contextPath}/" class="brand-logo">ODA</a>

	<div class="search-container-center">
		<input type="text" id="totalSearchInput" class="search-bar"
			placeholder="Search ODA..."
			onkeyup="if(window.event.keyCode==13){searchOda()}">

		<button type="button" onclick="searchOda()"
			class="btn btn-link p-0 position-absolute end-0 top-50 translate-middle-y pe-3 text-white-50 text-decoration-none">
			<span class="material-symbols-outlined" style="font-size: 20px;">search</span>
		</button>
	</div>

	<div class="d-flex align-items-center gap-2">
		<c:if test="${not empty sessionScope.member}">
			<button class="btn btn-custom-outline btn-sm d-none d-lg-block"
				onclick="location.href='${pageContext.request.contextPath}/post/write';">
				<span class="material-symbols-outlined align-middle"
					style="font-size: 1.0rem; margin-right: 2px;">edit</span> 글쓰기
			</button>
		</c:if>

		<c:choose>
			<c:when test="${empty sessionScope.member}">
				<button class="btn btn-signup-dynamic d-none d-lg-block me-1"
					onclick="location.href='${pageContext.request.contextPath}/member/signup';">
					<div class="btn-text-wrapper">
						<span class="text-hover">EXPLORE ODA COMMUNITY 🚀</span> <span
							class="text-default">회원가입</span>
					</div>
				</button>
				<button
					class="btn btn-custom-primary btn-login-sync btn-sm d-none d-lg-block"
					onclick="location.href='${pageContext.request.contextPath}/member/login'">
					로그인</button>
			</c:when>
			<c:otherwise>
				<button class="btn btn-custom-primary btn-sm d-none d-lg-block"
					onclick="location.href='${pageContext.request.contextPath}/member/logout';">로그아웃</button>
			</c:otherwise>
		</c:choose>

		<c:if test="${not empty sessionScope.member}">
			<div class="vr mx-2 text-secondary" style="height: 24px;"></div>
			
			<div class="noti-btn-wrapper">
	    		<button class="btn-icon" title="알림" onclick="toggleNoti(event)">
	        		<span class="material-symbols-outlined">notifications</span>
	        
	        		<span id="noti-badge" class="noti-badge-circle">0</span>
	    		</button>
			</div>
		</c:if>

		<c:if test="${not empty sessionScope.member}">
			<div class="dropdown">
				<button class="btn-icon p-0 border-0 ms-1" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">
					<div
						class="avatar-img d-flex align-items-center justify-content-center text-white small fw-bold"
						style="width: 32px; height: 32px; border-radius: 50%; overflow: hidden; position: relative; background: #6366f1; border: 1px solid rgba(255, 255, 255, 0.2);">
						<c:choose>
							<c:when test="${not empty sessionScope.member.avatar}">
								<img src="${sessionScope.member.avatar}"
									class="w-100 h-100 object-fit-cover" alt="Profile">
							</c:when>
							<c:otherwise>
                				${fn:substring(sessionScope.member.userName, 0, 1)}
            				</c:otherwise>
						</c:choose>
					</div>
				</button>
				<ul
					class="dropdown-menu dropdown-menu-end dropdown-menu-dark shadow-lg mt-2">
					<li><h6 class="dropdown-header">내 계정</h6></li>
					<li><hr class="dropdown-divider border-secondary opacity-25"></li>
					<li><a class="dropdown-item d-flex align-items-center gap-2"
						href="${pageContext.request.contextPath}/member/page?id=${sessionScope.member.userId}"><span
							class="material-symbols-outlined fs-6">person</span> 내 피드</a></li>
					<li><a class="dropdown-item d-flex align-items-center gap-2"
						href="${pageContext.request.contextPath}/member/settings"><span
						 class="material-symbols-outlined fs-6">settings</span> 설정</a></li>
				</ul>
			</div>
		</c:if>
	</div>

	<div id="notificationLayer" class="notification-floating-layer">
		<div
			class="noti-header p-3 d-flex justify-content-between align-items-center border-bottom border-white border-opacity-10">
			<h6 class="text-white fw-bold mb-0">Notifications</h6>
			<span class="text-xs opacity-50 cursor-pointer hover-white"
				onclick="closeNoti()">닫기</span>
		</div>

		<div class="noti-list custom-scrollbar" id="notiListContainer" style="max-height: 420px; overflow-y: auto;">
    	</div>

		<div class="noti-footer py-1 px-2 text-center border-top border-white border-opacity-10">
			<button type="button"
				class="btn btn-link text-xs text-decoration-none text-secondary hover-white"
				onclick="location.href='${pageContext.request.contextPath}/notification';">
				모든 알림 보기</button>
		</div>
	</div>
</header>

<div id="toastContainer"
	class="toast-container position-fixed bottom-0 end-0 p-3"
	style="z-index: 9999;"></div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

$(function() {
	if (${not empty sessionScope.member}) {
        updateUnreadCount();
    }
});

function updateUnreadCount() {
    $.ajax({
        url: '${pageContext.request.contextPath}/notification/loadNotiCount',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
            if (data.status === "success") {
                const count = data.count;
                const $badge = $('#noti-badge');
                const $sidebarDot = $('#sidebar-noti-dot');

                if (count > 0) {
                    $badge.text(count > 99 ? '99+' : count);
                    $badge.css('display', 'flex');
                    $sidebarDot.show();
                } else {
                    $badge.hide();
                    $sidebarDot.hide();
                }
            }
        }
    });
}

function searchOda() {
	// 1. 입력값 가져오기
	const input = document.getElementById("totalSearchInput");
	const keyword = input.value.trim(); // 공백 제거

	// 2. 유효성 검사 (공백이면 알림)
	if (!keyword) {
		alert("검색어를 입력해주세요.");
		input.focus();
		return;
	}

	// 3. 메인 페이지로 키워드와 함께 이동
	// (PostController와 main.jsp가 이 'keyword' 파라미터를 받아서 처리합니다)
	location.href = "${pageContext.request.contextPath}/main?keyword="
			+ encodeURIComponent(keyword);
}

function showToast(type, msg) {
	const container = document.getElementById('toastContainer');
	const toastId = 'toast-' + Date.now();

	let title = 'SYSTEM', icon = 'info', color = '#8B5CF6';
	if (type === "success") { title = 'SUCCESS'; icon = 'check_circle'; color = '#4ade80'; }
	else if (type === "error") { title = 'ERROR'; icon = 'error'; color = '#f87171'; }

	const toastHtml = `
			<div id="\${toastId}" class="glass-toast \${type}">
	            <div class="d-flex align-items-center gap-3">
	                <div class="toast-icon-circle">
	                    <span class="material-symbols-outlined fs-5">\${icon}</span>
	                </div>
	                <div class="toast-content">
	                    <h4 class="text-xs fw-bold text-uppercase tracking-widest mb-1" style="color: ${color}">\${title}</h4>
	                    <p class="text-sm text-gray-300 mb-0">\${msg}</p>
	                </div>
	            </div>
	        </div>`;

	const $newToast = $(toastHtml);
	$(container).append($newToast);

	setTimeout(() => $newToast.addClass('show'), 50);

	setTimeout(() => {
		$newToast.removeClass('show');

		setTimeout(() => {
			$newToast.animate({
				height: 0,
				marginTop: 0,
				marginBottom: 0,
				paddingTop: 0,
				paddingBottom: 0,
				opacity: 0
			}, {
				duration: 350,
				easing: "swing",
				complete: function() {
					$(this).remove();
				}
			});
		}, 400);
	}, 2500);
}

document.addEventListener('click', function(e) {
    const target = e.target.closest('.app-user-trigger'); 
    
    if (target) {
        const userId = target.dataset.userId;
        
        if (userId) {
            location.href = `${pageContext.request.contextPath}/member/page?id=` + userId;
        }
    }
});

// 알림 버튼 클릭 이벤트 (기존 버튼에 onclick="toggleNoti(event)" 추가)
function toggleNoti(e) {
    if (e) e.stopPropagation();
    const layer = document.getElementById('notificationLayer');
    
    if (!layer.classList.contains('show')) {
        loadNotiList();
    }
    
    layer.classList.toggle('show');
}

function closeNoti() {
  		document.getElementById('notificationLayer').classList.remove('show');
}

// 바깥 영역 클릭 시 닫기 로직 유지
document.addEventListener('click', function(e) {
  		const layer = document.getElementById('notificationLayer');
  		const btn = document.querySelector('[title="알림"]');
  
  		if (layer && layer.classList.contains('show')) {
      		if (!layer.contains(e.target) && !btn.contains(e.target)) {
          		closeNoti();
      		}
  		}
});

function loadNotiList() {
	const listBody = document.querySelector('.noti-list');
    
    listBody.innerHTML = `
        <div class="d-flex justify-content-center align-items-center p-5">
            <div class="spinner-border text-light opacity-50" role="status" style="width: 1.5rem; height: 1.5rem;">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>`;

    $.ajax({
        url: '${pageContext.request.contextPath}/notification/loadNotiList',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
            if (data.status === "success") {
                renderNotiList(data.list);
            }
        }
    });
}

function renderNotiList(list) {
    const $container = $('.noti-list'); // 사용하시는 클래스명에 맞춰 선택
    let html = "";

    if (!list || list.length === 0) {
        html = '<div class="text-center p-5 opacity-50 text-white text-sm">새로운 알림이 없습니다.</div>';
        $container.html(html);
        return;
    }

    list.forEach(item => {
        const isUnread = item.checked === 0;
        const unreadClass = isUnread ? 'unread' : '';
        const dot = isUnread ? '<div class="unread-dot-indicator"></div>' : '';
        
        let faIconClass = "";
        let typeColor = "";
        let extraStyle = ""; // 아이콘별 맞춤 스타일

        switch(item.type) {
            case 'POST_LIKE':
                faIconClass = "fa-heart";
                typeColor = "#f43f5e";
                extraStyle = "font-size: 13px !important; transform: translateY(1.5px);";
                break;
            case 'REPOST':
                faIconClass = "fa-retweet";
                typeColor = "#10b981";
                extraStyle = "font-size: 13px !important; transform: translateY(1px);";
                break;
            case 'FOLLOW':
                faIconClass = "fa-user-plus";
                typeColor = "#6366f1";
                extraStyle = "font-size: 11px !important;"; 
                break;
            case 'COMMENT':
                faIconClass = "fa-comment-dots";
                typeColor = "#10b981";
                extraStyle = "font-size: 11px !important;";
                break;
            case 'REPLY':
                faIconClass = "fa-reply";
                typeColor = "#3b82f6";
                extraStyle = "font-size: 11px !important;";
                break;
        }

        const typeBadgeHtml = `
            <div class="noti-type-badge">
                <i class="fa-solid \${faIconClass}" style="color: \${typeColor}; \${extraStyle}"></i>
            </div>`;
        
        const initial = item.fromUserInfo.userNickname ? item.fromUserInfo.userNickname.charAt(0).toUpperCase() : '';

        const profileHtml = item.fromUserInfo.profile_photo
            ? `<img src="\${item.fromUserInfo.profile_photo}" alt="Profile" class="w-100 h-100 object-fit-cover rounded-circle">`
            : `<div class="w-100 h-100 d-flex align-items-center justify-content-center text-white fw-bold rounded-circle" 
                    style="background: linear-gradient(135deg, #6366f1, #a855f7); font-size: 1.1rem;">
                   ${initial}
               </div>`;
               
        const commentPreviewHtml = (item.type === 'COMMENT' || item.type === 'REPLY') && item.commentInfo && item.commentInfo.content
            ? `<div class="text-xs mt-1" style="max-width: 350px; color: #a8a8b3; display: flex; gap: 4px;">
                    <span style="flex-shrink: 0;">ㄴ</span>
                    <span class="text-truncate" style="opacity: 0.9;">"\${item.commentInfo.content}"</span>
               </div>`
            : "";
               
        const postTitleHtml = item.targetPost && item.targetPost.title 
            ? `<div class="text-xs text-truncate mt-1" style="max-width: 350px; color: rgba(255, 255, 255, 0.35);">
                    <span style="font-size: 0.7rem; margin-right: 4px; border: 1px solid rgba(255,255,255,0.15); padding: 0px 3px; border-radius: 3px;">원문</span>
                    \${item.targetPost.title}
               </div>` 
            : "";

        html += `
        	<div class="noti-item \${unreadClass} d-flex align-items-start gap-3 py-3 px-3" 
            	onclick="handleNotiClick(event, this, \${item.notiId}, '\${item.type}', '\${item.targetPost ? item.targetPost.postId : 0}', '\${item.commentInfo ? item.commentInfo.commentId : 0}')" 
            	style="cursor:pointer; transition: all 0.4s ease;">
                <div class="noti-avatar-wrapper flex-shrink-0 app-user-trigger" data-user-id="\${item.fromUserInfo.userId}" style="width: 44px; height: 44px; position: relative;">
                    \${profileHtml}
                    \${typeBadgeHtml}
                </div>
                <div class="noti-info flex-grow-1 min-w-0">
                <div class="mb-1 text-white text-sm text-wrap d-flex align-items-baseline gap-1">
                	<span class="fw-bold flex-shrink-0 app-user-trigger" data-user-id="\${item.fromUserInfo.userId}" style="color: #efefff;">
                		\${item.fromUserInfo.userNickname}
            		</span>
            		<span class="opacity-75">
                		\${item.content}
            		</span>
                </div>
                \${postTitleHtml}
                \${commentPreviewHtml}
                <div>
                	<span class="text-xs text-secondary opacity-50">\${item.createdDate}</span>
            	</div>
            </div>
                \${dot}
            </div>`;
    });

    $container.html(html);
}

function handleNotiClick(e, element, notiId, type, postId, targetId) {
	
	if ($(e.target).closest('.app-user-trigger').length > 0) return;
	const $el = $(element);
	
    $.ajax({
        url: '${pageContext.request.contextPath}/notification/readNoti',
        type: 'POST',
        data: { notiId: notiId },
        success: function() {
            if (type === 'POST_LIKE' || type === 'FOLLOW') {
            	const currentHeight = $el.outerHeight();
                $el.css({
                    'height': currentHeight + 'px',
                    'max-height': currentHeight + 'px',
                    'transition': 'all 0.5s cubic-bezier(0.4, 0, 0.2, 1)',
                    'overflow': 'hidden'
                });

                requestAnimationFrame(() => {
                    $el.css({
                        'opacity': '0',
                        'max-height': '0',
                        'margin-top': '0',
                        'margin-bottom': '0',
                        'padding-top': '0',
                        'padding-bottom': '0',
                        'transform': 'scale(0.95)' // 살짝 작아지며 사라지는 효과 추가
                    });
                });

                $el.one('transitionend', function() {
                    $(this).remove();
                    updateUnreadCount();
                    
                    if ($('.noti-list .noti-item').length === 0) {
                        $('.noti-list').html('<div class="text-center p-5 opacity-50 text-white text-sm">새로운 알림이 없습니다.</div>');
                    }
                });
            } else {
            	location.href = '${pageContext.request.contextPath}/post/article?postId=' + postId + '&commentId=' + targetId;
            }
        },
        error: function() {
            if (type !== 'POST_LIKE' || type !== 'FOLLOW') {
            	location.href = '${pageContext.request.contextPath}/post/article?postId=' + postId + '&commentId=' + targetId;
            }
        }
    });
}
</script>