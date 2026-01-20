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
    width: 380px;   
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
				<button class="btn btn-custom-outline btn-sm d-none d-lg-block"
					onclick="location.href='${pageContext.request.contextPath}/member/signup';">회원가입</button>
				<button class="btn btn-custom-primary btn-sm d-none d-lg-block"
					onclick="location.href='${pageContext.request.contextPath}/member/login'">로그인</button>
			</c:when>
			<c:otherwise>
				<button class="btn btn-custom-primary btn-sm d-none d-lg-block"
					onclick="location.href='${pageContext.request.contextPath}/member/logout';">로그아웃</button>
			</c:otherwise>
		</c:choose>

		<div class="vr mx-2 text-secondary" style="height: 24px;"></div>

		<button class="btn-icon" title="게시물 작성">
			<span class="material-symbols-outlined">add</span>
		</button>
		<button class="btn-icon" title="알림" onclick="toggleNoti(event)">
			<span class="material-symbols-outlined">notifications</span>
		</button>

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
					<li><a class="dropdown-item d-flex align-items-center gap-2"
						href="${pageContext.request.contextPath}/member/page?id=${sessionScope.member.userId}"><span
							class="material-symbols-outlined fs-6">person</span> 내 피드</a></li>
					<li><a class="dropdown-item d-flex align-items-center gap-2"
						href="#"><span class="material-symbols-outlined fs-6">favorite</span>
							좋아요 누른 게시물</a></li>
					<li><hr class="dropdown-divider border-secondary opacity-25"></li>
					<li><a class="dropdown-item d-flex align-items-center gap-2"
						href="#"><span class="material-symbols-outlined fs-6">settings</span>
							설정</a></li>
					<li><a
						class="dropdown-item d-flex align-items-center gap-2 text-danger"
						href="#"><span class="material-symbols-outlined fs-6">logout</span>
							로그아웃</a></li>
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

		<div class="noti-list custom-scrollbar"
			style="max-height: 420px; overflow-y: auto;">

			<div class="noti-item unread d-flex align-items-center gap-3 py-2 px-3">
				<div class="noti-avatar-wrapper flex-shrink-0">
					<div class="rounded-circle border border-white border-opacity-10"
						style="width: 44px; height: 44px; background-image: url('https://i.pravatar.cc/150?u=1'); background-size: cover; background-position: center;">
					</div>
				</div>

				<div class="noti-info flex-grow-1 min-w-0">
					<p class="mb-1 text-white text-sm text-wrap">
						<strong>Cosmos_Walker</strong>님이 회원님을 팔로우하기 시작했습니다.
					</p>
					<span class="text-xs text-secondary opacity-50">5분 전</span>
				</div>
				<div class="unread-dot-indicator"></div>
			</div>

			<div class="noti-item d-flex align-items-center gap-3 py-2 px-3">
				<div class="noti-avatar-wrapper flex-shrink-0">
					<div class="rounded-circle border border-white border-opacity-10"
						style="width: 44px; height: 44px; background-image: url('https://i.pravatar.cc/150?u=2'); background-size: cover; background-position: center;">
					</div>
				</div>
				<div class="noti-info flex-grow-1 min-w-0">
					<p class="mb-1 text-white text-sm text-wrap">
						<strong>Nebula_Hunter</strong>님이 회원님의 게시글을 좋아합니다.
					</p>
					<span class="text-xs text-secondary opacity-50">1시간 전</span>
				</div>
			</div>

		</div>

		<div class="noti-footer py-1 px-2 text-center border-top border-white border-opacity-10">
    		<button class="btn btn-link text-xs text-decoration-none text-secondary hover-white">
        		전체 알림 보기
    		</button>
		</div>
	</div>
</header>

<div id="toastContainer"
	class="toast-container position-fixed bottom-0 end-0 p-3"
	style="z-index: 9999;"></div>

<script>
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
    
    // show 클래스가 있으면 제거(위로 슬라이딩), 없으면 추가(아래로 슬라이딩)
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
	</script>