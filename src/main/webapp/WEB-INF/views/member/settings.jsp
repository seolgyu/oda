<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>

<style type="text/css">
/* 설정 메뉴 아이템 기본 스타일 */
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
				<div class="d-flex justify-content-center py-4 px-3">
					<div class="d-flex gap-4 w-100" style="max-width: 1100px;">

						<aside class="d-flex flex-column gap-3"
							style="width: 280px; flex-shrink: 0;">
							<div class="glass-card p-3 shadow-lg">
								<h3
									class="text-white text-xs fw-bold text-uppercase tracking-widest mb-4 px-2 opacity-75">User
									Settings</h3>

								<nav class="d-flex flex-column gap-1">
									<a href="#" class="setting-nav-item active-setting-tab"> <span
										class="material-symbols-outlined">person</span> <span>Profile
											Interface</span>
									</a> <a href="#" class="setting-nav-item"> <span
										class="material-symbols-outlined">account_circle</span> <span>Account
											Info</span>
									</a> <a href="#" class="setting-nav-item"> <span
										class="material-symbols-outlined">security</span> <span>Privacy
											& Security</span>
									</a> <a href="#" class="setting-nav-item"> <span
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
							style="min-width: 0;">
							<div class="glass-card p-4 shadow-lg">
								<div
									class="mb-4 border-bottom border-white border-opacity-10 pb-3">
									<h2 class="text-white fs-4 fw-bold mb-1">Profile Interface</h2>
									<p class="text-secondary text-sm mb-0">Manage how your
										profile looks to other stargazers.</p>
								</div>

								<div class="d-flex flex-column gap-4">
									<div class="d-flex align-items-center gap-4">
										<div
											class="rounded-4 shadow-lg d-flex align-items-center justify-content-center text-white fw-bold fs-2"
											style="width: 100px; height: 100px; background: linear-gradient(135deg, #6366f1, #a855f7);">
											${fn:substring(user.userName, 0, 1)}</div>
										<div>
											<button
												class="btn btn-sm btn-outline-light rounded-pill px-3 mb-2">Change
												Photo</button>
											<p class="text-xs text-gray-500 mb-0">JPG, GIF or PNG.
												Max size of 800K</p>
										</div>
									</div>

									<div class="row g-3">
										<div class="col-md-6">
											<label class="text-white text-xs fw-bold mb-2 d-block">Display
												Name</label> <input type="text" class="form-control login-input"
												value="${user.userNickname}">
										</div>
										<div class="col-md-6">
											<label class="text-white text-xs fw-bold mb-2 d-block">Location</label>
											<input type="text" class="form-control login-input"
												placeholder="Earth">
										</div>
										<div class="col-12">
											<label class="text-white text-xs fw-bold mb-2 d-block">Bio</label>
											<textarea class="form-control login-input" rows="3"
												placeholder="Tell us about yourself..."></textarea>
										</div>
									</div>

									<div class="d-flex justify-content-end pt-3">
										<button class="btn btn-primary rounded-pill px-5 fw-bold"
											style="background: #2563eb; border: none;">Save
											Changes</button>
									</div>
								</div>
							</div>
						</section>

					</div>
				</div>
			</div>
		</main>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>