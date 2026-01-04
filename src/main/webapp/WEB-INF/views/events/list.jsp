<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">
</head>

<body>
    <%@ include file="/WEB-INF/views/home/adminheader.jsp"%>
    <%@ include file="/WEB-INF/views/home/adminsidebar.jsp"%>

    <!-- Scrollable -->
    <div class="feed-scroll-container custom-scrollbar admin-list">
        <div class="d-flex flex-col py-4 px-3">

            <!-- Breadcrumbs -->
            <nav class="flex items-center text-sm text-text-sub mb-4">
                <a href="#" class="hover:text-white transition-colors">홈</a>
                <span class="material-symbols-outlined mx-1 text-[16px]">chevron_right</span>
                <a href="#" class="hover:text-white transition-colors">서비스 관리</a>
                <span class="material-symbols-outlined mx-1 text-[16px]">chevron_right</span>
                <span class="text-white font-medium">이벤트</span>
            </nav>

            <!-- Page Heading -->
            <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-6">
                <div>
                    <h1 class="text-3xl md:text-4xl font-bold text-white tracking-tight">이벤트</h1>
                    <p class="text-text-sub text-base max-w-2xl">고객에게 제공할 다양한 이벤트 및 프로모션을 관리하세요.</p>
                </div>
                <button class="flex items-center gap-2 bg-primary hover:bg-primary-dark text-white font-medium py-2.5 px-5 rounded-lg shadow-lg">
                    <span class="material-symbols-outlined text-[20px]">edit_square</span>
                    <span>이벤트 작성</span>
                </button>
            </div>

            <!-- Filter & Search -->
            <div class="flex flex-col lg:flex-row justify-between items-stretch lg:items-center gap-4 p-2 bg-surface-dark rounded-xl border border-border-dark mb-6 shadow-xl">
                <div class="flex gap-1 overflow-x-auto no-scrollbar filter-buttons">
                    <button class="bg-primary/20 text-white border border-primary/20">전체보기</button>
                    <button class="hover:bg-white/5 hover:text-white text-text-sub border border-transparent">진행중인 이벤트</button>
                    <button class="hover:bg-white/5 hover:text-white text-text-sub border border-transparent">종료된 이벤트</button>
                </div>
                <div class="flex items-center gap-3 px-1 lg:px-2">
                    <div class="relative w-full lg:w-80 group">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-text-sub group-focus-within:text-primary transition-colors">
                            <span class="material-symbols-outlined">search</span>
                        </div>
                        <input type="text" placeholder="이벤트명 검색..." class="block w-full py-2 pl-10 pr-4 text-sm text-white bg-background-dark border border-border-dark rounded-lg focus:ring-1 focus:ring-primary focus:border-primary outline-none transition-all">
                    </div>
                    <div class="h-6 w-px bg-border-dark mx-1"></div>
                    <button class="p-2 text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors" title="새로고침">
                        <span class="material-symbols-outlined">refresh</span>
                    </button>
                </div>
            </div>

            <!-- Table -->
            <div class="bg-surface-dark rounded-xl border border-border-dark overflow-hidden shadow-2xl mb-8">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-text-sub">
                        <thead class="text-xs uppercase bg-black/20 text-text-sub border-b border-border-dark">
                            <tr>
                                <th class="p-4 w-10">
                                    <input type="checkbox" class="w-4 h-4 accent-primary rounded">
                                </th>
                                <th class="px-6 py-4 w-20 text-center font-medium">번호</th>
                                <th class="px-6 py-4 w-28 text-center font-medium">유형</th>
                                <th class="px-6 py-4 font-medium">제목</th>
                                <th class="px-6 py-4 w-40 text-center font-medium">작성자</th>
                                <th class="px-6 py-4 w-48 text-center font-medium">이벤트 시작/종료일</th>
                                <th class="px-6 py-4 w-24 text-center font-medium">조회수</th>
                                <th class="px-6 py-4 w-24 text-center font-medium">응모현황</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-border-dark">
                            <tr class="bg-primary/5 hover:bg-primary/10 transition-colors group">
                                <td class="p-4 text-center"><input type="checkbox" class="w-4 h-4 accent-primary rounded"></td>
                                <td class="px-6 py-4 text-center text-primary font-bold">128</td>
                                <td class="px-6 py-4 text-center">
                                    <span class="status progress">진행중</span>
                                </td>
                                <td class="px-6 py-4 font-medium text-white">
                                    <a href="#" class="flex items-center gap-2 group-hover:text-primary transition-colors">
                                        <span>[신년맞이] 전 품목 20% 할인 이벤트</span>
                                        <span class="size-2 bg-green-500 rounded-full animate-pulse"></span>
                                    </a>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <div class="flex items-center justify-center gap-2">
                                        <div class="w-6 h-6 rounded-full bg-slate-600 bg-cover ring-1 ring-border-dark" style='background-image:url("https://lh3.googleusercontent.com/aida-public/AB6AXuALbA-S2eE1p-oCMhl1i5etBWGFuGv6CcJYF0VkTYID-xSAJnyomEbHZ6QBob0wmsR4HS3-JZk1xzR6JvyCveZCUZ1HlD6e7p1TWUSzp56QH0Vp0ToxtPPdPIWz3oZUcaAXS-3i_1atXfK9bPaMTIfSVJvAVDnkcBFsjtGw00dIpUsyX4j43zm8004nFoJAD18cKgZ0Kqao4pZ9LFaEIcqKGE2JhpSavWZZXKWwlSZMmOXf6oHPeOD0kj7XSdbScDuG-B6LQOf4zVjw");'></div>
                                        <span>마케팅</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-center text-xs text-text-sub/80 whitespace-nowrap">2024-01-01 ~ 2024-01-31</td>
                                <td class="px-6 py-4 text-center text-xs">2,450</td>
                                <td class="px-6 py-4 text-center text-xs font-medium text-primary">342</td>
                            </tr>
                            <!-- 반복되는 행도 동일하게 status 클래스 적용 -->
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Pagination -->
            <div class="flex flex-col items-center justify-center pt-2 pb-10">
                <span class="text-sm text-text-sub mb-4">Showing <span class="font-semibold text-white">1-5</span> of <span class="font-semibold text-white">128</span></span>
                <ul class="inline-flex items-center -space-x-px text-sm pagination">
                    <li><a href="#" class="rounded-l-lg"><span class="material-symbols-outlined text-sm">chevron_left</span></a></li>
                    <li><a href="#" class="active">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#" class="rounded-r-lg"><span class="material-symbols-outlined text-sm">chevron_right</span></a></li>
                </ul>
            </div>

        </div>
    </div>
</body>
</html>
