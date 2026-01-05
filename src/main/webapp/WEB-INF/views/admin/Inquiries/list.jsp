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
    <%@ include file="../home/adminheader.jsp"%>
    <%@ include file="../home/adminsidebar.jsp"%>

    <!-- Scrollable Container -->
    <div class="feed-scroll-container custom-scrollbar admin-list">
        <div class="d-flex flex-column align-items-center py-4 px-3">

            <!-- Breadcrumbs -->
            <nav class="flex items-center text-sm text-text-sub mb-4">
                <a class="hover:text-white transition-colors" href="#">홈</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <a class="hover:text-white transition-colors" href="#">서비스 관리</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <span class="text-white font-medium">문의사항</span>
            </nav>

            <!-- Page Heading -->
            <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 w-full">
                <div class="flex flex-col gap-2">
                    <h1 class="text-3xl md:text-4xl font-bold text-white tracking-tight">문의사항</h1>
                    <p class="text-text-sub text-base max-w-2xl">서비스 이용자들이 작성한 문의사항에 대한 답변을 제공합니다.</p>
                </div>
                <button class="flex items-center gap-2 bg-primary hover:bg-primary-dark text-white font-medium py-2.5 px-5 rounded-lg transition-all">
                    <span class="material-symbols-outlined text-[20px]">edit_square</span>
                    <span>문의사항 답변</span>
                </button>
            </div>

            <!-- Filter Tabs & Search -->
            <div class="flex flex-col lg:flex-row justify-between items-stretch lg:items-center gap-4 p-2 w-full"
                 style="background-color: var(--surface-dark); border: 1px solid var(--border-dark); border-radius: 0.75rem;">
                <div class="flex p-1 gap-1 overflow-x-auto no-scrollbar">
                    <button class="px-4 py-2 text-sm font-medium text-white bg-primary border border-primary rounded-lg">전체보기</button>
                    <button class="px-4 py-2 text-sm font-medium text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors">답변대기</button>
                    <button class="px-4 py-2 text-sm font-medium text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors">답변완료</button>
                </div>
                <div class="flex items-center gap-3 px-1 lg:px-2 pb-1 lg:pb-0">
                    <div class="relative w-full lg:w-80 group">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-text-sub group-focus-within:text-primary transition-colors">
                            <span class="material-symbols-outlined">search</span>
                        </div>
                        <input class="block w-full py-2 pl-10 pr-4 text-sm text-white placeholder-text-sub bg-background-dark border border-border-dark rounded-lg focus:ring-1 focus:ring-primary focus:border-primary transition-all outline-none"
                               placeholder="제목, 작성자 검색..." type="text"/>
                    </div>
                    <div class="h-6 w-px bg-border-dark mx-1"></div>
                    <button class="flex items-center justify-center p-2 text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors" title="새로고침">
                        <span class="material-symbols-outlined">refresh</span>
                    </button>
                </div>
            </div>

            <!-- Table Card -->
            <div class="bg-surface-dark rounded-xl border border-border-dark overflow-hidden shadow-xl shadow-black/40 mb-8 w-full">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-text-sub">
                        <thead class="text-xs uppercase bg-black/20 text-text-sub border-b border-border-dark">
                            <tr>
                                <th class="p-4 w-10"><input class="w-4 h-4 text-primary bg-background-dark border-border-dark rounded focus:ring-primary" type="checkbox"/></th>
                                <th class="px-6 py-4 w-20 text-center font-medium">번호</th>
                                <th class="px-6 py-4 w-28 text-center font-medium">유형</th>
                                <th class="px-6 py-4 font-medium">제목</th>
                                <th class="px-6 py-4 w-40 text-center font-medium">작성자</th>
                                <th class="px-6 py-4 w-32 text-center font-medium">작성일</th>
                                <th class="px-6 py-4 w-28 text-center font-medium">상태</th>
                                <th class="px-6 py-4 w-24 text-center font-medium">조회수</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-border-dark">
                            <!-- 반복 row 예시 -->
                            <tr class="bg-surface-dark hover:bg-white/5 transition-colors group">
                                <td class="w-4 p-4"><input class="w-4 h-4 text-primary bg-background-dark border-border-dark rounded focus:ring-primary" type="checkbox"/></td>
                                <td class="px-6 py-4 text-center text-text-sub">152</td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded text-xs font-semibold bg-yellow-500/10 text-yellow-400 border border-yellow-500/20">대기</span>
                                </td>
                                <td class="px-6 py-4 font-medium text-white">
                                    <a class="group-hover:text-primary transition-colors flex items-center gap-2" href="#">
                                        로그인 오류 관련 문의드립니다.
                                        <span class="size-2 bg-red-500 rounded-full animate-pulse"></span>
                                    </a>
                                </td>
                                <td class="px-6 py-4 text-center">user123</td>
                                <td class="px-6 py-4 text-center text-xs text-text-sub/80">2023-10-25</td>
                                <td class="px-6 py-4 text-center">
                                    <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-500/10 text-green-400 border border-green-500/20 whitespace-nowrap">공개</span>
                                </td>
                                <td class="px-6 py-4 text-center text-xs">12</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Pagination -->
            <div class="flex flex-col items-center justify-center pt-2 pb-10 w-full">
                <span class="text-sm text-text-sub mb-4">
                    Showing <span class="font-semibold text-white">1-5</span> of <span class="font-semibold text-white">152</span>
                </span>
                <ul class="inline-flex items-center -space-x-px text-sm">
                    <li><a class="flex items-center justify-center px-4 h-10 text-text-sub bg-surface-dark border border-border-dark rounded-l-lg hover:bg-white/5 hover:text-white transition-colors" href="#"><span class="material-symbols-outlined text-sm">chevron_left</span></a></li>
                    <li><a class="flex items-center justify-center px-4 h-10 text-white bg-primary border border-primary hover:bg-primary-dark transition-colors font-medium z-10" href="#">1</a></li>
                    <li><a class="flex items-center justify-center px-4 h-10 text-text-sub bg-surface-dark border border-border-dark hover:bg-white/5 hover:text-white transition-colors" href="#">2</a></li>
                    <li><a class="flex items-center justify-center px-4 h-10 text-text-sub bg-surface-dark border border-border-dark hover:bg-white/5 hover:text-white transition-colors" href="#">3</a></li>
                    <li><a class="flex items-center justify-center px-4 h-10 text-text-sub bg-surface-dark border border-border-dark hover:bg-white/5 hover:text-white transition-colors" href="#">4</a></li>
                    <li><a class="flex items-center justify-center px-4 h-10 text-text-sub bg-surface-dark border border-border-dark hover:bg-white/5 hover:text-white transition-colors" href="#">5</a></li>
                    <li><a class="flex items-center justify-center px-4 h-10 text-text-sub bg-surface-dark border border-border-dark rounded-r-lg hover:bg-white/5 hover:text-white transition-colors" href="#"><span class="material-symbols-outlined text-sm">chevron_right</span></a></li>
                </ul>
            </div>

        </div>
    </div>
</body>
</html>
