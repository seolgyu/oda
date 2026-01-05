<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>ODA Admin - 이벤트 등록</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet" />

<%@ include file="/WEB-INF/views/home/head.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminmain.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminstyle.css">

<style>
/* [이벤트 작성 폼 전용 디자인] */

/* 1. 레이블 스타일 */
.form-label {
	font-size: 0.875rem;
	font-weight: 600;
	color: rgba(255, 255, 255, 0.85); /* 가독성을 위해 밝은 흰색 유지 */
	margin-bottom: 0.6rem;
	display: block;
}

/* 2. 글래스모피즘 입력창 (Input & Select & Date) */
.glass-input-box {
	background: rgba(15, 23, 42, 0.4) !important; /* 짙은 네이비 투명 */
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	color: #ffffff !important;
	border-radius: 0.5rem;
	padding: 0.8rem 1rem;
	width: 100%;
	transition: all 0.2s ease-in-out;
}

/* 포커스 시 하이라이트 효과 */
.glass-input-box:focus {
	background: rgba(15, 23, 42, 0.6) !important;
	border-color: #3b82f6 !important; /* 포인트 블루 컬러 */
	outline: none;
	box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
}

/* 3. 날짜 입력창(Date Picker) 아이콘 반전 (검정 -> 흰색) */
input[type="date"]::-webkit-calendar-picker-indicator {
	filter: invert(1) brightness(1.5); /* 어두운 배경에서 잘 보이도록 */
	cursor: pointer;
}

/* 4. 에디터 컨테이너 및 텍스트 영역 */
/* HTML에 있는 .glass-table-container를 에디터 컨테이너로 활용하도록 수정 */
.glass-table-container.editor-wrap {
	background: rgba(0, 0, 0, 0.2) !important;
	border-radius: 0.5rem;
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	overflow: hidden;
}

.editor-toolbar {
	/* bg-white bg-opacity-5 클래스와 중첩되므로 투명도 조절 */
	background: rgba(255, 255, 255, 0.05) !important;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
	padding: 0.5rem !important;
	display: flex;
	gap: 8px;
}

.toolbar-btn {
	background: transparent !important;
	border: none !important;
	color: #94a3b8 !important;
	padding: 6px !important;
	border-radius: 4px;
	transition: 0.2s;
	display: flex;
	align-items: center;
}

.toolbar-btn:hover {
	background: rgba(255, 255, 255, 0.1) !important;
	color: #ffffff !important;
}

/* 텍스트 영역 스타일 강제 적용 */
.editor-textarea {
	background: transparent !important;
	border: none !important;
	color: #ffffff !important;
	padding: 1.5rem !important;
	min-height: 450px;
	width: 100%;
	resize: vertical;
	outline: none !important;
	box-shadow: none !important; /* Bootstrap 포커스 테두리 제거 */
	line-height: 1.6;
}

.editor-textarea::placeholder {
	color: rgba(255, 255, 255, 0.3) !important;
}

/* 5. 선택 박스(Select) 화살표 커스텀 (다크모드용) */
select.glass-input-box {
	background-image:
		url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='white'%3e%3cpath fill-rule='evenodd' d='M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z'/%3e%3c/svg%3e");
	background-repeat: no-repeat;
	background-position: right 1rem center;
	background-size: 16px 12px;
	padding-right: 2.5rem;
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
			<div class="container-fluid p-4 p-md-5" style="max-width: 1100px;">

				<div class="card-dark mb-4 mt-2">
					<div
						class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 p-2">
						<div class="d-flex align-items-center gap-3">
							<div
								class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary p-3 rounded-circle">
								<span class="material-icons-round fs-4">add_box</span>
							</div>
							<div>
								<h1 class="h3 fw-bold mb-1 text-white">이벤트 등록</h1>
								<p class="text-white-50 small mb-0">새로운 프로모션의 제목과 진행 기간을
									설정하세요.</p>
							</div>
						</div>
						<div class="d-flex gap-2">
							<button class="btn btn-outline-light px-4 py-2 border-opacity-25"
								style="border-radius: 0.75rem;" onclick="history.back();">취소</button>
							<button
								class="btn btn-primary btn-write d-flex align-items-center gap-2 px-4 py-2"
								id="btnSubmit">
								<span class="material-icons-round fs-6">check_circle</span> <span>등록
									완료</span>
							</button>
						</div>
					</div>
				</div>

				<form id="eventForm" action="/admin/event/write" method="post">
					<div class="card-dark p-4 p-md-5 shadow-lg">

						<div class="mb-4">
							<label class="form-label">이벤트 제목</label> <input type="text"
								class="glass-input-box" name="title"
								placeholder="이벤트 명칭을 입력하세요.">
						</div>

						<div class="row mb-4">
							<div class="col-md-6 mb-4 mb-md-0">
								<label class="form-label">시작 일시</label> <input type="date"
									class="glass-input-box" name="startDate">
							</div>
							<div class="col-md-6">
								<label class="form-label">종료 일시</label> <input type="date"
									class="glass-input-box" name="endDate">
							</div>
						</div>

						<div class="mb-0">
							<label class="form-label">이벤트 상세 내용</label>
							<div
								class="glass-table-container editor-wrap p-0 overflow-hidden">
								<div
									class="editor-toolbar bg-white bg-opacity-5 p-2 d-flex gap-2 border-bottom border-white border-opacity-10">
									<button type="button"
										class="toolbar-btn btn btn-sm text-white-50">
										<span class="material-icons-round fs-5">format_bold</span>
									</button>
									<button type="button"
										class="toolbar-btn btn btn-sm text-white-50">
										<span class="material-icons-round fs-5">format_italic</span>
									</button>
									<button type="button"
										class="toolbar-btn btn btn-sm text-white-50">
										<span class="material-icons-round fs-5">format_list_bulleted</span>
									</button>
									<div class="mx-1 border-start border-white border-opacity-10"></div>
									<button type="button"
										class="toolbar-btn btn btn-sm text-white-50">
										<span class="material-icons-round fs-5">link</span>
									</button>
								</div>
								<textarea class="editor-textarea" name="content"
									placeholder="사용자들에게 안내할 이벤트 상세 내용을 작성하세요..."></textarea>
							</div>
						</div>
					</div>
				</form>
			</div>
		</main>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>