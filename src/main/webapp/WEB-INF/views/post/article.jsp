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
/* 1. 원본 디자인 CSS 유지 */
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
	background: transparent !important;
	border-bottom-color: #a855f7 !important;
	box-shadow: none !important;
	color: #fff !important;
}

.comment-input::placeholder {
	color: rgba(255, 255, 255, 0.4);
	text-align: left;
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
}

.hover-opacity-100:hover {
	opacity: 1 !important;
}

.text-pink {
	color: #ec4899 !important;
}

.carousel-control-prev, .carousel-control-next {
	width: 10%;
	opacity: 1;
}

.carousel-btn-glass {
	width: 40px;
	height: 40px;
	background: rgba(255, 255, 255, 0.1);
	backdrop-filter: blur(4px);
	border: 1px solid rgba(255, 255, 255, 0.2);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
}

.carousel-control-prev:hover .carousel-btn-glass, .carousel-control-next:hover .carousel-btn-glass
	{
	background: rgba(168, 85, 247, 0.6);
	border-color: #a855f7;
	transform: scale(1.1);
}

.image-wrapper {
	width: 100%;
	background-color: rgba(0, 0, 0, 0.2);
}

.form-control-sm {
	background-color: rgba(255, 255, 255, 0.05) !important;
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	color: white !important;
}

.form-control-sm:focus {
	border-color: #a855f7 !important;
	box-shadow: none !important;
}
</style>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		const carouselEl = document.getElementById('imageCarousel');
		if (!carouselEl)
			return;

		const items = carouselEl.querySelectorAll('.carousel-item');
		const btnPrev = document.getElementById('btnPrev');
		const btnNext = document.getElementById('btnNext');

		if (items.length <= 1) {
			if (btnPrev)
				btnPrev.style.display = 'none';
			if (btnNext)
				btnNext.style.display = 'none';
			return;
		}

		// 초기 상태: 첫 슬라이드이므로 Prev 숨김
		btnPrev.style.display = 'none';
		btnNext.style.display = 'flex';

		carouselEl.addEventListener('slid.bs.carousel', function(e) {
			const currentIndex = e.to;
			const lastIndex = items.length - 1;

			if (currentIndex === 0)
				btnPrev.style.display = 'none';
			else
				btnPrev.style.display = 'flex';

			if (currentIndex === lastIndex)
				btnNext.style.display = 'none';
			else
				btnNext.style.display = 'flex';
		});
	});
