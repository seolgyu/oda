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
        <%@ include file="/WEB-INF/views/community/sidebar.jsp"%>

        <main class="app-main flex-1 overflow-y-auto custom-scrollbar">
            
            <div class="space-background">
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="stars3"></div>
                <div class="planet planet-1"></div>
                <div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container w-full relative z-10">
                <div class="max-w-5xl mx-auto py-12 px-6">
                    
                    <div class="text-center mb-12">
                        <h1 class="text-4xl font-extrabold text-white tracking-tight mb-3">Explore Communities</h1>
                        <p class="text-gray-400 text-base font-light">Discover new spaces for collaboration and sharing in the galaxy.</p>
                    </div>

                    <div class="flex flex-col lg:flex-row gap-8">
                        <div class="flex-1 space-y-6">
                            
                            <div class="relative group">
                                <span class="material-symbols-outlined absolute left-5 top-1/2 -translate-y-1/2 text-gray-500">search</span>
                                <input type="text" class="custom-input w-full rounded-2xl py-4 pl-14 pr-6 text-white outline-none" placeholder="Search for a community by name...">
                            </div>

                            <div class="neon-card rounded-[2.5rem] overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty list}">
                                        <c:forEach var="dto" items="${list}">
                                            <div class="p-8 flex items-center justify-between border-b border-white/5 hover:bg-white/[0.03] transition-all group">
                                                <div class="flex items-center space-x-6">
                                                    <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white shadow-lg text-2xl font-bold">
                                                        ${dto.name.substring(0,1).toUpperCase()}
                                                    </div>
                                                    <div>
                                                        <h3 class="text-xl font-bold text-white group-hover:text-primary transition-colors">r/${dto.name}</h3>
                                                        <p class="text-gray-400 text-sm mt-1 line-clamp-1 font-light">${dto.description}</p>
                                                        <div class="flex items-center gap-3 mt-2">
                                                            <span class="text-[11px] px-2 py-0.5 rounded-md bg-white/5 text-gray-500 border border-white/10 uppercase tracking-tighter">Topic</span>
                                                            <span class="text-[11px] text-gray-500 font-medium">1.2k members</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <button class="bg-[#a855f7] hover:bg-[#9333ea] px-8 py-3 rounded-xl font-bold text-white shadow-[0_5px_20px_rgba(168,85,247,0.3)] transition-all transform hover:-translate-y-1 active:scale-95 flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-sm">rocket_launch</span> Join
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="p-20 text-center">
                                            <p class="text-gray-500 font-light">No communities found in this sector of the galaxy.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="w-full lg:w-80 space-y-6">
                            <div class="neon-card rounded-[2rem] p-8">
                                <label class="block text-xs font-bold text-gray-500 uppercase tracking-widest mb-6 border-b border-white/5 pb-3">Popular Topics</label>
                                <div class="flex flex-wrap gap-2.5">
                                    <button type="button" class="topic-btn px-4 py-2 rounded-xl text-[11px] font-medium">❤️ Health</button>
                                    <button type="button" class="topic-btn px-4 py-2 rounded-xl text-[11px] font-medium selected">🎮 Gaming</button>
                                    <button type="button" class="topic-btn px-4 py-2 rounded-xl text-[11px] font-medium">🧪 Science</button>
                                    <button type="button" class="topic-btn px-4 py-2 rounded-xl text-[11px] font-medium">🎨 Art</button>
                                    <button type="button" class="topic-btn px-4 py-2 rounded-xl text-[11px] font-medium">🚀 Tech</button>
                                </div>
                            </div>

                            <div class="px-4">
                                <button onclick="location.href='create'" class="w-full py-4 rounded-2xl border border-primary/30 text-primary font-bold text-sm hover:bg-primary/5 transition-all flex items-center justify-center gap-2">
                                    <span class="material-symbols-outlined">add</span> Create Your Own
                                </button>
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