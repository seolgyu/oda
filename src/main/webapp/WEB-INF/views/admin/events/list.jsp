<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ODA Admin - 이벤트/프로모션 관리</title>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<%@ include file="/WEB-INF/views/home/head.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminmain.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminstyle.css">

<style>
/* [1] 공지사항 전용 글래스모피즘 보정 스타일 */
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
.table-dark-custom th, .table-dark-custom td {
	background-color: transparent !important; /* 배경색 제거 */
	border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
	/* 테두리 투명도 */
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
/* 이벤트 전용 상태 컬러 */
.badge-upcoming {
	background: rgba(168, 85, 247, 0.2);
	color: #c084fc;
	border: 1px solid rgba(168, 85, 247, 0.3);
}

.badge-ongoing {
	background: rgba(34, 197, 94, 0.2);
	color: #4ade80;
	border: 1px solid rgba(34, 197, 94, 0.3);
}

.badge-ended {
	background: rgba(148, 163, 184, 0.2);
	color: #94a3b8;
	border: 1px solid rgba(148, 163, 184, 0.3);
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

	<%@ include file="../home/adminheader.jsp"%>

	<div class="app-body">
		<%@ include file="../home/adminsidebar.jsp"%>

		<main class="app-main custom-scrollbar">
			<div class="container-fluid p-4 p-md-5" style="max-width: 1400px;">
			
			 <nav aria-label="breadcrumb" class="mb-4">	
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">홈</a></li>
					<li class="breadcrumb-item"><a href="#">서비스 관리</a></li>
					<li aria-current="page" class="breadcrumb-item active">이벤트</li>
				</ol>
			</nav>

				<div class="card-dark mb-4 mt-2">
					<div
						class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 p-2">
						<div class="d-flex align-items-center gap-3">
							<div
								class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary p-3 rounded-circle">
								<span class="material-icons-round fs-4">celebration</span>
							</div>
							<div>
								<h1 class="h3 fw-bold mb-1 text-white">이벤트 관리</h1>
								<p class="text-white-50 small mb-0">프로모션 일정을 확인하고 이벤트를 효율적으로
									관리하세요.</p>
							</div>
						</div>

						<button
							class="btn btn-primary btn-write d-flex align-items-center gap-2 px-4 py-2"
							 onclick="location.href='${pageContext.request.contextPath}/admin/events/write';">
							<span class="material-icons-round fs-6">add_box</span> <span>새
								이벤트 등록</span>
						</button>
					</div>
				</div>

				<div class="card-dark mb-4 p-3">
					<div class="row g-3 align-items-center">
						<div class="col-12 col-lg-6">
							<div class="btn-group glass-btn-group">
								<button class="btn btn-outline-light active btn-sm px-3">전체</button>
								<button class="btn btn-outline-light btn-sm px-3">진행중</button>
								<button class="btn btn-outline-light btn-sm px-3">대기</button>
								<button class="btn btn-outline-light btn-sm px-3">종료</button>
							</div>
						</div>
						<div class="col-12 col-lg-6">
							<div class="input-group search-wrapper">
								<span class="material-icons-round text-white-50">search</span> <input
									type="text" class="form-control glass-input"
									placeholder="이벤트 제목 검색...">
								<button class="btn btn-link text-white-50 p-0 ms-2">
									<span class="material-icons-round">refresh</span>
								</button>
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
										type="checkbox" class="form-check-input"></th>
									<th style="width: 70px;">번호</th>
									<th style="width: 100px;">상태</th>
									<th>이벤트 제목</th>
									<th style="width: 140px;">시작일</th>
									<th style="width: 140px;">종료일</th>
									<th class="text-center" style="width: 90px;">조회수</th>
								</tr>
							</thead>
							<tbody>
								<tr style="background: rgba(34, 197, 94, 0.03);">
									<td class="text-center"><input type="checkbox"
										class="form-check-input"></td>
									<td class="text-white-50">15</td>
									<td><span class="badge badge-ongoing">진행 중</span></td>
									<td><span class="fw-bold text-white">겨울 맞이 커뮤니티 활동왕
											선정</span></td>
									<td class="text-white-50 date-text">2026-01-01</td>
									<td class="text-white-50 date-text">2026-01-31</td>
									<td class="text-center text-white-50">3,452</td>
								</tr>
								<tr>
									<td class="text-center"><input type="checkbox"
										class="form-check-input"></td>
									<td class="text-white-50">14</td>
									<td><span class="badge badge-upcoming">진행 예정</span></td>
									<td>설 연휴 특별 출석 체크 프로모션</td>
									<td class="text-white-50 date-text">2026-01-25</td>
									<td class="text-white-50 date-text">2026-02-05</td>
									<td class="text-center text-white-50">128</td>
								</tr>
								<tr>
									<td class="text-center"><input type="checkbox"
										class="form-check-input"></td>
									<td class="text-white-50">13</td>
									<td><span class="badge badge-ended">종료됨</span></td>
									<td class="text-white-50">크리스마스 창작 공모전</td>
									<td class="text-white-50 date-text">2025-12-01</td>
									<td class="text-white-50 date-text">2025-12-25</td>
									<td class="text-center text-white-50">5,102</td>
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
									href="#"><span class="material-icons-round fs-6">chevron_right</span></a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</main>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>