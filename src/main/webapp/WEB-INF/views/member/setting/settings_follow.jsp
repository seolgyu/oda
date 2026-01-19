<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="glass-card p-4 shadow-lg mx-auto"
	style="width: 820px; min-width: 820px; max-width: 100%;">
	<div class="mb-4 border-bottom border-white border-opacity-10 pb-1">
		<h2 class="text-white fs-4 fw-bold mb-3">Social Network</h2>

		<div class="d-flex gap-4" id="social-tabs">
			<%-- 카운트 영역에 id를 부여하여 JS에서 접근하기 쉽게 수정했습니다. --%>
			<button class="btn-tab ${type eq 'follower' ? 'active' : ''}"
				onclick="switchSocialTab(this, 'follower')">
				Followers <span id="follower-count-display"
					class="ms-1 opacity-50 text-xs count-area">${followerCount}</span>
			</button>
			<button class="btn-tab ${type eq 'following' ? 'active' : ''}"
				onclick="switchSocialTab(this, 'following')">
				Following <span id="following-count-display"
					class="ms-1 opacity-50 text-xs count-area">${followingCount}</span>
			</button>
		</div>
	</div>

	<div class="d-flex flex-column gap-2 list-container">
		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="dto" items="${list}">
					<div
						class="record-item d-flex align-items-stretch overflow-hidden shadow-sm mb-1">
						<div class="flex-grow-1 d-flex align-items-center gap-3 p-3">
							<div
								class="rounded-circle border border-white border-opacity-10 shadow-sm overflow-hidden flex-shrink-0 d-flex align-items-center justify-content-center app-user-trigger" data-user-id="${dto.userId}"
								style="width: 50px; height: 50px; background: linear-gradient(135deg, #6366f1, #a855f7);">
								<c:choose>
									<c:when test="${not empty dto.userProfile}">
										<img src="${dto.userProfile}" alt="Profile"
											class="w-100 h-100 object-fit-cover">
									</c:when>
									<c:otherwise>
										<span class="text-white fw-bold" style="font-size: 1.2rem;">
											${fn:substring(dto.userNickname, 0, 1)} </span>
									</c:otherwise>
								</c:choose>
							</div>

							<div class="flex-grow-1 min-w-0">
								<h4 class="text-white fs-6 fw-bold mb-0 text-truncate app-user-trigger" data-user-id="${dto.userId}">${dto.userNickname}</h4>
								<p class="text-secondary text-xs mb-0 opacity-50">c/${dto.userId}
									• ${dto.registerDate}</p>
							</div>
						</div>

						<div
							class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
							<c:set var="targetNum"
								value="${type eq 'follower' ? dto.reqId : dto.addId}" />
							<c:set var="isFollowing"
								value="${type eq 'following' || dto.followStatus}" />

							<%-- follow.js 규격: toggleFollow(addUserNum, btn) --%>
							<button type="button"
								class="btn-follow-status ${isFollowing ? 'btn-following' : ''}"
								onclick="toggleFollow('${targetNum}', this)">
								${isFollowing ? 'Following' : 'Follow'}</button>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="text-center py-5 opacity-50 empty-msg">리스트가
					비어있습니다.</div>
			</c:otherwise>
		</c:choose>
	</div>

	<div id="sentinel" style="height: 20px;"></div>
</div>

<style>
/* 탭 버튼 스타일 */
.btn-tab {
	background: none;
	border: none;
	padding: 10px 5px;
	color: rgba(255, 255, 255, 0.5);
	font-weight: 600;
	font-size: 0.9rem;
	position: relative;
	transition: all 0.2s;
}

.btn-tab.active {
	color: #818cf8;
}

.btn-tab.active::after {
	content: '';
	position: absolute;
	bottom: -2px;
	left: 0;
	width: 100%;
	height: 2px;
	background: #818cf8;
}

