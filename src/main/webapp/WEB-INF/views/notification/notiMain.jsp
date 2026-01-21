<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>
<style type="text/css">
/* 1. 페이지 메인 컨테이너 - 1000px에서 850px로 슬림화 */
.noti-page-container {
    width: 850px !important; 
    margin: 0 auto;
    padding: 3rem 1.5rem; /* 상하 여백 살짝 조절 */
    box-sizing: border-box;
}

/* 2. 상단 헤더 영역 스타일 */
.noti-header-title {
    font-size: 1.8rem; /* 2.2rem -> 1.8rem */
    letter-spacing: -1.2px;
    font-weight: 700;
    color: #fff;
    margin-bottom: 0.2rem;
}

.noti-header-subtitle {
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.95rem;
    margin-bottom: 0;
}

/* 3. 전체 읽음 처리 버튼 */
.btn-read-all {
    background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%) !important;
    border: none !important;
    color: white !important;
    font-weight: 700 !important;
    padding: 0.5rem 1.2rem !important; /* 패딩 슬림화 */
    border-radius: 50px !important;
    font-size: 0.8rem !important;
    transition: all 0.3s ease;
    box-shadow: 0 0 15px rgba(168, 85, 247, 0.4);
}

.btn-read-all:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 25px rgba(168, 85, 247, 0.6);
}

/* 4. 알림 카드 공통 스타일 */
.full-noti-item {
    position: relative;
    display: flex;
    align-items: center; /* 요소들 수직 중앙 정렬 */
    gap: 1.2rem; /* 1.5rem -> 1.2rem */
    padding: 1.2rem 3rem 1.2rem 1.2rem; /* 패딩 슬림화 */
    margin-bottom: 0.8rem; /* 카드 간격 축소 */
    border-radius: 16px; /* 20px -> 16px */
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(20px);
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    cursor: pointer;
    overflow: hidden;
}

/* 호버 애니메이션 */
.full-noti-item:hover {
    background: rgba(255, 255, 255, 0.08);
    transform: translateY(-3px);
    border-color: rgba(255, 255, 255, 0.2);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
}

/* 5. 상태별 스타일 (unread) */
.full-noti-item.unread {
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.12);
}

.full-noti-item.unread::before {
    content: "";
    position: absolute;
    left: 0;
    top: 25%;
    height: 50%;
    width: 3px; /* 4px -> 3px */
    background: #6366f1;
    border-radius: 0 4px 4px 0;
    box-shadow: 0 0 15px #6366f1;
}

.full-noti-item.read {
    background: rgba(255, 255, 255, 0.06);
    border: 1px solid rgba(255, 255, 255, 0.08);
}

/* 6. 아바타 및 이미지 - 80px에서 64px로 슬림화 */
.noti-avatar-box {
    position: relative;
    width: 64px; 
    height: 64px;
    flex-shrink: 0;
}

.noti-avatar-img {
    width: 100% !important;
    height: 100% !important;
    border-radius: 14px; /* 18px -> 14px */
    object-fit: cover;
    display: block;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

/* 아이콘 타입 배지 - 28px에서 24px로 슬림화 */
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
    z-index: 2;
}

/* 7. 텍스트 영역 및 인용구 */
.noti-content-area {
    flex-grow: 1;
    min-width: 0;
}

.noti-text {
    color: #efefff;
    font-size: 0.95rem; /* 1.05rem -> 0.95rem */
    margin: 0;
    line-height: 1.4;
}

.noti-text b {
    color: #fff;
    font-weight: 700;
}

.noti-post-quote {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.35);
    margin-top: 4px;
    display: block;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    border-left: 2px solid #a855f7;
    padding-left: 10px;
}

.noti-time-text {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.2);
    margin-top: 8px;
    display: block;
}

/* 8. 삭제 버튼 - 원래 디자인 및 위치 복구 */
.btn-delete-noti {
    position: absolute; 
    top: 0.6rem; 
    right: 0.6rem;
    background: none; 
    border: none; 
    color: rgba(255, 255, 255, 0.2);
    padding: 6px; 
    transition: all 0.2s ease; 
    opacity: 0; /* 평소엔 숨김 */
    z-index: 10;
}