</script>
</head>
<body>

	<%@ include file="../home/header.jsp"%>

	<div class="app-body">

		<%@ include file="../home/sidebar.jsp"%>

		<main class="app-main">
		
			<div id="sessionToast" class="glass-toast shadow-lg">
	            <div class="d-flex align-items-center gap-3">
	               <div class="toast-icon-circle">
	                  <span id="toastIcon" class="material-symbols-outlined fs-5">info</span>
	               </div>
	               <div class="toast-content">
	                  <h4 id="toastTitle"
	                     class="text-xs fw-bold text-uppercase tracking-widest mb-1">System
	                  </h4>
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
													<c:choose>
														<%-- 1. http로 시작하면(클라우드/소셜) 그대로 출력 --%>
														<c:when
															test="${fn:startsWith(memberdto.profile_photo, 'http')}">
															<img src="${memberdto.profile_photo}"
																style="width: 100%; height: 100%; object-fit: cover;">
														</c:when>
														<%-- 2. 아니면 로컬 업로드 경로 붙여서 출력 --%>
														<c:otherwise>
															<img
																src="${pageContext.request.contextPath}/uploads/profile/${memberdto.profile_photo}"
																style="width: 100%; height: 100%; object-fit: cover;">
														</c:otherwise>
													</c:choose>
												</c:when>
												<%-- 3. 프로필 사진 없으면 기본 아이콘 --%>
												<c:otherwise>
													<span class="material-symbols-outlined fs-3">person</span>
												</c:otherwise>
											</c:choose>
										</div>

										<div>
											<h3 class="text-sm fw-medium text-white mb-0">${not empty memberdto.userNickname ? memberdto.userNickname : memberdto.userId}</h3>
											<p class="text-xs text-gray-500 mb-0">${dto.timeAgo}
												&bull; 조회 ${dto.viewCount}</p>
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
																	<c:when
																		test="${fn:startsWith(fileDto.filePath, 'http')}">
																		<img src="${fileDto.filePath}" class="d-block"
																			style="max-width: 100%; max-height: 100%; object-fit: contain;"
																			alt="Post Image">
																	</c:when>
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
													<span class="carousel-btn-glass"><span
														class="material-symbols-outlined fs-4">chevron_left</span></span>
												</button>
												<button class="carousel-control-next" type="button"
													data-bs-target="#imageCarousel" data-bs-slide="next"
													id="btnNext">
													<span class="carousel-btn-glass"><span
														class="material-symbols-outlined fs-4">chevron_right</span></span>
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
										<%-- [기능 연결] 좋아요 버튼: onClick 이벤트 & DTO 상태 반영 --%>
										<button type="button"
											class="d-flex align-items-center gap-2 btn btn-link text-decoration-none p-0 hover-pink ${dto.likedByUser ? 'text-pink' : 'text-white-50'}"
											onclick="sendLike('${dto.postId}', this)">
											<span class="material-symbols-outlined fs-5">${dto.likedByUser ? 'favorite' : 'favorite_border'}</span>
											<span class="small like-count">${dto.likeCount}</span>
										</button>

										<button
											class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-blue">
											<span class="material-symbols-outlined fs-5">chat_bubble_outline</span>
											<span class="small" id="postCommentCount">${dto.commentCount}</span>
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

									<div class="d-flex gap-2 mb-4 align-items-start">

										<div
											class="avatar-sm flex-shrink-0 d-flex align-items-center justify-content-center rounded-circle fw-bold text-white overflow-hidden"
											style="width: 32px; height: 32px; background: linear-gradient(45deg, #a855f7, #6366f1); font-size: 0.8rem;">

											<c:choose>
												<%-- 1. 세션에 프로필 사진(avatar)이 있는 경우 --%>
												<c:when test="${not empty sessionScope.member.avatar}">
													<c:choose>
														<%-- 외부 링크(http)인 경우 --%>
														<c:when
															test="${fn:startsWith(sessionScope.member.avatar, 'http')}">
															<img src="${sessionScope.member.avatar}"
																style="width: 100%; height: 100%; object-fit: cover;">
														</c:when>
														<%-- 내부 파일인 경우 --%>
														<c:otherwise>
															<img
																src="${pageContext.request.contextPath}/uploads/profile/${sessionScope.member.avatar}"
																style="width: 100%; height: 100%; object-fit: cover;">
														</c:otherwise>
													</c:choose>
												</c:when>
												<%-- 2. 프로필 사진이 없으면 기본 사람 아이콘 표시 --%>
												<c:otherwise>
													<span class="material-symbols-outlined"
														style="font-size: 1.2rem;">person</span>
												</c:otherwise>
											</c:choose>
										</div>


										<div class="flex-grow-1 position-relative">
											<input type="text" id="replyContent"
												class="form-control comment-input text-white border-0 border-bottom border-secondary rounded-0 px-0 py-1"
												style="background: transparent; font-size: 0.9rem; box-shadow: none;"
												placeholder="댓글을 입력하세요...">

											<button type="button" onclick="sendReply();"
												class="btn btn-sm btn-link text-decoration-none text-primary fw-bold position-absolute top-50 end-0 translate-middle-y p-0"
												style="font-size: 0.85rem;">게시</button>
										</div>
									</div>

									<div id="listReplyDiv" class="mt-4"></div>
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

	<script type="text/javascript">
		const isLogin = "${not empty sessionScope.member ? 'true' : 'false'}";
		const contextPath = "${pageContext.request.contextPath}";
		const postId = "${dto.postId}";

		$(function() {
			if ("${dto.replyEnabled}" != "0") {
				listReply();
			}
		});

		// ---------------------------------------------------
		// [1] 댓글 리스트 불러오기 & 개수 자동 갱신
		// ---------------------------------------------------
		function listReply() {
			let url = contextPath + "/post/listReply";

			// GET 방식으로 요청
			$("#listReplyDiv").load(url + "?postId=" + postId, function() {
				// ★ [핵심] 리스트 로드 완료 후, listReply.jsp에 숨겨둔 개수를 가져와서 메인 화면 갱신
				const newCount = $("#dynamicCommentCount").val();
				if (newCount) {
					$("#postCommentCount").text(newCount);
				}
			});
		}

		// ---------------------------------------------------
		// [2] 댓글 등록/수정/삭제 기능
		// ---------------------------------------------------

		// 2-1. 원본 댓글 등록
		function sendReply() {
			if (isLogin === "false") {
				if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
					location.href = contextPath + '/member/login?redirect='
							+ encodeURIComponent(location.href);
				}
				return;
			}

			const content = $("#replyContent").val().trim();
			if (!content) {
				alert("댓글 내용을 입력하세요.");
				$("#replyContent").focus();
				return;
			}

			$.ajax({
				url : contextPath + "/post/insertReply",
				type : "post",
				data : {
					postId : postId,
					content : content
				},
				success : function(data) {
					if (data.trim() === "success") {
						$("#replyContent").val("");
						listReply(); // 리스트 갱신 (개수도 같이 갱신됨)
						showToast("success", "댓글이 등록되었습니다.");
					} else if (data.trim() === "login_required") {
						location.href = contextPath + '/member/login';
					} else {
						showToast("error", "댓글 등록에 실패했습니다.");
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		}

		// 2-2. 대댓글(답글) 폼 열기/닫기
		function showReplyForm(commentId) {
			// 다른 열린 폼들 닫기
			$(".reply-form").not("#replyForm-" + commentId).hide();
			// 내 폼 토글
			const $form = $("#replyForm-" + commentId);
			$form.toggle();
		}

		// 2-3. 대댓글 등록
		function sendReplyAnswer(parentCommentId) {
			if (isLogin === "false") {
				alert("로그인이 필요합니다.");
				return;
			}

			const contentObj = $("#replyContent-" + parentCommentId);
			const content = contentObj.val().trim();

			if (!content) {
				alert("답글 내용을 입력하세요.");
				contentObj.focus();
				return;
			}

			$.ajax({
				url : contextPath + "/post/insertReply",
				type : "post",
				data : {
					postId : postId,
					content : content,
					parentCommentId : parentCommentId
				},
				success : function(data) {
					if (data.trim() === "success") {
						listReply();
						showToast("success", "답글이 등록되었습니다.");
					} else {
						showToast("error", "답글 등록 실패.");
					}
				}
			});
		}

		// 2-4. 댓글 수정 폼 열기/닫기 (toggleEdit)
		function toggleEdit(commentId) {
			const viewArea = $("#comment-view-" + commentId);
			const editArea = $("#comment-edit-" + commentId);

			// 수정 폼이 보이면 -> 닫기 (취소)
			if (editArea.is(":visible")) {
				editArea.hide();
				viewArea.show();
			} else {
				// 수정 폼이 안 보이면 -> 열기
				// (다른 열린 수정 폼들 닫기)
				$("[id^='comment-edit-']").hide();
				$("[id^='comment-view-']").show();

				viewArea.hide();
				editArea.show();
			}
		}

		// 2-5. 댓글 수정 처리 (updateReply)
		function updateReply(commentId) {
			const content = $("#editContent-" + commentId).val().trim();
			if (!content) {
				alert("수정할 내용을 입력하세요.");
				return;
			}

			$.ajax({
				url : contextPath + "/post/updateReply",
				type : "post",
				data : {
					commentId : commentId,
					content : content
				},
				success : function(data) {
					if (data.trim() === "success") {
						listReply(); // 성공 시 리스트 다시 불러옴
						showToast("success", "댓글이 수정되었습니다.");
					} else if (data.trim() === "login_required") {
						showToast("error", "로그인이 필요합니다.");
					} else {
						showToast("error", "수정 권한이 없거나 실패했습니다.");
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		}

		// 2-6. 댓글 삭제
		function deleteReply(commentId) {
			if (!confirm("댓글을 완전히 삭제하시겠습니까? (대댓글도 함께 삭제됩니다)"))
				return;

			$.ajax({
				url : contextPath + "/post/deleteReply",
				type : "post",
				data : {
					commentId : commentId
				},
				success : function(data) {
					if (data.trim() === "success") {
						listReply(); // 리스트 및 개수 갱신
						showToast("success", "댓글이 삭제되었습니다.");
					} else {
						alert("삭제 실패했습니다.");
						showToast("error", "삭제 실패했습니다.");
					}
				}
			});
		}

		// ---------------------------------------------------
		// [3] 기타 기능 (좋아요, 게시글 처리)
		// ---------------------------------------------------

		function sendLike(postId, btn) {
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
							$btn.removeClass("text-white-50");
							showToast("success", "이 게시글을 좋아합니다.");
						} else {
							$icon.text("favorite_border");
							$btn.removeClass("text-pink");
							$btn.addClass("text-white-50");
							showToast("success", "좋아요를 취소했습니다.");
						}
					} else if (data.state === "login_required") {
						location.href = contextPath + '/member/login?redirect='
								+ encodeURIComponent(location.href);
						showToast("error", "로그인이 필요합니다.");
					}
				}
			});
		}

		function sendCommentLike(commentId, btn) {
			if (isLogin === "false") {
				if (confirm("로그인이 필요합니다.")) {
					location.href = contextPath + '/member/login?redirect='
							+ encodeURIComponent(location.href);
				}
				return;
			}

			$.ajax({
				url : contextPath + "/post/insertCommentLike",
				type : "post",
				data : {
					commentId : commentId
				},
				dataType : "json",
				success : function(data) {
					if (data.state === "success") {
						const $btn = $(btn);
						const $icon = $btn
								.find("span.material-symbols-outlined");
						const $count = $btn.find(".like-count");

						// 0이면 '좋아요' 텍스트, 아니면 숫자
						$count
								.text(data.likeCount > 0 ? data.likeCount
										: "좋아요");

						if (data.liked) {
							$icon.text("favorite");
							$btn.addClass("text-pink");
							$btn.removeClass("text-secondary");
						} else {
							$icon.text("favorite_border");
							$btn.removeClass("text-pink");
							$btn.addClass("text-secondary");
						}
					}
				}
			});
		}

		function deletePost(postId) {
			if (confirm("게시글을 삭제하시겠습니까?")) {
				location.href = contextPath + '/post/delete?postId=' + postId;
			}
		}

		function updatePost(postId) {
			location.href = contextPath + '/post/update?postId=' + postId;
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
		
	</script>
</body>
</html>