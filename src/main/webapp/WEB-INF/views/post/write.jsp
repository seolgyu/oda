<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<style>
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
        background: #ef4444; 
        transform: scale(1.1);
    }

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
                                    <c:when test="${mode == 'update'}">Edit Post
                                    <%-- 수정 모드일 때 소속 커뮤니티가 있다면 표시 --%>
							            <c:choose>
							                <c:when test="${not empty dto.communityId}">Post Update (Community)</c:when>
							                <c:otherwise>Edit Post</c:otherwise>
							            </c:choose>
                                    </c:when>
                                    <c:when test="${not empty com_name}">${com_name} 커뮤니티의 새글</c:when>
                                    <c:otherwise>New Post</c:otherwise>
                                </c:choose>
                            </h5>

                            <form name="postForm" method="post" enctype="multipart/form-data">
                                <c:if test="${mode == 'update'}">
                                    <input type="hidden" name="postId" value="${dto.postId}">
                                </c:if>
                                
                                <%-- 2. 커뮤니티 ID 전달 (등록/수정 공통) --%>
							    <%-- 컨트롤러 파라미터(communityId) 혹은 DTO의 정보를 우선순위에 따라 hidden에 담음 --%>
							    <c:set var="targetComid" value="${not empty communityId ? communityId : dto.communityId}"/>
							    <c:if test="${not empty targetComid}">
							        <input type="hidden" name="community_id" value="${targetComid}">
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
                                           accept="image/*, video/*" onchange="handleFileSelect(this);">
                                    
                                    <div class="viewer mt-2 d-flex flex-wrap gap-2"></div>
                                    
                                    <div id="deletedFileContainer"></div>
                                </div>

                                <div class="d-flex justify-content-between pt-2 border-top border-secondary border-opacity-25">
								    <div class="d-flex gap-2">
								        <button type="button" class="btn btn-sm btn-outline-light" onclick="tempSave();">임시저장</button>
								        <button type="button" class="btn btn-sm btn-outline-light" onclick="loadTemp();">불러오기</button>
								    </div>
								
								    <div class="d-flex gap-2">
								       	<c:set var="cancelUrl" value="${pageContext.request.contextPath}/main"/>
						                
						                <c:if test="${not empty targetComid}">
							                <c:set var="cancelUrl" value="${pageContext.request.contextPath}/community/main?community_id=${targetComid}"/>
							            </c:if>
						                
						                <button type="button" class="btn btn-sm btn-secondary" onclick="location.href='${cancelUrl}'">Cancel</button>
								       	
								       	<button type="button" class="btn btn-sm btn-primary px-4 fw-bold" 
								       			style="background: #a855f7; border: none;" onclick="sendOk();">
								            	${mode == 'update' ? 'Update' : 'Post'}
								        </button>
								    </div>
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

        const dataTransfer = new DataTransfer();

        $(function() {
            if (mode === "update") {
                const $viewer = $(".viewer");
                <c:if test="${not empty dto.fileList}">
                    <c:forEach var="file" items="${dto.fileList}">
                        {
                            let imgPath = "${file.filePath}";
                            if (!imgPath.startsWith("http")) {
                                imgPath = contextPath + "/uploads/photo/" + imgPath;
                            }

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


        function deleteOldFile(fileId) {
            if(!confirm("기존 이미지를 삭제하시겠습니까? (수정 완료 시 반영됩니다)")) return;
            
            $("#old-img-" + fileId).remove(); 

            let input = `<input type="hidden" name="delfile" value="\${fileId}">`;
            $("#deletedFileContainer").append(input);
        }


        function handleFileSelect(input) {
            if (input.files) {
                const filesArr = Array.from(input.files);
                filesArr.forEach(file => {
                	if (!file.type.match("image.*") && !file.type.match("video.*")) {
                        alert("이미지 또는 동영상 파일만 업로드할 수 있습니다.");
                        return;
                    }
                 
                    dataTransfer.items.add(file);  
                  
                });
                
                renderNewFiles();

                input.files = dataTransfer.files;
            }
        }

        function renderNewFiles() {
            $(".new-img-item").remove();
            const $viewer = $(".viewer");
            const files = dataTransfer.files;

            for(let i=0; i<files.length; i++) {
                const file = files[i];
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    let mediaTag = "";
                    
                    // 파일 타입이 비디오인지 확인
                    if (file.type.startsWith("video/")) {
                        // 동영상은 muted(음소거) 상태로 미리보기
                        mediaTag = `<video src="\${e.target.result}" style="width:100%; height:100%; object-fit:cover;" muted playsinline onmouseover="this.play()" onmouseout="this.pause()"></video>`;
                    } else {
                        // 이미지는 기존대로 처리
                        mediaTag = `<img src="\${e.target.result}">`;
                    }

                    let html = `
                        <div class="img-item new-img-item">
                            \${mediaTag}
                            <div class="btn-delete-img" onclick="deleteNewFile(\${i});">&times;</div>
                        </div>
                    `;
                    $viewer.append(html);
                }
                reader.readAsDataURL(file);
            }
        }

        function deleteNewFile(index) {
 
            const newDataTransfer = new DataTransfer();
            const files = dataTransfer.files;
            
            for(let i=0; i<files.length; i++) {
                if(i !== index) {
                    newDataTransfer.items.add(files[i]);
                }
            }
     
            dataTransfer.items.clear();
            for(let i=0; i<newDataTransfer.files.length; i++){
                dataTransfer.items.add(newDataTransfer.files[i]);
            }
  
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
        
        function tempSave() {
            const f = document.postForm;
            const title = f.title.value;
            const content = f.content.value; 
    
            if (!title.trim() && !content.trim()) {
                showToast('error', '작성된 글이 없습니다.');
                return;
            }

            $.ajax({
                type: "POST",
                url: contextPath + "/post/tempSave",
                data: {
                    title: title,
                    content: content
                },
                dataType: "json",
                success: function(data) {
                    if (data.state === "success") {
                        showToast('success', '게시글이 임시저장 되었습니다.');
                    } else if (data.state === "login_required") {
                        location.href = contextPath + "/member/login";
                    } else {
                        showToast('error', '임시저장에 실패했습니다.');
                    }
                },
                error: function(e) {
                    console.log(e);
                    showToast('error', '시스템 오류가 발생했습니다.');
                }
            });
        }

        function loadTemp() {
       
            const f = document.postForm;
            if(f.title.value.trim() || f.content.value.trim()) {
                if(!confirm("작성 중인 내용이 사라집니다. 임시저장된 글을 불러오시겠습니까?")) {
                    return;
                }
            }

            $.ajax({
                type: "POST",
                url: contextPath + "/post/loadTemp",
                dataType: "json",
                success: function(data) {
                    if (data.state === "success") {
                        f.title.value = data.title;
                        f.content.value = data.content;
                        
                        showToast('success', '임시저장된 글을 불러왔습니다.');
                    } else if (data.state === "not_found") {
                        showToast('error', '저장된 게시글이 없습니다.');
                    } else if (data.state === "login_required") {
                        location.href = contextPath + "/member/login";
                    }
                },
                error: function(e) {
                    console.log(e);
                    showToast('error', '불러오기 중 오류가 발생했습니다.');
                }
            });
        }

    </script>
</body>
</html>