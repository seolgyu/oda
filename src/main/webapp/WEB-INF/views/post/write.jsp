<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<style>
/* [수정 1] 배경화면을 화면 뒤에 고정 (스크롤해도 움직이지 않음) */
.space-background {
	position: fixed; /* 고정 위치 */
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: -1; /* 컨텐츠보다 뒤에 위치 */
	pointer-events: none; /* 클릭 방해 금지 */
	overflow: hidden;
}

/* 기존 스타일 유지 */
.board-input {
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.2);
	color: #fff;
	transition: all 0.3s;
}

.board-input:focus {
	background: rgba(255, 255, 255, 0.1);
	border-color: #a855f7;
	box-shadow: 0 0 10px rgba(168, 85, 247, 0.3);
	color: #fff;
}

.board-input::placeholder {
	color: rgba(255, 255, 255, 0.5);
}

.form-check-input {
	background-color: rgba(255, 255, 255, 0.2);
	border-color: rgba(255, 255, 255, 0.3);
	cursor: pointer;
}

.form-check-input:checked {
	background-color: #a855f7;
	border-color: #a855f7;
}

textarea.board-input::-webkit-scrollbar {
	width: 8px;
}

textarea.board-input::-webkit-scrollbar-thumb {
	background: rgba(255, 255, 255, 0.2);
	border-radius: 4px;
}

/* 이미지 미리보기 박스 스타일 */
.preview-box {
	width: 100px;
	height: 100px;
	border-radius: 1rem;
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, 0.2);
	position: relative;
	flex-shrink: 0; /* 박스가 찌그러지지 않도록 설정 */
}

.preview-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

