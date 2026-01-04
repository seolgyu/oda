<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>

    <!-- Material Symbols (아이콘용) -->
    <link
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
      rel="stylesheet"
    />

    <!-- notice 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">
</head>

<body>
    <%@ include file="/WEB-INF/views/home/adminheader.jsp"%>
    <%@ include file="/WEB-INF/views/home/adminsidebar.jsp"%>

    <!-- Scrollable  -->
    <div class="feed-scroll-container custom-scrollbar admin-list">
        <div class="d-flex flex-column align-items-center py-4 px-3">

            <!-- Breadcrumbs -->
            <nav class="flex items-center text-sm text-text-sub">
                <a class="hover:text-white transition-colors" href="#">홈</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <a class="hover:text-white transition-colors" href="#">서비스 관리</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <span class="text-white font-medium">공지사항</span>
            </nav>

            <!-- Page Heading -->
            <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8">
                <div class="flex flex-col gap-2">
                    <h1 class="text-3xl md:text-4xl font-bold text-white tracking-tight">공지사항</h1>
                    <p class="text-text-sub text-base max-w-2xl">서비스 이용자들에게 전달할 주요 소식과 업데이트 내용을 공지합니다.</p>
                </div>
                <button class="flex items-center gap-2 text-white font-medium py-2.5 px-5 rounded-lg transition-all"
                        style="background-color: var(--primary);" 
                        onmouseover="this.style.backgroundColor='var(--primary-dark)';" 
                        onmouseout="this.style.backgroundColor='var(--primary)';">
                    <span class="material-symbols-outlined text-[20px]">edit_square</span>
                    <span>공지사항 작성</span>
                </button>
            </div>

            <!-- Main Form Card -->
            <div class="flex flex-col lg:flex-row justify-between items-stretch lg:items-center gap-4 p-1"
                 style="background-color: var(--surface-dark); border: 1px solid var(--border-dark); border-radius: 0.75rem;">
                <div class="flex p-1 gap-1 overflow-x-auto no-scrollbar">
                    <button class="px-4 py-2 text-sm font-medium text-white"
                            style="background-color: var(--primary); border: 1px solid var(--primary); border-radius: 0.5rem;">
                        전체보기
                    </button>
                    <button class="px-4 py-2 text-sm font-medium text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors">
                        중요 공지
                    </button>
                    <button class="px-4 py-2 text-sm font-medium text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors">
                        일반 공지
                    </button>
                    <button class="px-4 py-2 text-sm font-medium text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors">
                        비공개
                    </button>
                </div>

                <div class="flex items-center gap-3 px-1 lg:px-2 pb-1 lg:pb-0">
                    <div class="relative w-full lg:w-80 group">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-text-sub group-focus-within:text-primary transition-colors">
                            <span class="material-symbols-outlined">search</span>
                        </div>
                        <input class="block w-full py-2 pl-10 pr-4 text-sm text-white placeholder:text-text-sub bg-background-dark border border-border-dark rounded-lg outline-none"
                               placeholder="제목, 작성자 검색..." type="text"/>
                    </div>
                    <div class="h-6 w-px" style="background-color: var(--border-dark); margin: 0 0.25rem;"></div>
                    <button class="flex items-center justify-center p-2 text-text-sub hover:text-white hover:bg-white/5 rounded-lg transition-colors" title="새로고침">
                        <span class="material-symbols-outlined">refresh</span>
                    </button>
                </div>
            </div>

            <div class="bg-surface-dark rounded-xl border border-border-dark overflow-hidden"
                 style="box-shadow: 0 4px 20px rgba(0,0,0,0.4);">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-text-sub">
                        <thead class="text-xs uppercase text-text-sub" style="border-bottom: 1px solid var(--border-dark); background-color: rgba(0,0,0,0.2);">
                            <tr>
                                <th class="p-4 w-10"><input class="w-4 h-4 text-primary bg-background-dark border-border-dark rounded" type="checkbox"/></th>
                                <th class="px-6 py-4 w-20 text-center font-medium">번호</th>
                                <th class="px-6 py-4 w-28 text-center font-medium">유형</th>
                                <th class="px-6 py-4 font-medium">제목</th>
                                <th class="px-6 py-4 w-40 text-center font-medium">작성자</th>
                                <th class="px-6 py-4 w-32 text-center font-medium">작성일</th>
                                <th class="px-6 py-4 w-24 text-center font-medium">조회수</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y" style="border-color: var(--border-dark);">
                            <!-- 테이블 행들은 기존 HTML 유지, bg-primary/5 → var(--primary) / hover 색상 변수로 적용 가능 -->
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 페이징 -->
            <div class="flex items-center justify-center mt-6">
                <nav aria-label="Page navigation">
                    <ul class="inline-flex items-center -space-x-px text-sm">
                        <li>
                            <a class="flex items-center justify-center px-3 h-8 leading-tight text-text-sub bg-surface-dark border border-border-dark rounded-l-lg hover:bg-white/5 hover:text-white transition-colors" href="#">
                                <span class="material-symbols-outlined text-sm">chevron_left</span>
                            </a>
                        </li>
                        <li>
                            <a class="flex items-center justify-center px-3 h-8 text-white bg-primary border border-primary transition-colors font-medium z-10" href="#">1</a>
                        </li>
                        <li>
                            <a class="flex items-center justify-center px-3 h-8 leading-tight text-text-sub bg-surface-dark border border-border-dark hover:bg-white/5 hover:text-white transition-colors" href="#">2</a>
                        </li>
                        <!-- 나머지 페이지 버튼 동일 -->
                    </ul>
                </nav>
            </div>

        </div>
    </div>
</body>