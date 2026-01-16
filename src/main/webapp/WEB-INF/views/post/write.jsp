<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<style>
    /* [스타일] 미리보기 이미지 아이템 */
    .img-item {
        position: relative;
        display: inline-block;
        margin: 5px;
        width: 100px;
        height: 100px;
        border-radius: 8px;
        overflow: hidden;
        border: 1px solid rgba(255,255,255,0.2);
        background: #000;
    }
    .img-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    /* [추가] 삭제 버튼 (이미지 위 X 표시) */
    .btn-delete-img {
        position: absolute;
        top: 5px;
        right: 5px;
        width: 20px;
        height: 20px;
        background: rgba(0, 0, 0, 0.7);
        color: white;
        border-radius: 50%;
        text-align: center;
        line-height: 18px;
        font-size: 14px;
        cursor: pointer;
        z-index: 10;
        border: 1px solid rgba(255,255,255,0.3);
        transition: all 0.2s;
    }
    .btn-delete-img:hover {
        background: #ef4444; /* 빨간색 */
        transform: scale(1.1);
    }

    /* 입력 폼 스타일 */
    .write-input {
        background: rgba(255, 255, 255, 0.05) !important;
        border: 1px solid rgba(255, 255, 255, 0.1) !important;
        color: white !important;
        font-size: 0.9rem;
    }
    .write-input:focus {
        background: rgba(255, 255, 255, 0.1) !important;
        border-color: #a855f7 !important;
        color: white !important;
        box-shadow: none !important;
    }
    .write-input::placeholder { color: rgba(255, 255, 255, 0.3); }
    .form-check-label { color: rgba(255, 255, 255, 0.8); font-size: 0.9rem; }
