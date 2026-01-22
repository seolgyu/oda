<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>
<style type="text/css">
/* 1. 페이지 메인 컨테이너 */
.noti-page-container {
	width: 850px !important;
	margin: 0 auto;
	padding: 3rem 1.5rem;
	box-sizing: border-box;
}

/* 2. 상단 헤더 및 버튼 그룹 */
.noti-header-title {
	font-size: 1.8rem;
	letter-spacing: -1.2px;
	font-weight: 700;
	color: #fff;
	margin-bottom: 0.2rem;
}

.noti-action-group {
	display: flex;
	gap: 10px;
	align-items: center;
}

/* 1. 버튼 그룹 레이아웃 */
.noti-action-group {
	display: flex;
	gap: 10px;
	align-items: center;
}

/* 2. 전체 읽음 & 전체 삭제 공통 스타일 (회색조) */
.btn-read-all, .btn-delete-all {
	/* 기본 상태: 반투명하고 차분한 회색조 */
	background: rgba(255, 255, 255, 0.05) !important;
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	color: rgba(255, 255, 255, 0.5) !important;
	font-weight: 700 !important;
	padding: 0.5rem 1.2rem !important;
	border-radius: 50px !important;
	font-size: 0.8rem !important;
	cursor: pointer;
	/* 붕 뜨는 transform 효과 제외, 색상 변화에만 집중 */
	transition: background 0.2s ease, color 0.2s ease, border-color 0.2s
		ease !important;
}

/* 3. Hover 시 시각적 피드백 (회색조 내에서 선명해짐) */
.btn-read-all:hover, .btn-delete-all:hover {
	background: rgba(255, 255, 255, 0.12) !important;
	color: #ffffff !important;
	border-color: rgba(255, 255, 255, 0.3) !important;
}

/* 개별 버튼 호버 시 포인트 컬러 (선택 사항) */
.btn-read-all:hover {
	box-shadow: 0 0 15px rgba(99, 102, 241, 0.2); /* 은은한 보라색 광채 */
}

.btn-delete-all:hover {
	box-shadow: 0 0 15px rgba(244, 63, 94, 0.2); /* 은은한 빨간색 광채 */
}

/* 클릭 시 피드백 */
.btn-read-all:active, .btn-delete-all:active {
	background: rgba(255, 255, 255, 0.2) !important;
	transform: scale(0.97); /* 제자리에서 아주 살짝 눌림 */
}

/* 4. 알림 카드 (Glassmorphism) */
.full-noti-item {
	position: relative;
	display: flex;
	align-items: center;
	gap: 1.2rem;
	padding: 1.2rem;
	margin-bottom: 0.8rem;
	border-radius: 16px;
	border: 1px solid rgba(255, 255, 255, 0.1);
	background: rgba(255, 255, 255, 0.05);
	backdrop-filter: blur(20px);
	transition: all 0.3s ease;
	cursor: pointer;
	overflow: hidden;
}

.full-noti-item:hover {
	background: rgba(255, 255, 255, 0.08);
	border-color: rgba(255, 255, 255, 0.2);
}

.full-noti-item.unread::before {
	content: "";
	position: absolute;
	left: 0;
	top: 25%;
	height: 50%;
	width: 3px;
	background: #6366f1;
	border-radius: 0 4px 4px 0;
}

/* 5. 아바타 및 내부 요소 */
.noti-avatar-box {
	position: relative;
	width: 64px;
	height: 64px;
	flex-shrink: 0;
}

.noti-avatar-img {
	width: 100% !important;
	height: 100% !important;
	border-radius: 14px;
	object-fit: cover;
	border: 1px solid rgba(255, 255, 255, 0.1);
}

.noti-type-icon-badge {
	position: absolute;
	bottom: -3px;
	right: -3px;
	width: 24px;
	height: 24px;
	background: #0f0f14;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid rgba(255, 255, 255, 0.1);
}

.noti-content-area {
	flex-grow: 1;
	min-width: 0;
}

.noti-text {
	color: rgba(255, 255, 255, 0.75);
	font-size: 0.95rem;
	line-height: 1.4;
}

.noti-time-text {
	font-size: 0.75rem;
	color: rgba(255, 255, 255, 0.2);
	margin-top: 8px;
}

/* 6. 삭제 버튼 (개별 알림용) */
.btn-delete-noti {
	position: absolute;
	top: 0.6rem;
	right: 0.6rem;
	background: none;
	border: none;
	color: rgba(255, 255, 255, 0.2);
	opacity: 0;
	transition: opacity 0.2s ease, color 0.2s ease;
}

.full-noti-item:hover .btn-delete-noti {
	opacity: 1;
}

.btn-delete-noti:hover {
	color: #f43f5e;
}

/* 7. 알림 없음 (Empty State) */
.empty-noti-glass {
	background: rgba(255, 255, 255, 0.03);
	backdrop-filter: blur(15px);
	border: 1px solid rgba(255, 255, 255, 0.08);
	border-radius: 24px;
	padding: 4rem 2rem;
	margin: 2rem 0;
}

