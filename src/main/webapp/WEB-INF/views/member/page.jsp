<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>

<style type="text/css">
/* 탭 버튼 컨테이너 내부 간격 조정 */
#mypage-tabs {
    display: flex;
    gap: 8px;
    padding: 2px;
}

/* 탭 버튼 기본 상태 (확실히 보이게 수정) */
#mypage-tabs .btn-sm, .layout-tabs .btn-sm{
    transition: all 0.2s ease-in-out;
    color: rgba(255, 255, 255, 0.7) !important; /* 잘 보이도록 밝기 조절 */
    background: transparent !important;
    border: 1px solid rgba(255, 255, 255, 0.1) !important; /* 약한 테두리 추가 */
    font-weight: 500 !important;
}

/* 마우스를 올렸을 때 (Hover) */
#mypage-tabs .btn-sm:hover, .layout-tabs .btn-sm:hover{
    color: #ffffff !important;
    background: rgba(255, 255, 255, 0.15) !important;
    border-color: rgba(255, 255, 255, 0.3) !important;
}

/* 활성화된 버튼 (선택됨 - 가장 중요) */
.active-filter {
    background: #ffffff !important;           /* 배경 흰색 */
    color: #000000 !important;                /* 글자 검은색 */
    border: 1px solid #ffffff !important;
    font-weight: 700 !important;
    box-shadow: 0 0 15px rgba(255, 255, 255, 0.3); /* 은은한 흰색 광택 */
}

