<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>

<style type="text/css">
/* 탭 버튼 컨테이너 내부 간격 조정 */
#mypage-tabs {
	display: flex;
	gap: 8px;
	padding: 2px;
}

/* 탭 버튼 기본 상태 (확실히 보이게 수정) */
#mypage-tabs .btn-sm, .layout-tabs .btn-sm {
	transition: all 0.2s ease-in-out;
	color: rgba(255, 255, 255, 0.7) !important; /* 잘 보이도록 밝기 조절 */
	background: transparent !important;
	border: 1px solid rgba(255, 255, 255, 0.1) !important; /* 약한 테두리 추가 */
	font-weight: 500 !important;
}

/* 마우스를 올렸을 때 (Hover) */
#mypage-tabs .btn-sm:hover, .layout-tabs .btn-sm:hover {
	color: #ffffff !important;
	background: rgba(255, 255, 255, 0.15) !important;
	border-color: rgba(255, 255, 255, 0.3) !important;
}

/* 활성화된 버튼 (선택됨 - 가장 중요) */
.active-filter {
	background: #ffffff !important; /* 배경 흰색 */
	color: #000000 !important; /* 글자 검은색 */
	border: 1px solid #ffffff !important;
	font-weight: 700 !important;
	box-shadow: 0 0 15px rgba(255, 255, 255, 0.3); /* 은은한 흰색 광택 */
}

/* 탭 콘텐츠 영역 기본 숨김 */
.tab-content {
	display: none;
}

/* 캐러셀 기본 레이아웃 */
.post-carousel {
	border-radius: 12px;
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, 0.1);
	position: relative;
	background: rgba(0, 0, 0, 0.2); /* 이미지 로딩 전 배경색 */
}

/* 좌우 화살표 버튼 커스텀 */
.carousel-control-prev, .carousel-control-next {
	width: 36px;
	height: 36px;
	background: rgba(0, 0, 0, 0.4); /* 반투명 블랙 */
	border-radius: 50%;
	top: 50%;
	transform: translateY(-50%);
	margin: 0 12px;
	backdrop-filter: blur(4px); /* 뒤에 비치는 이미지 흐리게 */
	transition: all 0.2s ease-in-out;
	opacity: 0; /* 평소에는 숨김 */
}

/* 포스트 카드에 마우스 올리면 화살표 나타나기 */
.glass-card:hover .carousel-control-prev, .glass-card:hover .carousel-control-next
	{
	opacity: 1;
}

.carousel-control-prev:hover, .carousel-control-next:hover {
	background: rgba(255, 255, 255, 0.2);
	transform: translateY(-50%) scale(1.1);
}

/* 하단 인디케이터(점) 커스텀 */
.carousel-indicators {
	margin-bottom: 0.5rem;
}

.carousel-indicators [data-bs-target] {
	width: 6px;
	height: 6px;
	border-radius: 50%;
	background-color: #fff;
	opacity: 0.4;
	border: none;
	margin: 0 4px;
	transition: opacity 0.3s ease;
}

.carousel-indicators .active {
	opacity: 1;
	transform: scale(1.2);
}

/* 이미지 비율 및 정렬 */
.carousel-item img {
	object-fit: cover;
	width: 100%;
	height: 100%;
}

/* 리스트 모드가 아닐 때 (기본 카드형) */
.card-view-item {
	display: block;
}

.list-view-item {
	display: none !important;
}

#post-list-container.list-mode {
	gap: 12px !important; /* 카드형보다 간격을 좁게 설정 */
}

#post-list-container.list-mode .card-view-item {
	display: none !important;
}

#post-list-container.list-mode .list-view-item {
	display: flex !important;
}

/* (추가) 카드 모드일 때 신규 생성된 리스트형 제어 */
#post-list-container:not(.list-mode) .list-view-item {
	display: none !important;
}

#post-list-container:not(.list-mode) .card-view-item {
	display: block !important;
}

