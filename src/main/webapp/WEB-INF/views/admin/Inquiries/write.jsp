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

    <div class="feed-scroll-container custom-scrollbar admin-create">
        <div class="d-flex flex-column align-items-center py-4 px-3">

            <!-- Breadcrumbs -->
            <nav class="flex items-center text-sm text-text-secondary mb-4">
                <a class="hover:text-white transition-colors" href="#">홈</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <a class="hover:text-white transition-colors" href="#">서비스 관리</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <span class="text-white font-medium">문의사항</span>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <span class="text-white font-medium">문의사항 답변 작성</span>
            </nav>

            <!-- Page Heading -->
            <main class="flex-1 overflow-y-auto p-6 lg:p-10 w-full max-w-5xl mx-auto">
                <div class="flex flex-col gap-6">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                        <div>
                            <h1 class="text-3xl font-bold text-white tracking-tight">문의사항 답변</h1>
                            <p class="text-text-sub mt-1">사용자가 남긴 문의에 대해 답변을 작성합니다.</p>
                        </div>
                        <div class="flex gap-3">
                            <button class="px-4 py-2 rounded-lg border border-border-dark text-text-sub hover:text-white hover:bg-surface-dark text-sm font-medium transition-colors">
                                취소
                            </button>
                            <button class="px-6 py-2 rounded-lg bg-primary hover:bg-primary-dark text-white text-sm font-medium shadow-lg shadow-primary/20 transition-all flex items-center gap-2">
                                <span class="material-symbols-outlined text-[18px]">send</span>
                                답변 완료
                            </button>
                        </div>
                    </div>

                    <!-- Inquiry & Answer Form -->
                    <div class="bg-surface-dark border border-border-dark rounded-xl p-6 lg:p-8 shadow-xl flex flex-col gap-6">
                        
                        <!-- Inquiry Title -->
                        <div class="flex flex-col gap-2">
                            <label class="text-white text-sm font-semibold">문의 제목</label>
                            <div class="w-full bg-background-dark border border-border-dark rounded-lg px-4 py-3 text-text-sub">
                                로그인 시 오류가 발생합니다
                            </div>
                        </div>

                        <!-- Inquiry Content -->
                        <div class="flex flex-col gap-2">
                            <label class="text-white text-sm font-semibold">문의 내용</label>
                            <div class="w-full bg-background-dark border border-border-dark rounded-lg p-4 text-text-sub min-h-[150px] leading-relaxed">
                                로그인 버튼을 누르면 오류 메시지가 뜨면서 접속이 되지 않습니다. 이전에 잘 사용했는데 갑자기 이러네요.
                            </div>
                        </div>

                        <div class="h-px bg-border-dark my-2"></div>

                        <!-- Meta Info -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-6">
                            <div class="lg:col-span-6 flex flex-col gap-2">
                                <label class="text-text-sub text-sm font-medium">답변자</label>
                                <div class="flex items-center gap-3 bg-background-dark border border-border-dark rounded-lg px-3 py-2.5">
                                    <div class="h-6 w-6 rounded-full bg-gradient-to-tr from-green-500 to-emerald-700 flex items-center justify-center text-[10px] font-bold text-white">AD</div>
                                    <span class="text-white text-sm">시스템 관리자</span>
                                    <span class="material-symbols-outlined text-text-sub text-[16px] ml-auto">lock</span>
                                </div>
                            </div>
                            <div class="lg:col-span-6 flex flex-col gap-2">
                                <label class="text-text-sub text-sm font-medium">답변일자</label>
                                <input class="w-full bg-background-dark border border-border-dark rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary" type="date" value="2023-10-27"/>
                            </div>
                        </div>

                        <!-- Answer Editor -->
                        <div class="flex flex-col gap-2 mt-2">
                            <label class="text-white text-sm font-semibold">답변 내용</label>
                            <div class="w-full bg-background-dark border border-border-dark rounded-lg overflow-hidden flex flex-col">
                                <div class="bg-surface-dark border-b border-border-dark p-2 flex flex-wrap gap-1">
                                    <!-- Editor buttons -->
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Bold">
                                        <span class="material-symbols-outlined text-[20px]">format_bold</span>
                                    </button>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Italic">
                                        <span class="material-symbols-outlined text-[20px]">format_italic</span>
                                    </button>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Underline">
                                        <span class="material-symbols-outlined text-[20px]">format_underlined</span>
                                    </button>
                                    <div class="w-px h-6 bg-border-dark mx-1 self-center"></div>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Align Left">
                                        <span class="material-symbols-outlined text-[20px]">format_align_left</span>
                                    </button>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Align Center">
                                        <span class="material-symbols-outlined text-[20px]">format_align_center</span>
                                    </button>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Align Right">
                                        <span class="material-symbols-outlined text-[20px]">format_align_right</span>
                                    </button>
                                    <div class="w-px h-6 bg-border-dark mx-1 self-center"></div>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Bullet List">
                                        <span class="material-symbols-outlined text-[20px]">format_list_bulleted</span>
                                    </button>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Numbered List">
                                        <span class="material-symbols-outlined text-[20px]">format_list_numbered</span>
                                    </button>
                                    <div class="w-px h-6 bg-border-dark mx-1 self-center"></div>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Insert Link">
                                        <span class="material-symbols-outlined text-[20px]">link</span>
                                    </button>
                                    <button class="p-1.5 rounded hover:bg-border-dark text-white transition-colors" title="Insert Image">
                                        <span class="material-symbols-outlined text-[20px]">image</span>
                                    </button>
                                </div>
                                <textarea class="w-full bg-background-dark p-4 text-white placeholder-text-sub min-h-[350px] focus:outline-none resize-y" placeholder="답변 내용을 입력하세요..."></textarea>
                            </div>
                        </div>

                        <!-- Mobile Action Buttons -->
                        <div class="mt-8 pt-6 border-t border-border-dark flex justify-end gap-3 lg:hidden">
                            <button class="px-4 py-2 rounded-lg border border-border-dark text-text-sub text-sm font-medium">취소</button>
                            <button class="px-6 py-2 rounded-lg bg-primary text-white text-sm font-medium shadow-lg shadow-primary/20">답변 완료</button>
                        </div>

                    </div>

                    <div class="text-center pb-10">
                        <p class="text-text-sub text-xs">
                            작성된 내용은 관리자 승인 후 즉시 반영됩니다. © 2024 Admin System
                        </p>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
