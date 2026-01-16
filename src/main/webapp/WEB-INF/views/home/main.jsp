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
/* Existing styles */
.filter-bar {
	background: transparent !important;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	margin-bottom: 1.5rem;
	padding-bottom: 1rem;
	position: relative;
	z-index: 1000;
}

.action-btn-hover.btn-like:hover {
	color: #ec4899 !important;
	background: rgba(236, 72, 153, 0.1) !important;
}

.action-btn-hover.btn-comment:hover {
	color: #60a5fa !important;
	background: rgba(96, 165, 250, 0.1) !important;
}

.action-btn-hover.btn-share:hover {
	color: #c084fc !important;
	background: rgba(192, 132, 252, 0.1) !important;
}

.action-btn-hover.btn-save:hover {
	color: #facc15 !important;
	background: rgba(250, 204, 21, 0.1) !important;
}

.action-btn-hover.btn-report:hover {
	color: #f87171 !important;
	background: rgba(248, 113, 113, 0.1) !important;
}

/* Pink style for likes */
.text-pink {
	color: #ec4899 !important;
}

.feed-card {
	border: 1px solid rgba(255, 255, 255, 0.08);
	margin-bottom: 2rem;
	cursor: pointer;
}

.carousel-inner {
	background-color: #000;
	border-radius: 0.5rem;
}

.image-container {
	height: 350px;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	background: #000;
}

.slider-img {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
}

.carousel-btn-glass {
	width: 44px;
	height: 44px;
	background: rgba(255, 255, 255, 0.15);
	backdrop-filter: blur(4px);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	transition: all 0.2s;
}

.carousel-btn-glass:hover {
	background: rgba(255, 255, 255, 0.25);
	transform: scale(1.1);
}

.carousel-control-prev, .carousel-control-next {
	opacity: 1;
	width: 10%;
}

.compact-card {
	display: flex;
	flex-direction: row;
	gap: 1rem;
	padding: 0.8rem 1rem;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	background: rgba(25, 25, 25, 0.6);
	margin-bottom: 0 !important;
	border-radius: 0 !important;
	cursor: pointer;
	transition: background 0.2s;
	align-items: stretch;
	width: 100%;
	box-sizing: border-box;
}

.compact-card:hover {
	background: rgba(255, 255, 255, 0.08);
}

.compact-card:first-child {
	border-top-left-radius: 1rem !important;
	border-top-right-radius: 1rem !important;
}

.compact-card:last-child {
	border-bottom-left-radius: 1rem !important;
	border-bottom-right-radius: 1rem !important;
	border-bottom: none;
}

.compact-thumbnail-area {
	width: 90px;
	height: 65px;
	border-radius: 8px;
	flex-shrink: 0;
	overflow: hidden;
	position: relative;
	background: #000;
	display: flex;
	align-items: center;
	justify-content: center;
}

.compact-thumb-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.3s;
	display: block;
}

.compact-card:hover .compact-thumb-img {
	transform: scale(1.05);
}

.card-action-btn {
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 8px 12px !important;
	border-radius: 50px !important;
	color: #d1d5db;
	font-weight: 600;
	font-size: 0.9rem !important;
	background: transparent;
	border: none;
	transition: all 0.2s ease-in-out;
	cursor: pointer;
}

.card-action-btn .material-symbols-outlined {
	font-size: 1.2rem;
}

.compact-action-btn {
	display: flex;
	align-items: center;
	gap: 6px;
	padding: 6px 10px !important;
	border-radius: 50px !important;
	color: #9ca3af;
	font-size: 0.85rem !important;
	font-weight: 600;
	background: transparent;
	border: none;
	transition: all 0.2s ease-in-out;
	cursor: pointer;
	white-space: nowrap !important;
}

.compact-action-btn .material-symbols-outlined {
	font-size: 1.1rem !important;
}

.compact-action-group {
	display: flex !important;
	flex-direction: row !important;
	align-items: center !important;
	gap: 0.4rem !important;
}

