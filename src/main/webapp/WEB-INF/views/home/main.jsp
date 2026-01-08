<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="head.jsp"%>
<style>
/* 1. 필터 바 (Glass 효과 + 고정) */
.filter-bar {
    background: rgba(255, 255, 255, 0.02);
    backdrop-filter: blur(5px);
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    
    /* [중요] 위치를 잡고 z-index를 높여서 카드보다 위에 뜨게 함 */
    position: relative; 
    z-index: 1000; 
}

/* 2. 공통 카드 스타일 (호버 효과) */
.feed-card {
    transition: transform 0.2s, background 0.2s;
    cursor: pointer;
    border: 1px solid rgba(255, 255, 255, 0.1);
    
    /* [중요] 카드는 기본 레벨(1)로 설정하여 필터바(1000)보다 아래에 있게 함 */
    position: relative;
    z-index: 1; 
}

.feed-card:hover {
    /* transform은 유지하되 z-index는 건드리지 않음 */
    transform: translateY(-2px);
    background: rgba(255, 255, 255, 0.08) !important;
}

/* 3. 카드형 (Card View) 썸네일 영역 */
.card-thumbnail-area {
	width: 100%;
	height: 300px; /* 높이 고정 */
	background-color: rgba(0, 0, 0, 0.2);
	border-radius: 0.5rem;
	overflow: hidden;
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
	justify-content: center;
}

.card-thumbnail-img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 꽉 차게 */
}

/* 4. 축약형 (Compact View) 스타일 */
.compact-card {
	display: flex;
	align-items: center;
	gap: 1.5rem;
	padding: 1rem 1.5rem;
}

.compact-thumbnail {
	width: 60px;
	height: 60px;
	border-radius: 0.5rem;
	object-fit: cover;
	flex-shrink: 0;
	background-color: rgba(255, 255, 255, 0.05);
}

/* 5. 드롭다운 메뉴 (유리 효과) */
.glass-dropdown {
    background: rgba(30, 30, 30, 0.95);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    box-shadow: 0 4px 20px rgba(0,0,0,0.5);
    
    /* [중요] 드롭다운이 확실하게 맨 위로 오도록 설정 */
    z-index: 2000 !important;
}

.dropdown-item {
	color: #e2e8f0;
	font-size: 0.9rem;
	padding: 0.5rem 1rem;
}

.dropdown-item:hover {
	background: rgba(168, 85, 247, 0.2);
	color: #fff;
}

.dropdown-item.active {
	background: #a855f7;
	color: #fff;
}

