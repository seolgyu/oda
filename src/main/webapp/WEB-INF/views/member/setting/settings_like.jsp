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

	<div class="d-flex flex-column gap-2" id="list-container">
		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="item" items="${list}">
					<div class="record-item d-flex align-items-stretch overflow-hidden">
						<div
							class="flex-grow-1 d-flex align-items-center gap-3 p-3 cursor-pointer item-content"
							onclick="location.href='${pageContext.request.contextPath}/post/article/${item.postId}';">

							<c:choose>
								<c:when test="${not empty item.thumbnail}">
									<div class="record-thumbnail rounded-3"
										style="background-image: url('${item.thumbnail}');"></div>
								</c:when>
								<c:otherwise>
									<div
										class="record-thumbnail rounded-3 d-flex align-items-center justify-content-center bg-white bg-opacity-5">
										<span class="material-symbols-outlined text-white opacity-20"
											style="font-size: 20px;">article</span>
									</div>
								</c:otherwise>
							</c:choose>

							<div class="flex-grow-1 min-w-0">
								<div class="d-flex align-items-center gap-2 mb-1 opacity-75">
									<span class="text-white text-xs fw-bold">${item.authorNickname}</span>
									<span class="text-secondary text-xs">· ${item.createdDate}</span>
								</div>
								<h4 class="text-white fs-6 fw-bold mb-1 text-truncate">${item.title}</h4>
								<p class="text-secondary text-xs mb-0 text-truncate opacity-50">${item.content}</p>
							</div>
						</div>

						<div
							class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
							<button type="button" class="btn-like-toggle"
								onclick="toggleLike(this, '${item.postId}')">
								<span class="material-symbols-outlined fill-icon text-danger">favorite</span>
							</button>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="text-center py-5">
					<span class="material-symbols-outlined text-secondary opacity-20"
						style="font-size: 64px;"> folder_open </span>
					<p class="text-secondary mt-3">저장된 게시글이 없습니다.</p>
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
function toggleLike(btn, postId) {
    const icon = $(btn).find('.material-symbols-outlined');
    
    // 이 부분은 추후 AJAX 서버 연동 로직이 들어갑니다.
    if (icon.css('font-variation-settings').includes("'FILL' 1")) {
        // 취소 처리
        icon.css('font-variation-settings', "'FILL' 0");
        icon.removeClass('text-danger').addClass('text-secondary');
        $(btn).closest('.record-item').css('opacity', '0.5'); // 시각적 피드백
    } else {
        // 복구 처리
        icon.css('font-variation-settings', "'FILL' 1");
        icon.addClass('text-danger').removeClass('text-secondary');
        $(btn).closest('.record-item').css('opacity', '1');
    }
}
</script>