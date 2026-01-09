<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ODA Admin - 공지사항 상세페이지</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<style>
:root {
	--bs-body-font-family: 'Inter', sans-serif;
	--primary-color: #2563EB;
	--primary-hover: #1D4ED8;
	--background-dark: #0F172A;
	--surface-dark: #1E293B;
	--border-dark: #334155;
	--text-muted: #94A3B8;
	--comment-box-bg: #1e293b;
	--heart-red: #EF4444;
}
        body {
            font-family: var(--bs-body-font-family);
            background-color: #111827;
            color: #F8FAFC;
            margin: 0;
            padding: 0;
        }

        .content-wrapper {
            flex: 1;
        }
        
/* 홈 > 서비스관리 > 공지사항 */
.breadcrumb-item + .breadcrumb-item::before {
     color: var(--text-secondary);
     content: "chevron_right";
     font-family: 'Material Symbols Outlined';
     font-size: 14px;
     vertical-align: middle;
     
     display: inline-block; 
     transform: translateY(6px); 
     
     line-height: 1;
     margin-right: 3px;
     margin-left: 3px;
}

.breadcrumb-item a {
     color: var(--text-secondary);
     text-decoration: none;
     line-height: 1;
}
        
.breadcrumb-item a:hover {
     color: var(--primary-color);
}