.full-noti-item:hover .btn-delete-noti {
    opacity: 1; /* 호버 시 등장 */
}

.btn-delete-noti:hover {
    color: #f43f5e;
    transform: scale(1.2);
}

/* 안읽음 글로우 점 */
.unread-glow-dot {
    width: 8px; /* 10px -> 8px */
    height: 8px;
    background: #6366f1;
    border-radius: 50%;
    box-shadow: 0 0 12px #6366f1;
    flex-shrink: 0;
    margin-left: auto; 
    margin-right: 0.4rem;
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
						<button class="btn btn-read-all">전체 읽음 처리</button>
					</div>

					<div id="fullNotiList">
						<%-- 컨트롤러에서 담아준 "list" 변수를 직접 사용 --%>
						<c:forEach var="dto" items="${list}">
							<div id="noti-${dto.notiId}"
								class="full-noti-item ${dto.checked ? 'read' : 'unread'}"
								onclick="handleNotiPageClick(event, this, '${dto.notiId}', '${dto.type}', '${dto.targetPost.postId}')">

								<div class="noti-avatar-box">
									<c:choose>
										<c:when test="${not empty dto.fromUserInfo.profile_photo}">
											<img src="${dto.fromUserInfo.profile_photo}"
												class="noti-avatar-img">
										</c:when>

										<c:otherwise>
											<div
												class="noti-avatar-img d-flex align-items-center justify-content-center text-white fw-bold"
												style="background: linear-gradient(135deg, #6366f1, #a855f7); font-size: 1.2rem; border: none;">
												<c:out
													value="${fn:substring(dto.fromUserInfo.userNickname, 0, 1).toUpperCase()}" />
											</div>
										</c:otherwise>
									</c:choose>

									<div class="noti-type-icon-badge">
										<c:choose>
											<c:when test="${dto.type == 'POST_LIKE'}">
												<span class="material-symbols-outlined text-danger"
													style="font-size: 16px; font-variation-settings: 'FILL' 1;">favorite</span>
											</c:when>
											<c:when test="${dto.type == 'FOLLOW'}">
												<span class="material-symbols-outlined text-primary"
													style="font-size: 16px; font-variation-settings: 'FILL' 1;">person_add</span>
											</c:when>
											<c:when test="${dto.type == 'COMMENT'}">
												<span class="material-symbols-outlined text-success"
													style="font-size: 16px; font-variation-settings: 'FILL' 1;">chat_bubble</span>
											</c:when>
											<c:otherwise>
												<span class="material-symbols-outlined text-info"
													style="font-size: 16px; font-variation-settings: 'FILL' 1;">notifications</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="noti-content-area">
									<div class="noti-text">
										<b>${dto.fromUserInfo.userNickname}</b>님이 ${dto.content}
									</div>
									<c:if test="${not empty dto.targetPost.title}">
										<div class="noti-post-quote text-truncate">"${dto.targetPost.title}"</div>
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

	<script type="text/javascript">
    	window.contextPath = '${pageContext.request.contextPath}';
	</script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/notification.js"></script>
	<script type="text/javascript">
	
	function handleNotiPageClick(e, element, notiId, type, postId) {
	    const $el = $(element);
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/notification/readNoti',
	        type: 'POST',
	        data: { notiId: notiId },
	        success: function() {
	            $el.removeClass('unread').addClass('read');
	            $el.find('.unread-glow-dot').remove();

	            if (type === 'REPLY' || type === 'COMMENT') {
	                location.href = '${pageContext.request.contextPath}/post/article?postId=' + postId;
	            }
	        },
	        error: function() {
	            if (type === 'REPLY' || type === 'COMMENT') {
	                location.href = '${pageContext.request.contextPath}/post/article?postId=' + postId;
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
    </script>
</body>
</html>