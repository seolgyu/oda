<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto"
	style="width: 820px; min-width: 820px; max-width: 100%;">
	<div
		class="mb-4 border-bottom border-white border-opacity-10 pb-3 d-flex justify-content-between align-items-end">
		<div>
			<h2 class="text-white fs-4 fw-bold mb-1">Liked Posts</h2>
			<p class="text-secondary text-sm mb-0">Review and manage your
				cosmic bookmarks.</p>
		</div>
		<span class="text-secondary text-xs pb-1">Total <span
			class="text-white fw-bold">${totalCount}</span></span>
	</div>

	<div class="d-flex flex-column gap-2 list-container">
		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="item" items="${list}">
					<div class="record-item d-flex align-items-stretch overflow-hidden">
						<div
							class="flex-grow-1 flex-shrink-1 d-flex align-items-center gap-3 p-3 cursor-pointer item-content"
							style="min-width: 0;"
							onclick="location.href='${pageContext.request.contextPath}/post/article?postId=${item.postId}';">

							<c:choose>
								<c:when test="${not empty item.thumbnail}">
									<div class="record-thumbnail rounded-3 flex-shrink-0"
										style="background-image: url('${item.thumbnail}');"></div>
								</c:when>
								<c:otherwise>
									<div
										class="record-thumbnail rounded-3 flex-shrink-0 d-flex align-items-center justify-content-center"
										style="background-color: rgba(255, 255, 255, 0.1); border: 1px dashed rgba(255, 255, 255, 0.2);">
										<span class="material-symbols-outlined text-white opacity-20"
											style="font-size: 24px;">image</span>
									</div>
								</c:otherwise>
							</c:choose>

							<div class="flex-grow-1 min-w-0" style="min-width: 0;">
								<div class="d-flex align-items-center gap-2 mb-1 opacity-75">
									<span class="text-white text-xs fw-bold text-truncate">${item.authorNickname}</span>
									<span class="text-secondary text-xs flex-shrink-0">·
										${item.createdDate}</span>
								</div>
								<h4 class="text-white fs-6 fw-bold mb-1 text-truncate">${item.title}</h4>
								<p class="text-secondary text-xs mb-0 text-truncate opacity-50">${item.content}</p>
							</div>
						</div>

						<div
							class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10 flex-shrink-0"
							style="width: 70px;">
							<button type="button" class="btn-like-toggle"
								onclick="toggleLike(this, '${item.postId}')">
								<span class="material-symbols-outlined text-danger"
									style="font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;">
									favorite </span>
							</button>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="text-center py-5">
					<span class="material-symbols-outlined text-secondary opacity-20"
						style="font-size: 64px;"> folder_open </span>
					<p class="text-secondary mt-3">좋아요 한 게시글이 없습니다.</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<div id="sentinel" style="height: 20px;"></div>
</div>

<style>
/* 리스트 아이템 레이아웃 */
.record-item {
	background: rgba(255, 255, 255, 0.02);
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 12px;
	transition: all 0.2s ease;
}

.record-item:hover {
	background: rgba(255, 255, 255, 0.05);
	border-color: rgba(255, 255, 255, 0.1);
}

/* 본문 영역 마우스 커서 */
.cursor-pointer {
	cursor: pointer;
}

/* 썸네일 크기 축소 (기록 확인용) */
.record-thumbnail {
	width: 50px;
	height: 50px;
	min-width: 50px;
	background-size: cover;
	background-position: center;
	border: 1px solid rgba(255, 255, 255, 0.1);
}

/* 우측 액션 섹션 고정 너비 */
.action-section {
	width: 80px;
	min-width: 80px;
	background: rgba(255, 255, 255, 0.01);
}

/* 좋아요 버튼 */
.btn-like-toggle {
	background: none;
	border: none;
	padding: 10px;
	border-radius: 50%;
	transition: all 0.2s;
	display: flex;
	align-items: center;
	justify-content: center;
}

.btn-like-toggle:hover {
	background: rgba(220, 38, 38, 0.15);
	transform: scale(1.1);
}

/* 아이콘 꽉 찬 상태 */
.fill-icon {
	font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;
}

/* 텍스트 생략 */
.text-truncate {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>

<script>

$(function() {
    if (window.io) window.io.disconnect();
    window.page = 1;
    window.isLoading = false;

    const target = document.getElementById('sentinel');

    if (target) {
        window.io = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting && !window.isLoading) {
                    loadNextPage('/member/settings/loadLikedPost', renderLikedPost);
                }
            });
        }, { threshold: 0.1});

        window.io.observe(target);
    }
});

function toggleLike(btn, postId) {
	
	if ($(btn).data('loading')) return;
    $(btn).data('loading', true);
    
	const $icon = $(btn).find('.material-symbols-outlined');
    const $item = $(btn).closest('.record-item');
    const isLiked = $icon.hasClass('text-danger');
    
    $.ajax({
		type: "POST",
		url: '${pageContext.request.contextPath}/member/settings/toggleLike',
		data: {postId: postId},
		dataType: "json",
		success: function(data) {
			if (data.status === 'success') {
				if(isLiked) {
			        $icon.css('font-variation-settings', "'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24");
			        $icon.removeClass('text-danger').addClass('text-secondary');
			        $item.css('opacity', '0.5');
			        showToast("success", "해당 게시글에 좋아요를 취소했습니다");
			    } else {
			        $icon.css('font-variation-settings', "'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24");
			        $icon.removeClass('text-secondary').addClass('text-danger');
			        $item.css('opacity', '1');
			        showToast("success", "해당 게시글에 좋아요를 눌렀습니다.");
			    }
			} else {
				showToast("error", "좋아요 처리에 실패했습니다.");
			}
		},
		error: function() {
			showToast("error", "서버 통신 에러.");
		},
		complete: function() {
			$(btn).data('loading', false);
		}
	});
}
</script>