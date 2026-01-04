<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
</head>

<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-white min-h-screen flex flex-col">

<!-- 로그인 성공 모달 관련 -->
<c:if test="${sessionScope.loginSuccess}">
    <script>
        const showLoginModal = true;
    </script>
    <c:remove var="loginSuccess" scope="session" />
</c:if>

<!-- 헤더와 사이드바 -->
<%@ include file="/WEB-INF/views/home/adminheader.jsp"%>
<%@ include file="/WEB-INF/views/home/adminsidebar.jsp"%>

<main class="flex-1 w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-4 mb-8">
        <div class="space-y-2">
            <h2 class="text-3xl md:text-4xl font-black tracking-tight text-gray-900 dark:text-white">
                반갑습니다, <span class="text-primary">관리자</span>님
            </h2>
            <p class="text-text-secondary text-base md:text-lg max-w-2xl">
                시스템 현황 및 최근 업데이트 개요입니다.
            </p>
        </div>
    </div>

    <div class="flex flex-col gap-6">

        <!-- 회원 통계 -->
        <section>
            <h3 class="text-lg font-bold flex items-center gap-2 mb-4">
                <span class="material-symbols-outlined text-primary">group</span>
                회원 통계
            </h3>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                <!-- 총 가입자 -->
                <div class="bg-white dark:bg-card-dark p-5 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex items-center justify-between group hover:border-primary/50 transition-colors">
                    <div>
                        <p class="text-sm font-medium text-text-secondary mb-1">총 가입자 수</p>
                        <div class="flex items-baseline gap-2">
                            <p class="text-2xl font-bold text-slate-900 dark:text-white">12,543</p>
                            <span class="text-xs font-bold text-blue-500 bg-blue-50 dark:bg-blue-500/10 px-1.5 py-0.5 rounded">+125</span>
                        </div>
                    </div>
                    <div class="size-10 rounded-lg bg-gray-50 dark:bg-white/5 flex items-center justify-center text-text-secondary group-hover:text-primary group-hover:bg-primary/10 transition-colors">
                        <span class="material-symbols-outlined">group_add</span>
                    </div>
                </div>

                <!-- 이용 중 회원 -->
                <div class="bg-white dark:bg-card-dark p-5 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex items-center justify-between group hover:border-emerald-500/50 transition-colors">
                    <div>
                        <p class="text-sm font-medium text-text-secondary mb-1">이용 중인 회원</p>
                        <div class="flex items-baseline gap-2">
                            <p class="text-2xl font-bold text-slate-900 dark:text-white">8,920</p>
                            <span class="text-xs font-bold text-emerald-500 flex items-center">
                                <span class="material-symbols-outlined text-[12px] mr-0.5">trending_up</span> 5.2%
                            </span>
                        </div>
                    </div>
                    <div class="size-10 rounded-lg bg-gray-50 dark:bg-white/5 flex items-center justify-center text-text-secondary group-hover:text-emerald-500 group-hover:bg-emerald-500/10 transition-colors">
                        <span class="material-symbols-outlined">person_check</span>
                    </div>
                </div>

                <!-- 탈퇴 회원 -->
                <div class="bg-white dark:bg-card-dark p-5 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex items-center justify-between group hover:border-red-500/50 transition-colors">
                    <div>
                        <p class="text-sm font-medium text-text-secondary mb-1">탈퇴 회원 수</p>
                        <div class="flex items-baseline gap-2">
                            <p class="text-2xl font-bold text-slate-900 dark:text-white">142</p>
                            <span class="text-xs text-text-secondary">최근 30일</span>
                        </div>
                    </div>
                    <div class="size-10 rounded-lg bg-gray-50 dark:bg-white/5 flex items-center justify-center text-text-secondary group-hover:text-red-500 group-hover:bg-red-500/10 transition-colors">
                        <span class="material-symbols-outlined">person_remove</span>
                    </div>
                </div>

                <!-- 휴먼 회원 -->
                <div class="bg-white dark:bg-card-dark p-5 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex items-center justify-between group hover:border-orange-500/50 transition-colors">
                    <div>
                        <p class="text-sm font-medium text-text-secondary mb-1">휴먼 회원 수</p>
                        <div class="flex items-baseline gap-2">
                            <p class="text-2xl font-bold text-slate-900 dark:text-white">450</p>
                            <span class="text-xs text-orange-400">전환 예정 12</span>
                        </div>
                    </div>
                    <div class="size-10 rounded-lg bg-gray-50 dark:bg-white/5 flex items-center justify-center text-text-secondary group-hover:text-orange-500 group-hover:bg-orange-500/10 transition-colors">
                        <span class="material-symbols-outlined">snooze</span>
                    </div>
                </div>
            </div>
        </section>

