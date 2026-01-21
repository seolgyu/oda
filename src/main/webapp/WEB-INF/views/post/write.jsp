<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<style>
	/* [1] 전체 카드 디자인: 더 깊이감 있는 글래스 효과 */
    .glass-card {
        background: rgba(20, 20, 20, 0.7) !important; /* 배경을 조금 더 어둡게 */
        backdrop-filter: blur(20px) !important;       /* 블러 효과 강화 */
        border: 1px solid rgba(255, 255, 255, 0.08) !important;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5) !important; /* 그림자 강화로 입체감 */
        border-radius: 24px !important;
        overflow: hidden; /* 내부 요소가 둥근 모서리를 넘지 않도록 */
    }
    
    .img-item {
        position: relative;
        display: inline-block;
        margin: 0; /* 간격은 flex gap으로 제어하므로 초기화 */
        width: 110px;  /* 크기 약간 키움 */
        height: 110px;
        border-radius: 16px; /* 더 둥글게 */
        overflow: hidden;
        border: 1px solid rgba(255, 255, 255, 0.1);
        background: #1a1a1a;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        transition: transform 0.2s ease;
    }
    
    .img-item:hover {
        transform: translateY(-3px); /* 마우스 올리면 살짝 뜸 */
        border-color: #a855f7;
    }
    
    .img-item img, .img-item video {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }
    
    .img-item:hover img {
        transform: scale(1.05); /* 이미지 살짝 확대 */
    }
   
    .btn-delete-img {
        position: absolute;
        top: 6px;
        right: 6px;
        width: 24px;
        height: 24px;
        background: rgba(0, 0, 0, 0.6);
        backdrop-filter: blur(4px);
        color: white;
        border-radius: 50%;
        text-align: center;
        line-height: 22px; /* 수직 중앙 정렬 보정 */
        font-size: 16px;
        cursor: pointer;
        z-index: 10;
        border: 1px solid rgba(255,255,255,0.2);
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .btn-delete-img:hover {
        background: #ef4444; /* 삭제 시 빨간색 */
        border-color: #ef4444;
        transform: rotate(90deg); /* 회전 효과 추가 */
    }
    
    .option-container {
        background: rgba(0, 0, 0, 0.2) !important; /* 인라인 스타일 덮어쓰기 */
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 16px !important;
        padding: 1.25rem !important;
    }

    .write-input {
        background: rgba(255, 255, 255, 0.03) !important; /* 아주 옅은 배경 */
        border: 1px solid rgba(255, 255, 255, 0.08) !important;
        border-radius: 12px !important;
        color: #f1f5f9 !important; /* 밝은 텍스트 */
        font-size: 0.95rem;
        padding: 12px 15px;
        transition: all 0.3s ease;
    }

    .write-input:hover {
        background: rgba(255, 255, 255, 0.06) !important;
        border-color: rgba(255, 255, 255, 0.2) !important;
    }

    .write-input:focus {
        background: rgba(255, 255, 255, 0.08) !important;
        border-color: #a855f7 !important; /* 포커스 시 보라색 포인트 */
        box-shadow: 0 0 0 4px rgba(168, 85, 247, 0.15) !important; /* 부드러운 글로우 효과 */
        color: #fff !important;
    }

    .write-input::placeholder {
        color: rgba(255, 255, 255, 0.3);
        font-weight: 300;
    }
    
    textarea.write-input {
        height: 160px !important; /* 기존 150px -> 500px로 변경 (빗금 친 만큼 확장) */
        resize: none;
    }
    textarea.write-input::-webkit-scrollbar {
        width: 6px;
    }
    textarea.write-input::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 3px;
    }
    
    .form-check-input {
        background-color: rgba(255, 255, 255, 0.1);
        border-color: rgba(255, 255, 255, 0.2);
        cursor: pointer;
    }
    
    .form-check-input:checked {
        background-color: #a855f7;
        border-color: #a855f7;
    }

    .form-check-label {
        color: rgba(255, 255, 255, 0.7);
        font-size: 0.9rem;
        cursor: pointer;
        transition: color 0.2s;
    }
    
    .form-check-input:checked + .form-check-label {
        color: #fff;
        font-weight: 500;
    }
    
    .btn-primary, .btn-secondary, .btn-outline-light {
        border-radius: 12px !important; /* 둥근 모서리 통일 */
        padding: 8px 24px !important;   /* 크기감 통일 */
        font-weight: 600 !important;    /* 폰트 굵기 통일 */
        letter-spacing: 0.5px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        height: 42px; /* 높이 강제 통일 */
    }

    /* Post 버튼 (그라데이션 유지) */
    .btn-primary {
        background: linear-gradient(135deg, #a855f7, #6366f1) !important;
        border: none !important;
        box-shadow: 0 4px 15px rgba(168, 85, 247, 0.4);
    }

    /* Cancel, 임시저장, 불러오기 버튼 (임시저장 버튼 스타일로 통일) */
    .btn-secondary, .btn-outline-light {
        background: transparent !important;
        border: 1px solid rgba(255, 255, 255, 0.2) !important;
        color: rgba(255, 255, 255, 0.8) !important;
    }
    
    .btn-secondary:hover, .btn-outline-light:hover {
        background: rgba(255, 255, 255, 0.1) !important;
        color: white !important;
        border-color: rgba(255, 255, 255, 0.4) !important;
    }

    /* [6] 라벨 및 헤더 타이포그래피 */
    .form-label {
        letter-spacing: 1px;
        color: #a855f7 !important; /* 라벨에 포인트 컬러 */
        margin-left: 4px;
        font-size: 0.75rem !important;
    }

    h5.text-white {
        font-family: 'Pretendard', sans-serif; /* 폰트가 있다면 적용 */
        letter-spacing: -0.5px;
        border-bottom-color: rgba(255,255,255,0.1) !important;
    }
    
    /* 파일 선택 버튼(input type=file) 커스텀 */
    input[type=file]::file-selector-button {
        margin-right: 15px;
        border: 1px solid rgba(255, 255, 255, 0.2); /* 테두리 추가 */
        background: transparent; /* 배경 투명 */
        padding: 0 20px; /* 패딩 조정 */
        height: 38px; /* 높이 맞춤 */
        border-radius: 12px; /* 둥근 모서리 */
        color: rgba(255, 255, 255, 0.8);
        cursor: pointer;
        font-weight: 600;
        transition: all .2s ease-in-out;
    }

    input[type=file]::file-selector-button:hover {
        background: rgba(255, 255, 255, 0.1);
        color: white;
        border-color: rgba(255, 255, 255, 0.4);
    }
    
    .feed-scroll-container {
        height: 100vh;       /* 화면 전체 높이 사용 */
        overflow-y: auto;    /* 세로 내용이 넘치면 스크롤 생성 */
        position: relative;
        z-index: 10;         /* 배경보다 위에 표시 */
        padding-top: 60px;   /* 헤더 높이만큼 여백 (헤더에 가려지지 않게) */
        padding-bottom: 50px; /* 바닥 여백 */
    }
    
    /* 작성 폼이 화면 아래에 딱 붙지 않게 여백 추가 */
    .container.py-4 {
        padding-bottom: 100px !important;
    }
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
			<div class="feed-scroll-container custom-scrollbar">
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
									
									    <div class="form-check">
									        <input class="form-check-input" type="checkbox" name="chkPrivate" id="chkPrivate" value="true"
									               ${mode == 'update' && dto.state == '나만보기' ? 'checked' : ''}>
									        <label class="form-check-label text-warning fw-bold" for="chkPrivate">나만 보기🔒</label>
									    </div>
									</div>
	
	                                <div class="mb-3">
	                                    <label class="form-label text-white-50 small text-uppercase fw-bold mb-1">Media</label>
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