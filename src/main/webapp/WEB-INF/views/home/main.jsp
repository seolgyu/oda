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
/* 1. 필터 바 투명화 (Box 2) */
.filter-bar {
	background: transparent !important; /* 배경 투명 */
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	margin-bottom: 0.5rem;
	padding-bottom: 0.5rem;
	position: relative;
	z-index: 1000;
}

/* 2. 카드형 뷰 - 이미지 슬라이더 스타일 */
.carousel-inner {
	background-color: #000; /* 빈 공간 검은색 처리 */
	border-radius: 0.5rem;
}

.image-container {
	height: 500px; /* 고정 높이 */
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
}

.slider-img {
	max-width: 100%;
	max-height: 100%;
	width: auto;
	height: auto;
	object-fit: contain; /* 이미지가 잘리지 않고 비율 유지 */
}

/* 슬라이더 버튼 스타일 (article.jsp와 통일) */
.carousel-btn-glass {
	width: 40px;
	height: 40px;
	background: rgba(255, 255, 255, 0.1);
	backdrop-filter: blur(4px);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
}

.carousel-control-prev, .carousel-control-next {
	opacity: 1;
	width: 10%;
}

/* 3. 축약형 뷰 (Reddit 스타일) */
.compact-card {
	display: flex;
	align-items: flex-start; /* 위쪽 정렬 */
	gap: 1rem;
	padding: 0.75rem; /* 패딩 축소 */
	border: 1px solid rgba(255, 255, 255, 0.05);
	background: rgba(20, 20, 20, 0.6); /* 더 어둡게 */
	border-radius: 0.3rem; /* 둥글기 축소 */
}

.compact-card:hover {
	background: rgba(255, 255, 255, 0.05);
	border-color: rgba(255, 255, 255, 0.2);
}

/* Reddit형 썸네일 */
.compact-thumbnail-area {
	width: 120px; /* 너비 고정 */
	height: 90px; /* 높이 고정 */
	background: #000;
	border-radius: 4px;
	flex-shrink: 0;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

.compact-thumb-img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 썸네일은 꽉 차게 (확대 기능 있으므로) */
}

.action-btn-group {
	display: flex;
	gap: 0.8rem; /* 버튼 사이 간격 */
	margin-top: 1.2rem; /* [요청 2] 위쪽 간격을 더 벌림 */
}

/* [수정] 액션 버튼 기본 스타일 */
.action-btn {
	display: flex;
	align-items: center;
	gap: 4px;
	padding: 6px 10px;
	border-radius: 4px;
	color: #9ca3af; /* 기본 회색 */
	font-size: 0.85rem;
	font-weight: 500;
	background: transparent;
	border: 1px solid transparent; /* 호버 시 테두리 방지용 투명 테두리 */
	transition: all 0.2s;
}

/* [요청 2] 버튼별 호버 색상 (Article 페이지와 통일) */
/* 댓글 - 파랑 */
.action-btn.btn-comment:hover {
	color: #60a5fa;
	background: rgba(96, 165, 250, 0.1);
}
/* 공유 - 보라 */
.action-btn.btn-share:hover {
	color: #c084fc;
	background: rgba(192, 132, 252, 0.1);
}
/* 저장 - 노랑 */
.action-btn.btn-save:hover {
	color: #facc15;
	background: rgba(250, 204, 21, 0.1);
}
/* 신고 - 빨강 */
.action-btn.btn-report:hover {
	color: #f87171;
	background: rgba(248, 113, 113, 0.1);
}
/* [추가] 좋아요 버튼 호버 효과 (카드형에 추가됨) */
.action-btn.btn-like:hover {
	color: #ec4899; /* 핑크색 */
	background: rgba(236, 72, 153, 0.1);
}

