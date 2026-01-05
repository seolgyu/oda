<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community.css">
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
                            <div class="banner-area">
                                <div class="stardust-overlay"></div>
                            </div>
                            <div class="profile-info-bar">
                                <div class="d-flex align-items-end gap-3">
                                    <div class="community-logo">S</div>
                                    <div class="pb-2 info-text-area">
                                        <h1 class="text-white fs-2 fw-bold mb-1">Stargazers Community</h1>
                                        <p class="text-secondary mb-0">c/stargazers • 14.2k Members • 8.5k Visitors</p>
                                    </div>
                                    <div class="ms-auto pb-2 d-flex gap-2">
                                        <button class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">Joined</button>
                                        <button class="btn-icon border border-white border-opacity-10 rounded-circle p-2">
                                            <span class="material-symbols-outlined text-white">notifications</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-4 w-100" style="max-width: 1100px;">
                        
                        <div class="flex-grow-1 d-flex flex-column gap-4" style="min-width: 0;">
                            
                            <div class="glass-panel px-3 py-2 d-flex align-items-center justify-content-between shadow-sm">
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm rounded-pill px-3 fw-bold active-filter">Hot</button>
                                    <button class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0">New</button>
                                    <button class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0">Top</button>
                                </div>
                                <div class="d-flex align-items-center gap-1 border-start border-white border-opacity-10 ps-2">
                                    <button class="btn-icon text-white"><span class="material-symbols-outlined fs-5">view_day</span></button>
                                    <button class="btn-icon text-secondary"><span class="material-symbols-outlined fs-5">reorder</span></button>
                                </div>
                            </div>

                            <div class="glass-panel p-3 shadow-lg">
                                <div class="d-flex gap-3">
                                    <div class="avatar-lg my-avatar" style="width: 45px; height: 45px; background: #555; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; flex-shrink: 0;">MK</div>
                                    <div class="flex-grow-1">
                                        <input class="create-input w-100 mb-2" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white; padding: 10px; border-radius: 8px;" placeholder="Share your latest creation..." type="text"/>
                                        <div class="d-flex justify-content-between align-items-center pt-2 border-top border-secondary border-opacity-25">
                                            <div class="d-flex gap-2">
                                                <button class="btn-icon text-gray-400 hover-purple"><span class="material-symbols-outlined fs-5">image</span></button>
                                                <button class="btn-icon text-gray-400 hover-blue"><span class="material-symbols-outlined fs-5">movie</span></button>
                                                <button class="btn-icon text-gray-400 hover-orange"><span class="material-symbols-outlined fs-5">schema</span></button>
                                            </div>
                                            <button class="action-btn-pill" style="background: #a855f7; color: white; border: none; padding: 5px 20px; border-radius: 20px;">Post</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="glass-card shadow-lg group">
                                <div class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar-md bg-warning text-white fw-bold" style="width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center;">JS</div>
                                        <div>
                                            <h3 class="text-sm fw-medium text-white mb-0">Julia Smith</h3>
                                            <p class="text-xs text-gray-500 mb-0">2 hours ago</p>
                                        </div>
                                    </div>
                                    <button class="btn-icon"><span class="material-symbols-outlined">more_horiz</span></button>
                                </div>
                                <div class="p-3">
                                    <p class="text-light text-sm mb-3">Nebulae effects using particle systems. 🌌</p>
                                    <div class="post-media-placeholder" style="height: 300px; background: rgba(0,0,0,0.3); border-radius: 12px;">
                                        <div class="nebula-effect"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <aside class="flex-column gap-4 sidebar-info">
                            <div class="glass-card p-4 shadow-lg">
                                <h3 class="sidebar-title" style="color: #a855f7; font-size: 0.8rem; font-weight: bold; margin-bottom: 1rem;">ABOUT COMMUNITY</h3>
                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <div class="community-sidebar-logo" style="width: 40px; height: 40px; background: #8b5cf6; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white;"><span class="material-symbols-outlined">flare</span></div>
                                    <h4 class="text-white text-sm fw-bold mb-0">r/Stargazers</h4>
                                </div>
                                <p class="text-secondary text-xs lh-relaxed mb-4">A community for amateur astronomers, astrophotographers, and space enthusiasts.</p>
                                <button class="btn btn-primary w-100 rounded-pill fw-bold py-2 mb-3" onclick="location.href='${pageContext.request.contextPath}/community/update';">커뮤니티 수정</button>
                            </div>
                        </aside>

                    </div> 
                </div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
</body>
</html>