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

.action-btn-hover.btn-repost:hover {
    color: #4ade80 !important;              
    background: rgba(74, 222, 128, 0.1) !important; 
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

.video-sound-btn {
    position: absolute;
    bottom: 15px;
    right: 15px;
    width: 32px;
    height: 32px;
    background: rgba(0, 0, 0, 0.6);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    z-index: 10;
    color: white;
    transition: background 0.2s;
}
.video-sound-btn:hover {
    background: rgba(0, 0, 0, 0.8);
}
.video-sound-btn span {
    font-size: 18px;
}

@keyframes loading-expand { 
	0% { width: 50px; opacity: 0.5; } 
	50% { width:200px; opacity:1; }
	100% { width:50px; opacity:0.5; }
}

</style>
</head>
<body>

	<%@ include file="header.jsp"%>

	<div class="app-body">
		<%@ include file="sidebar.jsp"%>

		<main class="app-main">

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

	<div id="imageModal" class="modal fade" tabindex="-1" aria-hidden="true" onclick="closeImageModal()">
	    <div class="modal-dialog modal-dialog-centered modal-lg">
	        <div class="modal-content bg-transparent border-0">
	            <div class="modal-body p-0 text-center position-relative">
	                
	                <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3" 
	                        style="z-index: 10;" onclick="closeImageModal()" aria-label="Close"></button>
	                
	                <img id="modalImage" src="" class="img-fluid rounded shadow-lg" style="max-height: 85vh; display: none;">
	                
	                <video id="modalVideo" src="" class="img-fluid rounded shadow-lg" 
	                       style="max-height: 85vh; display: none;" 
	                       controls autoplay playsinline muted>
	                </video>
	
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
		
		function showImageModal(url, type) {
		    const modal = new bootstrap.Modal(document.getElementById('imageModal'));
		    const $img = $('#modalImage');
		    const $video = $('#modalVideo');
		    const videoElement = $video[0]; // DOM 객체 가져오기

		    // 1. 화면 초기화
		    $img.hide();
		    $video.hide();
		    
		    // 2. 기존 재생 중지 및 초기화 (매우 중요)
		    videoElement.pause();
		    videoElement.currentTime = 0;
		    videoElement.removeAttribute('src'); // 기존 소스 제거

		    if (type === 'video') {
		        // [동영상 모드]
		        console.log("모달 동영상 재생 시도: " + url);
		        
		        $video.attr('src', url); // 새 주소 할당
		        $video.show();
		        
		        // ★ 소리 끄기 (자동 재생 정책 준수)
		        videoElement.muted = true;
		        
		        // 약간의 딜레이 후 재생 (모달이 완전히 뜬 뒤 실행)
		        setTimeout(() => {
		            const playPromise = videoElement.play();
		            if (playPromise !== undefined) {
		                playPromise.then(() => {
		                    console.log("모달 재생 성공");
		                }).catch(error => {
		                    console.log("모달 재생 실패(브라우저 차단):", error);
		                });
		            }
		        }, 300);
		        
		    } else {
		        // [이미지 모드]
		        $img.attr('src', url);
		        $img.show();
		    }
		    
		    modal.show();
		}			
		
		function closeImageModal() {
		    const video = document.getElementById('modalVideo');
		    if (video) {
		        video.pause();
		    }
		    $('#imageModal').modal('hide');
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
		
		/* 동영상 자동 재생 및 우선순위 관리 스크립트 */
		document.addEventListener("DOMContentLoaded", function() {
		    // 1. 현재 화면에 50% 이상 들어온 비디오들을 담아둘 목록 (Set)
		    const visibleVideos = new Set();

		    const observerOptions = {
		        root: null, // 뷰포트 기준
		        rootMargin: '0px',
		        threshold: 0.5 // [중요] 50% 이상 보이면 감지 (0.7은 너무 빡빡해서 잘 안될 수 있음)
		    };

		    const videoObserver = new IntersectionObserver((entries) => {
		        entries.forEach(entry => {
		            if (entry.isIntersecting) {
		                // 화면에 들어왔으면 목록에 추가
		                visibleVideos.add(entry.target);
		            } else {
		                // 화면에서 나가면 목록에서 제거하고 즉시 정지
		                visibleVideos.delete(entry.target);
		                entry.target.pause();
		            }
		        });

		        // [핵심 로직] 화면에 보이는 비디오들 중 '대장(가장 위에 있는 것)'을 뽑아서 재생
		        handleAutoPlay();

		    }, observerOptions);

		    // 우선순위 결정 및 재생 함수
		    function handleAutoPlay() {
		        if (visibleVideos.size === 0) return;

		        // Set을 배열로 변환
		        const videosArr = Array.from(visibleVideos);

		        // [정렬] 화면 위쪽(top) 좌표가 작을수록 위에 있는 동영상임
		        videosArr.sort((a, b) => {
		            return a.getBoundingClientRect().top - b.getBoundingClientRect().top;
		        });

		        // 1등(가장 위에 있는 비디오) 선정
		        const topVideo = videosArr[0];

		        // 1등만 재생
		        const playPromise = topVideo.play();
		        if (playPromise !== undefined) {
		            playPromise.catch(e => { 
		                // 브라우저 정책상 사용자가 클릭하기 전에는 자동재생을 막는 경우가 있음 (콘솔 로그 생략)
		            });
		        }

		        // 나머지 모든 비디오(1등이 아닌 애들)는 강제 정지
		        document.querySelectorAll('video.feed-video').forEach(v => {
		            if (v !== topVideo) {
		                v.pause();
		            }
		        });
		    }

		    // [MutationObserver] 무한 스크롤로 새로 생긴 동영상 감지
		    // '#list-container'는 게시글 목록을 감싸는 div의 ID입니다. (page.jsp나 main.jsp 구조 확인 필요)
		    // 만약 ID를 모른다면 document.body로 설정해도 되지만, 성능을 위해 정확한 컨테이너가 좋습니다.
		    const feedContainer = document.getElementById('list-container') || document.body;

		    const mutationObserver = new MutationObserver((mutations) => {
		        mutations.forEach((mutation) => {
		            mutation.addedNodes.forEach((node) => {
		                if (node.nodeType === 1) { // 요소 노드만
		                    // 새로 추가된 요소 안에 있는 비디오 찾아서 관찰 시작
		                    const videos = node.querySelectorAll('video.feed-video');
		                    videos.forEach(v => videoObserver.observe(v));
		                }
		            });
		        });
		    });

		    // 감시 시작
		    mutationObserver.observe(feedContainer, { childList: true, subtree: true });

		    // 처음에 이미 로딩된 비디오들도 관찰 시작
		    document.querySelectorAll('video.feed-video').forEach(v => videoObserver.observe(v));
		});

		// 마우스 호버 시 컨트롤바 표시/숨김 관리
		function showVideoControls(container) {
		    const video = $(container).find('video')[0];
		    const soundBtn = $(container).find('.video-sound-btn');
		    
		    // 비디오 태그가 없으면(이미지인 경우) 리턴
		    if (!video) return;

		    // 1. 브라우저 기본 컨트롤바 활성화 (재생바, 전체화면 등 나옴)
		    video.setAttribute("controls", "controls");
		    
		    // 2. 컨트롤바랑 겹치니까 우리가 만든 소리 버튼은 잠시 숨김
		    soundBtn.hide();
		}

		function hideVideoControls(container) {
		    const video = $(container).find('video')[0];
		    const soundBtn = $(container).find('.video-sound-btn');
		    
		    if (!video) return;

		    // [중요] 전체화면 모드일 때는 컨트롤바를 없애면 안 됨!
		    if (!document.fullscreenElement) {
		        // 1. 컨트롤바 제거
		        video.removeAttribute("controls");
		        
		        // 2. 소리 버튼 다시 표시
		        soundBtn.show();
		    }
		}
		
		// 소스 아이콘 토글 함수
		function toggleSound(btn, event) {
		    event.stopPropagation(); // 카드 클릭 이벤트 방지
		    const video = $(btn).prev('video')[0];
		    const icon = $(btn).find('span');
		    
		    if (video.muted) {
		        video.muted = false;
		        icon.text("volume_up");
		    } else {
		        video.muted = true;
		        icon.text("volume_off");
		    }
		}

		
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
		
		
		function toggleSave(postId, btn) {
			if (isLogin === "false") {
	            if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
	                location.href = contextPath + "/member/login";
	            }
	            return;
	        }

	        $.ajax({
	            url: "${pageContext.request.contextPath}/post/insertPostSave",
	            type: "post",
	            data: { postId: postId },
	            dataType: "json",
	            success: function(data) {
	                if (data.state === "success") {
	                    const $btn = $(btn);
	                    const $icon = $btn.find("span.material-symbols-outlined");
	                    
	                    if (data.saved) {
	                       
	                        $icon.text("bookmark");
	                        $btn.addClass("text-warning");
	                        showToast("success", "게시글을 저장했습니다.");
	                    } else {
	                        
	                        $icon.text("bookmark_border");
	                        $btn.removeClass("text-warning");
	                        showToast("info", "저장을 취소했습니다.");
	                    }
	                } else if (data.state === "login_required") {
	                    location.href = "${pageContext.request.contextPath}/member/login";
	                }
	            },
	            error: function(e) {
	                console.log(e);
	            }
	        });
	    }
	 
	    function toggleRepost(postId, btn) {
	    	if (isLogin === "false") {
	            if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
	                location.href = contextPath + "/member/login";
	            }
	            return;
	        }
	        $.ajax({
	            url: "${pageContext.request.contextPath}/post/insertPostRepost",
	            type: "post",
	            data: { postId: postId },
	            dataType: "json",
	            success: function(data) {
	                if (data.state === "success") {
	                    const $btn = $(btn);
	                    
	                    if (data.reposted) {
	                        
	                        $btn.addClass("text-success");
	                        showToast("success", "게시글을 리그렘했습니다.");
	                    } else {
	                       
	                        $btn.removeClass("text-success");
	                        showToast("info", "리그렘을 취소했습니다.");
	                    }
	                } else if (data.state === "login_required") {
	                    location.href = "${pageContext.request.contextPath}/member/login";
	                }
	            },
	            error: function(e) {
	                console.log(e);
	            }
	        });
	    }
	    
	    
	    
	    
	</script>
	
	
	
</body>
</html>