<section class="grid grid-cols-1 lg:grid-cols-12 gap-6">
<div class="lg:col-span-9 grid grid-cols-1 md:grid-cols-2 gap-6">
<div class="bg-white dark:bg-card-dark p-6 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex flex-col justify-between h-full min-h-[220px] relative overflow-hidden group hover:border-amber-500/50 transition-colors">
<div class="flex justify-between items-start z-10 h-full flex-col">
<div>
<h3 class="text-base font-medium text-text-secondary flex items-center gap-2 mb-2">
<span class="material-symbols-outlined text-amber-500 text-xl">cloud_upload</span>
                                콘텐츠 업로드 수
                            </h3>
<p class="text-6xl font-black text-slate-900 dark:text-white mt-4 tracking-tight">85</p>
</div>
<div class="text-sm text-amber-500 font-medium flex items-center gap-1 mt-4 bg-amber-50 dark:bg-amber-500/10 w-fit px-3 py-1.5 rounded-lg border border-amber-100 dark:border-amber-500/20">
<span class="material-symbols-outlined text-[16px]">new_releases</span>
                            신규 14건 등록됨
                        </div>
</div>
<div class="absolute -bottom-6 -right-6 text-amber-500/5 rotate-12 transition-transform group-hover:scale-110 duration-500">
<span class="material-symbols-outlined text-[200px]">upload_file</span>
</div>
</div>
<div class="bg-white dark:bg-card-dark p-6 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex flex-col justify-between h-full min-h-[220px] relative overflow-hidden group hover:border-pink-500/50 transition-colors">
<div class="flex justify-between items-start z-10 h-full flex-col">
<div>
<h3 class="text-base font-medium text-text-secondary flex items-center gap-2 mb-2">
<span class="material-symbols-outlined text-pink-500 text-xl">forum</span>
                                개설 커뮤니티 수
                            </h3>
<p class="text-6xl font-black text-slate-900 dark:text-white mt-4 tracking-tight">1,280</p>
</div>
<div class="text-sm text-pink-500 font-medium flex items-center gap-1 mt-4 bg-pink-50 dark:bg-pink-500/10 w-fit px-3 py-1.5 rounded-lg border border-pink-100 dark:border-pink-500/20">
<span class="material-symbols-outlined text-[16px]">trending_up</span>
                            +24 (오늘)
                        </div>
