<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ODA Admin - 공지사항 관리</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">

    <style>
/* [1] 공지사항 전용 글래스모피즘 보정 스타일  */
.glass-table-container {
	background: rgba(30, 41, 59, 0.4) !important;
	backdrop-filter: blur(15px);
	-webkit-backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 1rem;
	overflow: hidden;
	box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.5);
}

.table-dark-custom {
	color: #f1f5f9;
	margin-bottom: 0;
}

.table-dark-custom thead {
	background: rgba(255, 255, 255, 0.05);
	text-transform: uppercase;
	font-size: 0.75rem;
	letter-spacing: 0.05em;
}

.table-dark-custom th, .table-dark-custom td {
	padding: 1rem 1.25rem;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	vertical-align: middle;
}

.table-dark-custom tbody tr:hover {
	background: rgba(255, 255, 255, 0.03);
	transition: background 0.2s;
}

/* [2] 검색창 및 필터 글래스 스타일 */
.search-wrapper {
	background: rgba(15, 23, 42, 0.5);
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 0.75rem;
	padding: 0.5rem 1rem;
}

.glass-input {
	background: transparent;
	border: none;
	color: white;
	padding-left: 0.5rem;
}

.glass-input:focus {
	box-shadow: none;
	background: transparent;
	color: white;
}

/* [3] 뱃지 스타일 보정 */
.badge-urgent {
	background: rgba(239, 68, 68, 0.2);
	color: #f87171;
	border: 1px solid rgba(239, 68, 68, 0.3);
}

.badge-normal {
	background: rgba(59, 130, 246, 0.2);
	color: #60a5fa;
	border: 1px solid rgba(59, 130, 246, 0.3);
}

.badge-private {
	background: rgba(148, 163, 184, 0.2);
	color: #94a3b8;
	border: 1px solid rgba(148, 163, 184, 0.3);
}

/* [4] 버튼 커스텀 */
.btn-write {
	background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
	border: none;
	padding: 0.6rem 1.2rem;
	font-weight: 500;
	border-radius: 0.75rem;
	box-shadow: 0 4px 15px rgba(168, 85, 247, 0.4);
}

.btn-write:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(168, 85, 247, 0.5);
}

/* 테이블 헤더(th)와 데이터(td) 모두 투명화 */
.table-dark-custom th, 
.table-dark-custom td {
    background-color: transparent !important; /* 배경색 제거 */
    border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important; /* 테두리 투명도 */
    color: #f1f5f9 !important; /* 글자색 흰색 계열 고정 */
    backdrop-filter: none !important; /* 개별 셀에는 블러 중복 제거 */
}

/* 테이블 헤더(thead) 부분만 살짝 더 어둡게 비치도록 설정 */
.table-dark-custom thead tr {
    background-color: rgba(0, 0, 0, 0.2) !important; /* 헤더 영역 구분 */
}

