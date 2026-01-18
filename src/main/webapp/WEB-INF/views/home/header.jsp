<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
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
		<button class="btn-icon" title="알림">
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
	</script>