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
/* 기존 스타일 유지 */
.filter-bar {
	background: transparent !important;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	margin-bottom: 1.5rem;
	padding-bottom: 1rem;
	position: relative;
	z-index: 1000;
}
.action-btn-hover.btn-like:hover { color: #ec4899 !important; background: rgba(236, 72, 153, 0.1) !important; }
.action-btn-hover.btn-comment:hover { color: #60a5fa !important; background: rgba(96, 165, 250, 0.1) !important; }
.action-btn-hover.btn-share:hover { color: #c084fc !important; background: rgba(192, 132, 252, 0.1) !important; }
.action-btn-hover.btn-save:hover { color: #facc15 !important; background: rgba(250, 204, 21, 0.1) !important; }
.action-btn-hover.btn-report:hover { color: #f87171 !important; background: rgba(248, 113, 113, 0.1) !important; }

/* [추가] 좋아요 핑크색 스타일 */
.text-pink { color: #ec4899 !important; }

.feed-card { border: 1px solid rgba(255, 255, 255, 0.08); margin-bottom: 2rem; cursor: pointer; }
.carousel-inner { background-color: #000; border-radius: 0.5rem; }
.image-container { height: 350px; display: flex; align-items: center; justify-content: center; overflow: hidden; background: #000; }
.slider-img { max-width: 100%; max-height: 100%; object-fit: contain; }
.carousel-btn-glass { width: 44px; height: 44px; background: rgba(255, 255, 255, 0.15); backdrop-filter: blur(4px); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: all 0.2s; }
.carousel-btn-glass:hover { background: rgba(255, 255, 255, 0.25); transform: scale(1.1); }
.carousel-control-prev, .carousel-control-next { opacity: 1; width: 10%; }

.compact-card { display: flex; flex-direction: row; gap: 1rem; padding: 0.8rem 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.1); background: rgba(25, 25, 25, 0.6); margin-bottom: 0 !important; border-radius: 0 !important; cursor: pointer; transition: background 0.2s; align-items: stretch; }
.compact-card:hover { background: rgba(255, 255, 255, 0.08); }
.compact-card:first-child { border-top-left-radius: 1rem !important; border-top-right-radius: 1rem !important; }
.compact-card:last-child { border-bottom-left-radius: 1rem !important; border-bottom-right-radius: 1rem !important; border-bottom: none; }
.compact-thumbnail-area { width: 90px; height: 65px; border-radius: 8px; flex-shrink: 0; overflow: hidden; position: relative; background: #000; display: flex; align-items: center; justify-content: center; }
.compact-thumb-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; display: block; }
.compact-card:hover .compact-thumb-img { transform: scale(1.05); }

.card-action-btn { display: flex; align-items: center; gap: 8px; padding: 8px 12px !important; border-radius: 50px !important; color: #d1d5db; font-weight: 600; font-size: 0.9rem !important; background: transparent; border: none; transition: all 0.2s ease-in-out; cursor: pointer; }
.card-action-btn .material-symbols-outlined { font-size: 1.2rem; }

.compact-action-btn { display: flex; align-items: center; gap: 6px; padding: 6px 10px !important; border-radius: 50px !important; color: #9ca3af; font-size: 0.85rem !important; font-weight: 600; background: transparent; border: none; transition: all 0.2s ease-in-out; cursor: pointer; white-space: nowrap !important; }
.compact-action-btn .material-symbols-outlined { font-size: 1.1rem !important; }
.compact-action-group { display: flex !important; flex-direction: row !important; align-items: center !important; gap: 0.4rem !important; }

.feed-container-center { max-width: 650px; margin-left: auto; margin-right: auto; }
.feed-wrapper-compact { gap: 0 !important; }
.feed-wrapper-card { gap: 1.5rem !important; }
.modal-close-btn { position: absolute; top: -40px; right: 0; background: rgba(0, 0, 0, 0.5); border: 1px solid rgba(255, 255, 255, 0.3); color: white; border-radius: 50%; width: 36px; height: 36px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.2s; z-index: 1056; }
.modal-close-btn:hover { background: rgba(255, 255, 255, 0.2); transform: scale(1.1); }
.compact-meta-info { white-space: nowrap !important; flex-shrink: 0; min-width: 0; }
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
						<h4 id="toastTitle" class="text-xs fw-bold text-uppercase tracking-widest mb-1" style="color: #a855f7;">System</h4>
						<p id="toastMessage" class="text-sm text-gray-300 mb-0">메시지</p>
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
				<div class="container-fluid pt-2 pb-5">
					<div class="row justify-content-center">
						<div class="col-12 col-lg-11 col-xl-10 mx-auto feed-container-center">
							<div class="d-flex flex-column ${viewMode == 'compact' ? 'feed-wrapper-compact' : 'feed-wrapper-card'}">

								<div class="filter-bar d-flex justify-content-between align-items-center px-2">
									<div class="d-flex align-items-center gap-4 text-sm fw-medium text-gray-500 text-uppercase tracking-widest">
										<span class="text-white fs-4 fw-bold">Latest Updates</span>
									</div>
									<div class="d-flex gap-2">
										<div class="dropdown">
											<button class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-2 rounded-pill shadow-sm" style="background: rgba(0, 0, 0, 0.3);" type="button" data-bs-toggle="dropdown" aria-expanded="false">
												<span id="currentSortLabel"> <c:choose>
														<c:when test="${sort == 'likes'}">좋아요 순</c:when>
														<c:when test="${sort == 'views'}">조회수 순</c:when>
														<c:otherwise>최신순</c:otherwise>
													</c:choose>
												</span> <span class="material-symbols-outlined fs-6 small ms-1">expand_more</span>
											</button>
											<ul class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end shadow-lg">
												<li><a class="dropdown-item" href="javascript:changeSort('latest')">최신순</a></li>
												<li><a class="dropdown-item" href="javascript:changeSort('likes')">좋아요 순</a></li>
												<li><a class="dropdown-item" href="javascript:changeSort('views')">조회수 순</a></li>
											</ul>
										</div>
										<div class="dropdown">
											<button class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-2 rounded-pill shadow-sm" style="background: rgba(0, 0, 0, 0.3);" type="button" data-bs-toggle="dropdown" aria-expanded="false">
												<span class="material-symbols-outlined fs-6">${viewMode == 'compact' ? 'view_list' : 'view_day'} </span>
											</button>
											<ul class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end shadow-lg">
												<li><a class="dropdown-item" href="javascript:changeView('card')">카드형</a></li>
												<li><a class="dropdown-item" href="javascript:changeView('compact')">축약형</a></li>
											</ul>
										</div>
									</div>
								</div>

								<c:if test="${empty list}">
									<div class="text-center py-5 glass-card shadow-lg rounded-4">
										<p class="text-white-50 fs-5">등록된 게시글이 없습니다.</p>
									</div>
								</c:if>

								<c:forEach var="dto" items="${list}">
									<%-- ================= [VIEW 1] 카드형 ================= --%>
									<c:if test="${viewMode == 'card' || empty viewMode}">
										<div class="glass-card shadow-lg feed-card rounded-4" onclick="goArticle('${dto.postId}')" style="background: rgba(30, 30, 30, 0.6);">
											<div class="p-2 d-flex align-items-center justify-content-between">
												<div class="d-flex align-items-center gap-2">
													<div class="avatar-md text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden shadow-sm" style="background: linear-gradient(45deg, #a855f7, #6366f1); border-radius: 50%; width: 24px; height: 24px;">
														<c:choose>
															<c:when test="${not empty dto.authorProfileImage}">
																<img src="${pageContext.request.contextPath}/uploads/profile/${dto.authorProfileImage}" style="width: 100%; height: 100%; object-fit: cover;">
															</c:when>
															<c:otherwise><span class="fs-5">${fn:substring(dto.authorNickname, 0, 1)}</span></c:otherwise>
														</c:choose>
													</div>
													<div>
														<div class="fs-6">${dto.authorNickname}</div>
														<p class="text-sm text-gray-400 mb-0">${dto.timeAgo}</p>
													</div>
												</div>
											</div>

											<div class="px-3 pb-2">
												<h5 class="text-white fw-bold fs-6 mb-1">${dto.title}</h5>
												<p class="text-gray-300 text-sm mb-2 text-ellipsis">${dto.content}</p>
											</div>

											<c:if test="${not empty dto.fileList}">
												<div id="carousel-${dto.postId}" class="carousel slide pb-3" data-bs-interval="false" onclick="event.stopPropagation();">
													<div class="carousel-inner">
														<c:forEach var="fileDto" items="${dto.fileList}" varStatus="status">
															<div class="carousel-item ${status.first ? 'active' : ''}">
																<div class="image-container">
																	<c:choose>
																		<c:when test="${fn:startsWith(fileDto.filePath, 'http')}">
																			<img src="${fileDto.filePath}" class="slider-img">
																		</c:when>
																		<c:otherwise>
																			<img src="${pageContext.request.contextPath}/uploads/photo/${fileDto.filePath}" class="slider-img">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</c:forEach>
													</div>
													<c:if test="${fn:length(dto.fileList) > 1}">
														<button class="carousel-control-prev ps-3" type="button" data-bs-target="#carousel-${dto.postId}" data-bs-slide="prev" style="display: none;">
															<span class="carousel-btn-glass"><span class="material-symbols-outlined fs-4">chevron_left</span></span>
														</button>
														<button class="carousel-control-next pe-3" type="button" data-bs-target="#carousel-${dto.postId}" data-bs-slide="next">
															<span class="carousel-btn-glass"><span class="material-symbols-outlined fs-4">chevron_right</span></span>
														</button>
													</c:if>
												</div>
											</c:if>

											<div class="px-4 py-3 border-top border-white border-opacity-10">
												<div class="d-flex align-items-center w-100" onclick="event.stopPropagation();">
													<button class="card-action-btn action-btn-hover btn-like me-3 ${dto.likedByUser ? 'text-pink' : ''}"
															onclick="toggleLike('${dto.postId}', this); event.stopPropagation();">
														<span class="material-symbols-outlined">${dto.likedByUser ? 'favorite' : 'favorite_border'}</span> 
														<span class="like-count">${dto.likeCount}</span>
													</button>
													
													<button class="card-action-btn action-btn-hover btn-comment"
															onclick="goArticle('${dto.postId}'); event.stopPropagation();">
														<span class="material-symbols-outlined">chat_bubble</span>
														<span>${dto.commentCount}</span>
													</button>

													<div class="ms-auto d-flex gap-2">
														<button class="card-action-btn action-btn-hover btn-share"><span class="material-symbols-outlined">share</span> <span>공유</span></button>
														<button class="card-action-btn action-btn-hover btn-save"><span class="material-symbols-outlined">bookmark</span> <span>저장</span></button>
														<button class="card-action-btn action-btn-hover btn-report"><span class="material-symbols-outlined">campaign</span> <span>신고</span></button>
													</div>
												</div>
											</div>
										</div>
									</c:if>

									<%-- ================= [VIEW 2] 축약형 ================= --%>
									<c:if test="${viewMode == 'compact'}">
										<div class="compact-card shadow-sm" onclick="goArticle('${dto.postId}')">
											<div class="compact-thumbnail-area shadow-sm" onclick="event.stopPropagation(); showImageModal('${not empty dto.fileList ? dto.fileList[0].filePath : ''}');">
												<c:choose>
													<c:when test="${not empty dto.fileList}">
														<c:choose>
															<c:when test="${fn:startsWith(dto.fileList[0].filePath, 'http')}"><img src="${dto.fileList[0].filePath}" class="compact-thumb-img"></c:when>
															<c:otherwise><img src="${pageContext.request.contextPath}/uploads/photo/${dto.fileList[0].filePath}" class="compact-thumb-img"></c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise><div class="d-flex align-items-center justify-content-center w-100 h-100 bg-secondary bg-opacity-25"><span class="material-symbols-outlined text-white-50 fs-4">article</span></div></c:otherwise>
												</c:choose>
											</div>

											<div class="flex-grow-1 d-flex flex-column" style="min-width: 0;">
												<h5 class="text-white fw-bold fs-6 mb-2 text-truncate">${dto.title}</h5>
												<div class="d-flex align-items-center justify-content-between mt-auto pt-2">
													<div class="d-flex align-items-center gap-3 text-gray-400 compact-meta-info">
														<div class="d-flex align-items-center gap-2 text-white-50">
															<div class="rounded-circle overflow-hidden d-flex align-items-center justify-content-center shadow-sm" style="width: 20px; height: 20px; background: linear-gradient(45deg, #a855f7, #6366f1);">
																<c:choose>
																	<c:when test="${not empty dto.authorProfileImage}"><img src="${pageContext.request.contextPath}/uploads/profile/${dto.authorProfileImage}" style="width: 100%; height: 100%; object-fit: cover;"></c:when>
																	<c:otherwise><span class="text-white small fw-bold" style="font-size: 10px;">${fn:substring(dto.authorNickname, 0, 1)}</span></c:otherwise>
																</c:choose>
															</div>
															<span class="fw-bold text-sm text-white">${dto.authorNickname}</span>
														</div>
														<span class="opacity-50">&bull;</span> <span class="text-sm">${dto.timeAgo}</span>
													</div>

													<div class="compact-action-group ms-auto" onclick="event.stopPropagation();">
														<button class="compact-action-btn action-btn-hover btn-like p-0 border-0 ${dto.likedByUser ? 'text-pink' : ''}"
																onclick="toggleLike('${dto.postId}', this); event.stopPropagation();">
															<span class="material-symbols-outlined">${dto.likedByUser ? 'favorite' : 'favorite_border'}</span> 
															<span class="like-count">${dto.likeCount}</span>
														</button>
														
														<button class="compact-action-btn action-btn-hover btn-comment p-0 border-0"
																onclick="goArticle('${dto.postId}'); event.stopPropagation();">
															<span class="material-symbols-outlined">chat_bubble</span>
															<span>${dto.commentCount}</span>
														</button>
														
														<button class="compact-action-btn action-btn-hover btn-share p-0 border-0"><span class="material-symbols-outlined">share</span> <span>공유</span></button>
														<button class="compact-action-btn action-btn-hover btn-save p-0 border-0"><span class="material-symbols-outlined">bookmark</span> <span>저장</span></button>
														<button class="compact-action-btn action-btn-hover btn-report p-0 border-0"><span class="material-symbols-outlined">campaign</span> <span>신고</span></button>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content bg-transparent border-0 position-relative">
				<button type="button" class="modal-close-btn" onclick="closeImageModal()">
					<span class="material-symbols-outlined fs-4">close</span>
				</button>
				<div class="modal-body p-0 text-center">
					<img id="modalImage" src="" class="img-fluid rounded-4 shadow-lg" style="max-height: 90vh;">
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>

	<c:if test="${not empty sessionScope.toastMsg}">
		<script>
            $(document).ready(function() { showToast("${sessionScope.toastMsg}", "${sessionScope.toastType}"); });
        </script>
		<c:remove var="toastMsg" scope="session" />
		<c:remove var="toastType" scope="session" />
	</c:if>

	<script>
		const isLogin = "${not empty sessionScope.member ? 'true' : 'false'}";
		const contextPath = "${pageContext.request.contextPath}";

		// [추가] 메인 페이지용 좋아요 토글
		function toggleLike(postId, btn) {
			if(isLogin === "false") {
				// 로그인 모달 대신 리다이렉트 사용 (모달은 헤더에 있다고 가정)
				if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
					location.href = contextPath + '/member/login?redirect=' + encodeURIComponent(location.href);
				}
				return;
			}
	
			$.ajax({
				url: contextPath + "/post/insertPostLike",
				type: "post",
				data: { postId: postId },
				dataType: "json",
				success: function(data) {
					if(data.state === "success") {
						const $btn = $(btn);
						const $icon = $btn.find("span.material-symbols-outlined");
						const $count = $btn.find(".like-count");
						
						$count.text(data.likeCount);
						
						if(data.liked) {
							$icon.text("favorite");
							$btn.addClass("text-pink");
						} else {
							$icon.text("favorite_border");
							$btn.removeClass("text-pink");
						}
					} else if(data.state === "login_required") {
						location.href = contextPath + '/member/login?redirect=' + encodeURIComponent(location.href);
					}
				},
				error: function(e) { console.log(e); }
			});
		}

        function showToast(msg, type) {
            const $toast = $('#sessionToast');
			const $title = $('#toastTitle');
            const $icon = $('#toastIcon');
            $('#toastMessage').text(msg);
            if (type === "success") { $title.text('SUCCESS').css('color', '#4ade80'); $icon.text('check_circle'); } 
            else if (type === "info") { $title.text('INFO').css('color', '#8B5CF6'); $icon.text('info'); } 
            else if (type === "error") { $title.text('ERROR').css('color', '#f87171'); $icon.text('error'); }
            $toast.addClass('show');
            setTimeout(function() { $toast.removeClass('show'); }, 2500);
		}

        function changeSort(sortType) {
            const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('sort', sortType);
            window.location.search = urlParams.toString();
        }

        function changeView(viewMode) {
            const urlParams = new URLSearchParams(window.location.search);
			urlParams.set('view', viewMode);
            window.location.search = urlParams.toString();
        }

		// [수정] 상세 페이지 이동
        function goArticle(postId) {
            location.href = contextPath + '/post/article?postId=' + postId;
		}

        let myModalInstance = null;
		function showImageModal(imagePath) {
            if (!imagePath) return;
			let fullPath = "";
            if (imagePath.startsWith("http")) fullPath = imagePath;
            else fullPath = contextPath + '/uploads/photo/' + imagePath;
            document.getElementById('modalImage').src = fullPath;
			const modalElement = document.getElementById('imageModal');
            if (!myModalInstance) myModalInstance = new bootstrap.Modal(modalElement);
            myModalInstance.show();
		}
        function closeImageModal() { if (myModalInstance) myModalInstance.hide(); }
		
		$(document).ready(function() {
			const carousels = document.querySelectorAll('.carousel');
			carousels.forEach(function(carousel) {
				carousel.addEventListener('slid.bs.carousel', function (e) {
					const $carousel = $(e.target);
					const $items = $carousel.find('.carousel-item');
					const totalItems = $items.length;
					const currentIndex = e.to; 
					
					const $btnPrev = $carousel.find('.carousel-control-prev');
					const $btnNext = $carousel.find('.carousel-control-next');
		
					if (currentIndex === 0) $btnPrev.hide();
					else $btnPrev.css('display', 'flex'); 
		
					if (currentIndex === totalItems - 1) $btnNext.hide();
					else $btnNext.css('display', 'flex');
				});
			});
		});	
    </script>
    
    <script>
        window.addEventListener('pageshow', function(event) {
            // event.persisted: BFCache(뒤로가기 캐시)에서 로드되었는지 확인
            // window.performance...: 일부 브라우저 호환성 체크 (type 2가 뒤로가기)
            if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
                // 캐시된 페이지라면 강제로 새로고침하여 최신 데이터를 가져옴
                window.location.reload();
            }
        });
    </script>
</body>
</html>