/* th 내부의 글자 두께와 위치 정렬 */
.table-dark-custom th {
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.8rem;
    letter-spacing: 0.05em;
    color: rgba(255, 255, 255, 0.6) !important; /* 헤더 글자는 살짝 흐리게 */
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
.glass-input::placeholder {
    color: #ffffff80 !important;
    opacity: 1;
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
			<div class="container-fluid p-4 p-md-5" style="max-width: 1300px;">
			
			<nav aria-label="breadcrumb" class="mb-4">	
				<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">홈</a></li>
				<li class="breadcrumb-item"><a href="#">서비스 관리</a></li>
				<li aria-current="page" class="breadcrumb-item active">공지사항</li>
				</ol>
				</nav>

				<div class="card-dark mb-4 mt-2">
					<div
						class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 p-2">
						<div class="d-flex align-items-center gap-3">
							<div
								class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary p-3 rounded-circle">
								<span class="material-icons-round fs-4">campaign</span>
							</div>
							<div>
								<h1 class="h3 fw-bold mb-1 text-white">공지사항 관리</h1>
								<p class="text-white-50 small mb-0">서비스 이용자들에게 업데이트할 공지내용을 관리하세요.</p>
							</div>
						</div>

						<button
							class="btn btn-primary btn-write d-flex align-items-center gap-2 px-4 py-2" onclick="location.href='${pageContext.request.contextPath}/admin/notice/write';">
							<span class="material-icons-round fs-6">edit</span> <span>공지사항
								작성</span>
						</button>
					</div>
				</div>

				<div class="card-dark mb-4 p-3">
					<div class="row g-3 align-items-center">
						<div class="col-12 col-lg-6">
							<div class="btn-group glass-btn-group">
								<button class="btn btn-outline-light active btn-sm px-3">전체</button>
								<button class="btn btn-outline-light btn-sm px-3">주요</button>
								<button class="btn btn-outline-light btn-sm px-3">일반</button>
								<button class="btn btn-outline-light btn-sm px-3">비공개</button>
							</div>
						</div>
						<div class="col-12 col-lg-6">
							<div class="input-group search-wrapper">
								<span class="material-icons-round text-white-50 mt-2">search</span> <input
									type="text" class="form-control glass-input"
									placeholder="제목, 작성자 검색...">
								<!-- <button class="btn btn-link text-white-50 p-0 ms-2">
									<span class="material-icons-round">refresh</span>
								</button> -->
							</div>
						</div>
					</div>
				</div>

				<div class="glass-table-container">
					<div class="table-responsive">
						<table class="table table-dark-custom">
							<thead>
								<tr>
									<th class="text-center" style="width: 50px;"><input
										type="checkbox" class="form-check-input-all"></th>
									<th style="width: 80px;">번호</th>
									<th style="width: 100px;">유형</th>
									<th>제목</th>
									<th style="width: 150px;">작성자</th>
									<th style="width: 120px;">작성일</th>
									<th class="text-center" style="width: 100px;">조회수</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="dto" items="${list}"  varStatus="status">
								<tr style="background: rgba(59, 130, 246, 0.05);">
									<td class="text-center"><input type="checkbox"
										class="form-check-input"></td>
									<td class="text-white-50"><!-- <span class="material-icons-round text-primary fs-5"> -->${dto.notice_num}<!-- </span> --></td>
									<td><span class="badge badge-urgent">주요</span></td>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="fw-bold">[긴급] 서비스 점검 안내 (10.25 02:00 ~
												06:00)</span> <span class="badge bg-danger p-1 rounded-circle"><span
												class="visually-hidden">New</span></span>
										</div>
									</td>
									<td>${dto.user_nickname}</td>
									<td class="text-white-50">2023-10-24</td>
									<td class="text-center text-white-50">1,240</td>
								</tr>
							</c:forEach>
								<tr>
									<td class="text-center"><input type="checkbox"
										class="form-check-input"></td>
									<td class="text-white-50">128</td>
									<td><span class="badge badge-normal">일반</span></td>
									<td>11월 업데이트 미리보기 및 기능 개선 사항</td>
									<td>운영팀</td>
									<td class="text-white-50">2023-10-20</td>
									<td class="text-center text-white-50">856</td>
								</tr>
								<tr>
									<td class="text-center"><input type="checkbox"
										class="form-check-input"></td>
									<td class="text-white-50">127</td>
									<td><span
										class="badge badge-private d-flex align-items-center gap-1 w-fit"><span
											class="material-icons-round fs-6" style="font-size: 12px;">lock</span>비공개</span></td>
									<td class="text-white-50">시스템 안정화 작업 완료 보고</td>
									<td>개발팀</td>
									<td class="text-white-50">2023-10-12</td>
									<td class="text-center text-white-50">120</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div
						class="p-4 d-flex justify-content-center border-top border-white border-opacity-10">
						<nav>
							<ul class="pagination pagination-sm mb-0">
								<li class="page-item disabled"><a
									class="page-link bg-transparent border-white border-opacity-10 text-white-50"
									href="#"><span class="material-icons-round fs-6">chevron_left</span></a></li>
								<li class="page-item active"><a
									class="page-link bg-primary border-primary" href="#">1</a></li>
								<li class="page-item"><a
									class="page-link bg-transparent border-white border-opacity-10 text-white"
									href="#">2</a></li>
								<li class="page-item"><a
									class="page-link bg-transparent border-white border-opacity-10 text-white"
									href="#">3</a></li>
								<li class="page-item"><a
									class="page-link bg-transparent border-white border-opacity-10 text-white"
									href="#"><span class="material-icons-round fs-6">chevron_right</span></a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</main>
	</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_bbs_util.js"></script>
</body>
</html>