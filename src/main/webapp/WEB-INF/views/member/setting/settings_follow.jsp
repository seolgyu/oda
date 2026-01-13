<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-1">
        <h2 class="text-white fs-4 fw-bold mb-3">Social Network</h2>
        
        <div class="d-flex gap-4">
            <button class="btn-tab active" onclick="switchSocialTab(this, 'following')">
                Following <span class="ms-1 opacity-50 text-xs">128</span>
            </button>
            <button class="btn-tab" onclick="switchSocialTab(this, 'followers')">
                Followers <span class="ms-1 opacity-50 text-xs">256</span>
            </button>
        </div>
    </div>

    <div id="social-list" class="d-flex flex-column gap-2">
        
        <div class="record-item d-flex align-items-stretch overflow-hidden">
            <div class="flex-grow-1 d-flex align-items-center gap-3 p-3">
                <div class="rounded-circle border border-white border-opacity-10" 
                     style="width: 50px; height: 50px; background-image: url('https://i.pravatar.cc/150?u=1'); background-size: cover;">
                </div>
                
                <div class="flex-grow-1 min-w-0">
                    <h4 class="text-white fs-6 fw-bold mb-0 text-truncate">Cosmos_Walker</h4>
                    <p class="text-secondary text-xs mb-0 opacity-50">Followed since 2026.01.05</p>
                </div>
            </div>

            <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
                <button type="button" class="btn-follow-status following" onclick="toggleFollow(this, 'user_01')">
                    Following
                </button>
            </div>
        </div>

        <div class="record-item d-flex align-items-stretch overflow-hidden">
            <div class="flex-grow-1 d-flex align-items-center gap-3 p-3">
                <div class="rounded-circle border border-white border-opacity-10" 
                     style="width: 50px; height: 50px; background-image: url('https://i.pravatar.cc/150?u=2'); background-size: cover;">
                </div>
                
                <div class="flex-grow-1 min-w-0">
                    <h4 class="text-white fs-6 fw-bold mb-0 text-truncate">Nebula_Hunter</h4>
                    <p class="text-secondary text-xs mb-0 opacity-50">Followed since 2025.12.20</p>
                </div>
            </div>

            <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
                <button type="button" class="btn-follow-status" onclick="toggleFollow(this, 'user_02')">
                    Follow
                </button>
            </div>
        </div>

    </div>
</div>

<style>
/* 탭 버튼 스타일 */
.btn-tab {
    background: none; border: none; padding: 10px 5px;
    color: rgba(255,255,255,0.5); font-weight: 600; font-size: 0.9rem;
    position: relative; transition: all 0.2s;
}
.btn-tab.active { color: #818cf8; }
.btn-tab.active::after {
    content: ''; position: absolute; bottom: -2px; left: 0;
    width: 100%; height: 2px; background: #818cf8;
}

/* 팔로우 버튼 공통 */
.btn-follow-status {
    width: 100px; padding: 6px 0; border-radius: 8px; font-size: 0.75rem; font-weight: 700;
    transition: all 0.2s; border: 1px solid #818cf8; background: #818cf8; color: white;
}
/* Following 상태 (아웃라인 스타일) */
.btn-follow-status.following {
    background: transparent; border-color: rgba(255,255,255,0.2); color: rgba(255,255,255,0.6);
}
.btn-follow-status.following:hover {
    background: rgba(220, 38, 38, 0.1); border-color: #dc3545; color: #dc3545;
}
.btn-follow-status.following:hover::after { content: ''; } /* 나중에 'Unfollow' 텍스트 변경용 */

/* 기존 클래스 상속 및 보정 */
.action-section { width: 140px; min-width: 140px; }
.record-item { background: rgba(255, 255, 255, 0.02); border: 1px solid rgba(255, 255, 255, 0.05); border-radius: 12px; }
</style>

<script>
// 탭 전환 핸들러
function switchSocialTab(btn, type) {
    $('.btn-tab').removeClass('active');
    $(btn).addClass('active');
    
    // AJAX로 데이터 필터링 요청 예시
    // loadSettings('${pageContext.request.contextPath}/member/settings/social?type=' + type);
}

// 팔로우 상태 토글
function toggleFollow(btn, userId) {
    const $btn = $(btn);
    if ($btn.hasClass('following')) {
        // Unfollow 처리 (AJAX 호출 후 성공 시)
        $btn.removeClass('following').text('Follow');
    } else {
        // Follow 처리 (AJAX 호출 후 성공 시)
        $btn.addClass('following').text('Following');
    }
}
</script>