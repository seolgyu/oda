<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>ODA Admin - 공지사항 작성</title>

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
/* [1] 기존 공통 폼 스타일 */
.form-label {
	font-size: 0.875rem;
	font-weight: 600;
	color: rgba(255, 255, 255, 0.8);
	margin-bottom: 0.6rem;
}

.glass-input-box {
	background: rgba(15, 23, 42, 0.4) !important;
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	color: #fff !important;
	border-radius: 0.5rem;
	padding: 0.8rem 1rem;
	transition: all 0.2s;
	width: 100%;
}

.glass-input-box:focus {
	background: rgba(15, 23, 42, 0.6) !important;
	border-color: #3b82f6 !important;
	outline: none;
	box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
}

select.glass-input-box {
	background-image:
		url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='white'%3e%3cpath fill-rule='evenodd' d='M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z'/%3e%3c/svg%3e");
	background-repeat: no-repeat;
	background-position: right 1rem center;
	background-size: 16px 12px;
	appearance: none;
}

/* [2] 에디터(상세 내용) 전용 스타일 보정 */
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

/* [3] 파일 업로드 스타일 */
.file-upload-wrapper {
	border: 2px dashed rgba(255, 255, 255, 0.1);
	border-radius: 0.5rem;
	padding: 1.5rem;
	text-align: center;
	transition: all 0.2s;
	cursor: pointer;
}

.file-upload-wrapper:hover {
	border-color: #3b82f6;
	background: rgba(59, 130, 246, 0.05);
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
			<div class="container-fluid p-4 p-md-5" style="max-width: 1100px;">
			
			
			<nav aria-label="breadcrumb" class="mb-4">	
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">홈</a></li>
					<li class="breadcrumb-item"><a href="#">서비스 관리</a></li>
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/notice">공지사항</a></li>
					<li aria-current="page" class="breadcrumb-item active">공지사항 작성</li>
				</ol>
			</nav>

				<div class="card-dark mb-4 mt-2">
					<div
						class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 p-2">
						<div class="d-flex align-items-center gap-3">
							<div
								class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary p-3 rounded-circle">
								<span class="material-icons-round fs-4">edit_note</span>
							</div>
							<div>
								<h1 class="h3 fw-bold mb-1 text-white">공지사항 작성</h1>
								<p class="text-white-50 small mb-0">새로운 소식을 작성하여 사용자들에게
									공유하세요.</p>
							</div>
						</div>
						<div class="d-flex gap-2">
							<button class="btn btn-outline-light px-4 py-2 border-opacity-25"
								style="border-radius: 0.75rem;" onclick="history.back();">취소</button>
							<button
								class="btn btn-primary btn-write d-flex align-items-center gap-2 px-4 py-2"
								id="btnSubmit">
								<span class="material-icons-round fs-6">check_circle</span> <span>작성
									완료</span>
							</button>
						</div>
					</div>
				</div>

				<form id="noticeForm"
					action="${pageContext.request.contextPath}/admin/notice/write"
					method="post" enctype="multipart/form-data">
					<div class="card-dark p-4 p-md-5 shadow-lg">

						<div class="row mb-4">
							<div class="col-md-6 mb-4 mb-md-0">
								<label class="form-label">공지 설정</label> <select
									class="glass-input-box" name="is_Notice">
									<option value="0">일반 공지사항</option>
									<option value="1">고정 공지사항</option>
								</select>
							</div>
							<div class="col-md-6">
								<label class="form-label">공지 유형</label> <select
									class="glass-input-box" name="state">
									<option value="공개">공개</option>
									<option value="비공개">비공개</option>
									<option value="임시저장">임시저장</option>
									<option value="신고">신고</option>
								</select>
							</div>
						</div>

						<div class="mb-4">
							<label class="form-label">공지 제목</label> <input type="text"
								class="glass-input-box" name="subject"
								placeholder="공지사항 제목을 입력해 주세요.">
						</div>

						<div class="mb-0">
							<label class="form-label">상세 내용</label>
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

						<div class="mb-0">
							<label class="form-label">첨부 파일</label>
							<div class="file-upload-wrapper">
								<input type="file" name="upload" id="fileInput" class="hidden"
									style="display: none;" multiple>
								<div onclick="document.getElementById('fileInput').click();">
									<span class="material-icons-round fs-2 text-white-50 mb-2">cloud_upload</span>
									<p class="mb-1 text-white">클릭하여 파일을 업로드하거나 드래그하세요.</p>
									<p class="text-white-50 small mb-0">최대 10MB까지 가능합니다.</p>
								</div>
							</div>
							<div id="fileList" class="mt-2"></div>
						</div>
					</div>
				</form>
			</div>
		</main>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script>
        // 파일 선택 시 목록 표시 간단 로직
        document.getElementById('fileInput').addEventListener('change', function(e) {
            const list = document.getElementById('fileList');
            list.innerHTML = '';
            for(let file of e.target.files) {
                list.innerHTML += `<div class="text-primary small mt-1 d-flex align-items-center gap-1">
                    <span class="material-icons-round" style="font-size:14px">attach_file</span>\${file.name}</div>`;
            }
        });
    </script>
</body>
</html>