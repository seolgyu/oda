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

    <div class="app-body flex h-[calc(100vh-56px)] overflow-hidden">
        <%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

        <main class="app-main flex-1 overflow-y-auto custom-scrollbar">
            
            <div class="space-background">
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="stars3"></div>
                <div class="planet planet-1"></div>
                <div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container w-full relative z-10">
                <div class="w-full max-w-[950px] mx-auto py-12 px-6">
                    
                    <div class="text-center mb-12">
                        <h1 class="text-4xl font-extrabold text-white tracking-tight mb-3">커뮤니티 둘러보기</h1>
                        <p class="text-gray-400 text-base font-light">ODA에서 협업과 공유를 위한 새로운 공간을 발견해보세요.</p>
                    </div>

                    <div class="flex flex-col lg:flex-row gap-8">
                        <div class="lg:flex-[3] w-full min-w-0 space-y-6">
                            
                            <div class="relative group">
                                <span class="material-symbols-outlined absolute left-5 top-1/2 -translate-y-1/2 text-gray-500">search</span>
                                <input type="text" id="community-search" class="custom-input w-full rounded-2xl py-4 pl-14 pr-6 text-white outline-none" placeholder="커뮤니티를 이름으로 검색하세요...">
                            </div>

                            <div id="community-list" class="neon-card rounded-[2.5rem] overflow-hidden">
                                <jsp:include page="list_search.jsp" />
                            </div>
                        </div>

                        <div class="w-full lg:w-80 shrink-0 space-y-6">
                            <div class="neon-card rounded-[2rem] p-8">
                                <label class="block text-xs font-bold text-gray-500 uppercase tracking-widest mb-6 border-b border-white/5 pb-3">커뮤니티 인기 주제</label>
                                <div class="flex flex-wrap gap-2.5">
                                    <c:forEach var="cate" items="${categoryList}" varStatus="status">
							            <button type="button" class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium"
							                    data-id="${cate.category_id}">
							                # ${cate.category_name}
							            </button>
							        </c:forEach>
                                </div>
                            </div>

                            <div class="px-0"> 
                            	<button onclick="location.href='create'" 
							            class="neon-card w-full py-6 rounded-[2rem] text-primary font-bold text-base hover:bg-white/[0.05] transition-all flex items-center justify-center gap-2 group border-none">
							        <span class="material-symbols-outlined text-[#a855f7] group-hover:scale-110 transition-transform">add_circle</span>
							        <span class="tracking-tight text-[#a855f7]">나의 커뮤니티 만들기</span>
							    </button>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <div id="join-modal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/60 backdrop-blur-sm">
	    <div class="neon-card p-8 rounded-[2rem] w-80 text-center border border-white/10">
	        <h3 class="text-xl font-bold text-white mb-4">커뮤니티 가입</h3>
	        <p class="text-gray-400 mb-8">이 커뮤니티의 멤버가 되어<br>함께 소통하시겠습니까?</p>
	        <div class="flex gap-3">
	            <button onclick="closeJoinModal()" class="flex-1 py-3 rounded-xl bg-white/5 text-gray-400 hover:bg-white/10 transition-all">취소</button>
	            <button id="confirm-join-btn" class="flex-1 py-3 rounded-xl bg-primary text-white font-bold shadow-[0_5px_15px_rgba(168,85,247,0.4)]">가입하기</button>
	        </div>
	    </div>
	</div>

    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/community_list.js"></script>
</body>
</html>