</div>
<div class="absolute -bottom-6 -right-6 text-pink-500/5 rotate-12 transition-transform group-hover:scale-110 duration-500">
<span class="material-symbols-outlined text-[200px]">groups</span>
</div>
</div>
</div>
<div class="lg:col-span-3 flex flex-col gap-6">
<div class="bg-white dark:bg-card-dark p-5 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex items-center justify-between relative overflow-hidden group hover:border-red-500/50 transition-colors flex-1 min-h-[100px]">
<div class="z-10 relative w-full">
<h3 class="text-sm font-medium text-text-secondary flex items-center justify-between gap-2 mb-1">
<span>신고 콘텐츠 수</span>
<span class="material-symbols-outlined text-red-500 text-lg">report</span>
</h3>
<div class="flex items-end justify-between mt-2">
<p class="text-3xl font-black text-slate-900 dark:text-white">12</p>
<span class="text-xs font-bold text-red-500 bg-red-50 dark:bg-red-500/10 px-2 py-0.5 rounded border border-red-100 dark:border-red-500/20">처리필요 3건</span>
</div>
</div>
<div class="absolute right-2 bottom-2 text-red-500/5 rotate-12 group-hover:scale-110 transition-transform duration-500 pointer-events-none">
<span class="material-symbols-outlined text-[80px]">gpp_bad</span>
</div>
</div>
<div class="bg-white dark:bg-card-dark p-5 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm flex items-center justify-between relative overflow-hidden group hover:border-orange-500/50 transition-colors flex-1 min-h-[100px]">
<div class="z-10 relative w-full">
<h3 class="text-sm font-medium text-text-secondary flex items-center justify-between gap-2 mb-1">
<span>신고 커뮤니티 수</span>
<span class="material-symbols-outlined text-orange-500 text-lg">flag</span>
</h3>
<div class="flex items-end justify-between mt-2">
<p class="text-3xl font-black text-slate-900 dark:text-white">3</p>
<span class="text-xs font-bold text-text-secondary bg-gray-100 dark:bg-gray-800 px-2 py-0.5 rounded border border-gray-200 dark:border-gray-700">검토 대기중</span>
</div>
</div>
<div class="absolute right-2 bottom-2 text-orange-500/5 rotate-12 group-hover:scale-110 transition-transform duration-500 pointer-events-none">
<span class="material-symbols-outlined text-[80px]">flag</span>
</div>
</div>
</div>
</section>
<section>
<div class="bg-white dark:bg-card-dark p-6 rounded-xl border border-gray-200 dark:border-border-dark shadow-sm">
<div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
<div>
<h3 class="text-lg font-bold flex items-center gap-2">
<span class="material-symbols-outlined text-primary">ssid_chart</span>
                            방문자 추이 (주간)
                        </h3>
<p class="text-sm text-text-secondary mt-1">지난 7일간의 일반 방문자와 회원 방문자 변화 그래프</p>
</div>
<div class="flex items-center gap-6 bg-gray-50 dark:bg-black/20 px-4 py-2 rounded-lg border border-gray-100 dark:border-white/5">
<div class="flex items-center gap-2">
<span class="size-3 rounded-full bg-blue-500 shadow shadow-blue-500/50"></span>
<div class="flex flex-col">
<span class="text-xs text-text-secondary font-medium uppercase tracking-wider">일반 방문자</span>
<span class="text-lg font-bold leading-none">5,230</span>
</div>
</div>
<div class="w-px h-8 bg-gray-200 dark:bg-white/10"></div>
<div class="flex items-center gap-2">
<span class="size-3 rounded-full bg-purple-500 shadow shadow-purple-500/50"></span>
<div class="flex flex-col">
<span class="text-xs text-text-secondary font-medium uppercase tracking-wider">회원 방문자</span>
<span class="text-lg font-bold leading-none">3,150</span>
</div>
</div>
</div>
</div>
<div class="relative w-full h-[350px] bg-gradient-to-b from-gray-50/50 to-transparent dark:from-white/[0.02] dark:to-transparent rounded-lg border border-gray-100 dark:border-white/5 p-4 overflow-hidden">
<div class="absolute inset-0 flex flex-col justify-between px-10 py-4 pointer-events-none">
<div class="w-full h-px bg-gray-200 dark:bg-white/5 dashed"></div>
<div class="w-full h-px bg-gray-200 dark:bg-white/5"></div>
<div class="w-full h-px bg-gray-200 dark:bg-white/5"></div>
<div class="w-full h-px bg-gray-200 dark:bg-white/5"></div>
<div class="w-full h-px bg-gray-200 dark:bg-white/5"></div>
</div>

<!--  
<svg width="1000" height="300" viewBox="0 0 1000 300" style="width:100%; height:auto; overflow:visible;">
  <defs>
    <linearGradient id="blueGradient" x1="0" x2="0" y1="0" y2="1">
      <stop offset="0%" stop-color="#3b82f6" stop-opacity="0.3"></stop>
      <stop offset="100%" stop-color="#3b82f6" stop-opacity="0"></stop>
    </linearGradient>
    <linearGradient id="purpleGradient" x1="0" x2="0" y1="0" y2="1">
      <stop offset="0%" stop-color="#a855f7" stop-opacity="0.3"></stop>
      <stop offset="100%" stop-color="#a855f7" stop-opacity="0"></stop>
    </linearGradient>
  </defs>
  
  <path d="M50,140 L190,95 L330,110 L470,40 L610,60 L750,5 L890,38 L890,300 L50,300 Z" fill="url(#blueGradient)"></path>
  <path d="M50,195 L190,185 L330,160 L470,170 L610,145 L750,130 L890,142 L890,300 L50,300 Z" fill="url(#purpleGradient)"></path>
  
  <path d="M50,140 L190,95 L330,110 L470,40 L610,60 L750,5 L890,38" 
        fill="none" stroke="#3b82f6" stroke-linecap="round" stroke-linejoin="round" stroke-width="3"></path>
