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
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet">
    
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

/* ==========================================
   기본 레이아웃
   ========================================== */
body {
    font-family: var(--bs-body-font-family);
    background-color: #111827;
    color: #F8FAFC;
    margin: 0;
    padding: 0;
}

.main-content {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    width: 100%;
}

.content-wrapper {
    padding: 3rem 2rem;
    flex: 1;
}

/* ==========================================
   브레드크럼 네비게이션
   ========================================== */
.breadcrumb-item + .breadcrumb-item::before {
    color: var(--text-muted);
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
    color: var(--text-muted);
    text-decoration: none;
    line-height: 1;
}

.breadcrumb-item a:hover {
    color: var(--primary-color);
}

.breadcrumb-item.active {
    color: #fff;
}

/* ==========================================
   게시글 카드 (view-card)
   ========================================== */
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

/* ==========================================
   좋아요 버튼
   ========================================== */
.like-button-container {
    padding: 1rem 0 2.5rem 0;
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

.btn-like .material-symbols-outlined {
    font-variation-settings: 'FILL' 0, 'wght' 400;
}

/* ==========================================
   이전글/다음글 네비게이션
   ========================================== */
.navigation-links {
    border-top: 1px solid #374151;
}

.nav-item-row {
    padding: 0.75rem 1.5rem;
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #94A3B8;
    font-size: 0.875rem;
    transition: background-color 0.2s;
    border-bottom: 1px solid #374151;
}

.nav-item-row:last-child {
    border-bottom: none;
}

.nav-item-row:hover:not(.nav-item-disabled) {
    background-color: rgba(255,255,255,0.05);
}

.nav-item-row:hover:not(.nav-item-disabled) .nav-title {
    color: #fff;
}

.nav-item-disabled {
    cursor: default;
    color: #64748B;
}

.nav-label {
    font-weight: 600;
    margin-right: 1rem;
    color: #D1D5DB;
    min-width: 80px;
    flex-shrink: 0;
}

.nav-title {
    flex: 1;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    color: #94A3B8;
    transition: color 0.2s;
}

.nav-item-disabled .nav-label,
.nav-item-disabled .nav-title {
    color: #64748B;
}

/* ==========================================
   액션 버튼 푸터
   ========================================== */
.action-footer {
    padding: 1.5rem;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    border-top: 1px solid #374151;
}

.btn-action {
    padding: 0.5rem 1.25rem;
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

/* ==========================================
   첨부파일 섹션
   ========================================== */
.attachment-section {
    padding: 1.5rem;
    background-color: rgba(15, 23, 42, 0.5);
    border-top: 1px solid #374151;
    border-bottom: 1px solid #374151;
}

.attachment-header {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.875rem;
    font-weight: 600;
    color: #94A3B8;
    margin-bottom: 1rem;
}

.attachment-header .material-symbols-outlined {
    font-size: 1.25rem;
    color: #60A5FA;
}

.file-count {
    color: #60A5FA;
    font-weight: 500;
}

.attachment-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.attachment-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1rem;
    background-color: #1E293B;
    border: 1px solid #334155;
    border-radius: 0.375rem;
    color: #E2E8F0;
    text-decoration: none;
    transition: all 0.2s ease;
}

.attachment-item:hover {
    background-color: #334155;
    border-color: #60A5FA;
    color: #fff;
    transform: translateX(4px);
}

.attachment-item .material-symbols-outlined {
    font-size: 1.25rem;
    color: #60A5FA;
    flex-shrink: 0;
}

.file-name {
    flex: 1;
    font-size: 0.9375rem;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.download-icon {
    opacity: 0;
    transition: opacity 0.2s;
}

.attachment-item:hover .download-icon {
    opacity: 1;
}

/* ==========================================
   댓글 섹션 - 전체 컨테이너
   ========================================== */
.comments-section {
    padding: 2rem 1.5rem;
    border-top: 1px solid #374151;
    background-color: rgba(0,0,0,0.1);
}

/* ==========================================
   댓글 입력 영역
   ========================================== */
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
    transition: background-color 0.2s;
}

.btn-register:hover {
    background-color: var(--primary-hover);
    color: white;
}

/* ==========================================
   댓글 헤더 (개수, 페이지 표시)
   ========================================== */
.comment-header {
    font-size: 1rem;
    font-weight: 600;
    margin-bottom: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: #F8FAFC;
}

/* ==========================================
   댓글 리스트 컨테이너
   ========================================== */
.comment-list,
.list-content {
    display: flex;
    flex-direction: column;
    gap: 1.25rem;
    width: 100%;
}

/* 비어있을 때도 최소 공간 확보 */
.list-content:empty::after {
    content: '';
    display: block;
    min-height: 1px;
}
#listReply .list-content {
    display: flex !important;
    flex-direction: column !important;
    gap: 1.25rem !important;
    width: 100% !important;
}

