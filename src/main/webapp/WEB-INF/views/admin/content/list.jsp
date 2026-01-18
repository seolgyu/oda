<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ODA Admin - 콘텐츠 관리</title>
    
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
    --success-color: #10B981;
    --warning-color: #F59E0B;
    --danger-color: #EF4444;
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
}

.breadcrumb-item a:hover {
    color: var(--primary-color);
}

.breadcrumb-item.active {
    color: #fff;
}

/* ==========================================
   페이지 헤더
   ========================================== */
.page-header {
    margin-bottom: 2rem;
}

.page-title {
    font-size: 1.875rem;
    font-weight: 700;
    color: #fff;
    margin-bottom: 0.5rem;
}

.page-description {
    color: var(--text-muted);
    font-size: 0.9375rem;
}

/* ==========================================
   검색 및 필터 영역
   ========================================== */
.search-filter-card {
    background-color: var(--surface-dark);
    border: 1px solid #374151;
    border-radius: 0.75rem;
    padding: 1.5rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.filter-row {
    display: flex;
    gap: 1rem;
    align-items: flex-end;
    flex-wrap: wrap;
}

.filter-group {
    flex: 1;
    min-width: 200px;
}

.filter-label {
    display: block;
    font-size: 0.875rem;
    font-weight: 500;
    color: #D1D5DB;
    margin-bottom: 0.5rem;
}

.filter-select,
.filter-input {
    width: 100%;
    padding: 0.625rem 1rem;
    background-color: rgba(15, 23, 42, 0.5);
    border: 1px solid #334155;
    border-radius: 0.5rem;
    color: #E2E8F0;
    font-size: 0.9375rem;
    transition: all 0.2s ease;
}

.filter-select:focus,
.filter-input:focus {
    outline: none;
    border-color: var(--primary-color);
    background-color: rgba(15, 23, 42, 0.8);
    box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
}

.filter-select option {
    background-color: #1E293B;
    color: #E2E8F0;
}

.btn-search {
    padding: 0.625rem 2rem;
    background-color: var(--primary-color);
    color: white;
    border: none;
    border-radius: 0.5rem;
    font-weight: 500;
    font-size: 0.9375rem;
    transition: all 0.2s;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-search:hover {
    background-color: var(--primary-hover);
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

.btn-reset {
    padding: 0.625rem 1.5rem;
    background-color: transparent;
    color: #D1D5DB;
    border: 1px solid #4B5563;
    border-radius: 0.5rem;
    font-weight: 500;
    font-size: 0.9375rem;
    transition: all 0.2s;
    cursor: pointer;
}

.btn-reset:hover {
    background-color: #374151;
    border-color: #6B7280;
}

/* ==========================================
   통계 카드
   ========================================== */
.stats-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.stat-card {
    background-color: var(--surface-dark);
    border: 1px solid #374151;
    border-radius: 0.75rem;
    padding: 1.5rem;
    display: flex;
    align-items: center;
    gap: 1rem;
    transition: all 0.2s;
}

.stat-card:hover {
    border-color: #475569;
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.stat-icon {
    width: 3rem;
    height: 3rem;
    border-radius: 0.75rem;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}

.stat-icon.primary {
    background-color: rgba(37, 99, 235, 0.1);
    color: var(--primary-color);
}

.stat-icon.success {
    background-color: rgba(16, 185, 129, 0.1);
    color: var(--success-color);
}

.stat-icon.warning {
    background-color: rgba(245, 158, 11, 0.1);
    color: var(--warning-color);
}

.stat-icon.danger {
    background-color: rgba(239, 68, 68, 0.1);
    color: var(--danger-color);
}

.stat-content {
    flex: 1;
}

.stat-label {
    font-size: 0.875rem;
    color: var(--text-muted);
    margin-bottom: 0.25rem;
}

.stat-value {
    font-size: 1.5rem;
    font-weight: 700;
    color: #fff;
}

/* ==========================================
   회원 목록 테이블
   ========================================== */
.member-table-card {
    background-color: var(--surface-dark);
    border: 1px solid #374151;
    border-radius: 0.75rem;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.table-header {
    padding: 1.5rem;
    background-color: rgba(255, 255, 255, 0.02);
    border-bottom: 1px solid #374151;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.table-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #fff;
}

.table-actions {
    display: flex;
    gap: 0.75rem;
}

.btn-bulk {
    padding: 0.5rem 1.25rem;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
    transition: all 0.2s;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-bulk-suspend {
    background-color: rgba(245, 158, 11, 0.1);
    border: 1px solid rgba(245, 158, 11, 0.3);
    color: var(--warning-color);
}

.btn-bulk-suspend:hover {
    background-color: rgba(245, 158, 11, 0.2);
    border-color: var(--warning-color);
}

.btn-bulk-dormant {
    background-color: rgba(107, 114, 128, 0.1);
    border: 1px solid rgba(107, 114, 128, 0.3);
    color: #9CA3AF;
}

.btn-bulk-dormant:hover {
    background-color: rgba(107, 114, 128, 0.2);
    border-color: #9CA3AF;
}

.member-table-wrapper {
    overflow-x: auto;
}

.member-table {
    width: 100%;
    border-collapse: collapse;
}

.member-table thead {
    background-color: rgba(15, 23, 42, 0.5);
    border-bottom: 1px solid #374151;
}

.member-table thead th {
    padding: 1rem 1.5rem;
    text-align: left;
    font-size: 0.875rem;
    font-weight: 600;
    color: #D1D5DB;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

.member-table thead th:first-child {
    width: 50px;
    text-align: center;
}

.member-table tbody tr {
    border-bottom: 1px solid #374151;
    transition: background-color 0.2s;
}

.member-table tbody tr:hover {
    background-color: rgba(37, 99, 235, 0.05);
}

.member-table tbody td {
    padding: 1rem 1.5rem;
    color: #E2E8F0;
    font-size: 0.9375rem;
}

.member-table tbody td:first-child {
    text-align: center;
}

/* 체크박스 스타일 */
.custom-checkbox {
    width: 18px;
    height: 18px;
    cursor: pointer;
    accent-color: var(--primary-color);
}

/* 회원 정보 */
.member-info {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.member-avatar {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 0.5rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: 600;
    font-size: 1rem;
    flex-shrink: 0;
}

.member-details {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.member-name {
    font-weight: 600;
    color: #F8FAFC;
}

.member-id {
    font-size: 0.8125rem;
    color: var(--text-muted);
}

/* 상태 뱃지 */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.375rem;
    padding: 0.375rem 0.75rem;
    border-radius: 0.375rem;
    font-size: 0.8125rem;
    font-weight: 500;
}

.status-badge.active {
    background-color: rgba(16, 185, 129, 0.1);
    color: var(--success-color);
}

.status-badge.suspended {
    background-color: rgba(245, 158, 11, 0.1);
    color: var(--warning-color);
}

.status-badge.dormant {
    background-color: rgba(107, 114, 128, 0.1);
    color: #9CA3AF;
}

.status-badge.banned {
    background-color: rgba(239, 68, 68, 0.1);
    color: #c62828;
}

.status-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background-color: currentColor;
}

/* 액션 버튼 */
.action-buttons {
    display: flex;
    gap: 0.5rem;
}

.btn-action {
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-size: 0.8125rem;
    font-weight: 500;
    transition: all 0.2s;
    cursor: pointer;
    border: 1px solid;
}

.btn-action-detail {
    background-color: transparent;
    border-color: var(--primary-color);
    color: var(--primary-color);
}

.btn-action-detail:hover {
    background-color: rgba(37, 99, 235, 0.1);
}

.btn-action-suspend {
    background-color: transparent;
    border-color: var(--warning-color);
    color: var(--warning-color);
}

.btn-action-suspend:hover {
    background-color: rgba(245, 158, 11, 0.1);
}

.btn-action-activate {
    background-color: transparent;
    border-color: var(--success-color);
    color: var(--success-color);
}

.btn-action-activate:hover {
    background-color: rgba(16, 185, 129, 0.1);
}

/* ==========================================
   페이징
   ========================================== */
.table-footer {
    padding: 1.5rem;
    border-top: 1px solid #374151;
}

.page-navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
}

/* ==========================================
   모달
   ========================================== */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(4px);
    z-index: 9999;
    align-items: center;
    justify-content: center;
}

.modal-overlay.show {
    display: flex;
}

.modal-container {
    background-color: var(--surface-dark);
    border: 1px solid #374151;
    border-radius: 0.75rem;
    width: 90%;
    max-width: 500px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
}

.modal-header {
    padding: 1.5rem;
    border-bottom: 1px solid #374151;
}

.modal-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #fff;
}

.modal-body {
    padding: 1.5rem;
}

.form-group {
    margin-bottom: 1.25rem;
}

.form-group:last-child {
    margin-bottom: 0;
}

.form-label {
    display: block;
    font-size: 0.875rem;
    font-weight: 500;
    color: #D1D5DB;
    margin-bottom: 0.5rem;
}

.form-input,
.form-select,
.form-textarea {
    width: 100%;
    padding: 0.625rem 1rem;
    background-color: rgba(15, 23, 42, 0.5);
    border: 1px solid #334155;
    border-radius: 0.5rem;
    color: #E2E8F0;
    font-size: 0.9375rem;
    transition: all 0.2s ease;
}

.form-textarea {
    resize: vertical;
    min-height: 100px;
}

.form-input:focus,
.form-select:focus,
.form-textarea:focus {
    outline: none;
    border-color: var(--primary-color);
    background-color: rgba(15, 23, 42, 0.8);
    box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
}

.modal-footer {
    padding: 1.5rem;
    border-top: 1px solid #374151;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.btn-modal {
    padding: 0.625rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 0.9375rem;
    font-weight: 500;
    transition: all 0.2s;
    cursor: pointer;
}

.btn-modal-cancel {
    background-color: transparent;
    border: 1px solid #4B5563;
    color: #D1D5DB;
}

.btn-modal-cancel:hover {
    background-color: #374151;
}

.btn-modal-confirm {
    background-color: var(--primary-color);
    border: none;
    color: white;
}

.btn-modal-confirm:hover {
    background-color: var(--primary-hover);
}

.btn-bulk-activate {
    background-color: rgba(16, 185, 129, 0.1);
    border: 1px solid rgba(16, 185, 129, 0.3);
    color: var(--success-color);
}

.btn-bulk-activate:hover {
    background-color: rgba(16, 185, 129, 0.2);
    border-color: var(--success-color);
}

/* ==========================================
   Material Symbols 아이콘
   ========================================== */
.material-symbols-outlined {
    font-size: 1.25rem;
    vertical-align: middle;
}

/* ==========================================
   반응형 디자인
   ========================================== */
@media (max-width: 768px) {
    .content-wrapper {
        padding: 2rem 1rem;
    }
    
    .filter-row {
        flex-direction: column;
    }
    
    .filter-group {
        width: 100%;
    }
    
    .stats-container {
        grid-template-columns: 1fr;
    }
    
    .table-header {
        flex-direction: column;
        gap: 1rem;
        align-items: flex-start;
    }
    
    .table-actions {
        width: 100%;
        flex-direction: column;
    }
    
    .member-table-wrapper {
        overflow-x: scroll;
    }
    
    .member-table {
        min-width: 800px;
    }
    
    .action-buttons {
        flex-direction: column;
    }
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
            <div class="container-fluid p-4 p-md-5" style="max-width: 1400px;">
    
                <!-- 브레드크럼 -->
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">홈</a></li>
                        <li class="breadcrumb-item"><a href="#">콘텐츠 관리</a></li>
                        <li class="breadcrumb-item active" aria-current="page">콘텐츠 목록</li>
                    </ol>
                </nav>

                <!-- 페이지 헤더 -->
                <div class="page-header">
                    <h1 class="page-title">콘텐츠 관리</h1>
                    <p class="page-description">콘텐츠 정보 조회 및 상태 관리를 할 수 있습니다</p>
                </div>

                <!-- 통계 카드 -->
                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon primary">
                            <span class="material-symbols-outlined">group</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-label">전체 게시물</div>
                            <div class="stat-value">${postAllCount} </div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon success">
                            <span class="material-symbols-outlined">check_circle</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-label">정상 게시물</div>
                            <div class="stat-value">${postNormalCount} </div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon warning">
                            <span class="material-symbols-outlined">block</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-label">신고 게시물</div>
                            <div class="stat-value">${postDeclaCount} </div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon danger">
                            <span class="material-symbols-outlined">bedtime</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-label">신고처리 게시물</div>
                            <div class="stat-value">${postProCount} </div>
                        </div>
                    </div>
                </div>

                <!-- 검색 및 필터 -->
                <div class="search-filter-card">
                    <form name="searchForm" method="get">
                    <input type="hidden" name="size" value="${size}">
                    <input type="hidden" name="state" value="${state}">
                    <input type="hidden" name="page" value="${page}">
                    <input type="hidden" name="contextPath" value="${pageContext.request.contextPath}">
                        <div class="filter-row">
                            <div class="filter-group">
                                <label class="filter-label">검색 조건</label>
                                <select name="schType" class="filter-select">
                                    <option value="title" ${schType == 'title' ? 'selected' : ''}>제목</option>
                                    <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
                                    <option value="userNickname" ${schType == 'userNickname' ? 'selected' : ''}>닉네임</option>
                                    <option value="createdDate" ${schType == 'createdDate' ? 'selected' : ''}>작성일</option>
                                </select>
                            </div>
                            <div class="filter-group" style="flex: 2;">
                                <label class="filter-label">검색어</label>
                                <input type="text" name="kwd" class="filter-input" value="${kwd}" placeholder="검색어를 입력하세요">
                            </div>
                            <button type="button" class="btn-search" onclick="searchList();">
                                <span class="material-symbols-outlined">search</span>
                                검색
                            </button>
                            <button type="button" class="btn-reset" onclick="location.href='${pageContext.request.contextPath}/admin/content/list';">
                                초기화
                            </button>
                        </div>
                    </form>
                </div>

                <!-- 회원 목록 테이블 -->
                <div class="member-table-card">
                    <div class="table-header">
                        <div class="table-title">
                            게시물 목록 <span style="color: var(--text-muted); font-size: 0.875rem;">(총 ${countDto}명)</span>
                        </div>
                        <div class="col-12 col-lg-6">
						    <div class="btn-group glass-btn-group">
						        <button type="button" class="btn btn-outline-light ${empty state ? 'active' : ''} btn-sm px-3" value="">전체</button>
						        <button type="button" class="btn btn-outline-light ${state == '정상' ? 'active' : ''} btn-sm px-3" value="정상">정상</button>
						        <button type="button" class="btn btn-outline-light ${state == '신고' ? 'active' : ''} btn-sm px-3" value="신고">신고</button>
						        <button type="button" class="btn btn-outline-light ${state == '신고처리' ? 'active' : ''} btn-sm px-3" value="신고처리">신고처리된 게시물</button>
						    </div>
						</div>
                        <div class="table-actions">
                         	<button type="button" class="btn-bulk btn-bulk-activate" onclick="bulkActivate()">
						        <span class="material-symbols-outlined">check_circle</span>
						        선택 정상
						    </button>
                            <button type="button" class="btn-bulk btn-bulk-suspend" onclick="bulkSuspend()">
                                <span class="material-symbols-outlined">block</span>
                                선택 신고처리
                            </button>
                        </div>
                    </div>
                    
                    <div class="member-table-wrapper">
                        <table class="member-table">
                            <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" class="custom-checkbox" id="chkAll">
                                    </th>
                                    <th>작성저</th>
                                    <th>제목</th>
                                    <th>내용</th>
                                    <th>분류</th>
                                    <th>작성일</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dto" items="${memberList }" varStatus="status">
                                <tr>
                                    <td>
                                        <input type="checkbox" class="custom-checkbox chk" value="${dto.postId}">
                                    </td>
                                    <td>${dto.userNickname }</td>
                                    <td>${dto.title }</td>
                                    <td>${dto.content }</td>
                                    <td>${dto.postType }</td>
                                    <td>${dto.createdDate }</td>
                                    <td>
	                                    <c:if test="${dto.state == '정상'}">
	                                        <span class="status-badge active">
	                                            <span class="status-dot"></span>
	                                            정상
	                                        </span>
	                                    </c:if>
	                                    <c:if test="${dto.state == '신고'}">
	                                        <span class="status-badge suspended">
	                                            <span class="status-dot"></span>
	                                            신고
	                                        </span>
	                                    </c:if>
	                                    <c:if test="${dto.state == '나만보기'}">
	                                        <span class="status-badge dormant">
	                                            <span class="status-dot"></span>
	                                            나만보기
	                                        </span>
	                                    </c:if>
	                                    <c:if test="${dto.state == '임시저장'}">
	                                        <span class="status-badge banned">
	                                            <span class="status-dot"></span>
	                                            임시저장
	                                        </span>
	                                    </c:if>
                                    </td> 
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="table-footer">
                        <div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</div>
                    </div>
                </div>	

            </div>
        </main>
    </div>
  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/admin_content_util.js"></script>
</body>
</html>