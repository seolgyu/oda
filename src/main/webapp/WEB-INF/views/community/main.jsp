<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>
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
                                    <div class="rounded-4 border border-4 border-dark shadow-lg d-flex align-items-center justify-content-center text-white fw-bold fs-1" 
                                         style="width: 120px; height: 120px; background: linear-gradient(135deg, #6366f1, #a855f7); margin-top: -60px; position: relative; z-index: 2;">
                                        S
                                    </div>
                                    <div class="pb-2">
                                        <h1 class="text-white fs-2 fw-bold mb-1">${dto.com_name}</h1>
                                        <p class="text-secondary mb-0">• 가입자 수 ${dto.member_count} • 방문자 수 ${dto.today_visit}</p>
                                    </div>
                                    <div class="ms-auto pb-2 d-flex gap-2">
                                        <button class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">가입하기</button>
                                        <button class="btn-icon border border-white border-opacity-10 rounded-circle p-2">
                                            <span class="material-symbols-outlined text-white">notifications</span>
                                        </button>
                                        <button class="btn-icon btn-favorite border border-white border-opacity-10 rounded-circle p-2 ${dto.is_favorite == 1 ? 'active' : ''}"
											onclick="toggleFavorite(this, '${dto.community_id}')">
											<span class="material-symbols-outlined text-white" style="${dto.is_favorite == 1 ? 'color: #ffca28 !important; font-variation-settings: \'FILL\' 1, \'wght\' 700 !important;' : ''}">star</span>
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
                                    <button class="btn btn-sm rounded-pill px-3 fw-bold active-filter" style="background: rgba(255, 255, 255, 0.1); color: white; border: none;">인기순</button>
                                    <button class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0">최신순</button>
                                    <button class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0">댓글순</button>
                                </div>
                                <div class="d-flex align-items-center gap-1 border-start border-white border-opacity-10 ps-2">
                                    <button class="btn-icon text-white hover-purple"><span class="material-symbols-outlined fs-5">view_day</span></button>
                                    <button class="btn-icon text-secondary hover-white"><span class="material-symbols-outlined fs-5">reorder</span></button>
                                </div>
                            </div>

                            <div class="glass-panel p-3 shadow-lg">
                                <div class="d-flex gap-3">
                                    <div class="avatar-lg text-white fw-bold flex-shrink-0" style="background: linear-gradient(to top right, #a855f7, #6366f1);">MK</div>
                                    <div class="flex-grow-1">
                                        <input class="create-input text-base w-100 mb-2" placeholder="Share your latest creation..." type="text" style="background: transparent; border: none; color: white; outline: none;"/>
                                        <div class="d-flex justify-content-between align-items-center pt-2 border-top border-secondary border-opacity-25">
                                            <div class="d-flex gap-2">
                                                <button class="btn-icon text-gray-400 hover-purple"><span class="material-symbols-outlined fs-5">image</span></button>
                                                <button class="btn-icon text-gray-400 hover-blue"><span class="material-symbols-outlined fs-5">movie</span></button>
                                                <button class="btn-icon text-gray-400 hover-orange"><span class="material-symbols-outlined fs-5">schema</span></button>
                                            </div>
                                            <button class="action-btn-pill">Post</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="glass-card shadow-lg group">
                                <div class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar-md bg-warning text-white fw-bold">JS</div>
                                        <div><h3 class="text-sm fw-medium text-white mb-0">Julia Smith</h3><p class="text-xs text-gray-500 mb-0">2 hours ago</p></div>
                                    </div>
                                    <button class="btn-icon"><span class="material-symbols-outlined">more_horiz</span></button>
                                </div>
                                <div class="p-3">
                                    <p class="text-light text-sm mb-3 lh-base">Explored a new generative flow today. The combination of vector fields and particle systems created this amazing nebulae effect. 🌌✨</p>
                                    <div class="ratio ratio-16x9 w-100 rounded-3 overflow-hidden position-relative border border-white border-opacity-10">
                                        <div class="position-absolute w-100 h-100" style="background: linear-gradient(to bottom right, #312e81, #581c87, #000); opacity: 0.8;"></div>
                                        <div class="position-absolute w-100 h-100 d-flex align-items-center justify-content-center">
                                            <div class="rounded-circle" style="width: 8rem; height: 8rem; background: rgba(168, 85, 247, 0.3); filter: blur(40px);"></div>
                                        </div>
                                        <div class="position-absolute bottom-0 end-0 m-3 px-2 py-1 rounded text-xs font-monospace text-white-50 border border-white border-opacity-10" style="background: rgba(0, 0, 0, 0.6);">Generation #4291</div>
                                    </div>
                                </div>
                                <div class="px-3 py-2 d-flex align-items-center justify-content-between" style="background: rgba(255, 255, 255, 0.05);">
                                    <div class="d-flex gap-4">
                                        <button class="btn-icon text-xs ps-0 d-flex align-items-center gap-2"><span class="material-symbols-outlined fs-6 text-danger">favorite</span> 24</button>
                                        <button class="btn-icon text-xs d-flex align-items-center gap-2"><span class="material-symbols-outlined fs-6">chat_bubble</span> 5</button>
                                    </div>
                                    <button class="btn-icon text-xs pe-0 d-flex align-items-center gap-1"><span class="material-symbols-outlined fs-6">share</span> Share</button>
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
						        <h3 class="text-white text-xs fw-bold text-uppercase tracking-widest mb-3 opacity-75">커뮤니티 자세히 보기</h3>
						        
						        <div class="d-flex align-items-center gap-3 mb-3">
						            <div class="rounded-circle overflow-hidden border border-white border-opacity-10 shadow-sm" style="width: 50px; height: 50px; background: linear-gradient(135deg, #e11d48, #4c1d95);">
						                <div class="w-100 h-100 d-flex align-items-center justify-content-center text-white">
						                    <span class="material-symbols-outlined">flare</span>
						                </div>
						            </div>
						            <h4 class="text-white text-sm fw-bold mb-0">${dto.com_name}</h4>
						        </div>
						        
						        <p class="text-secondary text-xs lh-relaxed mb-4">${dto.com_description}</p>
						        
						        <div class="d-flex gap-4 mb-4 pt-3 border-top border-white border-opacity-10">
						            <div class="d-flex flex-column">
						                <span class="text-white text-sm fw-bold">${dto.member_count}</span>
						                <span class="text-secondary" style="font-size: 10px;">가입자수</span>
						            </div>
						            <div class="d-flex flex-column">
						                <div class="d-flex align-items-center gap-1">
						                    <span class="material-symbols-outlined text-info" style="font-size: 12px;">visibility</span>
						                    <span class="text-white text-sm fw-bold">${dto.total_visit}</span>
						                </div>
						                <span class="text-secondary" style="font-size: 10px;">총방문자수</span>
						            </div>
						        </div>
						
						        <div class="d-flex flex-column gap-2 mb-4">
								    <div class="d-flex align-items-center gap-2 text-secondary">
								        <span class="material-symbols-outlined" style="font-size: 18px;">cake</span>
								        <span style="font-size: 0.85rem;">${dto.created_date}</span>
								    </div>
								    <div class="d-flex align-items-center gap-2 text-secondary">
								        <span class="material-symbols-outlined" style="font-size: 18px;">${dto.is_private == '0' ? 'public' : 'lock'}</span>
								        <span style="font-size: 0.85rem;">${dto.is_private == '0' ? '전체공개' : '비공개'}</span>
								    </div>
								</div>
						
						        <button class="btn btn-primary w-100 rounded-pill fw-bold py-2 mb-3" style="background: #2563eb; border: none;">게시글 쓰기</button>
						        
						        <c:if test="${sessionScope.member.memberIdx == dto.user_num}">
								    <div class="text-center pt-2 border-top border-white border-opacity-10">
								        <span class="text-primary text-xs fw-bold" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/community/update?community_id=${dto.community_id}';">커뮤니티 설정</span>
								    </div>
								</c:if>
						        
						    </div>
						</aside>
						
                    </div> 
            	</div>
            </div>
        </main>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/community_form.js"></script>
</body>
</html>