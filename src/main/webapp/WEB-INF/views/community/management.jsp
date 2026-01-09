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
                    colors: {
                        primary: "#a855f7",
                        secondary: "#9333ea",
                    }
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
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="stars3"></div>
                <div class="planet planet-1"></div>
                <div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container w-full">
                <div class="w-full max-w-[950px] mx-auto py-12 px-6 relative z-10">
                    
                    <div class="text-left mb-10">
                        <h1 class="text-4xl font-extrabold text-white tracking-tight mb-2">내 커뮤니티</h1>
                        <p class="text-gray-400 text-base font-light">직접 만들거나 가입한 커뮤니티를 볼 수 있습니다.</p>
                    </div>

                    <div class="flex flex-col lg:flex-row gap-8">
                        <div class="lg:flex-[3] w-full min-w-0 space-y-6">
                            <div class="relative group">
                                <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-gray-500">search</span>
                                <input class="custom-input block w-full pl-12 pr-4 py-4 rounded-xl text-sm text-white" placeholder="커뮤니티 이름을 입력하세요..." type="text">
                            </div>

                            <div class="neon-card rounded-[2.5rem] overflow-hidden">
							    <c:choose>
							        <c:when test="${not empty allList}">
							            <c:forEach var="dto" items="${allList}">
							                <div class="p-6 flex items-center justify-between border-b border-white/5 hover:bg-white/[0.02] transition-all group">
							                    <div class="flex items-center space-x-4">
							                        <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white shadow-lg overflow-hidden">
							                            <c:choose>
							                                <c:when test="${not empty dto.icon_image}">
							                                    <img src="${dto.icon_image}" class="w-full h-full object-cover">
							                                </c:when>
							                                <c:otherwise>
							                                    <span class="font-bold text-xl">r/</span>
							                                </c:otherwise>
							                            </c:choose>
							                        </div>
							                        <div>
							                            <h3 class="text-lg font-bold text-gray-100 group-hover:text-primary transition-colors cursor-pointer" 
							                                onclick="location.href='${pageContext.request.contextPath}/community/main?id=${dto.community_id}';">
							                                ${dto.com_name}
							                            </h3>
							                            <p class="text-sm text-gray-400 mt-1 truncate max-w-[300px]">${dto.com_description}</p>
							                        </div>
							                    </div>
							                    <button class="ml-10 px-6 py-2.5 font-bold text-sm rounded-full transition-all active:scale-95 border-2
												    ${dto.user_num == sessionScope.member.memberIdx ? 
												    'border-purple-500 text-purple-500 hover:bg-purple-500 hover:text-white' : 
												    'border-primary text-primary hover:bg-primary hover:text-white'}">
												    ${dto.user_num == sessionScope.member.memberIdx ? '수정하기' : '탈퇴하기'}
												</button>
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
						        <div class="space-y-5">
						            <c:forEach var="fav" items="${favList}">
						                <div class="flex items-center space-x-3 group cursor-pointer" 
						                     onclick="location.href='${pageContext.request.contextPath}/community/main?id=${fav.community_id}';">
						                    <div class="w-9 h-9 rounded-xl bg-primary/20 flex items-center justify-center text-primary text-[10px] font-bold border border-primary/30 group-hover:bg-primary group-hover:text-white transition-all uppercase">
						                        ${fav.com_short_name}
						                    </div>
						                    <span class="text-sm font-medium text-gray-300 group-hover:text-primary transition-colors">r/${fav.com_name}</span>
						                </div>
						            </c:forEach>
						            <c:if test="${empty favList}">
						                <p class="text-xs text-gray-600">즐겨찾기한 커뮤니티가 없습니다.</p>
						            </c:if>
						        </div>
						    </div>
						</div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
</body>
</html>