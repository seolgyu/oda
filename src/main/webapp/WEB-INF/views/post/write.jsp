<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../home/head.jsp"%>
    <style>
        /* 투명 입력창 스타일 (우주 테마용) */
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
        .board-input::placeholder { color: rgba(255, 255, 255, 0.5); }
        
        /* 체크박스 커스텀 */
        .form-check-input { background-color: rgba(255, 255, 255, 0.2); border-color: rgba(255, 255, 255, 0.3); }
        .form-check-input:checked { background-color: #a855f7; border-color: #a855f7; }
        
        /* 스크롤바 디자인 */
        textarea.board-input::-webkit-scrollbar { width: 8px; }
        textarea.board-input::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.2); border-radius: 4px; }
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
                <div class="planet planet-1"></div>
            </div>

            <div class="d-flex justify-content-center align-items-center w-100 py-5" style="min-height: calc(100vh - 70px);">
                
                <div class="p-5 shadow-lg d-flex flex-column gap-4"
                     style="width: 100%; max-width: 800px; border-radius: 1rem; 
                            backdrop-filter: blur(12px); background: rgba(255, 255, 255, 0.05); 
                            border: 1px solid rgba(255, 255, 255, 0.1);">

                    <div class="border-bottom border-secondary border-opacity-25 pb-3">
                        <h2 class="text-white fw-bold fs-4 mb-1">
                            <span class="material-symbols-outlined align-middle me-2">edit_note</span>
                            <c:if test="${mode=='update'}">게시글 수정</c:if>
                            <c:if test="${mode=='write'}">게시글 작성</c:if>
                        </h2>
                        <p class="text-secondary text-xs mb-0">Share your thoughts with the universe.</p>
                    </div>

                    <form name="postForm" method="post">
                        
                        <div class="mb-3">
                            <label class="text-white-50 fw-bold mb-2 ms-1">Subject</label>
                            <input type="text" name="title" class="form-control board-input py-3" 
                                   placeholder="제목을 입력하세요" value="${dto.title}">
                        </div>

                        <div class="mb-3">
                            <label class="text-white-50 fw-bold mb-2 ms-1">Writer</label>
                            <input type="text" class="form-control board-input" 
                                   value="${sessionScope.member.userName}" readonly 
                                   style="background: rgba(0,0,0,0.2); cursor: default;">
                        </div>

                        <div class="mb-3 form-check ms-1">
                            <input class="form-check-input" type="checkbox" name="isNotice" value="1" id="noticeCheck"
                                <c:if test="${dto.postType == 'NOTICE'}">checked</c:if>>
                            <label class="form-check-label text-white-50" for="noticeCheck">
                                공지사항으로 등록 (Notice)
                            </label>
                        </div>

                        <div class="mb-4">
                            <label class="text-white-50 fw-bold mb-2 ms-1">Content</label>
                            <textarea name="content" class="form-control board-input" rows="12" 
                                      placeholder="내용을 자유롭게 작성하세요">${dto.content}</textarea>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-outline-light px-4" 
                                    onclick="location.href='${pageContext.request.contextPath}/post/list';">
                                Cancel
                            </button>
                            
                            <button type="button" class="btn text-white px-4 fw-bold"
                                    style="background: linear-gradient(to right, #a855f7, #6366f1); border: none;"
                                    onclick="sendOk();">
                                <c:if test="${mode=='update'}">Update</c:if>
                                <c:if test="${mode=='write'}">Submit</c:if>
                            </button>
                        </div>
                        
                        <c:if test="${mode=='update'}">
                            <input type="hidden" name="postId" value="${dto.postId}">
                        </c:if>

                    </form>
                </div>
            </div>
        </main>
    </div>

    <script type="text/javascript">
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

            // mode 변수에 따라 등록/수정 주소 결정
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