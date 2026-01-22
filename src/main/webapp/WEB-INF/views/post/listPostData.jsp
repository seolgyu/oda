<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:forEach var="dto" items="${list}">
    <%-- ================= [VIEW 1] 카드형 ================= --%>
    <c:if test="${viewMode == 'card' || empty viewMode}">
        <div class="glass-card shadow-lg feed-card rounded-4"
            onclick="goArticle('${dto.postId}')"
            style="background: rgba(30, 30, 30, 0.6);">
            <div class="p-3 d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-3"> <div class="avatar-lg text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden shadow-sm"
                style="background: linear-gradient(45deg, #a855f7, #6366f1);">
                <c:choose>
                    <c:when test="${not empty dto.authorProfileImage}">
                        <img src="${dto.authorProfileImage}" style="width: 100%; height: 100%; object-fit: cover;">
                    </c:when>
                    <c:otherwise>
                        <span class="text-white fw-bold" style="font-size: 14px;">${fn:substring(dto.authorNickname, 0, 1)}</span>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div>
                <div class="fs-6 d-flex align-items-center gap-1 fw-bold"> ${dto.authorNickname}
                    <c:if test="${dto.state == '나만보기'}">
                        <span class="material-symbols-outlined text-warning" style="font-size: 1rem;">lock</span>
                    </c:if>
                </div>
                <p class="text-sm text-gray-400 mb-0">
                    ${dto.timeAgo}
                    <c:if test="${dto.showViews == '1' or sessionScope.member.memberIdx == dto.userNum}">
                        &bull; 조회 ${dto.viewCount}
                    </c:if>
                </p>
            </div>
        </div>
    </div>
            
            <hr class="mx-3">

            <div class="px-3 pb-2 pt-3">
                <h5 class="text-white fw-bold fs-4 mb-1">${dto.title}</h5>
                <p class="text-gray-300 fs-6 mb-2 text-ellipsis">${dto.content}</p>
            </div>

            <c:if test="${not empty dto.fileList}">
                <div id="carousel-${dto.postId}" class="carousel slide pb-3"
                    data-bs-interval="false" onclick="event.stopPropagation();">
                    <div class="carousel-inner">
                        <c:forEach var="fileDto" items="${dto.fileList}" varStatus="status">
							<div class="carousel-item ${status.first ? 'active' : ''}">
								<div class="image-container" onmouseenter="showVideoControls(this)" onmouseleave="hideVideoControls(this)">
								    
								    <c:set var="mediaPath" value="${fileDto.filePath}" scope="request" />
								    <c:set var="mediaMode" value="feed" scope="request" /> <%-- 'feed' 모드 --%>
								    
								    <jsp:include page="/WEB-INF/views/post/mediaview.jsp" />
								</div>																		    
							</div>              
                        </c:forEach>
                    </div>
                    <c:if test="${fn:length(dto.fileList) > 1}">
                        <button class="carousel-control-prev ps-3" type="button"
                            data-bs-target="#carousel-${dto.postId}" data-bs-slide="prev"
                            style="display: none;">
                            <span class="carousel-btn-glass"><span
                                class="material-symbols-outlined fs-4">chevron_left</span></span>
                        </button>
                        <button class="carousel-control-next pe-3" type="button"
                            data-bs-target="#carousel-${dto.postId}" data-bs-slide="next">
                            <span class="carousel-btn-glass"><span
                                class="material-symbols-outlined fs-4">chevron_right</span></span>
                        </button>
                    </c:if>
                </div>
            </c:if>

            <div class="px-4 py-3 border-top border-white border-opacity-10">
                <div class="d-flex align-items-center w-100" onclick="event.stopPropagation();">
                    
                    <%-- [수정] 좋아요 버튼 숨김 처리 --%>
                    <c:if test="${dto.showLikes == '1' or sessionScope.member.memberIdx == dto.userNum}">
                        <button class="card-action-btn action-btn-hover btn-like me-3 ${dto.likedByUser ? 'text-pink' : ''}"
                            onclick="toggleLike('${dto.postId}', this); event.stopPropagation();">
                            <span class="material-symbols-outlined">${dto.likedByUser ? 'favorite' : 'favorite_border'}</span>
                            <span class="like-count">${dto.likeCount}</span>
                        </button>
                    </c:if>

                    <button class="card-action-btn action-btn-hover btn-comment"
                        onclick="goArticle('${dto.postId}'); event.stopPropagation();">
                        <span class="material-symbols-outlined">chat_bubble</span> <span>${dto.commentCount}</span>
                    </button>
                    
					<div class="ms-auto d-flex gap-2">
					    <button class="card-action-btn action-btn-hover btn-share"
					        onclick="copyUrl('${dto.postId}'); event.stopPropagation();">
					        <span class="material-symbols-outlined">share</span> <span>공유</span>
					    </button>
					
					    <button class="card-action-btn action-btn-hover btn-repost ${dto.repostedByUser ? 'text-repost-green' : ''}"
					        onclick="toggleRepost('${dto.postId}', this); event.stopPropagation();">
					        <span class="material-symbols-outlined">repeat</span> <span>리그렘</span>
					    </button>
					
					    <button class="card-action-btn action-btn-hover btn-save ${dto.savedByUser ? 'text-warning' : ''}"
					        onclick="toggleSave('${dto.postId}', this); event.stopPropagation();">
					        <span class="material-symbols-outlined">${dto.savedByUser ? 'bookmark' : 'bookmark_border'}</span> <span>저장</span>
					    </button>
					
					    <button class="card-action-btn action-btn-hover btn-report" 
					         onclick="openReportModal('${dto.postId}', '${dto.userNum}'); event.stopPropagation();">
					        <span class="material-symbols-outlined">campaign</span> <span>신고</span>
					    </button>
					</div>
                </div>
            </div>
        </div>
    </c:if>

    <%-- ================= [VIEW 2] 축약형 ================= --%>
    <c:if test="${viewMode == 'compact'}">
        <div class="compact-card shadow-sm"
            onclick="goArticle('${dto.postId}')" style="flex-shrink: 0;">
            
			<div class="compact-thumbnail-area shadow-sm">
			    <c:choose>
			        <c:when test="${not empty dto.fileList}">
			            
			            <c:set var="mediaPath" value="${dto.fileList[0].filePath}" scope="request" />
			            <c:set var="mediaMode" value="compact" scope="request" /> <%-- 'compact' 모드 --%>
			            
			            <jsp:include page="/WEB-INF/views/post/mediaview.jsp" />
			            
			        </c:when>
			        <c:otherwise>
			            <div class="d-flex align-items-center justify-content-center w-100 h-100 bg-secondary bg-opacity-25">
			                <span class="material-symbols-outlined text-white-50 fs-4">article</span>
			            </div>
			        </c:otherwise>
			    </c:choose>
			</div>			
 
            <div class="flex-grow-1 d-flex flex-column" style="min-width: 0;">
                <h5 class="text-white fw-bold fs-6 mb-2 text-truncate">
                    <%-- [추가] 축약형에도 나만 보기 아이콘 --%>
                    <c:if test="${dto.state == '나만보기'}">
                        <span class="material-symbols-outlined align-middle text-warning me-1" style="font-size: 1rem;">lock</span>
                    </c:if>
                    ${dto.title}
                </h5>
                <div class="d-flex align-items-center justify-content-between mt-auto pt-2">
                    <div class="d-flex align-items-center gap-3 text-gray-400 compact-meta-info">
                        <div class="d-flex align-items-center gap-2 text-white-50">
                            <div class="rounded-circle overflow-hidden d-flex align-items-center justify-content-center shadow-sm"
                                style="width: 20px; height: 20px; background: linear-gradient(45deg, #a855f7, #6366f1);">
                                <c:choose>
                                    <c:when test="${not empty dto.authorProfileImage}">
                                        <img src="${dto.authorProfileImage}" style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-white small fw-bold" style="font-size: 10px;">${fn:substring(dto.authorNickname, 0, 1)}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <span class="fw-bold text-sm text-white">${dto.authorNickname}</span>
                        </div>
                        <span class="opacity-50">&bull;</span> <span class="text-sm">${dto.timeAgo}</span>
                    </div>

                    <div class="compact-action-group ms-auto" onclick="event.stopPropagation();">
                        
                        <%-- [수정] 좋아요 버튼 숨김 처리 --%>
                        <c:if test="${dto.showLikes == '1' or sessionScope.member.memberIdx == dto.userNum}">
                            <button class="compact-action-btn action-btn-hover btn-like p-0 border-0 ${dto.likedByUser ? 'text-pink' : ''}"
                                onclick="toggleLike('${dto.postId}', this); event.stopPropagation();">
                                <span class="material-symbols-outlined">${dto.likedByUser ? 'favorite' : 'favorite_border'}</span>
                                <span class="like-count">${dto.likeCount}</span>
                            </button>
                        </c:if>

                        <button class="compact-action-btn action-btn-hover btn-comment p-0 border-0"
                            onclick="goArticle('${dto.postId}'); event.stopPropagation();">
                            <span class="material-symbols-outlined">chat_bubble</span> <span>${dto.commentCount}</span>
                        </button>
                        
                        <button class="compact-action-btn action-btn-hover btn-share p-0 border-0"
                            onclick="copyUrl('${dto.postId}'); event.stopPropagation();">
                            <span class="material-symbols-outlined">share</span> <span>공유</span>
                        </button>
                        
						<button class="compact-action-btn action-btn-hover btn-repost p-0 border-0 ${dto.repostedByUser ? 'text-repost-green' : ''}"
						    onclick="toggleRepost('${dto.postId}', this); event.stopPropagation();">
						    <span class="material-symbols-outlined">repeat</span> <span>리그렘</span>
						</button>    
						                    
                        <button class="compact-action-btn action-btn-hover btn-save p-0 border-0 ${dto.savedByUser ? 'text-warning' : ''}"
        					onclick="toggleSave('${dto.postId}', this); event.stopPropagation();">
       						<span class="material-symbols-outlined">${dto.savedByUser ? 'bookmark' : 'bookmark_border'}</span> <span>저장</span>
    					</button>
                        
                        <button class="compact-action-btn action-btn-hover btn-report p-0 border-0"
                            onclick="openReportModal('${dto.postId}', '${dto.userNum}'); event.stopPropagation();">
                            <span class="material-symbols-outlined">campaign</span> <span>신고</span>
                        </button>
                        
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</c:forEach>