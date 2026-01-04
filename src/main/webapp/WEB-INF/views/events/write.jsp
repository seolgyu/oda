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

    <div class="feed-scroll-container custom-scrollbar admin-create">
        <div class="d-flex flex-column align-items-center py-4 px-3">

            <!-- Breadcrumbs -->
            <nav class="flex items-center text-sm text-text-sub mb-4">
                <a class="hover:text-white transition-colors" href="#">홈</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <a class="hover:text-white transition-colors" href="#">서비스 관리</a>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <span class="text-white font-medium">이벤트</span>
                <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
                <span class="text-white font-medium">이벤트 작성</span>
            </nav>

            <!-- Page Heading -->
            <main class="flex-1 overflow-y-auto p-6 lg:p-10 w-full max-w-5xl mx-auto">
                <div class="flex flex-col gap-6">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                        <div>
                            <h1 class="text-3xl font-bold text-white tracking-tight">이벤트 작성</h1>
                            <p class="text-text-sub mt-1">사용자들에게 제공할 새로운 이벤트를 작성합니다.</p>
                        </div>
                        <div class="flex gap-3">
                            <button class="px-4 py-2 rounded-lg border border-border-dark text-text-sub hover:text-white hover:bg-surface-dark text-sm font-medium transition-colors">취소</button>
                            <button class="px-6 py-2 rounded-lg bg-primary hover:bg-primary-dark text-white text-sm font-medium shadow-lg shadow-primary/20 transition-all flex items-center gap-2">
                                <span class="material-symbols-outlined text-[18px]">send</span>
                                작성 완료
                            </button>
                        </div>
                    </div>

                    <!-- Form Card -->
                    <div class="bg-surface-dark border border-border-dark rounded-xl p-6 lg:p-8 shadow-xl flex flex-col gap-6">
                        
                        <!-- 제목 -->
                        <div class="flex flex-col gap-2">
                            <label class="text-white text-sm font-semibold">제목 <span class="text-red-500">*</span></label>
                            <input class="w-full bg-background-dark border border-border-dark rounded-lg px-4 py-3 text-white placeholder-text-sub focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all" placeholder="이벤트 제목을 입력해주세요" type="text"/>
                        </div>

                        <!-- 작성자 / 작성일 / 기간 -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-6">
                            <div class="lg:col-span-3 flex flex-col gap-2">
                                <label class="text-text-sub text-sm font-medium">작성자</label>
                                <div class="flex items-center gap-3 bg-background-dark border border-border-dark rounded-lg px-3 py-2.5">
                                    <div class="h-6 w-6 rounded-full bg-gradient-to-tr from-green-500 to-emerald-700 flex items-center justify-center text-[10px] font-bold text-white">AD</div>
                                    <span class="text-white text-sm">시스템 관리자</span>
                                    <span class="material-symbols-outlined text-text-sub text-[16px] ml-auto">lock</span>
                                </div>
                            </div>
                            <div class="lg:col-span-3 flex flex-col gap-2">
                                <label class="text-text-sub text-sm font-medium">작성일자</label>
                                <input class="w-full bg-background-dark border border-border-dark rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary" type="date" value="2023-10-27"/>
                            </div>
                            <div class="md:col-span-2 lg:col-span-6 flex flex-col gap-2">
                                <label class="text-text-sub text-sm font-medium">이벤트 기간 설정</label>
                                <div class="flex items-center gap-2">
                                    <input class="w-full bg-background-dark border border-border-dark rounded-lg px-3 py-2.5 text-white text-sm focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="시작일" type="date"/>
                                    <span class="text-text-sub text-sm">~</span>
                                    <input class="w-full bg-background-dark border border-border-dark rounded-lg px-3 py-2.5 text-white text-sm focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary" placeholder="종료일" type="date"/>
                                </div>
                            </div>
                        </div>

                        <!-- 내용 에디터 -->
                        <div class="flex flex-col gap-2 mt-2">
                            <label class="text-white text-sm font-semibold">내용</label>
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
                                <textarea class="w-full bg-background-dark p-4 text-white placeholder-text-sub min-h-[350px] focus:outline-none resize-y" placeholder="이벤트 내용을 입력하세요..."></textarea>
                            </div>
                        </div>

                        <!-- 첨부파일 -->
                        <div class="flex flex-col gap-2 mt-2">
                            <label class="text-white text-sm font-semibold flex justify-between">
                                <span>첨부파일</span>
                                <span class="text-text-sub text-xs font-normal">최대 10MB / 파일</span>
                            </label>
                            <div class="border-2 border-dashed border-border-dark bg-background-dark/50 rounded-lg p-6 flex flex-col items-center justify-center gap-3 hover:bg-background-dark hover:border-primary transition-all cursor-pointer group">
                                <div class="w-12 h-12 rounded-full bg-surface-dark flex items-center justify-center group-hover:bg-primary/20 transition-colors">
                                    <span class="material-symbols-outlined text-text-sub text-[24px] group-hover:text-primary">upload_file</span>
                                </div>
                                <div class="text-center">
                                    <p class="text-white text-sm font-medium">클릭하여 파일 업로드</p>
                                    <p class="text-text-sub text-xs mt-1">또는 파일을 여기로 드래그 하세요</p>
                                </div>
                            </div>

                            <!-- 업로드된 파일 -->
                            <div class="flex flex-col gap-2 mt-2">
                                <div class="flex items-center justify-between p-3 rounded-lg bg-background-dark border border-border-dark">
                                    <div class="flex items-center gap-3">
                                        <span class="material-symbols-outlined text-blue-400">description</span>
                                        <div>
                                            <p class="text-white text-sm font-medium">2023_서비스_정책변경안.pdf</p>
                                            <p class="text-text-sub text-xs">2.4 MB</p>
                                        </div>
                                    </div>
                                    <button class="text-text-sub hover:text-red-400 p-1">
                                        <span class="material-symbols-outlined text-[20px]">close</span>
                                    </button>
                                </div>
                                <div class="flex items-center justify-between p-3 rounded-lg bg-background-dark border border-border-dark">
                                    <div class="flex items-center gap-3">
                                        <span class="material-symbols-outlined text-green-400">image</span>
                                        <div>
                                            <p class="text-white text-sm font-medium">header_banner_image.png</p>
                                            <p class="text-text-sub text-xs">850 KB</p>
                                        </div>
                                    </div>
                                    <button class="text-text-sub hover:text-red-400 p-1">
                                        <span class="material-symbols-outlined text-[20px]">close</span>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- 모바일 액션 버튼 -->
                        <div class="mt-8 pt-6 border-t border-border-dark flex justify-end gap-3 lg:hidden">
                            <button class="px-4 py-2 rounded-lg border border-border-dark text-text-sub text-sm font-medium">취소</button>
                            <button class="px-6 py-2 rounded-lg bg-primary text-white text-sm font-medium shadow-lg shadow-primary/20">작성 완료</button>
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