</svg>
-->

<div class="absolute bottom-2 left-0 right-0 flex justify-between px-10 text-xs text-text-secondary font-medium uppercase tracking-wide">
<span>Mon</span>
<span>Tue</span>
<span>Wed</span>
<span>Thu</span>
<span>Fri</span>
<span>Sat</span>
<span>Sun</span>
</div>
</div>
</div>
</section>

<section>
<div class="bg-white dark:bg-card-dark rounded-xl border border-gray-200 dark:border-border-dark shadow-sm overflow-hidden">
<div class="p-6 border-b border-gray-200 dark:border-border-dark flex justify-between items-center">
<h3 class="text-lg font-bold flex items-center gap-2 text-gray-900 dark:text-white">
<span class="material-symbols-outlined text-purple-500">help_center</span>
                        새로 등록된 문의사항
                    </h3>
<a class="text-sm font-medium text-primary hover:text-primary/80 flex items-center gap-1 transition-colors" href="#">
                        전체보기 <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
</a>
</div>
<div class="overflow-x-auto">
<table class="w-full text-left text-sm">
<thead class="bg-gray-50 dark:bg-white/5 border-b border-gray-200 dark:border-border-dark">
<tr>
<th class="px-6 py-4 font-medium text-text-secondary whitespace-nowrap" scope="col">문의 제목</th>
<th class="px-6 py-4 font-medium text-text-secondary whitespace-nowrap" scope="col">작성자</th>
<th class="px-6 py-4 font-medium text-text-secondary whitespace-nowrap" scope="col">작성일</th>
<th class="px-6 py-4 font-medium text-text-secondary whitespace-nowrap" scope="col">상태</th>
<th class="px-6 py-4 font-medium text-text-secondary whitespace-nowrap text-right" scope="col">유형</th>
</tr>
</thead>
<tbody class="divide-y divide-gray-200 dark:divide-border-dark">
<tr class="hover:bg-gray-50 dark:hover:bg-white/5 transition-colors">
<td class="px-6 py-4 font-medium text-gray-900 dark:text-white">
<div class="flex items-center gap-2">
<span class="w-1.5 h-1.5 rounded-full bg-red-500"></span>
                                    로그인이 자꾸 풀립니다
                                </div>
</td>
<td class="px-6 py-4 text-gray-600 dark:text-gray-300">
<div class="flex items-center gap-2">
<div class="size-6 rounded-full bg-purple-100 dark:bg-purple-900/40 flex items-center justify-center text-[10px] font-bold text-purple-600 dark:text-purple-300">
                                        KM
                                    </div>
<span>kim_minsu</span>
</div>
</td>
<td class="px-6 py-4 text-text-secondary whitespace-nowrap">2023.10.25</td>
<td class="px-6 py-4">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-500/10 text-yellow-600 dark:text-yellow-400 border border-yellow-200 dark:border-yellow-500/30">
                                    답변 대기
                                </span>
</td>
<td class="px-6 py-4 text-right">
<div class="flex items-center justify-end gap-2">
<span class="text-xs text-text-secondary">비공개</span>
<span class="material-symbols-outlined text-text-secondary text-[18px]">lock</span>
</div>
</td>
</tr>
<tr class="hover:bg-gray-50 dark:hover:bg-white/5 transition-colors">
<td class="px-6 py-4 font-medium text-gray-900 dark:text-white">
<div class="flex items-center gap-2">
<span class="w-1.5 h-1.5 rounded-full bg-blue-500"></span>
                                    결제 내역 확인 부탁드립니다
                                </div>