/* 탭 콘텐츠 영역 기본 숨김 */
.tab-content {
    display: none;
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
                <div class="d-flex flex-column align-items-center py-4 px-3">
                    
                    <div class="w-100 mb-4" style="max-width: 1100px;">
                        <div class="glass-card overflow-hidden shadow-lg border-0" style="border-radius: 1rem !important;">
                            <div style="height: 220px; background: linear-gradient(to right, #1e1b4b, #4338ca, #1e1b4b); position: relative;">
                                <div class="position-absolute w-100 h-100" style="background: url('https://www.transparenttextures.com/patterns/stardust.png'); opacity: 0.3;"></div>
                            </div>
                            <div class="px-4 pb-4 pt-4 position-relative" style="background: rgba(13, 14, 18, 0.85); backdrop-filter: blur(10px);">
								<div class="d-flex align-items-end gap-3">
									<div
										class="rounded-4 border border-4 border-dark shadow-lg d-flex align-items-center justify-content-center text-white fw-bold fs-1"
										style="width: 120px; height: 120px; background: linear-gradient(135deg, #6366f1, #a855f7); margin-top: -60px; position: relative; z-index: 2;">
										${not empty user.profile_photo ? user.profile_photo : fn:substring(user.userName, 0, 1)}
									</div>
									<div class="pb-2">
										<h1 class="text-white fs-2 fw-bold mb-1">${user.userNickname}
										</h1>
										<p class="text-secondary mb-0">
											c/${user.userId} | <span class="text-white fw-bold">14.2k</span>
											Followers | <span class="text-white fw-bold">8.5k</span>
											Visitors
										</p>
									</div>
									<div class="ms-auto pb-2 d-flex gap-2">
										<button
											class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">Follow</button>
										<button
											class="btn-icon border border-white border-opacity-10 rounded-circle p-2">
											<span class="material-symbols-outlined text-white">notifications</span>
										</button>
										<c:if
											test="${not empty sessionScope.member and sessionScope.member.userId eq user.userId}">
											<button
												onclick="location.href='${pageContext.request.contextPath}/member/settings';"
												class="btn-icon border border-white border-opacity-10 rounded-circle p-2">
												<span class="material-symbols-outlined text-white">settings</span>
											</button>
										</c:if>
									</div>
								</div>
							</div>
                        </div>
                    </div>

                    <div class="d-flex gap-4 w-100" style="max-width: 1100px;">
                        
                        <div class="flex-grow-1 d-flex flex-column gap-4" style="min-width: 0;">

							<div
								class="glass-panel px-3 py-2 d-flex align-items-center justify-content-between shadow-sm">
								<div class="d-flex gap-2" id="mypage-tabs">
									<button
										class="btn btn-sm rounded-pill px-3 fw-bold active-filter"
										data-target="my-posts">My Post</button>
									<button
										class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0"
										data-target="reposts">Repost</button>
								</div>
								<div
									class="layout-tabs d-flex align-items-center gap-2 border-start border-white border-opacity-10 ps-3">
									<button class="btn btn-sm rounded-pill px-3 active-filter">
										<span class="material-symbols-outlined fs-5">view_day</span>
									</button>

									<button class="btn btn-sm rounded-pill px-3">
										<span class="material-symbols-outlined fs-5">reorder</span>
									</button>
								</div>
							</div>

							<div class="glass-card shadow-lg group">
								<div
									class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
									<div class="d-flex align-items-center gap-3">
										<div class="avatar-md bg-warning text-white fw-bold">JS</div>
										<div>
											<h3 class="text-sm fw-medium text-white mb-0">Julia
												Smith</h3>
											<p class="text-xs text-gray-500 mb-0">2 hours ago</p>
										</div>
									</div>
									<button class="btn-icon">
										<span class="material-symbols-outlined">more_horiz</span>
									</button>
								</div>
								<div class="p-3">
									<p class="text-light text-sm mb-3 lh-base">Explored a new
										generative flow today. The combination of vector fields and
										particle systems created this amazing nebulae effect. 🌌✨</p>
									<div
										class="ratio ratio-16x9 w-100 rounded-3 overflow-hidden position-relative border border-white border-opacity-10">
										<div class="position-absolute w-100 h-100"
											style="background: linear-gradient(to bottom right, #312e81, #581c87, #000); opacity: 0.8;"></div>
										<div
											class="position-absolute w-100 h-100 d-flex align-items-center justify-content-center">
											<div class="rounded-circle"
												style="width: 8rem; height: 8rem; background: rgba(168, 85, 247, 0.3); filter: blur(40px);"></div>
										</div>
										<div
											class="position-absolute bottom-0 end-0 m-3 px-2 py-1 rounded text-xs font-monospace text-white-50 border border-white border-opacity-10"
											style="background: rgba(0, 0, 0, 0.6);">Generation
											#4291</div>
									</div>
								</div>
								<div
									class="px-3 py-2 d-flex align-items-center justify-content-between"
									style="background: rgba(255, 255, 255, 0.05);">
									<div class="d-flex gap-4">
										<button
											class="btn-icon text-xs ps-0 d-flex align-items-center gap-2">
											<span class="material-symbols-outlined fs-6 text-danger">favorite</span>
											24
										</button>
										<button
											class="btn-icon text-xs d-flex align-items-center gap-2">
											<span class="material-symbols-outlined fs-6">chat_bubble</span>
											5
										</button>
									</div>
									<button
										class="btn-icon text-xs pe-0 d-flex align-items-center gap-1">
										<span class="material-symbols-outlined fs-6">share</span>
										Share
									</button>
								</div>
							</div>

							<div class="glass-card shadow-lg group">
                                <div class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar-md bg-success text-white fw-bold">DT</div>
                                        <div><h3 class="text-sm fw-medium text-white mb-0">David Torres</h3><p class="text-xs text-gray-500 mb-0">5 hours ago</p></div>
                                    </div>
                                    <button class="btn-icon"><span class="material-symbols-outlined">more_horiz</span></button>
                                </div>
                                <div class="p-3">
                                    <p class="text-light text-sm mb-3">Working on the UI components for the new design system. Thoughts on this palette?</p>
                                    <div class="row g-2" style="height: 12rem;">
                                        <div class="col-6 h-100">
                                            <div class="h-100 rounded-3 border border-white border-opacity-10 p-2 position-relative overflow-hidden" style="background-color: #1e1e24;">
                                                <div class="mt-4 d-flex flex-column gap-2">
                                                    <div class="rounded" style="height: 8px; width: 75%; background: rgba(255, 255, 255, 0.1);"></div>
                                                    <div class="rounded border border-white border-opacity-10 border-dashed d-flex align-items-center justify-content-center text-xs text-muted" style="height: 64px; background: rgba(255, 255, 255, 0.05);">Component A</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 h-100">
                                            <div class="h-100 rounded-3 border border-white border-opacity-10 p-2 position-relative overflow-hidden" style="background-color: #1e1e24;">
                                                <div class="d-flex flex-column gap-2">
                                                    <div class="d-flex gap-2">
                                                        <div class="rounded" style="width: 32px; height: 32px; background: rgba(255, 255, 255, 0.1);"></div>
                                                        <div class="flex-grow-1 d-flex flex-column gap-1"><div class="rounded" style="height: 8px; width: 100%; background: rgba(255, 255, 255, 0.1);"></div></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="px-3 py-2 d-flex align-items-center justify-content-between" style="background: rgba(255, 255, 255, 0.05);">
                                    <div class="d-flex gap-4">
                                        <button class="btn-icon text-xs ps-0 d-flex align-items-center gap-2"><span class="material-symbols-outlined fs-6">favorite</span> 86</button>
                                        <button class="btn-icon text-xs d-flex align-items-center gap-2"><span class="material-symbols-outlined fs-6">chat_bubble</span> 12</button>
                                    </div>
                                    <button class="btn-icon text-xs pe-0 d-flex align-items-center gap-1"><span class="material-symbols-outlined fs-6">share</span> Share</button>
                                </div>
                            </div>
                        </div>

                        <aside class="d-none d-xl-flex flex-column gap-4" style="width: 320px; flex-shrink: 0;">
						    <div class="glass-card p-4 shadow-lg">
						        <h3 class="text-white text-xs fw-bold text-uppercase tracking-widest mb-3 opacity-75">About Community</h3>
						        
						        <div class="d-flex align-items-center gap-3 mb-3">
						            <div class="rounded-circle overflow-hidden border border-white border-opacity-10 shadow-sm" style="width: 50px; height: 50px; background: linear-gradient(135deg, #e11d48, #4c1d95);">
						                <div class="w-100 h-100 d-flex align-items-center justify-content-center text-white">
						                    <span class="material-symbols-outlined">flare</span>
						                </div>
						            </div>
						            <h4 class="text-white text-sm fw-bold mb-0">r/Stargazers</h4>
						        </div>
						        
						        <p class="text-secondary text-xs lh-relaxed mb-4">A community for amateur astronomers, astrophotographers, and space enthusiasts.</p>
						        
						        <div class="d-flex gap-4 mb-4 pt-3 border-top border-white border-opacity-10">
						            <div class="d-flex flex-column">
						                <span class="text-white text-sm fw-bold">14.2k</span>
						                <span class="text-secondary" style="font-size: 10px;">Members</span>
						            </div>
						            <div class="d-flex flex-column">
						                <div class="d-flex align-items-center gap-1">
						                    <span class="material-symbols-outlined text-info" style="font-size: 12px;">visibility</span>
						                    <span class="text-white text-sm fw-bold">8.5k</span>
						                </div>
						                <span class="text-secondary" style="font-size: 10px;">Visitors</span>
						            </div>
						        </div>
						
						        <div class="d-flex flex-column gap-2 mb-4">
								    <div class="d-flex align-items-center gap-2 text-secondary">
								        <span class="material-symbols-outlined" style="font-size: 18px;">cake</span>
								        <span style="font-size: 0.85rem;">Created Sep 20, 2021</span>
								    </div>
								    <div class="d-flex align-items-center gap-2 text-secondary">
								        <span class="material-symbols-outlined" style="font-size: 18px;">public</span>
								        <span style="font-size: 0.85rem;">Public Access</span>
								    </div>
								</div>
						
						        <button class="btn btn-primary w-100 rounded-pill fw-bold py-2 mb-3" style="background: #2563eb; border: none;">Create Post</button>
						        
						        <div class="text-center pt-2 border-top border-white border-opacity-10">
						            <span class="text-primary text-xs fw-bold" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/community/update';">COMMUNITY OPTIONS</span>
						        </div>
						    </div>
						</aside>
						
                    </div> 
            	</div>
            </div>
        </main>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>          
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#mypage-tabs button, .layout-tabs button').on('click', function() {
	        
	        // 1. 같은 부모를 공유하는 버튼들 중에서만 'active-filter' 제거
	        // 이렇게 해야 왼쪽 탭을 눌러도 오른쪽 탭의 선택 상태가 풀리지 않습니다.
	        $(this).parent().find('button').removeClass('active-filter');
	        
	        // 2. 클릭한 버튼에 활성화 클래스(음영/테두리 효과) 추가
	        $(this).addClass('active-filter');
	        
	        /*
	        // 3. [옵션] 게시글 필터링 로직 (data-target 속성이 있는 경우만)
	        const target = $(this).data('target');
	        if (target) {
	            $('.tab-content').hide(); // 모든 콘텐츠 숨김
	            $('#' + target).fadeIn(300); // 선택된 콘텐츠만 보임
	        }
	        */
	    });

	});
	
	</script>
</body>
</html>