/* 메인 영역 스크롤 설정 */
.app-main {
	overflow-y: auto !important;
	height: 100vh;
	position: relative;
}
</style>
</head>
<body>

	<%@ include file="../home/header.jsp"%>

	<div class="app-body">
		<%@ include file="../home/sidebar.jsp"%>

		<main class="app-main">
			<div class="space-background">
				<div class="stars"></div>
				<div class="stars2"></div>
				<div class="stars3"></div>
				<div class="planet planet-1"></div>
				<div class="planet planet-2"></div>
			</div>

			<div class="container py-5">
				<div class="row justify-content-center">
					<div class="col-12 col-lg-8 col-xl-7">

						<div class="p-4 p-md-5 shadow-lg d-flex flex-column gap-4 mb-5"
							style="border-radius: 1rem; backdrop-filter: blur(12px); background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1);">

							<div
								class="border-bottom border-secondary border-opacity-25 pb-3">
								<h2 class="text-white fw-bold fs-4 mb-1">
									<span class="material-symbols-outlined align-middle me-2">edit_note</span>
									<c:if test="${mode=='update'}">게시글 수정</c:if>
									<c:if test="${mode=='write'}">게시글 작성</c:if>
								</h2>
							</div>

							<form name="postForm" method="post" enctype="multipart/form-data">

								<div class="mb-3">
									<label class="text-white-50 fw-bold mb-2 ms-1">Subject</label>
									<input type="text" name="title"
										class="form-control board-input py-3" placeholder="제목을 입력하세요"
										value="${dto.title}">
								</div>

								<div class="mb-3">
									<label class="text-white-50 fw-bold mb-2 ms-1">Writer</label> <input
										type="text" class="form-control board-input"
										value="${sessionScope.member.userName}" readonly
										style="background: rgba(0, 0, 0, 0.2); cursor: default;">
								</div>

								<div class="mb-3">
									<label class="text-white-50 fw-bold mb-2 ms-1">Images</label>
									<div class="d-flex gap-3 align-items-center flex-wrap">
										<div onclick="document.getElementById('selectFile').click();"
											style="width: 100px; height: 100px; border-radius: 1rem; border: 2px dashed rgba(255, 255, 255, 0.3); background: rgba(255, 255, 255, 0.05); cursor: pointer; display: flex; flex-direction: column; justify-content: center; align-items: center; transition: all 0.2s;"
											onmouseover="this.style.borderColor='#a855f7'; this.style.color='#fff';"
											onmouseout="this.style.borderColor='rgba(255,255,255,0.3)';">
											<span class="material-symbols-outlined text-white-50 fs-1">add_photo_alternate</span>
											<span class="text-white-50" style="font-size: 0.7rem;">Add
												Image</span>
										</div>

										<div id="preview-area" class="d-flex gap-2 flex-wrap"></div>
									</div>

									<input type="file" name="selectFile" id="selectFile"
										accept="image/*" multiple style="display: none;"
										onchange="handleImgFileSelect(this)">
								</div>

								<div class="mb-3">
									<label class="text-white-50 fw-bold mb-2 ms-1">Content</label>
									<textarea name="content" class="form-control board-input"
										rows="10" placeholder="내용을 입력하세요">${dto.content}</textarea>
								</div>

								<div class="d-flex flex-column gap-3 mt-2 p-3 rounded-3"
									style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.1);">
									<h5 class="text-white-50 fs-6 fw-bold mb-2">
										<span class="material-symbols-outlined align-middle me-1">settings</span>Post
										Settings
									</h5>

									<div class="form-check form-switch ms-1">
										<input class="form-check-input" type="checkbox" role="switch"
											id="chkReply" name="chkReply" value="true"
											<c:if test="${dto.replyEnabled == '0'}">checked</c:if>>
										<label class="form-check-label text-secondary" for="chkReply">댓글
											기능 끄기</label>
									</div>

									<div class="form-check form-switch ms-1">
										<input class="form-check-input" type="checkbox" role="switch"
											id="chkCounts" name="chkCounts" value="true"
											<c:if test="${dto.showCounts == '0'}">checked</c:if>>
										<label class="form-check-label text-secondary" for="chkCounts">좋아요/조회수
											숨기기</label>
									</div>

									<c:if test="${sessionScope.member.userLevel > 50}">
										<div
											class="form-check form-switch ms-1 mt-1 pt-2 border-top border-secondary border-opacity-25">
											<input class="form-check-input" type="checkbox" role="switch"
												id="noticeCheck" name="isNotice" value="1"
												<c:if test="${dto.postType == 'NOTICE'}">checked</c:if>>
											<label class="form-check-label text-warning fw-bold"
												for="noticeCheck">공지사항 등록</label>
										</div>
									</c:if>
								</div>

								<div class="d-flex justify-content-end gap-2 mt-4 pb-3">
									<button type="button" class="btn btn-outline-light px-4"
										onclick="location.href='${pageContext.request.contextPath}/post/list';">Cancel</button>
									<button type="button" class="btn text-white px-4 fw-bold"
										style="background: linear-gradient(to right, #a855f7, #6366f1); border: none;"
										onclick="sendOk();">Submit</button>
								</div>
							</form>
						</div>
						<div style="height: 50px;"></div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script type="text/javascript">
        // [수정 2] 파일 누적을 위한 전역 변수 생성
        const dataTransfer = new DataTransfer();

        function handleImgFileSelect(e) {
            const newFiles = e.files;
            
            if(newFiles != null && newFiles.length > 0) {
                // 새로 선택된 파일들을 통합 리스트(dataTransfer)에 추가
                for(let i=0; i < newFiles.length; i++){
                    // (선택사항) 여기서 중복 체크를 할 수도 있음
                    dataTransfer.items.add(newFiles[i]);
                }
                
                // input 태그의 파일 리스트를 누적된 리스트로 교체
                document.getElementById("selectFile").files = dataTransfer.files;
            }

            // 미리보기 영역 초기화 및 다시 그리기
            const previewArea = document.getElementById("preview-area");
            previewArea.innerHTML = ""; 

            const allFiles = dataTransfer.files;
            for(let i=0; i<allFiles.length; i++) {
                const f = allFiles[i];
                if(!f.type.match("image.*")) continue;

                const reader = new FileReader();
                reader.onload = function(e) {
                    const html = `
                        <div class="preview-box">
                            <img src="\${e.target.result}" class="preview-img">
                        </div>`;
                    previewArea.innerHTML += html;
                }
                reader.readAsDataURL(f);
            }
        }

        function sendOk() {
            const f = document.postForm;
            
            if(!f.title.value.trim()) {
                alert("제목을 입력하세요.");
                f.title.focus();
                return;
            }
            if(!f.content.value.trim()) {
                alert("내용을 입력하세요.");
                f.content.focus();
                return;
            }

            let mode = "${mode}";
            if(mode === "write") {
                f.action = "${pageContext.request.contextPath}/post/write";
            } else if(mode === "update") {
                f.action = "${pageContext.request.contextPath}/post/update";
            }

            f.submit();
        }
    </script>
</body>
</html>