</td>
<td class="px-6 py-4 text-gray-600 dark:text-gray-300">
<div class="flex items-center gap-2">
<div class="size-6 rounded-full bg-blue-100 dark:bg-blue-900/40 flex items-center justify-center text-[10px] font-bold text-blue-600 dark:text-blue-300">
                                        LJ
                                    </div>
<span>lee_jiwon</span>
</div>
</td>
<td class="px-6 py-4 text-text-secondary whitespace-nowrap">2023.10.24</td>
<td class="px-6 py-4">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400">
                                    처리중
                                </span>
</td>
<td class="px-6 py-4 text-right">
<div class="flex items-center justify-end gap-2">
<span class="text-xs text-text-secondary">비공개</span>
<span class="material-symbols-outlined text-text-secondary text-[18px]">lock</span>
</div>
</td>
</tr>
<tr class="hover:bg-gray-50 dark:hover:bg-white/5 transition-colors">
<td class="px-6 py-4 font-medium text-gray-900 dark:text-white">
                                새로운 커뮤니티 개설 요청
                            </td>
<td class="px-6 py-4 text-gray-600 dark:text-gray-300">
<div class="flex items-center gap-2">
<div class="size-6 rounded-full bg-green-100 dark:bg-green-900/40 flex items-center justify-center text-[10px] font-bold text-green-600 dark:text-green-300">
                                        PJ
                                    </div>
<span>park_jun</span>
</div>
</td>
<td class="px-6 py-4 text-text-secondary whitespace-nowrap">2023.10.23</td>
<td class="px-6 py-4">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400">
                                    처리중
                                </span>
</td>
<td class="px-6 py-4 text-right">
<div class="flex items-center justify-end gap-2">
<span class="text-xs text-primary">공개</span>
<span class="material-symbols-outlined text-primary text-[18px]">public</span>
</div>
</td>
</tr>
<tr class="hover:bg-gray-50 dark:hover:bg-white/5 transition-colors">
<td class="px-6 py-4 font-medium text-gray-900 dark:text-white text-opacity-60 dark:text-opacity-60">
                                앱 다크모드 설정이 안보여요
                            </td>
<td class="px-6 py-4 text-gray-600 dark:text-gray-300">
<div class="flex items-center gap-2">
<div class="size-6 rounded-full bg-orange-100 dark:bg-orange-900/40 flex items-center justify-center text-[10px] font-bold text-orange-600 dark:text-orange-300">
                                        CS
                                    </div>
<span>choi_sora</span>
</div>
</td>
<td class="px-6 py-4 text-text-secondary whitespace-nowrap">2023.10.22</td>
<td class="px-6 py-4">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400">
                                    답변완료
                                </span>
</td>
<td class="px-6 py-4 text-right">
<div class="flex items-center justify-end gap-2">
<span class="text-xs text-primary">공개</span>
<span class="material-symbols-outlined text-primary text-[18px]">public</span>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<div class="p-4 border-t border-gray-200 dark:border-border-dark flex items-center justify-between">
<span class="text-sm text-text-secondary">Showing 1-4 of 24</span>
<div class="flex gap-1">
<button class="size-8 flex items-center justify-center rounded-lg border border-gray-200 dark:border-border-dark hover:bg-gray-50 dark:hover:bg-white/5 text-text-secondary disabled:opacity-50">
<span class="material-symbols-outlined text-[18px]">chevron_left</span>
</button>
<button class="size-8 flex items-center justify-center rounded-lg border border-gray-200 dark:border-border-dark hover:bg-gray-50 dark:hover:bg-white/5 text-text-secondary">
<span class="material-symbols-outlined text-[18px]">chevron_right</span>
</button>
</div>
</div>
</div>
</section>
</div>
</main>

<footer class="border-t border-gray-200 dark:border-border-dark py-6 mt-auto">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col sm:flex-row justify-between items-center gap-4 text-sm text-text-secondary">
        <p>© 2023 ODA Admin System. All rights reserved.</p>
        <div class="flex gap-6">
            <a class="hover:text-primary transition-colors" href="#">개인정보처리방침</a>
            <a class="hover:text-primary transition-colors" href="#">이용약관</a>
            <a class="hover:text-primary transition-colors" href="#">고객센터</a>
        </div>
    </div>
</footer>

</body>
</html>
