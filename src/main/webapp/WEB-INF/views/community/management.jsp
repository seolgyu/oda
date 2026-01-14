<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#a855f7", secondary: "#9333ea" }
                }
            }
        }
    </script>
</head>
<body class="bg-[#050505] text-gray-100">

    <%@ include file="/WEB-INF/views/home/header.jsp"%>

    <div class="app-body"> 
        <%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

        <main class="app-main flex-1 custom-scrollbar" style="overflow-y: auto;">
            <div class="space-background">
                <div class="stars"></div><div class="stars2"></div><div class="stars3"></div>
                <div class="planet planet-1"></div><div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container w-full">
                <div class="w-full max-w-[950px] mx-auto py-12 px-6 relative z-10">
                    
                    <div class="text-center mb-10">
                        <h1 class="text-4xl font-extrabold text-white tracking-tight mb-2">내 커뮤니티</h1>
                        <p class="text-gray-400 text-base font-light">직접 만들거나 가입한 커뮤니티를 관리합니다.</p>
                    </div>

                    <div class="flex flex-col lg:flex-row gap-8">
                        <div class="lg:flex-[3] w-full min-w-0 space-y-6">
                            <div class="neon-card rounded-[2.5rem] overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty allList}">
                                        <c:forEach var="dto" items="${allList}">
                                            <div class="p-6 flex items-center justify-between border-b border-white/5 hover:bg-white/[0.02] transition-all group">
                                                <div class="flex items-center space-x-4">
                                                    <button class="btn-favorite p-2 transition-all active:scale-90" 
													        onclick="toggleFavorite(this, '${dto.community_id}')">
													    <span class="material-symbols-outlined text-2xl transition-all ${dto.is_favorite == 1 ? 'text-yellow-400' : 'text-gray-600'}"
														      style="font-variation-settings: 'FILL' ${dto.is_favorite == 1 ? 1 : 0}, 'wght' 700 !important; 
														             ${dto.is_favorite == 1 ? 'color: #facc15 !important;' : ''}">
														    kid_star
														</span>
													</button>

                                                    <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white shadow-lg overflow-hidden shrink-0">
                                                        <c:choose>
                                                            <c:when test="${not empty dto.icon_image}">
                                                                <img src="${dto.icon_image}" class="w-full h-full object-cover">
                                                            </c:when>
                                                            <c:otherwise><span class="font-bold text-xl">r/</span></c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <h3 class="text-lg font-bold text-gray-100 group-hover:text-primary transition-colors cursor-pointer" 
                                                            onclick="location.href='main?community_id=${dto.community_id}';">
                                                            ${dto.com_name}
                                                        </h3>
                                                        <p class="text-sm text-gray-400 mt-1 truncate max-w-[180px] md:max-w-[250px]">${dto.com_description}</p>
                                                    </div>
                                                </div>

                                                <div class="shrink-0 ml-4">
                                                    <c:choose>
                                                        <c:when test="${dto.user_num == sessionScope.member.memberIdx}">
											                <button onclick="location.href='update?community_id=${dto.community_id}'" 
											                        class="w-32 py-3 bg-[#a855f7] hover:bg-[#9333ea] rounded-xl font-bold text-white transition-all flex items-center justify-center gap-2 border-none outline-none">
											                    <span class="material-symbols-outlined text-sm">edit</span> 수정하기
											                </button>
											            </c:when>
											            
                                                        <c:otherwise>
											                <button onclick="leaveCommunity('${dto.community_id}')" 
											                        class="w-32 py-3 bg-white/10 hover:bg-white/20 text-gray-300 rounded-xl font-bold flex items-center justify-center gap-2 transition-all border-none outline-none">
											                    <span class="material-symbols-outlined text-sm">logout</span> 탈퇴하기
											                </button>
											            </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="p-10 text-center text-gray-500">참여 중인 커뮤니티가 없습니다.</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-full lg:w-80 space-y-6">
                            <div class="neon-card rounded-[2rem] p-8">
                                <h3 class="text-xs font-bold text-gray-500 uppercase tracking-widest mb-6 border-b border-white/5 pb-3">즐겨찾기</h3>
                                <div id="right-fav-list" class="space-y-5">
                                    <jsp:include page="/WEB-INF/views/community/management_fav.jsp" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <div id="confirm-modal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/60 backdrop-blur-sm">
        <div class="neon-card p-8 rounded-[2rem] w-80 text-center border border-white/10 bg-[#111]">
            <h3 class="text-xl font-bold text-white mb-4">커뮤니티 탈퇴</h3>
            <p class="text-gray-400 mb-8">정말로 이 커뮤니티를 탈퇴하시겠습니까?</p>
            <div class="flex gap-3">
                <button onclick="closeConfirmModal()" class="flex-1 py-3 rounded-xl bg-white/5 text-gray-400 hover:bg-white/10 transition-all">취소</button>
                <button id="modal-confirm-btn" class="flex-1 py-3 rounded-xl bg-red-500 text-white font-bold">탈퇴하기</button>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/community_form.js"></script>
</body>
</html>