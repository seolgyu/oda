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
	background-color: rgba(0, 0, 0, 0.2);
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

.hover-pink:hover {
	color: #ec4899 !important;
}

.hover-blue:hover {
	color: #60a5fa !important;
}

.hover-green:hover {
	color: #4ade80 !important;
}

.hover-yellow:hover {
	color: #facc15 !important;
}

.hover-purple:hover {
	color: #c084fc !important;
	/* [article.jsp] style 태그 안에 추가 */
	/* 커스텀 캐러셀 버튼 스타일 */ . carousel-control-prev , .carousel-control-next {
	width : 10%; /* 클릭 영역 너비 */
	opacity: 1; /* 투명도 오버라이드 */
}

/* 버튼 내부의 유리 구슬 디자인 */
.carousel-btn-glass {
	width: 40px;
	height: 40px;
	background: rgba(255, 255, 255, 0.1); /* 반투명 배경 */
	backdrop-filter: blur(4px); /* 블러 효과 */
	border: 1px solid rgba(255, 255, 255, 0.2); /* 얇은 테두리 */
	border-radius: 50%; /* 원형 */
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
}

/* 호버 시 효과 */
.carousel-control-prev:hover .carousel-btn-glass, .carousel-control-next:hover .carousel-btn-glass
	{
	background: rgba(168, 85, 247, 0.6); /* 보라색 하이라이트 */
	border-color: #a855f7;
	transform: scale(1.1); /* 살짝 커짐 */
}

/* 이미지 래퍼: 이미지가 없을 때 영역 확보용 */
.image-wrapper {
	width: 100%;
	background-color: rgba(0, 0, 0, 0.2);
}
</style>
<script type="text/javascript">
	function deletePost(postId) {
		if (confirm("게시글을 삭제하시겠습니까?")) {
			// 삭제 처리 URL로 이동 (아직 구현 전이라면 알림만)
			// location.href = '${pageContext.request.contextPath}/post/delete?postId=' + postId;
			alert("삭제 기능 구현 예정입니다.");
		}
	}

	function updatePost(postId) {
		location.href = '${pageContext.request.contextPath}/post/update?postId='
				+ postId;
	}
</script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		// 1. 요소 선택
		const carouselEl = document.getElementById('imageCarousel');

		// 이미지가 없거나 1개뿐이면 로직 실행 안 함
		if (!carouselEl)
			return;

		const items = carouselEl.querySelectorAll('.carousel-item');
		const btnPrev = document.getElementById('btnPrev');
		const btnNext = document.getElementById('btnNext');

		// 이미지가 1개면 버튼 모두 숨김
		if (items.length <= 1) {
			if (btnPrev)
				btnPrev.style.display = 'none';
			if (btnNext)
				btnNext.style.display = 'none';
			return;
		}

		// 2. 초기 상태 설정 (첫 페이지이므로 Prev 숨김)
		btnPrev.style.display = 'none';
		btnNext.style.display = 'flex'; // flex로 해야 중앙 정렬 유지됨

		// 3. 슬라이드 이벤트 리스너 (슬라이드 완료 후 발생)
		carouselEl.addEventListener('slid.bs.carousel', function(e) {
			const currentIndex = e.to; // 이동한 인덱스 (0부터 시작)
			const lastIndex = items.length - 1;

			// (1) 첫 번째 슬라이드일 때
			if (currentIndex === 0) {
				btnPrev.style.display = 'none';
			} else {
				btnPrev.style.display = 'flex';
			}

			// (2) 마지막 슬라이드일 때
			if (currentIndex === lastIndex) {
				btnNext.style.display = 'none';
			} else {
				btnNext.style.display = 'flex';
			}
		});
	});
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
								<button type="button" class="btn-icon text-white"
									onclick="history.back()">
									<span class="material-symbols-outlined">arrow_back</span>
								</button>
								<span class="text-white fw-bold fs-5">Post</span>
							</div>

							<div class="glass-card shadow-lg mb-4"
								style="background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 1rem;">

								<div
									class="p-4 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
									<div class="d-flex align-items-center gap-3">
										<div
											class="avatar-md text-white fw-bold d-flex align-items-center justify-content-center"
											style="width: 48px; height: 48px; border-radius: 50%; background: linear-gradient(45deg, #a855f7, #6366f1); overflow: hidden;">
											<c:choose>
												<c:when test="${not empty memberdto.profile_photo}">
													<img
														src="${pageContext.request.contextPath}/uploads/profile/${memberdto.profile_photo}"
														style="width: 100%; height: 100%; object-fit: cover;">
												</c:when>
												<c:otherwise>
													<span class="material-symbols-outlined fs-3">person</span>
												</c:otherwise>
											</c:choose>
										</div>
										<div>
											<h3 class="text-sm fw-medium text-white mb-0">${not empty memberdto.userNickname ? memberdto.userNickname : memberdto.userId}
											</h3>
											<p class="text-xs text-gray-500 mb-0">${dto.detailDate} &bull; 조회 ${dto.viewCount}</p>
										</div>
									</div>

									<c:if
										test="${sessionScope.member.memberIdx == memberdto.userIdx}">
										<div class="dropdown">
											<button class="btn btn-icon text-white" type="button"
												data-bs-toggle="dropdown" aria-expanded="false">
												<span class="material-symbols-outlined">more_horiz</span>
											</button>
											<ul class="dropdown-menu dropdown-menu-dark glass-dropdown"
												style="background: rgba(30, 30, 30, 0.9);">
												<li><a class="dropdown-item" href="#"
													onclick="updatePost('${dto.postId}'); return false;">수정</a></li>
												<li><a class="dropdown-item text-danger" href="#"
													onclick="deletePost('${dto.postId}'); return false;">삭제</a></li>
											</ul>
										</div>
									</c:if>
								</div>

								<div class="p-4">
									<h4 class="text-white fw-bold mb-4" style="font-size: 1.5rem;">${dto.title}</h4>

									<c:if test="${not empty dto.fileList}">
										<div class="mb-4">
											<div id="imageCarousel" class="carousel slide"
												data-bs-interval="false">

												<div class="carousel-inner rounded-3 overflow-hidden">
													<c:forEach var="fileDto" items="${dto.fileList}"
														varStatus="status">
														<div class="carousel-item ${status.first ? 'active' : ''}">

															<div
																class="image-wrapper d-flex justify-content-center align-items-center bg-dark bg-opacity-25"
																style="height: 500px;">
																<c:choose>
																	<%-- 1. http로 시작하는 URL (Cloudinary 파일) --%>
																	<c:when
																		test="${fn:startsWith(fileDto.filePath, 'http')}">
																		<img src="${fileDto.filePath}" class="d-block"
																			style="max-width: 100%; max-height: 100%; object-fit: contain;"
																			alt="Post Image">
																	</c:when>

																	<%-- 2. 로컬 업로드 파일 --%>
																	<c:otherwise>
																		<img
																			src="${pageContext.request.contextPath}/uploads/photo/${fileDto.filePath}"
																			class="d-block"
																			style="max-width: 100%; max-height: 100%; object-fit: contain;"
																			alt="Post Image">
																	</c:otherwise>
																</c:choose>
															</div>


														</div>
													</c:forEach>
												</div>

												<button class="carousel-control-prev" type="button"
													data-bs-target="#imageCarousel" data-bs-slide="prev"
													id="btnPrev" style="display: none;">
													<span class="carousel-btn-glass"> <span
														class="material-symbols-outlined fs-4">chevron_left</span>
													</span> <span class="visually-hidden">Previous</span>
												</button>

												<button class="carousel-control-next" type="button"
													data-bs-target="#imageCarousel" data-bs-slide="next"
													id="btnNext">
													<span class="carousel-btn-glass"> <span
														class="material-symbols-outlined fs-4">chevron_right</span>
													</span> <span class="visually-hidden">Next</span>
												</button>
											</div>
										</div>
									</c:if>

									<div class="article-content">${dto.content}</div>
								</div>

								<div
									class="px-4 py-3 d-flex align-items-center justify-content-between border-top border-white border-opacity-10"
									style="background: rgba(255, 255, 255, 0.02);">

									<div class="d-flex gap-4">
										<button
											class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-pink">
											<span class="material-symbols-outlined fs-5">favorite_border</span>
											<span class="small">${dto.likeCount}</span>
										</button>
										<button
											class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-blue">
											<span class="material-symbols-outlined fs-5">chat_bubble_outline</span>
											<span class="small">${dto.commentCount}</span>
										</button>
										<button
											class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-green">
											<span class="material-symbols-outlined fs-5">repeat</span>
										</button>
									</div>

									<div class="d-flex gap-3">
										<button
											class="btn btn-link text-decoration-none text-white-50 p-0 hover-yellow">
											<span class="material-symbols-outlined fs-5">bookmark_border</span>
										</button>
										<button
											class="btn btn-link text-decoration-none text-white-50 p-0 hover-purple">
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
										<div
											class="avatar-sm bg-secondary text-white fw-bold flex-shrink-0 d-flex align-items-center justify-content-center rounded-circle"
											style="width: 36px; height: 36px;">ME</div>
										<div class="flex-grow-1 position-relative">
											<input type="text"
												class="form-control comment-input rounded-pill px-3 text-sm"
												placeholder="Add a comment...">
											<button
												class="btn btn-sm btn-primary rounded-pill position-absolute top-50 end-0 translate-middle-y me-1 px-3"
												style="background: #a855f7; border: none; font-size: 0.75rem;">Post</button>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>