</style>
</head>
<body>

    <%@ include file="../home/header.jsp"%>

    <div class="app-body">
        <%@ include file="../home/sidebar.jsp"%>

        <main class="app-main">
            <div class="space-background">
                <div class="stars"></div><div class="stars2"></div><div class="stars3"></div>
                <div class="planet planet-1"></div><div class="planet planet-2"></div>
            </div>

            <div class="container py-4" style="position: relative; z-index: 1;">
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-8">
                        <div class="glass-card shadow-lg p-4 rounded-4" 
                             style="background: rgba(30, 30, 30, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(255,255,255,0.1);">
                            
                            <h5 class="text-white fw-bold mb-3 border-bottom border-secondary border-opacity-25 pb-2">
                                <c:choose>
                                    <c:when test="${mode == 'update'}">Edit Post</c:when>
                                    <c:otherwise>New Post</c:otherwise>
                                </c:choose>
                            </h5>

                            <form name="postForm" method="post" enctype="multipart/form-data">
                                <c:if test="${mode == 'update'}">
                                    <input type="hidden" name="postId" value="${dto.postId}">
                                </c:if>

                                <div class="mb-3">
                                    <label class="form-label text-white-50 small text-uppercase fw-bold mb-1">Title</label>
                                    <input type="text" name="title" class="form-control write-input" 
                                           value="${dto.title}" placeholder="제목을 입력하세요">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-white-50 small text-uppercase fw-bold mb-1">Content</label>
                                    <textarea name="content" class="form-control write-input" 
                                              style="height: 150px; resize: none;" 
                                              placeholder="내용을 입력하세요">${dto.content}</textarea>
                                </div>

                                <div class="mb-3 d-flex flex-wrap gap-4 p-3 rounded-3" style="background: rgba(0,0,0,0.2);">
    
								    <div class="form-check">
								        <input class="form-check-input" type="checkbox" name="chkReply" id="chkReply" value="0"
								               ${mode == 'update' && dto.replyEnabled == '0' ? 'checked' : ''}>
								        <label class="form-check-label" for="chkReply">댓글 비허용</label>
								    </div>
								
								    <div class="form-check">
								        <input class="form-check-input" type="checkbox" name="chkLikes" id="chkLikes" value="0"
								               ${mode == 'update' && dto.showLikes == '0' ? 'checked' : ''}>
								        <label class="form-check-label" for="chkLikes">좋아요 숨김</label>
								    </div>
								
								    <div class="form-check">
								        <input class="form-check-input" type="checkbox" name="chkViews" id="chkViews" value="0"
								               ${mode == 'update' && dto.showViews == '0' ? 'checked' : ''}>
								        <label class="form-check-label" for="chkViews">조회수 숨김</label>
								    </div>
								
								    <div class="form-check ms-auto">
								        <input class="form-check-input" type="checkbox" name="chkPrivate" id="chkPrivate" value="true"
								               ${mode == 'update' && dto.state == '나만보기' ? 'checked' : ''}>
								        <label class="form-check-label text-warning fw-bold" for="chkPrivate">🔒 나만 보기</label>
								    </div>
								</div>

                                <div class="mb-3">
                                    <label class="form-label text-white-50 small text-uppercase fw-bold mb-1">Images</label>
                                    <input type="file" name="selectFile" id="selectFile" class="form-control write-input" multiple 
                                           accept="image/*" onchange="handleFileSelect(this);">
                                    
                                    <div class="viewer mt-2 d-flex flex-wrap gap-2"></div>
                                    
                                    <div id="deletedFileContainer"></div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 pt-2 border-top border-secondary border-opacity-25">
                                    <button type="button" class="btn btn-sm btn-secondary" onclick="location.href='${pageContext.request.contextPath}/main'">Cancel</button>
                                    <button type="button" class="btn btn-sm btn-primary px-4 fw-bold" 
                                            style="background: #a855f7; border: none;" onclick="sendOk();">
                                        ${mode == 'update' ? 'Update' : 'Post'}
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
        const mode = "${mode}";
        
        // [새 파일 관리용 DataTransfer 객체]
        const dataTransfer = new DataTransfer();

        $(function() {
            // [수정 모드] 기존 이미지 표시
            if (mode === "update") {
                const $viewer = $(".viewer");
                <c:if test="${not empty dto.fileList}">
                    <c:forEach var="file" items="${dto.fileList}">
                        {
                            let imgPath = "${file.filePath}";
                            if (!imgPath.startsWith("http")) {
                                imgPath = contextPath + "/uploads/photo/" + imgPath;
                            }
                            
                            // 기존 파일은 deleteOldFile 함수 호출
                            let html = `
                                <div class="img-item" id="old-img-${file.fileAtId}">
                                    <img src="\${imgPath}">
                                    <div class="btn-delete-img" onclick="deleteOldFile('${file.fileAtId}');">&times;</div>
                                </div>
                            `;
                            $viewer.append(html);
                        }
                    </c:forEach>
                </c:if>
            }
        });

        // [기존 파일 삭제] - 화면에서 숨기고 hidden input 추가
        function deleteOldFile(fileId) {
            if(!confirm("기존 이미지를 삭제하시겠습니까? (수정 완료 시 반영됩니다)")) return;
            
            $("#old-img-" + fileId).remove(); // 화면 제거
            
            // 삭제할 파일 ID를 form에 추가 (name="delfile")
            let input = `<input type="hidden" name="delfile" value="\${fileId}">`;
            $("#deletedFileContainer").append(input);
        }

        // [새 파일 선택 핸들러]
        function handleFileSelect(input) {
            if (input.files) {
                const filesArr = Array.from(input.files);
                filesArr.forEach(file => {
                    if (!file.type.match("image.*")) return;
                    
                    // DataTransfer에 담기
                    dataTransfer.items.add(file);
                    
                    // 미리보기 생성 (새 파일은 deleteNewFile 호출)
                    // file 객체를 식별하기 위해 lastModified 등을 활용하거나 인덱스 사용
                    // 여기선 간단히 렌더링 시점에 매핑
                    renderNewFiles();
                });
                
                // input 파일 리스트 업데이트
                input.files = dataTransfer.files;
            }
        }

        // [새 파일 렌더링 및 삭제 기능]
        function renderNewFiles() {
            // 기존에 렌더링된 '새 파일' 미리보기만 제거 (기존 DB파일은 건드리지 않음)
            $(".new-img-item").remove();
            
            const $viewer = $(".viewer");
            const files = dataTransfer.files;

            for(let i=0; i<files.length; i++) {
                const file = files[i];
                const reader = new FileReader();
                reader.onload = function(e) {
                    let html = `
                        <div class="img-item new-img-item">
                            <img src="\${e.target.result}">
                            <div class="btn-delete-img" onclick="deleteNewFile(\${i});">&times;</div>
                        </div>
                    `;
                    $viewer.append(html);
                }
                reader.readAsDataURL(file);
            }
        }

        // [새 파일 삭제]
        function deleteNewFile(index) {
            // DataTransfer에서 해당 인덱스 파일 제거
            const newDataTransfer = new DataTransfer();
            const files = dataTransfer.files;
            
            for(let i=0; i<files.length; i++) {
                if(i !== index) {
                    newDataTransfer.items.add(files[i]);
                }
            }
            
            // 전역 dataTransfer 업데이트
            dataTransfer.items.clear();
            for(let i=0; i<newDataTransfer.files.length; i++){
                dataTransfer.items.add(newDataTransfer.files[i]);
            }
            
            // input 업데이트 및 다시 그리기
            document.getElementById("selectFile").files = dataTransfer.files;
            renderNewFiles();
        }

        function sendOk() {
            const f = document.postForm;
            if(!f.title.value.trim()) { alert("제목을 입력하세요."); f.title.focus(); return; }
            if(!f.content.value.trim()) { alert("내용을 입력하세요."); f.content.focus(); return; }
            
            f.action = contextPath + "/post/" + mode;
            f.submit();
        }
    </script>
</body>
</html>