<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto"
	style="width: 820px; min-width: 820px; max-width: 100%;">
	<div
		class="mb-4 border-bottom border-white border-opacity-10 pb-3 d-flex justify-content-between align-items-end">
		<div>
			<h2 class="text-white fs-4 fw-bold mb-1">Saved Posts</h2>
			<p class="text-secondary text-sm mb-0">Review and manage your cosmic bookmarks.</p>
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
											style="font-size: 24px;">bookmark</span> </div>
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
							<button type="button" class="btn-save-toggle"
								onclick="toggleSave(this, '${item.postId}')">
								<span class="material-symbols-outlined text-primary"
									style="font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;">
									bookmark </span> </button>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="text-center py-5">
					<span class="material-symbols-outlined text-secondary opacity-20"
						style="font-size: 64px;"> bookmark_add </span> <p class="text-secondary mt-3">저장된 게시글이 없습니다.</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<div id="sentinel" style="height: 20px;"></div>
</div>

<style>
/* 기존 스타일 그대로 유지하되 포인트 컬러만 저장 컨셉(Blue/Violet)으로 조정 */
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
.cursor-pointer { cursor: pointer; }
.record-thumbnail {
	width: 50px; height: 50px; min-width: 50px;
	background-size: cover; background-position: center;
	border: 1px solid rgba(255, 255, 255, 0.1);
}
.action-section {
	width: 80px; min-width: 80px;
	background: rgba(255, 255, 255, 0.01);
}
.btn-save-toggle {
	background: none; border: none; padding: 10px;
	border-radius: 50%; transition: all 0.2s;
	display: flex; align-items: center; justify-content: center;
}
.btn-save-toggle:hover {
	background: rgba(99, 102, 241, 0.15); /* 블루 계열 호버 */
	transform: scale(1.1);
}
.text-primary { color: #818cf8 !important; } /* 북마크 강조용 라이트 블루 */
.text-truncate { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
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
                    // 북마크 로딩 경로로 수정
                    loadNextPage('/member/settings/loadSavedPost', renderSavedPost);
                }
            });
        }, { threshold: 0.1});
        window.io.observe(target);
    }
});

function toggleSave(btn, postId) {
	if ($(btn).data('loading')) return;
    $(btn).data('loading', true);
    
	const $icon = $(btn).find('.material-symbols-outlined');
    const $item = $(btn).closest('.record-item');
    const isSaved = $icon.hasClass('text-primary');
    
    $.ajax({
		type: "POST",
		url: '${pageContext.request.contextPath}/member/settings/toggleSave',
		data: {postId: postId},
		dataType: "json",
		success: function(data) {
			if (data.status === 'success') {
				if(isSaved) {
			        $icon.css('font-variation-settings', "'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24");
			        $icon.removeClass('text-primary').addClass('text-secondary');
			        $item.css('opacity', '0.5');
			        showToast("success", "북마크를 취소했습니다.");
			    } else {
					// 다시 저장
			        $icon.css('font-variation-settings', "'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24");
			        $icon.removeClass('text-secondary').addClass('text-primary');
			        $item.css('opacity', '1');
			        showToast("success", "북마크에 저장되었습니다.");
			    }
			} else {
				showToast("error", "저장에 실패했습니다.");
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