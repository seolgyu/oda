<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<style>
    
    .article-image {
        width: 100%;
        max-height: 600px;
        object-fit: contain; 
        background-color: rgba(0,0,0,0.2);
        border-radius: 0.5rem;
        margin-bottom: 1rem;
    }
    
    .comment-input {
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: #fff;
    }
    .comment-input:focus {
        background: rgba(255, 255, 255, 0.1);
        border-color: #a855f7;
        box-shadow: none;
        color: #fff;
    }
    
    .article-content {
        white-space: pre-wrap; 
        word-break: break-all;
        color: #e2e8f0;
        line-height: 1.7;
    }

    .hover-pink:hover { color: #ec4899 !important; }
    .hover-blue:hover { color: #60a5fa !important; }
    .hover-green:hover { color: #4ade80 !important; }
    .hover-yellow:hover { color: #facc15 !important; }
    .hover-purple:hover { color: #c084fc !important; }

</style>
<script type="text/javascript">
    function deletePost(postId) {
        if(confirm("게시글을 삭제하시겠습니까?")) {
            // 삭제 처리 URL로 이동 (아직 구현 전이라면 알림만)
            // location.href = '${pageContext.request.contextPath}/post/delete?postId=' + postId;
            alert("삭제 기능 구현 예정입니다.");
        }
    }

    function updatePost(postId) {
        location.href = '${pageContext.request.contextPath}/post/update?postId=' + postId;
    }
</script>
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

            <div class="feed-scroll-container custom-scrollbar">
				<div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-12 col-lg-8 col-xl-7">
                            
                            <div class="d-flex align-items-center gap-2 mb-3 px-1">
                                <button type="button" class="btn-icon text-white" onclick="location.href='${pageContext.request.contextPath}/post/list?page=${page}'">
                                    <span class="material-symbols-outlined">arrow_back</span>
                                </button>
                                <span class="text-white fw-bold fs-5">Post</span>
                            </div>

                            <div class="glass-card shadow-lg mb-4" 
                                 style="background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 1rem;">
                                
                                <div class="p-4 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar-md text-white fw-bold d-flex align-items-center justify-content-center" 
                                             style="width: 48px; height: 48px; border-radius: 50%; background: linear-gradient(45deg, #a855f7, #6366f1); overflow: hidden;">
                                             <c:choose>
                                                <c:when test="${not empty memberdto.profile_photo}">
                                                    <img src="${pageContext.request.contextPath}/uploads/profile/${memberdto.profile_photo}" style="width:100%; height:100%; object-fit:cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="material-symbols-outlined fs-3">person</span>
                                                </c:otherwise>
                                             </c:choose>
                                        </div>
                                        <div>
                                            <h3 class="text-sm fw-medium text-white mb-0">
                                                ${not empty memberdto.userNickname ? memberdto.userNickname : memberdto.userId} 
                                            </h3>
                                            <p class="text-xs text-gray-500 mb-0">${dto.createdDate} &bull; 조회 ${dto.viewCount}</p>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${sessionScope.member.memberIdx == memberdto.userIdx}">
                                        <div class="dropdown">
                                            <button class="btn btn-icon text-white" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <span class="material-symbols-outlined">more_horiz</span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-dark glass-dropdown" style="background: rgba(30, 30, 30, 0.9);">
                                                <li><a class="dropdown-item" href="#" onclick="updatePost('${dto.postId}'); return false;">수정</a></li>
                                                <li><a class="dropdown-item text-danger" href="#" onclick="deletePost('${dto.postId}'); return false;">삭제</a></li>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="p-4">
                                    <h4 class="text-white fw-bold mb-4" style="font-size: 1.5rem;">${dto.title}</h4>
                                    
                                    <c:if test="${not empty dto.fileList}">
                                        <div class="mb-4">
                                            <c:forEach var="fileDto" items="${dto.fileList}">
                                                <img src="${pageContext.request.contextPath}/uploads/photo/${fileDto.filePath}" 
                                                     class="article-image" alt="Attachment">
                                            </c:forEach>
                                        </div>
                                    </c:if>

                                    <div class="article-content">${dto.content}</div>
                                </div>

                                <div class="px-4 py-3 d-flex align-items-center justify-content-between border-top border-white border-opacity-10"
                                    style="background: rgba(255, 255, 255, 0.02);">
                                    
                                    <div class="d-flex gap-4">
                                        <button class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-pink">
                                            <span class="material-symbols-outlined fs-5">favorite_border</span> 
                                            <span class="small">${dto.likeCount}</span>
                                        </button>
                                        <button class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-blue">
                                            <span class="material-symbols-outlined fs-5">chat_bubble_outline</span>
                                            <span class="small">${dto.commentCount}</span>
                                        </button>
                                        <button class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-green">
                                            <span class="material-symbols-outlined fs-5">repeat</span>
                                        </button>
                                    </div>

                                    <div class="d-flex gap-3">
                                        <button class="btn btn-link text-decoration-none text-white-50 p-0 hover-yellow">
                                            <span class="material-symbols-outlined fs-5">bookmark_border</span>
                                        </button>
                                        <button class="btn btn-link text-decoration-none text-white-50 p-0 hover-purple">
                                            <span class="material-symbols-outlined fs-5">share</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <c:if test="${dto.replyEnabled != '0'}">
                                <div class="glass-card shadow-lg p-4" 
                                     style="background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 1rem;">
                                    <h5 class="text-white text-sm fw-bold mb-3">Comments</h5>
                                    
                                    <div class="d-flex gap-3 mb-4">
                                        <div class="avatar-sm bg-secondary text-white fw-bold flex-shrink-0 d-flex align-items-center justify-content-center rounded-circle" style="width:36px; height:36px;">ME</div>
                                        <div class="flex-grow-1 position-relative">
                                            <input type="text" class="form-control comment-input rounded-pill px-3 text-sm" placeholder="Add a comment...">
                                            <button class="btn btn-sm btn-primary rounded-pill position-absolute top-50 end-0 translate-middle-y me-1 px-3" 
                                                    style="background: #a855f7; border:none; font-size: 0.75rem;">Post</button>
                                        </div>
                                    </div>

                                    <div class="text-center py-4 text-white-50">
                                        <span class="material-symbols-outlined fs-1 opacity-25">chat</span>
                                        <p class="mt-2 small">아직 댓글이 없습니다. 첫 번째 댓글을 남겨보세요!</p>
                                    </div>
                                </div>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
		</main>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>