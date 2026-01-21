<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<%-- [핵심] 컨트롤러에서 보낸 최신 댓글 개수를 숨겨둠 (article.jsp가 이걸 읽어감) --%>
<input type="hidden" id="dynamicCommentCount" value="${commentCount}">

<c:if test="${empty listReply}">
	<div class="text-center py-3 text-white-50">
		<p class="small mb-0" style="font-size: 0.8rem;">첫 댓글의 주인공이 되어보세요!</p>
	</div>
</c:if>

<c:forEach var="dto" items="${listReply}">
	<div
		class="comment-item py-1 ${dto.parentCommentId != 0 ? 'ms-5' : ''}">

		<div class="d-flex align-items-start gap-2">
			<div class="flex-shrink-0 mt-1">
			
				<div
					class="rounded-circle overflow-hidden d-flex align-items-center justify-content-center shadow-sm app-user-trigger"
					style="width: 28px; height: 28px; background: linear-gradient(45deg, #a855f7, #6366f1); cursor: pointer;"
					data-user-id="${dto.userId}">
					<c:choose>
						<c:when test="${not empty dto.profileImage}">
							<c:choose>
								<%-- 1. http로 시작하면(소셜 로그인 등) 그대로 출력 --%>
								<c:when test="${fn:startsWith(dto.profileImage, 'http')}">
									<img src="${dto.profileImage}"
										style="width: 100%; height: 100%; object-fit: cover;">
								</c:when>
								<%-- 2. 아니면 서버 업로드 경로 붙여서 출력 --%>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/uploads/profile/${dto.profileImage}"
										style="width: 100%; height: 100%; object-fit: cover;">
								</c:otherwise>
							</c:choose>
						</c:when>
						<%-- 3. 프로필 사진 없으면 닉네임 첫 글자 --%>
						<c:otherwise>
							<span class="text-white fw-bold" style="font-size: 12px;">${fn:substring(dto.userNickName, 0, 1)}</span>
						</c:otherwise>
					</c:choose>
				</div>



			</div>

			<div class="flex-grow-1 text-start">

				<div class="mb-0" id="comment-view-${dto.commentId}">
					<span class="text-white fw-bold me-1" style="font-size: 0.85rem;">${dto.userNickName}</span>
					<span class="text-white-50"
						style="font-size: 0.85rem; word-break: break-all;"> <c:choose>
							<c:when test="${dto.isDeleted == '1'}">
								<span class="fst-italic small">삭제된 댓글입니다.</span>
							</c:when>
							<c:otherwise>
                                ${dto.content}
                            </c:otherwise>
						</c:choose>
					</span>
				</div>

				<div id="comment-edit-${dto.commentId}" style="display: none;" class="mt-1">
				
				
					<div class="d-flex gap-2 align-items-center">
						<input type="text" id="editContent-${dto.commentId}"
							class="form-control form-control-sm bg-transparent text-white border-secondary rounded-0 border-top-0 border-start-0 border-end-0 px-0"
							value="${dto.content}" style="font-size: 0.85rem;">
						<div class="d-flex dgap-1 flex-shrink-0">
							<%-- 수정 취소 버튼 --%>
							<button type="button" class="btn btn-sm text-white-50 p-0"
								style="font-size: 0.8rem; white-space: nowrap;"
								onclick="toggleEdit('${dto.commentId}')">취소</button>
							<%-- 수정 저장 버튼 --%>
							<button type="button" class="btn btn-sm text-primary fw-bold p-0"
								style="font-size: 0.8rem; white-space: nowrap;"
								onclick="updateReply('${dto.commentId}')">저장</button>
						</div>
					</div>
					
									
				</div>
				

				<div class="d-flex align-items-center gap-3 mt-1">
					<span class="text-white-50" style="font-size: 0.7rem;">${dto.timeAgo}</span>

					<c:if test="${dto.isDeleted == '0'}">
						<button type="button"
							class="btn p-0 border-0 d-flex align-items-center gap-1 ${dto.likedByUser ? 'text-pink' : 'text-secondary'}"
							onclick="sendCommentLike('${dto.commentId}', this)"
							style="font-size: 0.7rem; background: transparent;">
							<span class="material-symbols-outlined"
								style="font-size: 0.8rem;"> ${dto.likedByUser ? 'favorite' : 'favorite_border'}
							</span> <span class="like-count">${dto.likeCount > 0 ? dto.likeCount : '좋아요'}</span>
						</button>

						<button type="button"
							class="btn p-0 border-0 text-secondary fw-bold"
							onclick="showReplyForm('${dto.commentId}', this)"
							style="font-size: 0.7rem; background: transparent;">답글
							달기</button>

						<c:if test="${sessionScope.member.memberIdx == dto.userNum}">
							<%-- 수정 버튼 --%>
							<button type="button"
								class="btn p-0 border-0 text-secondary opacity-75 hover-opacity-100"
								onclick="toggleEdit('${dto.commentId}')"
								style="font-size: 0.7rem; background: transparent;">수정</button>

							<%-- 삭제 버튼 --%>
							<button type="button"
								class="btn p-0 border-0 text-danger opacity-75 hover-opacity-100"
								onclick="deleteReply('${dto.commentId}')"
								style="font-size: 0.7rem; background: transparent;">삭제</button>
						</c:if>
					</c:if>
				</div>

				<div id="replyForm-${dto.commentId}" class="mt-2" style="display: none;">
					<div class="d-flex gap-2 align-items-center">
						<input type="text" id="replyContent-${dto.commentId}"
							class="form-control comment-input text-white border-0 border-bottom border-secondary rounded-0 px-0 py-1"
							placeholder="답글을 입력하세요..." 
							style="background: transparent; font-size: 0.9rem; box-shadow: none;">
						<button type="button"
							class="btn btn-sm btn-link text-decoration-none text-primary fw-bold p-0 flex-shrink-0"
							onclick="sendReplyAnswer('${dto.commentId}')" style="font-size: 0.85rem; white-space: nowrap;">등록</button>
					</div>
				</div>

			</div>
		</div>
	</div>
</c:forEach>