/* 팔로우 전: 보라색 그라데이션 */
.btn-follow-status {
	width: 100px;
	padding: 6px 0;
	border-radius: 20px;
	font-size: 0.75rem;
	font-weight: 700;
	transition: all 0.3s ease;
	background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%) !important;
	border: none !important;
	color: white !important;
}

.btn-follow-status:not(.btn-following):hover {
	filter: brightness(1.1);
	transform: translateY(-1px);
	box-shadow: 0 4px 12px rgba(168, 85, 247, 0.4);
}

/* 팔로우 중(Following): 어둡고 반투명한 디자인 고정 */
.btn-follow-status.btn-following {
	background: rgba(255, 255, 255, 0.1) !important;
	border: 1px solid rgba(255, 255, 255, 0.2) !important;
	color: rgba(255, 255, 255, 0.6) !important;
	box-shadow: none !important;
}

.btn-follow-status.btn-following:hover {
	background: rgba(255, 255, 255, 0.15) !important;
	color: #ffffff !important;
}

.action-section {
	width: 140px;
	min-width: 140px;
}

.record-item {
	background: rgba(255, 255, 255, 0.02);
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 12px;
}
</style>

<script>
window.currentSocialType = '${type}'; 

// [수정] follow.js의 성공 콜백에서 카운트까지 업데이트하도록 함수를 래핑하거나 재정의
// 이미 외부 js를 가져오고 있다면, 해당 js의 성공 로직 뒤에 카운트 반영 코드가 필요합니다.
// 여기서는 버튼 클릭 시 상단 카운트를 즉시 반영하기 위한 추가 로직을 포함합니다.

function updateTabCounts(isFollowing) {
    const $followingCount = $('#following-count-display');
    let count = parseInt($followingCount.text());
    
    if (isFollowing) {
        $followingCount.text(count + 1);
    } else {
        $followingCount.text(Math.max(0, count - 1));
    }
}

const originalToggleFollow = window.toggleFollow;
window.toggleFollow = function(addUserNum, btn) {
    const $btn = $(btn);
    const wasFollowing = $btn.hasClass('btn-following');
    
    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            if (mutation.attributeName === 'class') {
                const isNowFollowing = $btn.hasClass('btn-following');
                if (wasFollowing !== isNowFollowing) {
                    updateTabCounts(isNowFollowing);
                    observer.disconnect();
                }
            }
        });
    });
    
    observer.observe(btn, { attributes: true });
    originalToggleFollow(addUserNum, btn);
};

$(function() {
    if (window.io) window.io.disconnect();
    window.page = 1; window.isLoading = false;
    const target = document.getElementById('sentinel');
    if (target) {
        window.io = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting && !window.isLoading) {
                    loadNextPage('/member/settings/loadFollowList?type=' + window.currentSocialType, renderFollowItem);
                }
            });
        }, observerOptions);
        window.io.observe(target);
    }
});

function switchSocialTab(btn, type) {
    if (window.currentSocialType === type) return;
    $('#social-tabs .btn-tab').removeClass('active');
    $(btn).addClass('active');

    window.currentSocialType = type;
    window.page = 1; window.isLoading = false;
    const $container = $('.list-container');
    
    $container.css('opacity', '0.3');

    $.ajax({
        url: window.cp + "/member/settings/loadFollowList",
        type: "GET",
        data: { type: type, page: 1 },
        dataType: "json",
        success: function(data) {
            // 탭 전환 시 카운트 정보가 서버에서 온다면 최신화
            if(data.followerCount !== undefined) $('#follower-count-display').text(data.followerCount);
            if(data.followingCount !== undefined) $('#following-count-display').text(data.followingCount);

            if (data.status === "success" && data.list && data.list.length > 0) {
                let html = "";
                data.list.forEach(item => { html += renderFollowItem(item); });
                $container.html(html);
                if(window.io) window.io.observe(document.getElementById('sentinel'));
            } else {
                $container.html('<div class="text-center py-5 opacity-50 empty-msg">리스트가 비어있습니다.</div>');
            }
        },
        complete: function() {
            $container.css('opacity', '1');
        }
    });
}
</script>