.feed-container-center {
	max-width: 650px;
	margin-left: auto;
	margin-right: auto;
}

.feed-wrapper-compact {
	gap: 0 !important;
}

.feed-wrapper-card {
	gap: 1.5rem !important;
}

.feed-wrapper-compact .compact-card:first-child {
	border-top-left-radius: 1rem !important;
	border-top-right-radius: 1rem !important;
}

.feed-wrapper-compact .compact-card:last-child {
	border-bottom-left-radius: 1rem !important;
	border-bottom-right-radius: 1rem !important;
	border-bottom: none;
}

.modal-close-btn {
	position: absolute;
	top: -40px;
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
	z-index: 1056;
}

.modal-close-btn:hover {
	background: rgba(255, 255, 255, 0.2);
	transform: scale(1.1);
}

.compact-meta-info {
	white-space: nowrap !important;
	flex-shrink: 0;
	min-width: 0;
}

.loading-bar-wrapper {
	width: 100%;
	padding: 20px 0;
	display: none; /* 기본 숨김 */
	justify-content: center;
}

.loading-bar-wrapper.active {
	display: flex;
}

.loading-bar {
	width: 50px;
	height: 4px;
	background: #a855f7;
	border-radius: 2px;
	animation: loading-expand 1s ease-in-out infinite;
	box-shadow: 0 0 10px #a855f7;
}

