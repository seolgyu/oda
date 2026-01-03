<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700&display=swap" rel="stylesheet"/>
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
<body class="bg-[#050505] text-gray-100 overflow-hidden font-sans">

    <%@ include file="/WEB-INF/views/layout/header.jsp"%>

    <div class="app-body">
        <%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

        <main class="app-main flex-1">
            <div class="space-background">
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="stars3"></div>
                <div class="planet planet-1"></div>
                <div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container custom-scrollbar w-full">
                <div class="max-w-3xl mx-auto py-12 px-4 relative z-10">
                    
                    <div class="text-center mb-10">
                        <h1 class="text-4xl font-extrabold text-white tracking-tight mb-2">Create a Community</h1>
                        <p class="text-gray-400 text-base font-light">Build a new space for collaboration and sharing in the galaxy.</p>
                    </div>

                    <div class="neon-card rounded-[2.5rem] p-8 md:p-12">
                        <form action="create_ok.jsp" method="post" class="space-y-8 relative z-10">
                            
                            <div class="space-y-3">
                                <label class="block text-sm font-medium text-gray-300 ml-1">Community Name <span class="text-red-500">*</span></label>
                                <input type="text" name="name" class="custom-input w-full rounded-xl py-4 px-5 text-white" placeholder="e.g. Generative Art Enthusiasts">
                            </div>

                            <div class="space-y-3">
                                <label class="block text-sm font-medium text-gray-300 ml-1">Description</label>
                                <textarea name="description" rows="4" class="custom-input w-full rounded-xl py-4 px-5 text-white resize-none" placeholder="Tell people what your community is about..."></textarea>
                            </div>

                            <div class="space-y-3">
                                <label class="block text-sm font-medium text-gray-300 ml-1">Privacy & Accessibility</label>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <label class="privacy-card card-selected relative flex cursor-pointer rounded-2xl p-6 h-[90px] items-center">
                                        <input type="radio" name="privacy-type" value="public" checked class="sr-only">
                                        <div class="flex flex-1 gap-4 items-center">
                                            <span class="material-symbols-outlined text-green-400 text-2xl flex-none">public</span>
                                            <div class="flex-1">
                                                <p class="text-[15px] font-bold title-text text-[#a855f7]">Public</p>
                                                <p class="text-[11px] text-gray-400 leading-tight">Anyone can view and post.</p>
                                            </div>
                                        </div>
                                        <div class="check-container w-6 h-6 flex-none flex justify-center items-center ml-2">
                                            <span class="material-symbols-outlined text-[#a855f7] text-2xl">check_circle</span>
                                        </div>
                                    </label>
                                    
                                    <label class="privacy-card card-unselected relative flex cursor-pointer rounded-2xl p-6 h-[90px] items-center">
                                        <input type="radio" name="privacy-type" value="restricted" class="sr-only">
                                        <div class="flex flex-1 gap-4 items-center">
                                            <span class="material-symbols-outlined text-red-400 text-2xl flex-none">lock</span>
                                            <div class="flex-1">
                                                <p class="text-[15px] font-bold title-text text-white">Restricted</p>
                                                <p class="text-[11px] text-gray-400 leading-tight">Only approved members can view.</p>
                                            </div>
                                        </div>
                                        <div class="check-container w-6 h-6 flex-none flex justify-center items-center ml-2"></div>
                                    </label>
                                </div>
                            </div>

                            <div class="space-y-4">
                                <label class="block text-sm font-medium text-gray-300 ml-1">Select Topics</label>
                                <div class="flex flex-wrap gap-2.5">
                                    <button type="button" class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium">❤️ Health</button>
                                    <button type="button" class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium selected">🎮 Gaming</button>
                                    <button type="button" class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium">🧪 Science</button>
                                    <button type="button" class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium">🎨 Art</button>
                                    <button type="button" class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium">🚀 Tech</button>
                                    <button type="button" class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium">🌍 Travel</button>
                                </div>
                            </div>

                            <div class="flex justify-end items-center gap-6 pt-6 border-t border-white/5">
                                <button type="button" class="text-sm text-gray-500 hover:text-white transition-colors" onclick="history.back()">Cancel</button>
                                <button type="submit" class="bg-[#a855f7] hover:bg-[#9333ea] px-10 py-4 rounded-2xl font-bold text-white shadow-[0_10px_40px_rgba(168,85,247,0.4)] flex items-center gap-2 transition-all transform hover:-translate-y-1">
                                    <span class="material-symbols-outlined text-lg">rocket_launch</span> Create Community
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
</body>
</html>