#listReply .comment-box {
    display: flex !important;
    flex-direction: column !important;
}

/* ==========================================
   개별 댓글 박스
   ========================================== */
.comment-box {
    background-color: var(--comment-box-bg);
    border: 1px solid #334155;
    border-radius: 0.5rem;
    padding: 1.25rem;
    display: flex;
    flex-direction: column;
}

/* 댓글 메타 정보 (작성자, 날짜, 메뉴) */
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

/* 댓글 내용 */
.comment-body {
    font-size: 0.9375rem;
    color: #CBD5E1;
    line-height: 1.5;
    margin-bottom: 0.75rem;
}

/* 숨겨진 댓글 스타일 */
.comment-body.text-primary.text-opacity-50 {
    color: rgba(37, 99, 235, 0.5) !important;
}

/* ==========================================
   댓글 액션 버튼 (답글, 좋아요/싫어요)
   ========================================== */
.comment-actions {
    display: flex;
    gap: 1rem;
    align-items: center;
    flex-wrap: wrap;
}

.btn-reply, 
.btn-view-replies {
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

.btn-reply:hover, 
.btn-view-replies:hover {
    color: #94A3B8;
}

/* ==========================================
   댓글 드롭다운 메뉴 (삭제, 숨김, 차단 등)
   ========================================== */
.reply-dropdown {
    cursor: pointer;
    color: #64748B;
    transition: color 0.2s;
    padding: 0.25rem;
}

.reply-dropdown:hover {
    color: #94A3B8;
}

.reply-menu {
    position: absolute;
    background: #1E293B;
    border: 1px solid #334155;
    border-radius: 0.375rem;
    padding: 0.5rem;
    z-index: 1000;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
    min-width: 120px;
}

.reply-menu-item {
    padding: 0.5rem 0.75rem;
    cursor: pointer;
    color: #E2E8F0;
    font-size: 0.875rem;
    transition: background-color 0.2s;
    border-radius: 0.25rem;
}

.reply-menu-item:hover {
    background-color: #334155;
}

/* ==========================================
   좋아요/싫어요 버튼
   ========================================== */
.btnSendReplyLike {
    background-color: transparent;
    border: 1px solid #334155;
    color: #94A3B8;
    padding: 0.25rem 0.75rem;
    font-size: 0.875rem;
    border-radius: 0.375rem;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    transition: all 0.2s;
}

.btnSendReplyLike:hover {
    background-color: #334155;
    border-color: #475569;
    color: #fff;
}

.btnSendReplyLike i {
    font-size: 1rem;
}

/* ==========================================
   답글 컨테이너
   ========================================== */
.re-comment-container {
    margin-top: 1rem;
    padding-left: 1.5rem;
    display: none;
    flex-direction: column;
    gap: 1.25rem;
}

/* d-none이 아닐 때만 표시 */
.re-comment-container:not(.d-none) {
    display: flex;
}

.answer-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.re-comment-item {
    padding: 1rem;
    display: flex;
    flex-direction: column;
    background: #0F172A;
    border: 1px solid #334155;
    border-radius: 0.5rem;
}

/* ==========================================
   페이징
   ========================================== */
.list-footer {
    margin-top: 1.5rem;
}

.page-navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
}

/* ==========================================
   Material Symbols 아이콘
   ========================================== */
.material-symbols-outlined {
    font-size: 1.1rem;
    vertical-align: middle;
}

/* ==========================================
   반응형 디자인
   ========================================== */
@media (max-width: 768px) {
    .comment-meta {
        flex-wrap: wrap;
    }
    
    .comment-actions {
        font-size: 0.7rem;
    }
    
    .re-comment-container {
        padding-left: 0.75rem;
    }
    
    .view-content {
        padding: 1.5rem 1rem;
    }
    
    .comments-section {
        padding: 1.5rem 1rem;
    }
}

/* ==========================================
   유틸리티 클래스
   ========================================== */
.d-none {
    display: none !important;
}

.text-primary {
    color: #2563EB !important;
}

.text-opacity-50 {
    opacity: 0.5 !important;
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
			<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/notice/list">공지사항 리스트</a></li>
			<li aria-current="page" class="breadcrumb-item active">공지사항 상세</li>
		</ol>
	</nav>
	
	<div class="d-flex gap-2">
	<c:choose>
		<c:when test="${sessionScope.member.userId==dto.user_id}">
			<button type="button" class="btn btn-action btn-outline-custom" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.notice_num}&page=${page}&size=${size}';">수정</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-action btn-outline-custom" disabled>수정</button>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${sessionScope.member.userId==dto.user_id}">
			<button type="button" class="btn btn-action btn-outline-custom" onclick="deleteOk();">삭제</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-action btn-outline-custom" disabled>삭제</button>
		</c:otherwise>
	</c:choose>
	</div>
