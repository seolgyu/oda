<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
	<div class="mb-4 border-bottom border-white border-opacity-10 pb-3 d-flex justify-content-between align-items-end">
		<div>
			<h2 class="text-white fs-4 fw-bold mb-1">My Comments</h2>
			<p class="text-secondary text-sm mb-0">Review your cosmic conversations and thoughts.</p>
		</div>
		<span class="text-secondary text-xs pb-1">Total <span class="text-white fw-bold">${dataCount}</span> Comments</span>
	</div>

	<div class="d-flex flex-column gap-4 list-container">
		<c:forEach var="dto" items="${list}">
			<div class="record-item p-3 overflow-hidden mb-4"
				style="background: rgba(255, 255, 255, 0.02); border: 1px solid rgba(255, 255, 255, 0.05); border-radius: 12px;">
				
				<div class="d-flex align-items-center gap-3 mb-3 cursor-pointer pb-3 border-bottom border-white border-opacity-10"
					onclick="location.href='${pageContext.request.contextPath}/post/article?postId=${dto.postId}';">
					<div class="record-thumbnail rounded-3"
						style="width: 45px; height: 45px; background-image: url('${dto.parentThumbnail}'); background-size: cover; background-position: center; flex-shrink: 0;"></div>
					<div class="flex-grow-1 min-w-0">
						<div class="d-flex align-items-center gap-2 mb-1 opacity-50">
							<span class="text-white text-xs fw-bold">${dto.item.authorNickname}</span> 
							<span class="text-secondary text-xs">· Original Post</span>
						</div>
						<h4 class="text-white fs-6 fw-bold mb-0 text-truncate">${dto.item.title}</h4>
					</div>
					<span class="material-symbols-outlined text-secondary opacity-30">chevron_right</span>
				</div>

				<div class="d-flex flex-column gap-3 ps-1">
					<div class="comment-group-item d-flex gap-2">
						<span class="text-secondary opacity-25 mt-1" style="font-family: sans-serif; font-size: 1.2rem;">ㄴ</span>
						<div class="comment-content-box p-3 rounded-3 flex-grow-1" style="background: rgba(255, 255, 255, 0.04); border: 1px solid rgba(255, 255, 255, 0.08);">
							
							<c:if test="${dto.depth > 1}">
								<div class="parent-quote p-3 mb-3 rounded-2"
									style="background: rgba(255, 255, 255, 0.06); border-left: 4px solid rgba(255, 255, 255, 0.2);">
									<div class="d-flex align-items-center gap-2 mb-2">
										<span class="badge rounded-pill text-white"
											style="background-color: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.1); font-size: 0.65rem; padding: 0.3em 0.7em; letter-spacing: 0.5px;">REPLY TO</span> 
										<span class="text-white fw-bold" style="font-size: 0.8rem;">@${dto.parentUserNum}</span>
									</div>
									<div class="text-white-50 text-sm ps-1"
										style="line-height: 1.5; border-left: 1px solid rgba(255, 255, 255, 0.1); padding-left: 10px;">
										<span class="opacity-75">"${dto.parentCommentContent}"</span>
									</div>
								</div>
							</c:if>

							<div class="d-flex justify-content-between align-items-start mb-2">
								<span class="${dto.depth > 1 ? 'text-info' : 'text-primary'} text-xs fw-bold" style="letter-spacing: 0.5px;">
									${dto.depth > 1 ? 'MY REPLY' : 'MY COMMENT'}
								</span> 
								<span class="text-secondary text-xs opacity-75">${dto.createdDate}</span>
							</div>
							<p class="text-white text-sm mb-0 fw-normal" style="line-height: 1.6; opacity: 0.9;">${dto.content}</p>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<div id="sentinel" style="height: 20px;"></div>
</div>

<style>
/* 기존 record-item 스타일 계승 및 보정 */
.record-item {
	background: rgba(255, 255, 255, 0.02);
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 16px;
	transition: all 0.2s ease;
}

.record-item:hover {
	background: rgba(255, 255, 255, 0.04);
	border-color: rgba(99, 102, 241, 0.2);
}

.cursor-pointer {
	cursor: pointer;
}

.record-thumbnail {
	width: 45px;
	height: 45px;
	min-width: 45px;
	background-size: cover;
	background-position: center;
	border: 1px solid rgba(255, 255, 255, 0.1);
}

.text-primary {
	color: #818cf8 !important;
}

.text-truncate {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

/* 댓글 박스 호버 효과 */
.record-item:hover .comment-content-box {
	border-color: rgba(99, 102, 241, 0.3) !important;
	background: rgba(255, 255, 255, 0.05) !important;
}
</style>

<script>
$(function() {
    if (window.io) {
        window.io.disconnect();
    }

    window.page = 1; 
    window.isLoading = false;
    
    window.io = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting && !window.isLoading) {
                loadNextPage('/member/settings/loadMyReply', renderCommentList);
            }
        });
    }, { threshold: 0.1 });

    const sentinel = document.querySelector('#sentinel');
    if (sentinel) {
        window.io.observe(sentinel);
    }
    
    window.page = 1;
});
</script>

