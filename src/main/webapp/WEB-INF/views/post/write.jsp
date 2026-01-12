<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<style>
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

.preview-box {
	width: 100px;
	height: 100px;
	border-radius: 1rem;
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, 0.2);
	position: relative;
	flex-shrink: 0;
}

.preview-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
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

			<div class="feed-scroll-container custom-scrollbar w-100">

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

								<form name="postForm" method="post"
									enctype="multipart/form-data">

									<div class="mb-3">
										<label class="text-white-50 fw-bold mb-2 ms-1">Subject</label>
										<input type="text" name="title"
											class="form-control board-input py-3" placeholder="제목을 입력하세요"
											value="${dto.title}">
									</div>

									<div class="mb-3">
										<label class="text-white-50 fw-bold mb-2 ms-1">Writer</label>
										<input type="text" class="form-control board-input"
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
											onclick="this.value=null;"
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
											<label class="form-check-label text-secondary"
												for="chkCounts">좋아요/조회수 숨기기</label>
										</div>

										<c:if test="${sessionScope.member.userLevel > 50}">
											<div
												class="form-check form-switch ms-1 mt-1 pt-2 border-top border-secondary border-opacity-25">
												<input class="form-check-input" type="checkbox"
													role="switch" id="noticeCheck" name="isNotice" value="1"
													<c:if test="${dto.postType == 'NOTICE'}">checked</c:if>>
												<label class="form-check-label text-warning fw-bold"
													for="noticeCheck">공지사항 등록</label>
											</div>
										</c:if>
									</div>

									<div class="d-flex justify-content-end gap-2 mt-4 pb-3">
										<button type="button" class="btn btn-outline-light px-4"
											onclick="location.href='${pageContext.request.contextPath}/main';">Cancel</button>
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
			</div>
		</main>
	</div>

	<div class="modal fade" id="deleteConfirmModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content"
				style="background: rgba(30, 30, 30, 0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 1rem; color: #fff;">
				<div class="modal-body text-center p-4">
					<div class="mb-3">
						<span class="material-symbols-outlined text-danger"
							style="font-size: 3rem;">delete_forever</span>
					</div>
					<h5 class="fw-bold mb-3">이미지 삭제</h5>
					<p class="text-white-50 mb-4">선택한 이미지를 삭제하시겠습니까?</p>
					<div class="d-flex justify-content-center gap-2">
						<button type="button" class="btn btn-outline-light px-4"
							data-bs-dismiss="modal">아니요</button>
						<button type="button" class="btn btn-danger px-4"
							id="btnDeleteConfirm">예, 삭제합니다</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>

	<script type="text/javascript">
    // 전역 변수로 파일 관리
    const dataTransfer = new DataTransfer();
    let deleteTargetIndex = -1; // 삭제할 파일 인덱스 임시 저장용

    // 1. 파일 선택 시 실행
    function handleImgFileSelect(e) {
        const newFiles = e.files;
        
        if(newFiles != null && newFiles.length > 0) {
            for(let i=0; i < newFiles.length; i++){
                // 이미지 파일인지 확인
                if(!newFiles[i].type.match("image.*")) continue;
                dataTransfer.items.add(newFiles[i]);
            }
            updateFileInputAndPreview();
        }
    }

    // 2. 미리보기 업데이트 및 input 업데이트 (공통 함수)
    function updateFileInputAndPreview() {
        // input에 최신 파일 리스트 할당
        document.getElementById("selectFile").files = dataTransfer.files;

        const previewArea = document.getElementById("preview-area");
        previewArea.innerHTML = ""; 

        const allFiles = dataTransfer.files;
        
        for(let i=0; i < allFiles.length; i++) {
            const f = allFiles[i];
            const reader = new FileReader();
            
            reader.onload = function(e) {
                // 클릭 시 openDeleteModal(인덱스) 실행
                const html = `
                    <div class="preview-box" onclick="openDeleteModal(\${i})" style="cursor: pointer;">
                        <img src="\${e.target.result}" class="preview-img">
                        <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center opacity-0 hover-overlay" 
                             style="background: rgba(0,0,0,0.5); transition: opacity 0.2s;">
                             <span class="material-symbols-outlined text-white">delete</span>
                        </div>
                    </div>`;
                previewArea.innerHTML += html;
                
                // 마지막 파일 로드 후 CSS 호버 효과 주입 (JS로 동적 생성된 요소라 스타일 태그에 추가 권장)
                // *CSS style 태그에 .preview-box:hover .hover-overlay { opacity: 1 !important; } 추가하면 더 예쁩니다.
            }
            reader.readAsDataURL(f);
        }
    }

    // 3. 삭제 모달 열기
    function openDeleteModal(index) {
        deleteTargetIndex = index;
        const modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        modal.show();
    }

    // 4. 모달에서 '예' 버튼 클릭 시 실제 삭제 처리
    document.addEventListener("DOMContentLoaded", function(){
        document.getElementById("btnDeleteConfirm").addEventListener("click", function(){
            if(deleteTargetIndex > -1) {
                const newDt = new DataTransfer();
                const files = dataTransfer.files;
                
                for(let i=0; i < files.length; i++) {
                    // 삭제할 인덱스는 건너뛰고 새 DataTransfer에 담기
                    if(i !== deleteTargetIndex) {
                        newDt.items.add(files[i]);
                    }
                }
                
                // 전역 변수 교체
                dataTransfer.items.clear();
                for(let i=0; i<newDt.files.length; i++){
                    dataTransfer.items.add(newDt.files[i]);
                }

                // 화면 갱신
                updateFileInputAndPreview();
                
                // 모달 닫기
                const modalEl = document.getElementById('deleteConfirmModal');
                const modalInstance = bootstrap.Modal.getInstance(modalEl);
                modalInstance.hide();
            }
        });
    });

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