.breadcrumb-item.active {
     color: #fff;
}

        .view-card {
            background-color: var(--surface-dark);
            border: 1px solid #374151;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .view-header {
            padding: 1.5rem;
            background-color: rgba(255,255,255,0.02);
        }
        .view-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1rem;
            text-align: center;
        }
        .title-divider {
            border-top: 1px solid #374151;
            margin-bottom: 1rem;
        }
        .view-info-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #94A3B8;
            font-size: 0.875rem;
        }
        .view-content {
            padding: 2rem 2rem 1rem 2rem;
            min-height: 300px;
            line-height: 1.6;
            color: #E2E8F0;
            border-top: 1px solid #374151;
        }
        .like-button-container {
            padding: 2rem 0 3rem 0;
            display: flex;
            justify-content: center;
        }
        .btn-like {
            background-color: transparent;
            border: 1.5px solid #4B5563;
            color: #D1D5DB;
            border-radius: 2rem;
            padding: 0.6rem 2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .btn-like:hover {
            border-color: var(--heart-red);
            color: var(--heart-red);
            background-color: rgba(239, 68, 68, 0.05);
        }
        .btn-like.active {
            border-color: var(--heart-red);
            color: var(--heart-red);
            background-color: rgba(239, 68, 68, 0.1);
        }
        .btn-like .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400;
        }
        .btn-like.active .material-symbols-outlined {
            font-variation-settings: 'FILL' 1, 'wght' 400;
            color: var(--heart-red);
        .content-image-placeholder {
            max-width: 100%;
            margin: 1.5rem 0;
            border-radius: 0.375rem;
            border: 1px solid #334155;
        }
        .navigation-links {
            border-top: 1px solid #374151;
        }
        .nav-item-link {
            padding: 0.75rem 1.5rem;
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #94A3B8;
            font-size: 0.875rem;
            transition: background-color 0.2s;
        }
        .nav-item-link:hover {
            background-color: rgba(255,255,255,0.05);
            color: #fff;
        }
        .nav-item-link:not(:last-child) {
            border-bottom: 1px solid #374151;
        }
        .nav-label {
            font-weight: 600;
            margin-right: 1rem;
            color: #D1D5DB;
            min-width: 60px;
        }
        .action-footer {
            padding: 1.5rem;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            border-top: 1px solid #374151;
        }
        .btn-action {
            padding: 0.5rem 1.50rem;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: 0.375rem;
            transition: all 0.2s;
        }
        .btn-outline-custom {
            border: 1px solid #4B5563;
            color: #D1D5DB;
            background: transparent;
        }
        .btn-outline-custom:hover {
            background-color: #374151;
            color: #fff;
        }
        .btn-list {
            background-color: #334155;
            border: 1px solid #475569;
            color: #F8FAFC;
        }
        .btn-list:hover {
            background-color: #475569;
            color: #fff;
        }
        .comments-section {
            padding: 2rem 1.5rem;
            border-top: 1px solid #374151;
            background-color: rgba(0,0,0,0.1);
        }
        .comment-header {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .comment-input-container {
            margin-bottom: 2rem;
            background: #0F172A;
            border: 1px solid #334155;
            border-radius: 0.5rem;
            padding: 1rem;
        }
        .comment-textarea {
            background: transparent;
            border: none;
            color: #F1F5F9;
            width: 100%;
            resize: none;
            min-height: 80px;
            font-size: 0.9375rem;
        }
        .comment-textarea:focus {
            outline: none;
        }
        .comment-input-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 0.5rem;
        }
        .btn-register {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.4rem 1.25rem;
            font-size: 0.875rem;
            border-radius: 0.375rem;
        }
        .btn-register:hover {
            background-color: var(--primary-hover);
            color: white;
        }
        .comment-list {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }
        .comment-box {
            background-color: var(--comment-box-bg);
            border: 1px solid #334155;
            border-radius: 0.5rem;
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
        }
        .comment-meta {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            gap: 0.75rem;
        }
        .comment-author {
            font-weight: 600;
            font-size: 0.875rem;
            color: #F8FAFC;
        }
        .comment-date {
            font-size: 0.75rem;
            color: #94A3B8;
        }
        .reply-count-trigger {
            cursor: pointer;
            text-decoration: none;
            color: var(--primary-color);
            margin-left: 0.25rem;
        }
        .reply-count-trigger:hover {
            text-decoration: underline;
        }
        .comment-body {
            font-size: 0.9375rem;
            color: #CBD5E1;
            line-height: 1.5;
            margin-bottom: 0.5rem;
        }
        .comment-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        .btn-reply, .btn-view-replies {
            background: none;
            border: none;
            color: #64748B;
            font-size: 0.75rem;
            padding: 0;
            display: flex;
            align-items: center;
            gap: 0.25rem;
            cursor: pointer;
            transition: color 0.2s;
        }
        .btn-reply:hover, .btn-view-replies:hover {
            color: #94A3B8;
        }
        .re-comment-container {
            margin-top: 1rem;
            padding-left: 1.5rem;
            display: none;
            flex-direction: column;
            gap: 1.25rem;
        }
        .reply-toggle-check {
            display: none;
        }
        .reply-toggle-check:checked ~ .re-comment-container {
            display: flex;
        }
        .re-comment-item {
            padding: 0;
            display: flex;
            flex-direction: column;
            background: transparent;
            border: none;
        }
        .material-symbols-outlined {
            font-size: 1.1rem;
        }

</style>
</head> 
<body class="bg-background-dark text-white">

	<div class="space-background">
        <div class="stars"></div>
        <div class="stars2"></div>
        <div class="stars3"></div>
        <div class="planet planet-1"></div>
        <div class="planet planet-2"></div>
    </div>

    <%@ include file="../home/adminheader.jsp" %>

    <div class="app-body">
        <%@ include file="../home/adminsidebar.jsp" %>
        
	<main class="app-main custom-scrollbar">
			<div class="container-fluid p-4 p-md-5" style="max-width: 1100px;">
    
<div class="d-flex justify-content-between align-items-center mb-4">
   <nav aria-label="breadcrumb">   
      <ol class="breadcrumb mb-0">
         <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">홈</a></li>
         <li class="breadcrumb-item"><a href="#">서비스 관리</a></li>
         <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin.list">리스트</a></li>
         <li aria-current="page" class="breadcrumb-item active">공지사항 상세</li>
      </ol>
   </nav>
   
   <div class="d-flex gap-2">
      <button class="btn btn-action btn-outline-custom">수정</button>
      <button class="btn btn-action btn-outline-custom">삭제</button>
   </div>
</div>

	<div class="view-card">
		<div class="view-header">
			<h1 class="view-title">강사님이 보고있습니다.</h1>
			<div class="title-divider"></div>
			
			<div class="view-info-bar">
				<div>이름 : 관리자</div>
				<div>2025-12-31 09:11:47 <span class="mx-2">|</span> 조회 7</div>
			</div>
		</div>
		
	<div class="view-content">
		<p>안녕하세요. 공지사항 내용입니다.</p>
		<p>시스템 점검 안내 및 교육 일정에 대한 상세 내용을 확인해 주시기 바랍니다.</p>
			<img alt="Announcement Image" class="content-image-placeholder" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBU-bCLB_bG8ykPdI7eLB-HnY3-XXQXn2xqgugPmbR3z4u91yF5yFKJJlRMoO7QBkLJwJrajtYVVbmzPY1bk7OiXBSFFxMyYsA8O-QReyUWV0fSYcCmanxOWFh6dWYsNHM_Q5BPNWguJ781w_meYo5Gysmqeb_gE8q1liKubB-VO-djC6vfIDs44Mm4zIRIQjcdIliZSD_kVYFNYRdefpD9Zm11sfEPYK6VmwuI9vZCGd14sdM2Jrb0DGGhd3sw2e4T2AUwFPCaDa4"/>
		<p>추가 문의사항은 관리자에게 연락 부탁드립니다. 감사합니다.</p>
	</div>
	
	<div class="like-button-container">
		<button class="btn btn-like active">
			<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1, 'wght' 400;">favorite</span>
			좋아요
		</button>
	</div>
	
	<div class="navigation-links">
		<a class="nav-item-link" href="#">
			<span class="nav-label">이전글 :</span>
			<span>시스템 업데이트 공지사항</span>
		</a>
		
		<a class="nav-item-link" href="#">
			<span class="nav-label">다음글 :</span>
			<span class="text-secondary">다음글이 없습니다.</span>
		</a>
	</div>
	
	<div class="comments-section">
	
	<div class="comment-header">
		<span class="material-symbols-outlined">forum</span>
		댓글 3개
	</div>
	
	<div class="comment-input-container">
		<textarea class="comment-textarea" placeholder="댓글을 입력해주세요."></textarea>
	
		<div class="comment-input-footer">
			<button class="btn btn-register">등록</button>
		</div>
	</div>
	
	<div class="comment-list">
	<div class="comment-box">
	
	<div class="comment-meta">
		<span class="comment-author">김철수</span>
			<span class="comment-date">2026-01-01 10:30 
			<label class="reply-count-trigger" for="toggle-replies-1">(1)</label>
		</span>
	</div>

	<div class="comment-body">
		좋은 정보 감사합니다! 시스템 점검 시간이 정확히 언제부터인가요?
	</div>

	<div class="comment-actions">
		<button class="btn-reply">
			<span class="material-symbols-outlined">chat_bubble</span>
			답글 쓰기
		</button>
		<label class="btn-view-replies" for="toggle-replies-1">
			<span class="material-symbols-outlined">expand_more</span>
			답글 보기
		</label>
	</div>
	
	<input class="reply-toggle-check" id="toggle-replies-1" type="checkbox"/>
		<div class="re-comment-container">
			<div class="re-comment-item">
				<div class="comment-meta">
					<span class="comment-author">관리자</span>
					<span class="comment-date">2026-01-01 11:15</span>
				</div>
			<div class="comment-body">
			해당 공지사항 상단 이미지를 참고하시면 시간 확인이 가능하십니다.
			</div>
			
			<div class="comment-actions">
				<button class="btn-reply">답글 쓰기</button>
			</div>
		</div>
		</div>
	</div>
	
	<div class="comment-box">
	<div class="comment-meta">
		<span class="comment-author">이영희</span>
		<span class="comment-date">2026-01-01 14:05 
			<label class="reply-count-trigger" for="toggle-replies-2">(1)</label>
	</span>
	</div>
	<div class="comment-body">
	강사님 화이팅입니다. 좋은 수업 기대하겠습니다!
	</div>

<div class="comment-actions">
<button class="btn-reply">
<span class="material-symbols-outlined">chat_bubble</span>
 답글 쓰기
</button>
<label class="btn-view-replies" for="toggle-replies-2">
<span class="material-symbols-outlined">expand_more</span>
답글 보기
</label>
</div>

<input checked="" class="reply-toggle-check" id="toggle-replies-2" type="checkbox"/>
<div class="re-comment-container">
<div class="re-comment-item">
<div class="comment-meta">
<span class="comment-author">박지민</span>
<span class="comment-date">2026-01-01 15:20</span>
</div>
<div class="comment-body">
저도 정말 기대되네요!
</div>

	<div class="comment-actions">
	<button class="btn-reply">답글 쓰기</button>
	</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="action-footer">
		<button class="btn btn-action btn-list">리스트</button>
	</div>

			</div>
			</div>
		</main>
	</div>
	

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_bbs_util.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_notice.js"></script>

</body>
</html>