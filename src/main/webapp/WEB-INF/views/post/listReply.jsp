<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:forEach var="dto" items="${listReply}">
    <div class="comment-item py-2 px-3 mb-2 border-bottom border-secondary border-opacity-10 
                ${dto.parentCommentId != 0 ? 'ms-5 bg-white bg-opacity-10 rounded-3' : ''}">
        
        <div class="d-flex justify-content-between align-items-start">
            <div class="d-flex gap-2 w-100">
                <div class="flex-shrink-0">
                    <div class="rounded-circle overflow-hidden d-flex align-items-center justify-content-center" 
                         style="width: 32px; height: 32px; background: #333;">
                        <c:if test="${not empty dto.profileImage}">
                            <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profileImage}" 
                                 style="width: 100%; height: 100%; object-fit: cover;">
                        </c:if>
                        <c:if test="${empty dto.profileImage}">
                            <span class="material-symbols-outlined text-white-50 fs-5">person</span>
                        </c:if>
                    </div>
                </div>

                <div class="flex-grow-1">
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="text-white fw-bold small">${dto.userNickName}</span>
                        <span class="text-white-50" style="font-size: 0.75rem;">${dto.createdDate}</span>
                    </div>

                    <div class="text-gray-300 text-sm mb-2" style="white-space: pre-wrap;">
                        <c:choose>
                            <c:when test="${dto.isDeleted == '1'}">
                                <span class="text-white-50 fst-italic">삭제된 댓글입니다.</span>
                            </c:when>
                            <c:otherwise>
                                ${dto.content}
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${dto.isDeleted == '0'}">
                        <div class="d-flex align-items-center gap-3">
                            <button type="button" class="btn btn-link p-0 text-decoration-none d-flex align-items-center gap-1 btn-comment-like ${dto.likedByUser ? 'text-pink' : 'text-white-50'}"
                                    onclick="sendCommentLike('${dto.commentId}', this)">
                                <span class="material-symbols-outlined" style="font-size: 1rem;">
                                    ${dto.likedByUser ? 'favorite' : 'favorite_border'}
                                </span>
                                <span class="small like-count">${dto.likeCount > 0 ? dto.likeCount : '좋아요'}</span>
                            </button>

                            <button type="button" class="btn btn-link p-0 text-decoration-none text-white-50 small"
                                    onclick="showReplyForm('${dto.commentId}', this)">답글 달기</button>

                            <c:if test="${sessionScope.member.memberIdx == dto.userNum || sessionScope.member.userLevel > 50}">
                                <button type="button" class="btn btn-link p-0 text-decoration-none text-danger small opacity-75"
                                        onclick="deleteReply('${dto.commentId}')">삭제</button>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div id="replyForm-${dto.commentId}" class="reply-form mt-3 ms-4" style="display: none;">
            <div class="d-flex gap-2">
                <input type="text" class="form-control form-control-sm bg-dark text-white border-secondary" 
                       placeholder="@${dto.userNickName}님에게 답글 작성..." id="replyContent-${dto.commentId}">
                <button type="button" class="btn btn-sm btn-primary text-nowrap"
                        onclick="sendReplyAnswer('${dto.commentId}')">등록</button>
            </div>
        </div>
    </div>
</c:forEach>