</div>


	<div class="view-card">
		<div class="view-header">
			<h1 class="view-title">${dto.noti_title}</h1>
			<div class="title-divider"></div>
			
			<div class="view-info-bar">
				<div>이름 : ${dto.user_nickname}</div>
				<div>${dto.noti_reg_date } <span class="mx-2">|</span> 조회 ${dto.noti_hitCount }</div>
			</div>
		</div>
		
	<div class="view-content">
		${dto.noti_content}
	</div>
	<c:if test="${listFile.size() != 0}">
    <div class="attachment-section">
        <div class="attachment-header">
            <i class="material-symbols-outlined">attach_file</i>
            <span>첨부파일</span>
            <span class="file-count">(${listFile.size()})</span>
        </div>
        <div class="attachment-list">
            <c:forEach var="vo" items="${listFile}" varStatus="status">
                <a href="${pageContext.request.contextPath}/admin/notice/download?fileNum=${vo.fileNum}" 
                   class="attachment-item">
                    <i class="material-symbols-outlined">description</i>
                    <span class="file-name">${vo.originalFilename}</span>
                    <i class="material-symbols-outlined download-icon">download</i>
                </a>
            </c:forEach>
        </div>
    </div>
	</c:if>
	<div class="like-button-container">
		<button class="btn btn-like">
			<span class="material-symbols-outlined">favorite</span>
		</button>
	</div>
	
	<div class="navigation-links">
    <c:if test="${not empty prevDto}">
        <a class="nav-item-row" href="${pageContext.request.contextPath}/admin/notice/article?${query}&num=${prevDto.notice_num}">
            <span class="nav-label">이전글</span>
            <span class="nav-title"><c:out value="${prevDto.noti_title}"/></span>
        </a>
    </c:if>
    <c:if test="${empty prevDto}">
        <div class="nav-item-row nav-item-disabled">
            <span class="nav-label">이전글</span>
            <span class="nav-title">이전글이 없습니다.</span>
        </div>
    </c:if>
    
    <c:if test="${not empty nextDto}">
        <a class="nav-item-row" href="${pageContext.request.contextPath}/admin/notice/article?${query}&num=${nextDto.notice_num}">
            <span class="nav-label">다음글</span>
            <span class="nav-title"><c:out value="${nextDto.noti_title}"/></span>
        </a>
    </c:if>
    <c:if test="${empty nextDto}">
        <div class="nav-item-row nav-item-disabled">
            <span class="nav-label">다음글</span>
            <span class="nav-title">다음글이 없습니다.</span>
        </div>
    </c:if>
</div>
	
	<div class="comments-section">
    
    <!-- 댓글 입력창 -->
    <div class="comment-input-container">
        <textarea class="comment-textarea" name="content" placeholder="댓글을 입력해주세요."></textarea>
        <div class="comment-input-footer">
            <button class="btn btn-register btnSendReply">등록</button>
        </div>
    </div>
    
    <!-- ✅ 댓글 리스트 영역 -->
    <div id="listReply" 
         data-contextPath="${pageContext.request.contextPath}" 
         data-postsUrl="${pageContext.request.contextPath}/admin/notice"
         data-num="${dto.notice_num}"
         data-liked="1">
        
        <!-- 댓글 헤더 (개수, 페이지 정보) -->
        <div class="comment-header">
            <span class="material-symbols-outlined">forum</span>
            <span class="reply-count"></span>
            <span class="reply-page"></span>
        </div>
        
        <!-- ✅ 댓글 컨텐츠 영역 (동적으로 삽입될 부분) -->
        <div class="comment-list list-content" data-pageNo="0" data-totalPage="0">
            <!-- 여기에 renderReplies()가 생성한 HTML이 삽입됨 -->
        </div>
        
        <!-- 페이징 -->
        <div class="list-footer">
            <div class="page-navigation"></div>
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
	<script type="text/javascript">
		function deleteOk() {
		    if(confirm('게시글을 삭제 하시 겠습니까 ? ')) {
			    let params = 'num=${dto.notice_num}&${query}';
			    let url = '${pageContext.request.contextPath}/admin/notice/delete?' + params;
		    	location.href = url;
		    }
		}
	</script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_bbs_reply.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_bbs_util.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_notice.js"></script>

</body>
</html>