/* (수정) 리스트 모드일 때 개별 카드 스타일 */
#post-list-container.list-mode .post-item-card {
	margin-bottom: 0 !important;
	border-radius: 12px !important;
	padding: 0 !important; /* 내부 간격은 list-view-item에서 조절 */
}

/* 리스트 모드 텍스트 한줄 자르기 */
#post-list-container.list-mode .text-truncate {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* 리스트 아이템에 마우스를 올렸을 때 효과 */
#post-list-container.list-mode .post-item-card:hover {
	background: rgba(255, 255, 255, 0.08);
	transform: translateY(-1px);
	border-color: rgba(255, 255, 255, 0.2);
}

/* 리스트 모드일 때 아바타 크기 고정 */
#post-list-container.list-mode .avatar-sm {
	flex-shrink: 0;
}

/* 제목과 본문을 한 줄로 나란히 배치할 때 제목 강조 */
#post-list-container.list-mode .list-view-item span.fw-bold {
	color: #e0e0e0;
	min-width: fit-content;
}

/* 전환 시 부드러운 느낌을 위한 트랜지션 */
.post-item-card {
	transition: all 0.2s ease-in-out;
}

/* (추가) 본문 2줄 제한 및 말줄임 처리 */
.text-truncate-2 {
	display: -webkit-box;
	-webkit-line-clamp: 2; /* 2줄까지만 표시 */
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	word-break: break-all;
}
</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/home/header.jsp"%>

	<div class="app-body">

		<%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

		<main class="app-main">
			<div class="space-background">
				<div class="stars"></div>
				<div class="stars2"></div>
				<div class="stars3"></div>
				<div class="planet planet-1"></div>
				<div class="planet planet-2"></div>
			</div>

			<div id="sessionToast" class="glass-toast shadow-lg">
				<div class="d-flex align-items-center gap-3">
					<div class="toast-icon-circle">
						<span id="toastIcon" class="material-symbols-outlined fs-5">info</span>
					</div>
					<div class="toast-content">
						<h4 id="toastTitle"
							class="text-xs fw-bold text-uppercase tracking-widest mb-1">System</h4>
						<p id="toastMessage" class="text-sm text-gray-300 mb-0">메시지</p>
					</div>
				</div>
			</div>

			<div class="feed-scroll-container custom-scrollbar">
				<div class="d-flex flex-column align-items-center py-4 px-3">

					<div class="w-100 mb-4" style="max-width: 1100px;">
						<div class="glass-card overflow-hidden shadow-lg border-0"
							style="border-radius: 1rem !important;">
							<div class="position-relative overflow-hidden"
								style="height: 220px;">
								<c:choose>
									<c:when test="${not empty user.banner_photo}">
										<img src="${user.banner_photo}"
											class="w-100 h-100 object-fit-cover" alt="Banner">
									</c:when>
									<c:otherwise>
										<div class="w-100 h-100"
											style="background: linear-gradient(to right, #1e1b4b, #4338ca, #1e1b4b); position: relative;">
											<div class="position-absolute w-100 h-100"
												style="background: url('https://www.transparenttextures.com/patterns/stardust.png'); opacity: 0.3;"></div>
										</div>
									</c:otherwise>
								</c:choose>

								<div class="position-absolute bottom-0 start-0 w-100"
									style="height: 40%; background: linear-gradient(to top, rgba(13, 14, 18, 0.3), transparent); pointer-events: none;">
								</div>
							</div>
							<div class="px-4 pb-4 pt-4 position-relative"
								style="background: rgba(13, 14, 18, 0.85); backdrop-filter: blur(10px);">
								<div class="d-flex align-items-end gap-3">
									<div
										class="rounded-4 border border-4 border-dark shadow-lg d-flex align-items-center justify-content-center text-white fw-bold fs-1"
										style="width: 120px; height: 120px; background: linear-gradient(135deg, #6366f1, #a855f7); margin-top: -60px; position: relative; z-index: 2; overflow: hidden;">

										<c:choose>
											<c:when test="${not empty user.profile_photo}">
												<img src="${user.profile_photo}"
													class="w-100 h-100 object-fit-cover" alt="Profile">
											</c:when>
											<c:otherwise>
            									${fn:substring(user.userName, 0, 1)}
        									</c:otherwise>
										</c:choose>
									</div>
									<div class="pb-2">
										<h1 class="text-white fs-2 fw-bold mb-1">${user.userNickname}
										</h1>
										<p class="text-secondary mb-0">
											c/${user.userId} | <span class="text-white fw-bold">14.2k</span>
											Followers | <span class="text-white fw-bold">8.5k</span>
											Visitors
										</p>
									</div>
									<div class="ms-auto pb-2 d-flex gap-2">
										<button
											class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">Follow</button>
										<button
											class="btn-icon border border-white border-opacity-10 rounded-circle p-2">
											<span class="material-symbols-outlined text-white">notifications</span>
										</button>
										<c:if
											test="${not empty sessionScope.member and sessionScope.member.userId eq user.userId}">
											<button
												onclick="location.href='${pageContext.request.contextPath}/member/settings';"
												class="btn-icon border border-white border-opacity-10 rounded-circle p-2">
												<span class="material-symbols-outlined text-white">settings</span>
											</button>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="d-flex gap-4 w-100" style="max-width: 1100px;">

						<div class="flex-grow-1 d-flex flex-column gap-4"
							style="min-width: 0;">

							<div
								class="glass-panel px-3 py-2 d-flex align-items-center justify-content-between shadow-sm">
								<div class="d-flex gap-2" id="mypage-tabs">
									<button
										class="btn btn-sm rounded-pill px-3 fw-bold active-filter"
										data-target="my-posts">My Post</button>
									<button
										class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0"
										data-target="reposts">Repost</button>
								</div>
								<div
									class="layout-tabs d-flex align-items-center gap-2 border-start border-white border-opacity-10 ps-3">
									<button class="btn btn-sm rounded-pill px-3 active-filter">
										<span class="material-symbols-outlined fs-5">view_day</span>
									</button>

									<button class="btn btn-sm rounded-pill px-3">
										<span class="material-symbols-outlined fs-5">reorder</span>
									</button>
								</div>
							</div>

							<div id="post-list-container" class="d-flex flex-column gap-4">
								<c:forEach var="item" items="${post}">
									<div class="glass-card shadow-lg group mb-4 post-item-card">

										<div class="list-view-item p-3" style="display: none;">
											<div class="d-flex align-items-start gap-3 w-100">
												<div class="flex-shrink-0 thumbnail-box"
													style="width: 90px; height: 90px;">
													<c:choose>
														<c:when test="${not empty item.fileList}">
															<img src="${item.fileList[0].filePath}"
																class="w-100 h-100 object-fit-cover rounded-3 border border-white border-opacity-10">
														</c:when>
														<c:otherwise>
															<div
																class="w-100 h-100 rounded-3 d-flex align-items-center justify-content-center border border-white border-opacity-10"
																style="background: rgba(255, 255, 255, 0.05);">
																<span class="material-symbols-outlined opacity-20">image</span>
															</div>
														</c:otherwise>
													</c:choose>
												</div>

												<div
													class="flex-grow-1 overflow-hidden d-flex flex-column justify-content-between"
													style="min-height: 90px;">
													<div>
														<div class="d-flex align-items-center gap-2 mb-1">
															<span class="text-white fw-bold text-sm">${item.authorNickname}</span>
															<span class="text-secondary text-xs opacity-75">c/${item.authorId}</span>
															<span class="ms-auto text-xs text-gray-500">${item.createdDate}</span>
														</div>

														<c:if test="${not empty item.title}">
															<h4 class="text-white text-sm fw-bold mb-0 text-truncate">${item.title}</h4>
														</c:if>

														<p
															class="text-light opacity-50 text-xs mb-2 text-truncate">
															${item.content}</p>
													</div>

													<div
														class="d-flex align-items-center justify-content-between mt-auto">
														<div class="d-flex gap-3">
															<button
																class="btn-icon d-flex align-items-center gap-1 p-0"
																onclick="toggleLike(this, '${item.postId}')">
																<span
																	class="material-symbols-outlined fs-6 ${item.likedByUser ? 'text-danger' : ''}"
																	style="font-variation-settings: 'FILL' ${item.likedByUser ? 1 : 0};">favorite</span>
																<span class="text-xs opacity-75 like-count">${item.likeCount}</span>
															</button>
															<button
																class="btn-icon d-flex align-items-center gap-1 p-0"
																onclick="location.href='${pageContext.request.contextPath}/post/article?postId=${item.postId}';">
																<span class="material-symbols-outlined fs-6">chat_bubble</span>
																<span class="text-xs opacity-75">${item.commentCount}</span>
															</button>
															<button class="btn-icon p-0">
																<span class="material-symbols-outlined fs-6">repeat</span>
															</button>
														</div>
														<div class="d-flex gap-3 text-white-50">
															<button class="btn-icon p-0" title="공유하기">
																<span class="material-symbols-outlined fs-6">share</span>
															</button>
															<button class="btn-icon p-0" title="저장하기">
																<span class="material-symbols-outlined fs-6">bookmark</span>
															</button>
															<button class="btn-icon p-0" title="신고하기">
																<span class="material-symbols-outlined fs-6">report</span>
															</button>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="card-view-item">
											<div
												class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
												<div class="d-flex align-items-center gap-3">
													<div
														class="avatar-md bg-info text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden"
														style="width: 40px; height: 40px; border-radius: 10px; background: linear-gradient(135deg, #6366f1, #a855f7);">
														<c:choose>
															<c:when test="${not empty item.authorProfileImage}">
																<img src="${item.authorProfileImage}"
																	class="w-100 h-100 object-fit-cover">
															</c:when>
															<c:otherwise>${fn:substring(item.authorNickname, 0, 1)}</c:otherwise>
														</c:choose>
													</div>
													<div>
														<h3 class="text-sm fw-medium text-white mb-0">${item.authorNickname}</h3>
														<p class="text-xs text-gray-500 mb-0">${item.createdDate}</p>
													</div>
												</div>
												<button class="btn-icon text-white-50">
													<span class="material-symbols-outlined">more_horiz</span>
												</button>
											</div>

											<div class="p-3 pb-2">
												<c:if test="${not empty item.title}">
													<h4 class="text-white fs-6 fw-bold mb-1">${item.title}</h4>
												</c:if>
												<p class="text-light text-sm mb-0 lh-base"
													style="white-space: pre-wrap;">${item.content}</p>
											</div>

											<c:if test="${not empty item.fileList}">
												<div class="p-3 pt-0">
													<c:choose>
														<%-- 이미지가 여러 장인 경우: 캐러셀 --%>
														<c:when test="${item.fileList.size() > 1}">
															<div id="carousel-${item.postId}"
																class="carousel slide post-carousel"
																data-bs-ride="false">
																<div class="carousel-indicators">
																	<c:forEach var="file" items="${item.fileList}"
																		varStatus="status">
																		<button type="button"
																			data-bs-target="#carousel-${item.postId}"
																			data-bs-slide-to="${status.index}"
																			class="${status.first ? 'active' : ''}"></button>
																	</c:forEach>
																</div>
																<div class="carousel-inner">
																	<c:forEach var="file" items="${item.fileList}"
																		varStatus="status">
																		<div
																			class="carousel-item ${status.first ? 'active' : ''}">
																			<div class="ratio ratio-16x9">
																				<img src="${file.filePath}"
																					class="d-block w-100 object-fit-cover">
																			</div>
																		</div>
																	</c:forEach>
																</div>
																<button class="carousel-control-prev" type="button"
																	data-bs-target="#carousel-${item.postId}"
																	data-bs-slide="prev">
																	<span class="material-symbols-outlined fs-4">chevron_left</span>
																</button>
																<button class="carousel-control-next" type="button"
																	data-bs-target="#carousel-${item.postId}"
																	data-bs-slide="next">
																	<span class="material-symbols-outlined fs-4">chevron_right</span>
																</button>
															</div>
														</c:when>
														<%-- 이미지가 한 장인 경우 --%>
														<c:otherwise>
															<div class="post-carousel">
																<div class="ratio ratio-16x9">
																	<img src="${item.fileList[0].filePath}"
																		class="d-block w-100 object-fit-cover">
																</div>
															</div>
														</c:otherwise>
													</c:choose>
												</div>
											</c:if>

											<div
												class="px-3 py-2 d-flex align-items-center justify-content-between border-top border-white border-opacity-10"
												style="background: rgba(255, 255, 255, 0.05);">
												<div class="d-flex gap-4">
													<button class="btn-icon d-flex align-items-center gap-1"
														onclick="toggleLike(this, '${item.postId}')">
														<span
															class="material-symbols-outlined fs-5 ${item.likedByUser ? 'text-danger' : ''}"
															style="font-variation-settings: 'FILL' ${item.likedByUser ? 1 : 0};">favorite</span>
														<span class="text-xs opacity-75 like-count">${item.likeCount}</span>
													</button>
													<button class="btn-icon d-flex align-items-center gap-1"
														onclick="location.href='${pageContext.request.contextPath}/post/article?postId=${item.postId}';">
														<span class="material-symbols-outlined fs-5">chat_bubble</span>
														<span class="text-xs opacity-75">${item.commentCount}</span>
													</button>
													<button class="btn-icon">
														<span class="material-symbols-outlined fs-5">repeat</span>
													</button>
												</div>
												<div class="d-flex gap-3 text-white-50">
													<button class="btn-icon" title="공유하기">
														<span class="material-symbols-outlined fs-5">share</span>
													</button>
													<button class="btn-icon" title="저장하기">
														<span class="material-symbols-outlined fs-5">bookmark</span>
													</button>
													<button class="btn-icon" title="신고하기">
														<span class="material-symbols-outlined fs-5">report</span>
													</button>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>

							<div id="sentinel" style="height: 50px;"></div>
						</div>
						<aside class="d-none d-xl-flex flex-column gap-4"
							style="width: 320px; flex-shrink: 0;">
							<div class="glass-card p-4 shadow-lg">
								<h3
									class="text-white text-xs fw-bold text-uppercase tracking-widest mb-3 opacity-75">About
									Community</h3>

								<div class="d-flex align-items-center gap-3 mb-3">
									<div
										class="rounded-circle overflow-hidden border border-white border-opacity-10 shadow-sm"
										style="width: 50px; height: 50px; background: linear-gradient(135deg, #e11d48, #4c1d95);">
										<div
											class="w-100 h-100 d-flex align-items-center justify-content-center text-white">
											<span class="material-symbols-outlined">flare</span>
										</div>
									</div>
									<h4 class="text-white text-sm fw-bold mb-0">r/Stargazers</h4>
								</div>

								<p class="text-secondary text-xs lh-relaxed mb-4">A
									community for amateur astronomers, astrophotographers, and
									space enthusiasts.</p>

								<div
									class="d-flex gap-4 mb-4 pt-3 border-top border-white border-opacity-10">
									<div class="d-flex flex-column">
										<span class="text-white text-sm fw-bold">14.2k</span> <span
											class="text-secondary" style="font-size: 10px;">Members</span>
									</div>
									<div class="d-flex flex-column">
										<div class="d-flex align-items-center gap-1">
											<span class="material-symbols-outlined text-info"
												style="font-size: 12px;">visibility</span> <span
												class="text-white text-sm fw-bold">8.5k</span>
										</div>
										<span class="text-secondary" style="font-size: 10px;">Visitors</span>
									</div>
								</div>

								<div class="d-flex flex-column gap-2 mb-4">
									<div class="d-flex align-items-center gap-2 text-secondary">
										<span class="material-symbols-outlined"
											style="font-size: 18px;">cake</span> <span
											style="font-size: 0.85rem;">Created Sep 20, 2021</span>
									</div>
									<div class="d-flex align-items-center gap-2 text-secondary">
										<span class="material-symbols-outlined"
											style="font-size: 18px;">public</span> <span
											style="font-size: 0.85rem;">Public Access</span>
									</div>
								</div>

								<button
									class="btn btn-primary w-100 rounded-pill fw-bold py-2 mb-3"
									style="background: #2563eb; border: none;">Create Post</button>

								<div
									class="text-center pt-2 border-top border-white border-opacity-10">
									<span class="text-primary text-xs fw-bold"
										style="cursor: pointer;"
										onclick="location.href='${pageContext.request.contextPath}/community/update';">COMMUNITY
										OPTIONS</span>
								</div>
							</div>
						</aside>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script type="text/javascript">
		window.userId = "${user.userId}";
		window.cp = "${pageContext.request.contextPath}";
	</script>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/mypage.js"></script>

	<script type="text/javascript">
		function toggleLike(btn, postId) {
			if ($(btn).data('loading'))
				return;
			$(btn).data('loading', true);

			const $btn = $(btn);
			const $icon = $btn.find('.material-symbols-outlined');
			const $countSpan = $btn.find('.like-count');

			const isLiked = $icon.hasClass('text-danger');

			$
					.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath}/member/settings/toggleLike',
						data : {
							postId : postId
						},
						dataType : "json",
						success : function(data) {
							if (data.status === 'success') {
								if (isLiked) {
									$icon.css('font-variation-settings',
											"'FILL' 0");
									$icon.removeClass('text-danger');
									showToast("success", "좋아요를 취소했습니다.");
								} else {
									$icon.css('font-variation-settings',
											"'FILL' 1");
									$icon.addClass('text-danger');
									showToast("success", "좋아요를 눌렀습니다.");
								}

								if (data.likeCount !== undefined) {
									$countSpan.text(data.likeCount);
								}
							} else {
								showToast("error", "좋아요 처리에 실패했습니다.");
							}
						},
						error : function(xhr) {
							showToast("error", "서버 통신 에러.");
							console.error(xhr.responseText);
						},
						complete : function() {
							$btn.data('loading', false);
						}
					});
		}

		$(document).ready(
				function() {
					// 레이아웃 전환 버튼 클릭 이벤트
					$('.layout-tabs button').on(
							'click',
							function() {
								// 1. 버튼 활성화 UI 처리 (검은색 배경/흰색 글자 전환)
								const $parent = $(this).parent();
								$parent.find('button').removeClass(
										'active-filter');
								$(this).addClass('active-filter');

								// 2. 클릭한 버튼의 아이콘 이름 확인
								const iconName = $(this).find(
										'.material-symbols-outlined').text()
										.trim();
								const $container = $('#post-list-container');

								// 3. 아이콘 종류에 따라 클래스 토글
								if (iconName === 'reorder') {
									// 리스트형(축약형) 모드 활성화
									$container.addClass('list-mode');
									// 리스트 모드일 때 간격을 좁게 만들기 위해 gap-4를 gap-2로 변경 (선택사항)
									$container.removeClass('gap-4').addClass(
											'gap-2');
								} else {
									// 카드형(기본) 모드 활성화
									$container.removeClass('list-mode');
									$container.removeClass('gap-2').addClass(
											'gap-4');
								}
							});

					// [참고] 기존 탭(My Post / Repost) 코드와 충돌하지 않도록 별도로 관리됩니다.
					$('#mypage-tabs button').on(
							'click',
							function() {
								$(this).parent().find('button').removeClass(
										'active-filter');
								$(this).addClass('active-filter');
								// 여기에 포스트 필터링(Ajax 등) 로직을 추가하시면 됩니다.
							});
				});
	</script>
</body>
</html>