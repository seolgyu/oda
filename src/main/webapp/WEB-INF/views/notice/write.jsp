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
    <nav class="flex items-center text-sm text-text-secondary mb-4">
      <a class="hover:text-white transition-colors" href="#">홈</a>
      <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
      <a class="hover:text-white transition-colors" href="#">서비스 관리</a>
      <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
      <span class="text-white font-medium">공지사항</span>
      <span class="material-symbols-outlined text-[16px] mx-1">chevron_right</span>
      <span class="text-white font-medium">공지사항 작성</span>
    </nav>

    <!-- Page Heading -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8 w-full">
      <div class="flex flex-col gap-2">
        <h1 class="text-3xl md:text-4xl font-bold text-white tracking-tight">공지사항 작성</h1>
        <p class="text-text-secondary text-base max-w-2xl">
          서비스 이용자들에게 전달할 공지사항을 작성합니다.
        </p>
      </div>
      <div class="flex gap-3">
        <button class="px-4 py-2 rounded-lg border border-border-dark text-text-secondary hover:text-white hover:bg-surface-dark text-sm font-medium transition-colors">
          취소
        </button>
        <button class="px-6 py-2 rounded-lg bg-primary hover:bg-primary-dark text-white text-sm font-medium shadow-lg shadow-primary/20 transition-all flex items-center gap-2">
          <span class="material-symbols-outlined text-[18px]">send</span>
          등록
        </button>
      </div>
    </div>

    <!-- Main Form Card -->
    <div class="w-full rounded-xl border border-border-dark shadow-sm overflow-hidden bg-surface-dark p-6 md:p-8 flex flex-col gap-6">
      
      <!-- Title -->
      <div class="flex flex-col gap-2">
        <label class="text-sm font-semibold text-white" for="title">
          제목 <span class="text-red-500">*</span>
        </label>
        <input
          id="title"
          type="text"
          placeholder="공지사항 제목을 입력하세요"
          class="w-full rounded-lg border border-border-dark bg-background-dark px-4 py-3 text-base text-white placeholder-text-secondary focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all"
        />
      </div>

      <!-- Meta Info -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-6">
        <!-- Author -->
        <div class="lg:col-span-4 flex flex-col gap-2">
          <label class="text-sm font-medium text-text-secondary">작성자</label>
          <div class="flex items-center gap-2 px-4 py-2.5 rounded-lg border border-border-dark bg-background-dark text-white">
            <span class="material-symbols-outlined text-[18px]">person</span>
            <span class="text-sm">관리자 (Admin)</span>
          </div>
        </div>
        <!-- Date -->
        <div class="lg:col-span-4 flex flex-col gap-2">
          <label class="text-sm font-medium text-text-secondary">작성일자</label>
          <div class="flex items-center gap-2 px-4 py-2.5 rounded-lg border border-border-dark bg-background-dark text-white">
            <span class="material-symbols-outlined text-[18px]">calendar_today</span>
            <span class="text-sm">2023-10-27</span>
          </div>
        </div>
        <!-- Options -->
        <div class="lg:col-span-4 flex flex-col gap-2">
          <label class="text-sm font-medium text-text-secondary">설정 옵션</label>
          <div class="flex items-center gap-6 h-full pt-1">
            <label class="flex items-center gap-2 cursor-pointer group">
              <input
                type="checkbox"
                class="w-5 h-5 rounded border border-border-dark text-primary focus:ring-primary bg-background-dark cursor-pointer"
              />
              <span class="text-sm font-medium text-white group-hover:text-primary transition-colors">
                상단 고정 (공지)
              </span>
            </label>
            <label class="flex items-center gap-2 cursor-pointer group">
              <input
                type="checkbox"
                checked
                class="w-5 h-5 rounded border border-border-dark text-primary focus:ring-primary bg-background-dark cursor-pointer"
              />
              <span class="text-sm font-medium text-white group-hover:text-primary transition-colors">
                공개 여부
              </span>
            </label>
          </div>
        </div>
      </div>

      <!-- Content -->
      <hr class="border-border-dark/50 my-4"/>
      <div class="flex flex-col gap-2">
        <label class="text-sm font-semibold text-white">내용</label>
        <textarea
          placeholder="내용을 입력하세요..."
          rows="15"
          class="w-full resize-y border border-border-dark rounded-lg bg-background-dark p-4 text-white placeholder-text-secondary focus:ring-0 outline-none"
        ></textarea>
      </div>

    </div>
  </div>
</div>