/* 텍스트 말줄임 처리 */
.text-ellipsis {
	display: -webkit-box;
	-webkit-line-clamp: 3; /* 3줄까지만 표시 */
	-webkit-box-orient: vertical;
	overflow: hidden;
}
</style>
</head>
<body>

	<%@ include file="header.jsp"%>

	<div class="app-body">

		<%@ include file="sidebar.jsp"%>

		<main class="app-main">

			<div id="sessionToast" class="glass-toast shadow-lg">
				<div class="d-flex align-items-center gap-3">
					<div class="toast-icon-circle">
						<span id="toastIcon" class="material-symbols-outlined fs-5">info</span>
					</div>
					<div class="toast-content">
						<h4 id="toastTitle"
							class="text-xs fw-bold text-uppercase tracking-widest mb-1"
							style="color: #a855f7;">System</h4>
						<p id="toastMessage" class="text-sm text-gray-300 mb-0">여기</p>
					</div>
				</div>
			</div>

			<div class="space-background">
				<div class="stars"></div>
				<div class="stars2"></div>
				<div class="stars3"></div>
				<div class="planet planet-1"></div>
				<div class="planet planet-2"></div>
			</div>
			<div class="feed-scroll-container custom-scrollbar">

				<div class="feed-wrapper d-flex flex-column gap-4">

					<div class="glass-panel p-3 shadow-lg">
						<div class="d-flex gap-3">
							<div class="avatar-lg text-white fw-bold flex-shrink-0"
								style="background: linear-gradient(to top right, #a855f7, #6366f1);">
								${not empty sessionScope.member ? fn:substring(sessionScope.member.userName, 0, 1) : "G"}
							</div>
							<div class="flex-grow-1">
								<input class="create-input text-base"
									placeholder="${not empty sessionScope.member ? 'Share your latest creation...' : 'Please login to post...'}"
									type="text" ${empty sessionScope.member ? 'disabled' : ''} />

								<div
									class="d-flex justify-content-between align-items-center mt-2 pt-2 border-top border-secondary border-opacity-25">
									<div class="d-flex gap-2">
										<button class="btn-icon text-gray-400 hover-purple">
											<span class="material-symbols-outlined fs-5">image</span>
										</button>
										<button class="btn-icon text-gray-400 hover-blue">
											<span class="material-symbols-outlined fs-5">movie</span>
										</button>
									</div>

									<c:if test="${not empty sessionScope.member}">
										<button class="action-btn-pill"
											onclick="location.href='${pageContext.request.contextPath}/post/write'">Post</button>
									</c:if>
								</div>
							</div>
						</div>
					</div>

					<div
						class="filter-bar d-flex justify-content-between align-items-center px-2">
						<div
							class="d-flex align-items-center gap-4 text-xs fw-medium text-gray-500 text-uppercase tracking-widest">
							<span>Latest Updates</span>
						</div>

						<div class="d-flex gap-2">
							<div class="dropdown">
								<button
									class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-2 rounded-pill"
									style="background: rgba(255, 255, 255, 0.05);" type="button"
									data-bs-toggle="dropdown" aria-expanded="false">
									<span id="currentSortLabel"> <c:choose>
											<c:when test="${sort == 'likes'}">좋아요 많은 순</c:when>
											<c:when test="${sort == 'views'}">조회수 순</c:when>
											<c:when test="${sort == 'trend'}">급상승</c:when>
											<c:otherwise>최신순</c:otherwise>
										</c:choose>
									</span> <span class="material-symbols-outlined fs-6 small ms-1">expand_more</span>
								</button>
								<ul
									class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end">
									<li><h6 class="dropdown-header text-white-50">정렬 기준</h6></li>
									<li><a
										class="dropdown-item ${sort == 'latest' || empty sort ? 'active' : ''}"
										href="javascript:changeSort('latest')">최신순</a></li>
									<li><a
										class="dropdown-item ${sort == 'likes' ? 'active' : ''}"
										href="javascript:changeSort('likes')">좋아요 많은 순</a></li>
									<li><a
										class="dropdown-item ${sort == 'views' ? 'active' : ''}"
										href="javascript:changeSort('views')">조회수 순</a></li>
									<li><a
										class="dropdown-item ${sort == 'trend' ? 'active' : ''}"
										href="javascript:changeSort('trend')">급상승</a></li>
								</ul>
							</div>

							<div class="dropdown">
								<button
									class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-2 rounded-pill"
									style="background: rgba(255, 255, 255, 0.05);" type="button"
									data-bs-toggle="dropdown" aria-expanded="false">
									<span class="material-symbols-outlined fs-6"> ${viewMode == 'compact' ? 'view_list' : 'view_day'}
									</span>
								</button>
								<ul
									class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end"
									style="min-width: 120px;">
									<li><h6 class="dropdown-header text-white-50">보기</h6></li>
									<li><a
										class="dropdown-item ${viewMode == 'card' || empty viewMode ? 'active' : ''}"
										href="javascript:changeView('card')"> <span
											class="material-symbols-outlined fs-6 align-middle me-2">view_day</span>카드형
									</a></li>
									<li><a
										class="dropdown-item ${viewMode == 'compact' ? 'active' : ''}"
										href="javascript:changeView('compact')"> <span
											class="material-symbols-outlined fs-6 align-middle me-2">view_list</span>축약형
									</a></li>
								</ul>
							</div>
						</div>
					</div>

					<c:if test="${empty list}">
						<div class="text-center py-5 glass-card shadow-lg">
							<span
								class="material-symbols-outlined fs-1 text-white-50 opacity-25">inbox</span>
							<p class="text-white-50 mt-3">등록된 게시글이 없습니다.</p>
						</div>
					</c:if>

					<c:forEach var="dto" items="${list}">

						<c:if test="${viewMode == 'card' || empty viewMode}">
							<div class="glass-card shadow-lg feed-card group"
								onclick="goArticle('${dto.postId}')">

								<div
									class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
									<div class="d-flex align-items-center gap-3">
										<div
											class="avatar-md text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden"
											style="background: linear-gradient(45deg, #a855f7, #6366f1); border-radius: 50%;">
											<c:choose>
												<c:when test="${not empty dto.authorProfileImage}">
													<img
														src="${pageContext.request.contextPath}/uploads/profile/${dto.authorProfileImage}"
														style="width: 100%; height: 100%; object-fit: cover;">
												</c:when>
												<c:otherwise>
                                    ${fn:substring(dto.authorNickname, 0, 1)}
                                </c:otherwise>
											</c:choose>
										</div>
										<div>
											<h3 class="text-sm fw-medium text-white mb-0">${dto.authorNickname}</h3>
											<p class="text-xs text-gray-500 mb-0">${dto.createdDate}</p>
										</div>
									</div>
								</div>

								<div class="p-3">
									<p class="text-light text-sm mb-3 lh-base text-ellipsis"
										style="color: #d1d5db;">${dto.content}</p>

									<c:if test="${not empty dto.thumbnail}">
										<div
											class="card-thumbnail-area border border-white border-opacity-10">
											<img
												src="${pageContext.request.contextPath}/uploads/photo/${dto.thumbnail}"
												class="card-thumbnail-img" alt="Post Image">
										</div>
									</c:if>
								</div>

								<div
									class="px-3 py-2 d-flex align-items-center justify-content-between"
									style="background: rgba(255, 255, 255, 0.05);">
									<div class="d-flex gap-4">
										<button
											class="d-flex align-items-center gap-2 btn-icon text-xs ps-0 hover-pink">
											<span class="material-symbols-outlined fs-6">favorite</span>
											${dto.likeCount}
										</button>
										<button
											class="d-flex align-items-center gap-2 btn-icon text-xs hover-blue">
											<span class="material-symbols-outlined fs-6">chat_bubble</span>
											${dto.viewCount}
										</button>
									</div>
									<button
										class="d-flex align-items-center gap-1 btn-icon text-xs pe-0 hover-purple">
										<span class="material-symbols-outlined fs-6">share</span>
										Share
									</button>
								</div>
							</div>
						</c:if>

						<c:if test="${viewMode == 'compact'}">
							<div
								class="glass-card shadow-sm feed-card rounded-3 compact-card"
								onclick="goArticle('${dto.postId}')">

								<c:choose>
									<c:when test="${not empty dto.thumbnail}">
										<img
											src="${pageContext.request.contextPath}/uploads/photo/${dto.thumbnail}"
											class="compact-thumbnail" alt="Thumb">
									</c:when>
									<c:otherwise>
										<div
											class="compact-thumbnail d-flex align-items-center justify-content-center text-white-50">
											<span class="material-symbols-outlined">article</span>
										</div>
									</c:otherwise>
								</c:choose>

								<div class="flex-grow-1" style="min-width: 0;">
									<h5 class="text-white fw-bold fs-6 mb-1 text-truncate">${dto.title}</h5>
									<div
										class="d-flex align-items-center gap-2 text-xs text-gray-400">
										<span class="text-white fw-medium">${dto.authorNickname}</span>
										<span>&bull;</span> <span>${dto.createdDate}</span>
									</div>
								</div>

								<div
									class="d-flex flex-column align-items-end gap-1 text-xs text-white-50">
									<span class="d-flex align-items-center gap-1"> <span
										class="material-symbols-outlined" style="font-size: 1rem;">favorite</span>
										${dto.likeCount}
									</span> <span class="d-flex align-items-center gap-1"> <span
										class="material-symbols-outlined" style="font-size: 1rem;">visibility</span>
										${dto.viewCount}
									</span>
								</div>
							</div>
						</c:if>

					</c:forEach>

					<div class="text-center py-4">
						<span class="text-secondary small">You've reached the end
							of the feed</span>
					</div>
				</div>




			</div>
			<div class="position-absolute bottom-0 end-0 m-4 z-3">
				<button
					class="d-flex align-items-center gap-2 rounded-pill px-3 py-2 shadow-lg border border-white border-opacity-10"
					style="background: rgba(39, 39, 42, 0.8); backdrop-filter: blur(12px);">
					<div class="d-flex flex-column align-items-start lh-1 me-2">
						<span class="text-uppercase text-muted fw-semibold"
							style="font-size: 10px; letter-spacing: 0.05em;">Tasks</span> <span
							class="text-sm fw-medium text-white-50">0 active</span>
					</div>
					<div
						style="width: 1px; height: 24px; background: rgba(255, 255, 255, 0.1);"></div>
					<div
						class="rounded-circle d-flex align-items-center justify-content-center text-muted ms-1"
						style="width: 24px; height: 24px;">
						<span class="material-symbols-outlined fs-5">chevron_right</span>
					</div>
				</button>
			</div>
			<div
				class="position-absolute bottom-0 start-0 m-4 z-3 d-none d-md-flex align-items-center gap-2 px-3 py-1 rounded-3 border border-white border-opacity-10 text-muted font-monospace text-xs"
				style="background: rgba(39, 39, 42, 0.8); backdrop-filter: blur(12px);">
				<span class="material-symbols-outlined" style="font-size: 14px;">grid_4x4</span>
				<span>492</span>
			</div>
		</main>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>

	<c:if test="${not empty sessionScope.toastMsg}">
		<script>
			$(document).ready(
					function() {
						showToast("${sessionScope.toastMsg}",
								"${sessionScope.toastType}");
					});
		</script>
		<c:remove var="toastMsg" scope="session" />
		<c:remove var="toastType" scope="session" />
	</c:if>

	<script>
		function showToast(msg, type) {
			const $toast = $('#sessionToast');
			const $title = $('#toastTitle');
			const $icon = $('#toastIcon');

			$('#toastMessage').text(msg);

			if (type === "success") {
				$title.text('SUCCESS').css('color', '#4ade80');
				$icon.text('check_circle');
			} else if (type === "info") {
				$title.text('INFO').css('color', '#8B5CF6');
				$icon.text('info');
			} else if (type === "error") {
				$title.text('ERROR').css('color', '#f87171');
				$icon.text('error');
			}

			$toast.addClass('show');

			setTimeout(function() {
				$toast.removeClass('show');
			}, 2500);
		}
	</script>

	<script>
		// 1. 정렬 변경 함수
		function changeSort(sortType) {
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('sort', sortType);
			// view 모드는 유지하면서 sort만 변경
			window.location.search = urlParams.toString();
		}

		// 2. 보기 모드 변경 함수
		function changeView(viewMode) {
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('view', viewMode);
			// sort는 유지하면서 view만 변경
			window.location.search = urlParams.toString();
		}

		// 3. 게시글 상세 이동 함수
		function goArticle(postId) {
			location.href = '${pageContext.request.contextPath}/post/article?postId='
					+ postId;
		}
	</script>


</body>
</html>