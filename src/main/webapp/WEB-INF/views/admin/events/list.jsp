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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%@ include file="/WEB-INF/views/home/head.jsp"%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
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
	background: rgba(15, 23, 42, 0.5);
    border: none;
    color: #fff !important;
    padding-left: 0.5rem;
}

.glass-input:focus {
	background: rgba(15, 23, 42, 0.5);
    box-shadow: none !important;
    outline: none;
    color: #fff !important;
}


/* 🔥 Chrome autofill 강제 제거 */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px rgba(255, 255, 255, 0.05) inset !important;
    -webkit-text-fill-color: #fff !important;
    transition: background-color 9999s ease-out;
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

.glass-input::placeholder {
    color: #ffffff80 !important;
    opacity: 1;
}

.text-wrap { 
  display: inline-flex;
  max-width: 550px;
  > a {
     flex: 1;  /* 플렉스 아이템이 자신의 컨테이너가 차지하는 공간을 맞추기 위해 크기를 키우거나 줄이는 방법 지정 */
     white-space: nowrap;
     overflow: hidden;
     text-overflow: ellipsis;
 } 
}

.eventlink {
    cursor: pointer;       /* 마우스 손가락 모양 */
    text-decoration: none; /* 밑줄 제거 */
}

.eventlink:hover {
    text-decoration: underline; /* 마우스를 올렸을 때만 밑줄이 생기게 하고 싶다면 추가 */
    color: #ccc;               /* 살짝 밝게 변하는 효과 */
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
			<div class="container-fluid p-4 p-md-5" style="max-width: 1300px;">
			
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
							<div class="d-flex gap-2">
							<button	
								class="btn btn-primary btn-write d-flex align-items-center gap-2 px-4 py-2" onclick="location.href='${pageContext.request.contextPath}/admin/events/write?size=${size}';">
								<span class="material-icons-round fs-3">edit</span> <span>작성</span>
							</button>
							<button type = "button" id="btnDeleteList" class = "btn btn-primary btn-write d-flex align-items-center gap-2 px-4 py-2">
								<span class="material-icons-round fs-3">delete</span> <span>삭제</span>
							</button>
						</div>
					</div>
				</div>

				<div id="topFilterArea" class="card-dark mb-4 p-3">
					<div class="row g-3 align-items-center">
						<div class="col-12 col-lg-6">
							<div class="btn-group glass-btn-group">
								<button class="btn btn-outline-light ${active_status ? 'active' : ''} btn-sm px-3" value="">전체</button>
								<button class="btn btn-outline-light ${active_status == '진행중' ? 'active' : ''} btn-sm px-3" value="진행중">진행중</button>
								<button class="btn btn-outline-light ${active_status == '진행예정' ? 'active' : ''}btn-sm px-3" value="진행예정">진행예정</button>
								<button class="btn btn-outline-light ${active_status == '종료' ? 'active' : ''}btn-sm px-3" value="종료">종료</button>
							</div>
						</div>	
							<div class="col-12 col-lg-4 offset-lg-2">
							<form name="searchForm" method="get">
								<input type="hidden" name="page" value="${page}">
						        <input type="hidden" name="size" value="${size}">
						         <input type="hidden" name="active_status" value="${active_status}">
						         
						        <div class="input-group search-wrapper">
						            <select name="schType" class="form-select glass-select" style="max-width: 120px; background: transparent; border: none; border-right: 1px solid rgba(255, 255, 255, 0.1); color: white; padding-right: 2rem;">
						                <option value="all" ${schType == 'all' ? 'selected' : ''}>전체</option>
						                <option value="title_content" ${schType == 'title_content' ? 'selected' : ''}>제목+내용</option>
						                <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
						                <option value="startdate" ${schType == 'startdate' ? 'selected' : ''}>시작일</option>
						            </select>
						            
						            <span style="width:10px;"></span>
						            <span class="material-icons-round text-white-25 mt-2" onclick="search();" style="cursor: pointer;">search</span> 
						            <input type="text" name="kwd" class="form-control glass-input" value="${kwd}" placeholder="제목,내용,시작일 검색...">
						        </div>
							</form>
						</div>
					</div>
				</div>

				<div class="glass-table-container">
					<div class="table-responsive">
						<table class="table table-dark-custom">
							<thead>
								<tr>
									<th class="text-center" style="width: 50px;">
										<input type="checkbox" class="form-check-input-all"></th>
									<th style="width: 80px;">번호</th>
									<th style="width: 100px;">상태</th>
									<th>제목</th>
									<th style="width: 150px;">시작일</th>
									<th style="width: 120px;">종료일</th>
									<th class="text-center" style="width: 100px;">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${listTop}" varStatus="active_status">
								<tr style="background: rgba(59, 130, 246, 0.05);">
									<td class="text-center">
									<span class="material-symbols-outlined text-primary fs-5">campaign</span></td>
									<td class="text-white">${dto.event_num}</td>
									<td>
										<span class="badge badge-ongoing">진행</span>
									</td>
									<td>
										<span class="eventlink fw-bold text-white">
											<a href="${articleUrl}&event_num=${dto.event_num}" class="text-reset"><c:out value="${dto.event_title}"/></a>
										</span>
									</td>
									<td class="text-white-50 date-text">${dto.start_date}</td>
									<td class="text-white-50 date-text">${dto.end_date}</td>
									<td class="text-center text-white-50">${dto.hitCount}</td>
								</tr>
								</c:forEach>
								
								<c:forEach var="dto" items="${list}" varStatus="active_status">
								<tr>
									<td class="text-center">
										<input type="checkbox" class="form-check-input" name="event_num"></td>
									<td class="text-white">${dto.event_num}</td>
									<td>
										<c:if test="${dto.active_status == '진행예정'}">
											<span class="badge badge-upcoming">${dto.active_status}</span>
										</c:if>
										<c:if test="${dto.active_status == '진행'}">
											<span class="badge badge-ongoing">${dto.active_status}</span>
										</c:if>
										<c:if test="${dto.active_status == '종료'}">
											<span class="badge badge-ended">${dto.active_status}</span>
										</c:if>
									</td>
									<td>
										<span class="eventlink fw-bold text-white">
											<a href="${articleUrl}&event_num=${dto.event_num}" class="text-reset"><c:out value="${dto.event_title}"/></a>
										</span>
									</td>
									<td class="text-white-50 date-text">${dto.start_date}</td>
									<td class="text-white-50 date-text">${dto.end_date}</td>
									<td class="text-center text-white-50">${dto.hitCount}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="p-4 d-flex justify-content-center border-top border-white border-opacity-10">
						<nav>
						<span class="text-sm text-text-sub mb-4">
						 	<span class="font-semibold text-white">(${page}/${total_page} page)</span> of <span class="font-semibold text-white">${dataCount}</span>
						</span>
							<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</div>
						</nav>
					</div>
				</div>
			</div>
		</main>
	</div>

<script type="text/javascript">
function sendOk() {
	const f = document.eventForm;
	let str;
	
	str = f.title.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.title.focus();
		return;
	}

	str = f.content.value.trim();
	if( ! str ) {
		alert('내용을 입력하세요. ');
		f.content.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/admin/events/${mode}';
	f.submit();
	
	return true;
}


<c:if test="${mode=='update'}">
function deleteFile(fileNum) {
	if(! confirm('파일을 삭제 하시겠습니까 ? ')) {
		return;
	}
	
	let params = 'event_num=${dto.event_num}&file_at_id=' + file_at_id + '&page=${page}&size=${size}';
	let url = '${pageContext.request.contextPath}/admin/event/deleteFile?' + params;
	location.href = url;
}
</c:if>
</script>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/admin_bbs_util.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/admin_event.js"></script>
</body>
</html>