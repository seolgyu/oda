<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	window.cp = '${pageContext.request.contextPath}';
	window.isLogin = "${not empty sessionScope.member}";
</script>
<style type="text/css">

.setting-nav-item {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 10px 15px;
	border-radius: 0.75rem;
	color: rgba(255, 255, 255, 0.6);
	text-decoration: none;
	transition: all 0.2s ease;
	font-size: 0.9rem;
	font-weight: 500;
}

.setting-nav-item:hover {
	background: rgba(255, 255, 255, 0.05);
	color: white;
}

/* 활성화된 메뉴 스타일 */
.active-setting-tab {
	background: rgba(99, 102, 241, 0.15);
	color: #818cf8;
	box-shadow: inset 0 0 0 1px rgba(99, 102, 241, 0.2);
}

.setting-nav-item span.material-symbols-outlined {
	font-size: 20px;
}

/* 설정 페이지용 입력창 스타일 (기존 login-input 활용) */
.login-input {
	background: rgba(255, 255, 255, 0.05) !important;
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	color: white !important;
}

.login-input:focus {
	background: rgba(255, 255, 255, 0.08) !important;
	border-color: #6366f1 !important;
	box-shadow: 0 0 0 0.25 dark-blue !important;
}

/* 드롭다운 화살표 회전 */
.dropdown-trigger.active .dropdown-arrow {
	transform: rotate(180deg);
}

/* 서브 메뉴 컨테이너: 왼쪽 간격을 본체 메뉴 아이콘 라인에 맞춤 */
.dropdown-container {
	margin-top: 2px;
	margin-bottom: 5px;
	/* 선을 없애거나 아주 흐리게 하여 왼쪽 여백 확보 */
	border-left: 1px solid rgba(255, 255, 255, 0.05);
	margin-left: 20px;
}

/* 서브 메뉴 아이템: 텍스트가 너무 치우치지 않게 패딩 최소화 */
.dropdown-container .setting-nav-item {
	padding-left: 12px !important;
	gap: 10px !important; /* 아이콘과 텍스트 간격 */
	color: rgba(255, 255, 255, 0.5);
}

.dropdown-container .setting-nav-item:hover {
	background: rgba(255, 255, 255, 0.03);
	color: #818cf8;
}
</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/home/header.jsp"%>

	<div class="app-body">

		<%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

		<main class="app-main">
			<div class="space-background">
				<div class="stars"></div>
				<div class="stars2"></div>
				<div class="stars3"></div>
				<div class="planet planet-1"></div>
				<div class="planet planet-2"></div>
			</div>

			<div class="feed-scroll-container custom-scrollbar">
				<div class="d-flex justify-content-center py-4 pb-0 px-3">
					<div class="d-flex gap-4 w-100" style="max-width: 1100px;">

						<aside class="d-flex flex-column gap-3"
							style="width: 280px; flex-shrink: 0;">
							<div class="glass-card p-3 shadow-lg">
								<h3
									class="text-white text-xs fw-bold text-uppercase tracking-widest mb-4 px-2 opacity-75">User
									Settings</h3>

								<nav class="d-flex flex-column gap-1">
									<a href="#" class="setting-nav-item active-setting-tab"
										data-url="${pageContext.request.contextPath}/member/settings/profile">
										<span class="material-symbols-outlined">person</span> <span>Profile
											Interface</span>
									</a> <a href="#" class="setting-nav-item"
										data-url="${pageContext.request.contextPath}/member/settings/account">
										<span class="material-symbols-outlined">account_circle</span>
										<span>Account Info</span>
									</a>

									<div class="setting-nav-dropdown">
										<button
											class="setting-nav-item w-100 border-0 bg-transparent dropdown-trigger"
											type="button" style="display: flex; align-items: center;">
											<span class="material-symbols-outlined">analytics</span> <span
												class="flex-grow-1 text-start">My Activity</span> <span
												class="material-symbols-outlined dropdown-arrow"
												style="font-size: 1.2rem; transition: transform 0.3s;">expand_more</span>
										</button>

										<div class="dropdown-container"
											style="display: none; padding-left: 15px; flex-direction: column; gap: 2px;">
											<a href="#" class="setting-nav-item py-2"
												data-url="${pageContext.request.contextPath}/member/settings/follow"
												style="font-size: 0.85rem;"> <span
												class="material-symbols-outlined" style="font-size: 18px;">group</span>
												팔로우
											</a> <a href="#" class="setting-nav-item py-2"
												data-url="${pageContext.request.contextPath}/member/settings/like"
												style="font-size: 0.85rem;"> <span
												class="material-symbols-outlined" style="font-size: 18px;">favorite</span>
												좋아요
											</a> <a href="#" class="setting-nav-item py-2"
												data-url="${pageContext.request.contextPath}/member/settings/saved"
												style="font-size: 0.85rem;"> <span
												class="material-symbols-outlined" style="font-size: 18px;">bookmark</span>
												저장
											</a> <a href="#" class="setting-nav-item py-2"
												data-url="${pageContext.request.contextPath}/member/settings/comments"
												style="font-size: 0.85rem;"> <span
												class="material-symbols-outlined" style="font-size: 18px;">forum</span>
												댓글
											</a>
										</div>
									</div>

									<div class="setting-nav-dropdown">
										<button
											class="setting-nav-item w-100 border-0 bg-transparent dropdown-trigger"
											type="button" style="display: flex; align-items: center;">
											<span class="material-symbols-outlined">security</span> <span
												class="flex-grow-1 text-start">Privacy & Security</span> <span
												class="material-symbols-outlined dropdown-arrow"
												style="font-size: 1.2rem; transition: transform 0.3s;">expand_more</span>
										</button>

										<div class="dropdown-container"
											style="display: none; padding-left: 15px; flex-direction: column; gap: 2px;">
											<a href="#" class="setting-nav-item py-2"
												data-url="${pageContext.request.contextPath}/member/settings/privacyScope"
												style="font-size: 0.85rem;"> <span
												class="material-symbols-outlined" style="font-size: 18px;">visibility</span>
												공개 범위 설정
											</a> <a href="#" class="setting-nav-item py-2"
												data-url="${pageContext.request.contextPath}/member/settings/pwdChange"
												style="font-size: 0.85rem;"> <span
												class="material-symbols-outlined" style="font-size: 18px;">lock_reset</span>
												비밀번호 변경
											</a>
										</div>
									</div>

									<a href="#" class="setting-nav-item"
									   data-url="${pageContext.request.contextPath}/member/settings/notification"> <span
										class="material-symbols-outlined">notifications_active</span>
										<span>Notifications</span>
									</a>

									<div class="border-top border-white border-opacity-10 my-2"></div>

									<a href="#" class="setting-nav-item text-danger opacity-75">
										<span class="material-symbols-outlined">logout</span> <span>Sign
											Out</span>
									</a>
								</nav>
							</div>

							<div class="glass-card p-4 shadow-sm border-0"
								style="background: rgba(99, 102, 241, 0.1);">
								<p class="text-white text-xs fw-bold mb-2">Need help?</p>
								<p class="text-secondary text-xs mb-0">Check our FAQ or
									contact support for advanced issues.</p>
							</div>
						</aside>

						<section class="flex-grow-1 d-flex flex-column gap-4"
							id="settings-content" style="min-width: 0;">
							<jsp:include page="setting/settings_profile.jsp" />
						</section>

					</div>
				</div>
			</div>
		</main>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/settings.js"></script>	
	<script src="${pageContext.request.contextPath}/dist/js/follow.js"></script>	
</body>
</html>