@
keyframes loading-expand { 0% {
	width: 50px;
	opacity: 0.5;
}
50
%
{
width
:
200px;
opacity
:
1;
}
100
%
{
width
:
50px;
opacity
:
0.5;
}
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
						<div
							class="col-12 col-lg-11 col-xl-10 mx-auto feed-container-center">

							<div
								class="filter-bar d-flex justify-content-between align-items-center px-2">
								<div
									class="d-flex align-items-center gap-4 text-sm fw-medium text-gray-500 text-uppercase tracking-widest">
									<span class="text-white fs-4 fw-bold">Latest Updates</span>
								</div>

								<div class="d-flex gap-2">
									<div class="dropdown">
										<button
											class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-2 rounded-pill shadow-sm"
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
											class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end shadow-lg">
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
											class="btn btn-sm text-white border border-secondary border-opacity-25 d-flex align-items-center gap-2 px-3 py-2 rounded-pill shadow-sm"
											style="background: rgba(0, 0, 0, 0.3);" type="button"
											data-bs-toggle="dropdown" aria-expanded="false">
											<span class="material-symbols-outlined fs-6">
												${viewMode == 'compact' ? 'view_list' : 'view_day'} </span>
										</button>
										<ul
											class="dropdown-menu dropdown-menu-dark glass-dropdown dropdown-menu-end shadow-lg">
											<li><a class="dropdown-item"
												href="javascript:changeView('card')">카드형</a></li>
											<li><a class="dropdown-item"
												href="javascript:changeView('compact')">축약형</a></li>
										</ul>
									</div>
								</div>
							</div>

							<div id="postListContainer"
								class="d-flex flex-column ${viewMode == 'compact' ? 'feed-wrapper-compact' : 'feed-wrapper-card'}">
								<c:if test="${empty list}">
									<div class="text-center py-5 glass-card shadow-lg rounded-4">
										<p class="text-white-50 fs-5">등록된 게시글이 없습니다.</p>
									</div>
								</c:if>

								<jsp:include page="../post/listPostData.jsp" />
							</div>

							<div id="infiniteLoadingBar" class="loading-bar-wrapper">
								<div class="loading-bar"></div>
							</div>

							<div id="scrollSentinel"></div>

						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<div class="modal fade" id="imageModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content bg-transparent border-0 position-relative">
				<button type="button" class="modal-close-btn"
					onclick="closeImageModal()">
					<span class="material-symbols-outlined fs-4">close</span>
				</button>
				<div class="modal-body p-0 text-center">
					<img id="modalImage" src="" class="img-fluid rounded-4 shadow-lg"
						style="max-height: 90vh;">
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="reportModal" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content glass-card border-0" style="background: rgba(30, 30, 30, 0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.1);">
	            <div class="modal-header border-bottom border-secondary">
	                <h5 class="modal-title text-white">게시글 신고</h5>
	                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body">
	                <input type="hidden" id="reportPostId">
	                <p class="text-gray-300 mb-3 small">신고 사유를 선택해주세요.</p>
	                
	                <select id="reportReasonSelect" class="form-select bg-dark text-white border-secondary mb-3" onchange="toggleReportReason(this)">
	                    <option value="">사유 선택...</option>
	                    <option value="스팸/홍보 도배">스팸/홍보 도배</option>
	                    <option value="욕설/비하 발언">욕설/비하 발언</option>
	                    <option value="음란물/유해 정보">음란물/유해 정보</option>
	                    <option value="custom">직접 입력</option>
	                </select>
	                
	                <textarea id="reportReasonText" class="form-control bg-dark text-white border-secondary" 
	                          rows="4" placeholder="신고 사유를 입력하세요..." style="display: none;"></textarea>
	            </div>
	            <div class="modal-footer border-top border-secondary">
	                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-danger btn-sm" onclick="submitReport()">신고하기</button>
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
		$(document).ready(function() {
		    // 세션에 저장된 메시지가 있다면 출력 (JSTL 사용)
		    const toastType = "${sessionScope.toastType}";
		    const toastMsg = "${sessionScope.toastMsg}";
		    
		    if(toastMsg) {
		        showToast(toastType, toastMsg);
		    }
		});
		</script>
		
		<c:remove var="toastMsg" scope="session" />
		<c:remove var="toastType" scope="session" />
	</c:if>

	<script>
		const isLogin = "${not empty sessionScope.member ? 'true' : 'false'}";
		const contextPath = "${pageContext.request.contextPath}";

		// Like Toggle
		function toggleLike(postId, btn) {
			if (isLogin === "false") {
				if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
					location.href = contextPath + '/member/login?redirect='
							+ encodeURIComponent(location.href);
				}
				return;
			}

			$.ajax({
				url : contextPath + "/post/insertPostLike",
				type : "post",
				data : {
					postId : postId
				},
				dataType : "json",
				success : function(data) {
					if (data.state === "success") {
						const $btn = $(btn);
						const $icon = $btn
								.find("span.material-symbols-outlined");
						const $count = $btn.find(".like-count");

						$count.text(data.likeCount);

						if (data.liked) {
							$icon.text("favorite");
							$btn.addClass("text-pink");
							showToast("success", "이 게시글을 좋아합니다.");
						} else {
							$icon.text("favorite_border");
							$btn.removeClass("text-pink");
							showToast("success", "좋아요를 취소했습니다.");
						}
					} else if (data.state === "login_required") {
						location.href = contextPath + '/member/login?redirect='
								+ encodeURIComponent(location.href);
						showToast("error", "로그인이 필요합니다.");
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		}

		function showToast(type, msg) {
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

		function goArticle(postId) {
			location.href = contextPath + '/post/article?postId=' + postId;
		}

		let myModalInstance = null;
		function showImageModal(imagePath) {
			if (!imagePath)
				return;
			let fullPath = "";
			if (imagePath.startsWith("http"))
				fullPath = imagePath;
			else
				fullPath = contextPath + '/uploads/photo/' + imagePath;
			document.getElementById('modalImage').src = fullPath;
			const modalElement = document.getElementById('imageModal');
			if (!myModalInstance)
				myModalInstance = new bootstrap.Modal(modalElement);
			myModalInstance.show();
		}
		function closeImageModal() {
			if (myModalInstance)
				myModalInstance.hide();
		}

		$(document).ready(function() {
			const carousels = document.querySelectorAll('.carousel');
			carousels.forEach(function(carousel) {
				carousel.addEventListener('slid.bs.carousel', function(e) {
					const $carousel = $(e.target);
					const $items = $carousel.find('.carousel-item');
					const totalItems = $items.length;
					const currentIndex = e.to;

					const $btnPrev = $carousel.find('.carousel-control-prev');
					const $btnNext = $carousel.find('.carousel-control-next');

					if (currentIndex === 0)
						$btnPrev.hide();
					else
						$btnPrev.css('display', 'flex');

					if (currentIndex === totalItems - 1)
						$btnNext.hide();
					else
						$btnNext.css('display', 'flex');
				});
			});
		});
	</script>

	<script>
		window.addEventListener('pageshow', function(event) {
			if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
				window.location.reload();
			}
		});
	</script>

	<script>
		let currentPage = 1;
		let isLoading = false;
		let isFinished = false;

		const urlParams = new URLSearchParams(window.location.search);
		const currentSort = urlParams.get('sort') || 'latest';
		const currentView = urlParams.get('view') || 'card';
		const currentKeyword = urlParams.get('keyword') || '';
		
		$(document).ready(function() {
	        if(currentKeyword) {
	            $("#totalSearchInput").val(currentKeyword);
	        }
	        
	        // 캐러셀 버튼 초기화
	        initCarouselButtons();
	    });
		
		const observerOptions = {
			root : null, 
			rootMargin : '0px',
			threshold : 0.1
		};

		
		const observer = new IntersectionObserver(function(entries, observer) {
			entries.forEach(function(entry) {
				
				if (entry.isIntersecting && !isLoading && !isFinished) {
					loadMorePosts();
				}
			});
		}, observerOptions); 

		document.addEventListener("DOMContentLoaded", function() {
			const sentinel = document.getElementById('scrollSentinel');
			if (sentinel) {
				observer.observe(sentinel);
			}
		});

		
		function loadMorePosts() {
			if (isFinished) return; 

			console.log("무한 스크롤 요청 시작: Page " + (currentPage + 1));

			isLoading = true;
			$('#infiniteLoadingBar').addClass('active');

			currentPage++;

			$.ajax({ 	url : '${pageContext.request.contextPath}/post/listPostAjax',
					 	type : 'GET',
						data : {
							page : currentPage,
							sort : currentSort,
							view : currentView,
							keyword : currentKeyword
						},

						success : function(data) {
							console.log("데이터 수신 성공. 길이: "
									+ (data ? data.length : 0));

							if (!data || data.trim() === "") {
								console.log("더 이상 데이터가 없습니다.");
								isFinished = true;
								const sentinel = document
										.getElementById('scrollSentinel');
								if (sentinel)
									observer.unobserve(sentinel);
							} else {
								
								var $tempHtml = $('<div>').html(data);

								var $items = $tempHtml
										.find('.feed-card, .compact-card')
										.add(
												$tempHtml
														.filter('.feed-card, .compact-card'));
	
								if ($items.length > 0) {
									console.log("게시글 " + $items.length
											+ "개 추출 성공. 화면에 추가합니다.");
									$('#postListContainer').append($items);
									
									initCarouselButtons();
								} else {
									
									console.log("게시글 카드를 찾을 수 없습니다. (로그인 페이지나 전체 페이지가 로드되었을 가능성)");

									if (data.indexOf("Welcome Back") > -1
											|| data.indexOf("로그인") > -1) {
									}
								}
							}
						},

						error : function(xhr, status, error) {
							console.error("데이터 로드 실패!");
							console.error("Status: " + status);
							console.error("Response: " + xhr.responseText);

							currentPage--; 
						},
						complete : function() {
							isLoading = false;
							setTimeout(function() {
								$('#infiniteLoadingBar').removeClass('active');
							}, 500);
						}
					});
		}

		function initCarouselButtons() {
			const carousels = document.querySelectorAll('.carousel');
			carousels.forEach(function(carousel) {
				$(carousel).off('slid.bs.carousel').on(
						'slid.bs.carousel',
						function(e) {
							const $carousel = $(e.target);
							const $items = $carousel.find('.carousel-item');
							const totalItems = $items.length;
							const currentIndex = e.to;

							const $btnPrev = $carousel
									.find('.carousel-control-prev');
							const $btnNext = $carousel
									.find('.carousel-control-next');

							if (currentIndex === 0)
								$btnPrev.hide();
							else
								$btnPrev.css('display', 'flex');

							if (currentIndex === totalItems - 1)
								$btnNext.hide();
							else
								$btnNext.css('display', 'flex');
						});
			});
		}
		// URL 복사 함수
		function copyUrl(postId) {
		    
		    const url = window.location.origin + '${pageContext.request.contextPath}/post/article?postId=' + postId;

		    if (navigator.clipboard && navigator.clipboard.writeText) {
		        navigator.clipboard.writeText(url).then(() => {
		        	showToast("success", "클립보드에 주소가 복사되었습니다.");
		        }).catch(err => {
		            // 실패 시 구형 방식 시도
		            fallbackCopyTextToClipboard(url);
		        });
		    } else {
		        // 구형 브라우저(또는 HTTP 환경) 대응
		        fallbackCopyTextToClipboard(url);
		    }
		}

		// 구형 브라우저용 복사 함수 (임시 textarea 생성 방식)
		function fallbackCopyTextToClipboard(text) {
		    const textArea = document.createElement("textarea");
		    textArea.value = text;
		    
		    // 화면 밖으로 숨김
		    textArea.style.position = "fixed";
		    textArea.style.left = "-9999px";
		    document.body.appendChild(textArea);
		    textArea.focus();
		    textArea.select();

		    try {
		        const successful = document.execCommand('copy');
		        if (successful) {
		        	showToast("success", "클립보드에 주소가 복사되었습니다.");
		        } else {
		        	showToast("error", "주소 복사에 실패했습니다.");
		        }
		    } catch (err) {
		    	showToast("error", "주소 복사에 실패했습니다.");
		    }
		    document.body.removeChild(textArea);
		}
		
		function openReportModal(postId) {			
			if (isLogin === "false") {
		        if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
		            location.href = contextPath + "/member/login";
		        }
		        return; 
		    }
			
		    $("#reportPostId").val(postId);
		    $("#reportReasonSelect").val("");
		    $("#reportReasonText").val("").hide();
		    
		    const myModal = new bootstrap.Modal(document.getElementById('reportModal'));
		    myModal.show();
		}

		function toggleReportReason(select) {
		    if(select.value === "custom") {
		        $("#reportReasonText").show().focus();
		    } else {
		        $("#reportReasonText").hide();
		    }
		}

		function submitReport() {
		    const postId = $("#reportPostId").val();
		    let reason = $("#reportReasonSelect").val();
		    
		    if(!reason) {
		        showToast("error", "신고 사유를 선택해주세요.");
		        return;
		    }
		    if(reason === "custom") {
		        reason = $("#reportReasonText").val().trim();
		        if(!reason) {
		            showToast("error", "상세 사유를 입력해주세요.");
		            return;
		        }
		    }
		    
		    $.ajax({
		        url: contextPath + "/post/report",
		        type: "post",
		        data: { postId: postId, reason: reason },
		        dataType: "json",
		        success: function(data) {
		            $('#reportModal').modal('hide');
		            if(data.state === "success") {
		                showToast("success", "신고가 접수되었습니다.");
		            } else if(data.state === "login_required") {
		                if(confirm("로그인이 필요합니다.")) location.href = contextPath + "/member/login";
		            } else {
		                showToast("error", "신고 실패");
		            }
		        },
		        error: function() { showToast("error", "서버 에러"); }
		    });
		}
		
	</script>
	
	
	
</body>
</html>