/* [추가] 카드형 뷰 하단에서는 버튼 그룹의 위쪽 여백을 없앰 */
.feed-card .action-btn-group {
	margin-top: 0 !important;
	width: 100%;
	/* 버튼들 사이 간격을 균등하게 배분하려면 아래 주석 해제 */
	/* justify-content: space-between; */
}
/* 공통 */
.glass-dropdown {
	background: rgba(30, 30, 30, 0.95);
	backdrop-filter: blur(12px);
	border: 1px solid rgba(255, 255, 255, 0.1);
	z-index: 2000 !important;
}

/* 간격 축소 */
.feed-wrapper {
	gap: 0.5rem !important;
} /* 게시물 사이 간격 줄임 */

/* [요청 4] 모달 닫기 버튼 스타일 */
.modal-close-btn {
	position: absolute;
	top: -40px; /* 이미지 위쪽 바깥으로 배치 */
	right: 0;
	background: rgba(0, 0, 0, 0.5);
	border: 1px solid rgba(255, 255, 255, 0.3);
	color: white;
	border-radius: 50%;
	width: 36px;
	height: 36px;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: all 0.2s;
	z-index: 1056; /* 모달 바디보다 위에 */
}

.modal-close-btn:hover {
	background: rgba(255, 255, 255, 0.2);
	transform: scale(1.1);
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

				<div class="feed-wrapper d-flex flex-column">

					<div
						class="filter-bar d-flex justify-content-between align-items-center px-2">
						<div
							class="d-flex align-items-center gap-4 text-xs fw-medium text-gray-500 text-uppercase tracking-widest">
							<span class="text-white-50">Latest Updates</span>
						</div>

						<div class="d-flex gap-2">
							<div class="dropdown">
								<button
									class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
									style="background: rgba(0, 0, 0, 0.3);" type="button"
									data-bs-toggle="dropdown" aria-expanded="false">
									<span id="currentSortLabel"> <c:choose>
											<c:when test="${sort == 'likes'}">좋아요 순</c:when>
											<c:when test="${sort == 'views'}">조회수 순</c:when>
											<c:otherwise>최신순</c:otherwise>
										</c:choose>
									</span> <span class="material-symbols-outlined fs-6 small ms-1">expand_more</span>
								</button>
								<ul
									class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end">
									<li><a class="dropdown-item"
										href="javascript:changeSort('latest')">최신순</a></li>
									<li><a class="dropdown-item"
										href="javascript:changeSort('likes')">좋아요 순</a></li>
									<li><a class="dropdown-item"
										href="javascript:changeSort('views')">조회수 순</a></li>
								</ul>
							</div>

							<div class="dropdown">
								<button
									class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
									style="background: rgba(0, 0, 0, 0.3);" type="button"
									data-bs-toggle="dropdown" aria-expanded="false">
									<span class="material-symbols-outlined fs-6"> ${viewMode == 'compact' ? 'view_list' : 'view_day'}
									</span>
								</button>
								<ul
									class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end">
									<li><a class="dropdown-item"
										href="javascript:changeView('card')">카드형</a></li>
									<li><a class="dropdown-item"
										href="javascript:changeView('compact')">축약형</a></li>
								</ul>
							</div>
						</div>
					</div>

					<c:if test="${empty list}">
						<div class="text-center py-5 glass-card shadow-lg">
							<p class="text-white-50">등록된 게시글이 없습니다.</p>
						</div>
					</c:if>

					<c:forEach var="dto" items="${list}">

						<c:if test="${viewMode == 'card' || empty viewMode}">
							<div class="glass-card shadow-lg feed-card mb-3"
								onclick="goArticle('${dto.postId}')"
								style="background: rgba(30, 30, 30, 0.4);">

								<div
									class="p-3 d-flex align-items-center justify-content-between">
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
												<c:otherwise>${fn:substring(dto.authorNickname, 0, 1)}</c:otherwise>
											</c:choose>
										</div>
										<div>
											<h3 class="text-sm fw-medium text-white mb-0">${dto.authorNickname}</h3>
											<p class="text-xs text-gray-500 mb-0">${dto.createdDate}</p>
										</div>
									</div>
								</div>

								<div class="px-3 pb-2">
									<h5 class="text-white fw-bold fs-5">${dto.title}</h5>
									<p class="text-gray-300 text-sm mb-3 text-ellipsis">${dto.content}</p>
								</div>

								<c:if test="${not empty dto.fileList}">
									<div id="carousel-${dto.postId}"
										class="carousel slide px-3 pb-3" data-bs-interval="false"
										onclick="event.stopPropagation();">
										<div class="carousel-inner">
											<c:forEach var="fileDto" items="${dto.fileList}"
												varStatus="status">
												<div class="carousel-item ${status.first ? 'active' : ''}">
													<div class="image-container">
														<img
															src="${pageContext.request.contextPath}/uploads/photo/${fileDto.filePath}"
															class="slider-img" alt="Post Image">
													</div>
												</div>
											</c:forEach>
										</div>
										<c:if test="${fn:length(dto.fileList) > 1}">
											<button class="carousel-control-prev" type="button"
												data-bs-target="#carousel-${dto.postId}"
												data-bs-slide="prev">
												<span class="carousel-btn-glass"><span
													class="material-symbols-outlined">chevron_left</span></span>
											</button>
											<button class="carousel-control-next" type="button"
												data-bs-target="#carousel-${dto.postId}"
												data-bs-slide="next">
												<span class="carousel-btn-glass"><span
													class="material-symbols-outlined">chevron_right</span></span>
											</button>
										</c:if>
									</div>
								</c:if>

								<div class="px-3 py-3 border-top border-white border-opacity-10">
									<div class="action-btn-group"
										onclick="event.stopPropagation();">

										<button class="action-btn btn-like">
											<span class="material-symbols-outlined fs-6">favorite</span>
											<span>${dto.likeCount}</span>
										</button>

										<button class="action-btn btn-comment">
											<span class="material-symbols-outlined fs-6">chat_bubble</span>
											<span>${dto.commentCount}</span>
										</button>

										<button class="action-btn btn-share">
											<span class="material-symbols-outlined fs-6">share</span> <span>공유</span>
										</button>

										<button class="action-btn btn-save">
											<span class="material-symbols-outlined fs-6">bookmark</span>
											<span>저장</span>
										</button>

										<button class="action-btn btn-report ms-auto">
											<span class="material-symbols-outlined fs-6">flag</span> <span>신고</span>
										</button>
									</div>
								</div>
							</div>

						</c:if>

						<c:if test="${viewMode == 'compact'}">
							<div class="compact-card mb-2"
								onclick="goArticle('${dto.postId}')">

								<div class="compact-thumbnail-area"
									onclick="event.stopPropagation(); showImageModal('${dto.fileList[0].filePath}');">
									<c:choose>
										<c:when test="${not empty dto.fileList}">
											<img
												src="${pageContext.request.contextPath}/uploads/photo/${dto.fileList[0].filePath}"
												class="compact-thumb-img" alt="Thumb">
											<div class="position-absolute p-1">
												<span class="material-symbols-outlined text-white fs-6"
													style="text-shadow: 0 0 4px black;">open_in_full</span>
											</div>
										</c:when>
										<c:otherwise>
											<span class="material-symbols-outlined text-white-50">article</span>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="flex-grow-1" style="min-width: 0;">
									<div class="d-flex align-items-center gap-2 mb-1">
										<span class="text-xs text-white fw-bold">${dto.authorNickname}</span>
										<span class="text-xs text-gray-500">&bull;
											${dto.createdDate}</span>
									</div>

									<h5 class="text-white fw-bold fs-6 mb-1 text-truncate">${dto.title}</h5>

									<div class="action-btn-group"
										onclick="event.stopPropagation();">
										<button class="action-btn btn-comment">
											<span class="material-symbols-outlined fs-6">chat_bubble</span>
											<span>${dto.commentCount} 댓글</span>
										</button>
										<button class="action-btn btn-share">
											<span class="material-symbols-outlined fs-6">share</span> <span>공유</span>
										</button>
										<button class="action-btn btn-save">
											<span class="material-symbols-outlined fs-6">bookmark</span>
											<span>저장</span>
										</button>
										<button class="action-btn btn-report">
											<span class="material-symbols-outlined fs-6">flag</span> <span>신고</span>
										</button>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
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
	<div class="modal fade" id="imageModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content bg-transparent border-0 position-relative">

				<button type="button" class="modal-close-btn"
					onclick="closeImageModal()">
					<span class="material-symbols-outlined">close</span>
				</button>

				<div class="modal-body p-0 text-center">
					<img id="modalImage" src="" class="img-fluid rounded shadow-lg"
						style="max-height: 85vh;">
				</div>
			</div>
		</div>
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

	<script>
		// 모달 인스턴스를 저장할 전역 변수
		let myModalInstance = null;

		// 1. 이미지 확대 모달 열기
		function showImageModal(imagePath) {
			if (!imagePath)
				return;

			const fullPath = '${pageContext.request.contextPath}/uploads/photo/'
					+ imagePath;
			const modalElement = document.getElementById('imageModal');

			// 이미지 경로 설정
			document.getElementById('modalImage').src = fullPath;

			// 모달 인스턴스가 없으면 생성, 있으면 재사용
			if (!myModalInstance) {
				myModalInstance = new bootstrap.Modal(modalElement);
			}

			myModalInstance.show();
		}

		// 2. 이미지 확대 모달 닫기 (X 버튼용)
		function closeImageModal() {
			if (myModalInstance) {
				myModalInstance.hide();
			}
		}
	</script>

	<script>
		// [요청] 캐러셀(슬라이더) 버튼 제어 로직: 첫 장에선 < 숨김, 마지막 장에선 > 숨김
		document.addEventListener('DOMContentLoaded', function() {

			// 화면에 있는 모든 슬라이더를 찾음
			const carousels = document.querySelectorAll('.carousel');

			carousels.forEach(function(carousel) {
				// 1. 초기 상태 설정
				const prevBtn = carousel
						.querySelector('.carousel-control-prev');
				const nextBtn = carousel
						.querySelector('.carousel-control-next');
				const items = carousel.querySelectorAll('.carousel-item');

				// 이미지가 없거나 버튼이 없는 경우 패스
				if (!items.length)
					return;

				// (1) 처음 로딩 시 첫 번째 장이므로 Prev 버튼 숨기기
				if (prevBtn)
					prevBtn.style.display = 'none';

				// (2) 이미지가 1개뿐이면 Next 버튼도 숨기기
				if (items.length <= 1 && nextBtn) {
					nextBtn.style.display = 'none';
				}

				// 2. 슬라이드 넘길 때마다 실행되는 이벤트
				carousel.addEventListener('slid.bs.carousel', function(e) {
					const currentIndex = e.to; // 현재 보고 있는 순서 (0부터 시작)
					const lastIndex = items.length - 1; // 마지막 순서

					// A. 첫 번째 장일 때 -> Prev 숨김, Next 보임
					if (currentIndex === 0) {
						if (prevBtn)
							prevBtn.style.display = 'none';
						if (nextBtn)
							nextBtn.style.display = 'flex';
					}
					// B. 마지막 장일 때 -> Prev 보임, Next 숨김
					else if (currentIndex === lastIndex) {
						if (prevBtn)
							prevBtn.style.display = 'flex';
						if (nextBtn)
							nextBtn.style.display = 'none';
					}
					// C. 중간일 때 -> 둘 다 보임
					else {
						if (prevBtn)
							prevBtn.style.display = 'flex';
						if (nextBtn)
							nextBtn.style.display = 'flex';
					}
				});
			});
		});
	</script>
</body>
</html>