.empty-noti-icon {
	font-size: 64px !important;
	background: linear-gradient(135deg, #6366f1, #a855f7);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.noti-user-name {
	color: #efefff; /* 일반 텍스트보다 살짝 더 밝은 연보라빛 화이트 */
	font-weight: 800 !important; /* 아주 두껍게 */
	letter-spacing: -0.3px;
	/* 은은한 네온 효과로 시선 집중 */
	text-shadow: 0 0 8px rgba(168, 85, 247, 0.3);
	margin-right: 2px;
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

			<div class="feed-scroll-container custom-scrollbar">
				<div class="noti-page-container">
					<div class="d-flex justify-content-between align-items-center mb-5">
						<div>
							<h2 class="text-white fw-bold mb-1"
								style="font-size: 2.2rem; letter-spacing: -1.5px;">Notifications</h2>
							<p class="text-secondary mb-0">당신의 우주에서 일어난 새로운 활동들입니다.</p>
						</div>
						<div class="noti-action-group">
							<button type="button" class="btn btn-read-all"
								onclick="readAllNotifications()">전체 읽음 처리</button>
							<button type="button" class="btn btn-delete-all"
								onclick="deleteAllNotifications()">전체 삭제</button>
						</div>
					</div>

					<div id="fullNotiList">
						<c:choose>
							<c:when test="${not empty list}">
								<c:forEach var="dto" items="${list}">
									<div id="noti-${dto.notiId}"
										class="full-noti-item ${dto.checked ? 'read' : 'unread'}"
										onclick="handleNotiPageClick(event, this, '${dto.notiId}', '${dto.type}', '${dto.targetPost.postId}', '${dto.commentInfo.commentId}')">

										<div class="noti-avatar-box">
											<c:choose>
												<c:when test="${not empty dto.fromUserInfo.profile_photo}">
													<img src="${dto.fromUserInfo.profile_photo}"
														data-user-id="${dto.fromUserInfo.userId}"
														class="noti-avatar-img app-user-trigger">
												</c:when>

												<c:otherwise>
													<div
														class="noti-avatar-img d-flex align-items-center justify-content-center text-white fw-bold app-user-trigger"
														data-user-id="${dto.fromUserInfo.userId}"
														style="background: linear-gradient(135deg, #6366f1, #a855f7); font-size: 1.2rem; border: none;">
														<c:out
															value="${fn:substring(dto.fromUserInfo.userNickname, 0, 1).toUpperCase()}" />
													</div>
												</c:otherwise>
											</c:choose>

											<div class="noti-type-icon-badge">
												<c:choose>
													<c:when test="${dto.type == 'POST_LIKE'}">
														<i class="fa-solid fa-heart"
															style="color: #f43f5e; font-size: 13px;"></i>
													</c:when>

													<c:when test="${dto.type == 'FOLLOW'}">
														<i class="fa-solid fa-user-plus"
															style="color: #6366f1; font-size: 11px;"></i>
													</c:when>

													<c:when test="${dto.type == 'COMMENT'}">
														<i class="fa-solid fa-comment-dots"
															style="color: #10b981; font-size: 11px;"></i>
													</c:when>

													<c:when test="${dto.type == 'REPLY'}">
														<i class="fa-solid fa-reply"
															style="color: #3b82f6; font-size: 11px;"></i>
													</c:when>

													<c:otherwise>
														<i class="fa-solid fa-bell"
															style="color: #0ea5e9; font-size: 11px;"></i>
													</c:otherwise>
												</c:choose>
											</div>
										</div>

										<div class="noti-content-area">
											<div class="noti-text">
												<span class="noti-user-name app-user-trigger" data-user-id="${dto.fromUserInfo.userId}">
												${dto.fromUserInfo.userNickname}</span>님이
												${dto.content}
											</div>

											<c:if test="${not empty dto.targetPost.title}">
												<div class="noti-post-quote text-truncate"
													style="font-size: 0.75rem; color: rgba(255, 255, 255, 0.35); margin-top: 4px;">
													<span
														style="font-size: 0.65rem; margin-right: 4px; border: 1px solid rgba(255, 255, 255, 0.15); padding: 0px 3px; border-radius: 3px;">원문</span>
													${dto.targetPost.title}
												</div>
											</c:if>

											<c:if
												test="${(dto.type == 'COMMENT' || dto.type == 'REPLY') && not empty dto.commentInfo.content}">
												<div class="noti-comment-preview mt-1"
													style="font-size: 0.8rem; color: #a8a8b3; display: flex; gap: 4px; max-width: 100%;">
													<span style="flex-shrink: 0;">ㄴ</span> <span
														class="text-truncate" style="opacity: 0.9;"> "<c:out
															value="${dto.commentInfo.content}" />"
													</span>
												</div>
											</c:if>

											<div class="noti-time-text">${dto.createdDate}</div>
										</div>

										<c:if test="${!dto.checked}">
											<div class="unread-glow-dot"></div>
										</c:if>

										<button class="btn-delete-noti"
											onclick="event.stopPropagation(); removeNotiPage('${dto.notiId}', this);">
											<span class="material-symbols-outlined"
												style="font-size: 18px;">close</span>
										</button>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="text-center py-5 opacity-50 text-white">표시할
									알림이 없습니다.</div>
							</c:otherwise>
						</c:choose>
					</div>

					<div id="notiSentinel" style="height: 50px;"></div>
					<div id="notiLoader" class="text-center py-3"
						style="display: none;">
						<div class="spinner-border text-primary opacity-50" role="status"
							style="width: 1.5rem; height: 1.5rem;">
							<span class="visually-hidden">Loading...</span>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script
		src="${pageContext.request.contextPath}/dist/js/notification.js"></script>
	<script type="text/javascript">
	
	function handleNotiPageClick(e, element, notiId, type, postId, targetId) {
		if (e.target.closest('.app-user-trigger')) {
	        return;
	    }
		
	    const $el = $(element);
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/notification/readNoti',
	        type: 'POST',
	        data: { notiId: notiId },
	        success: function() {
	            $el.removeClass('unread').addClass('read');
	            $el.find('.unread-glow-dot').remove();

	            if (type === 'REPLY' || type === 'COMMENT') {
	            	location.href = '${pageContext.request.contextPath}/post/article?postId=' + postId + '&commentId=' + targetId;
	            }
	        },
	        error: function() {
	            if (type === 'REPLY' || type === 'COMMENT') {
	            	location.href = '${pageContext.request.contextPath}/post/article?postId=' + postId + '&commentId=' + targetId;
	            }
	        }
	    });
	}

	function removeNotiPage(notiId, btn) {
	    const $item = $(btn).closest('.full-noti-item');

	    $.ajax({
	        url: '${pageContext.request.contextPath}/notification/deleteNoti',
	        type: 'POST',
	        data: { notiId: notiId },
	        dataType: 'json',
	        success: function(data) {
	            if (data.status === "success") {
	                $item.animate({ 
	                    opacity: 0, 
	                    left: '20px' 
	                }, 300, function() {
	                    $(this).slideUp(250, function() { 
	                        $(this).remove(); 
	                        
	                        if ($('.full-noti-item').length === 0) {
	                            $('#fullNotiList').html('<div class="text-center py-5 opacity-50 text-white">표시할 알림이 없습니다.</div>');
	                        }
	                        
	                        updateUnreadCount();
	                    });
	                });
	            } else {
	                alert("알림 삭제에 실패했습니다.");
	            }
	        },
	        error: function() {
	            alert("서버 통신 중 오류가 발생했습니다.");
	        }
	    });
	}
	
	function readAllNotifications() {
	    if ($('.full-noti-item.unread').length === 0) {
	        if(typeof showToast === 'function') showToast("info", "새로 읽을 알림이 없습니다.");
	        return;
	    }

	    $.ajax({
	    	url: '${pageContext.request.contextPath}/notification/readNotiAll',
	        type: 'POST',
	        dataType: 'json',
	        success: function(data) {
	            if (data.status === "success") {
	                $('.full-noti-item').removeClass('unread').addClass('read');
	                
	                $('.unread-glow-dot').fadeOut(300, function() {
	                    $(this).remove();
	                });

	                if (typeof updateUnreadCount === 'function') {
	                    updateUnreadCount();
	                }

	                if(typeof showToast === 'function') showToast("success", "모든 알림을 읽음 처리했습니다.");
	            } else {
	                showToast("error" ,"처리 중 오류가 발생했습니다.");
	            }
	        },
	        error: function() {
	        	showToast("error" ,"서버 통신 중 오류가 발생했습니다.");
	        }
	    });
	}
	
	function deleteAllNotifications() {
	    if ($('.full-noti-item').length === 0) {
	        if(typeof showToast === 'function') showToast("info", "삭제할 알림이 없습니다.");
	        return;
	    }

	    if (!confirm("모든 알림을 삭제하시겠습니까?\n삭제된 알림은 복구할 수 없습니다.")) {
	        return;
	    }

	    $.ajax({
	        url: '${pageContext.request.contextPath}/notification/deleteNotiAll',
	        type: 'POST',
	        dataType: 'json',
	        success: function(data) {
	            if (data.status === "success") {
	                location.reload(); 
	            } else {
	                if(typeof showToast === 'function') showToast("error", "알림 전체 삭제에 실패했습니다.");
	            }
	        },
	        error: function() {
	            if(typeof showToast === 'function') showToast("error", "서버 통신 중 오류가 발생했습니다.");
	        }
	    });
	}
    </script>
</body>
</html>