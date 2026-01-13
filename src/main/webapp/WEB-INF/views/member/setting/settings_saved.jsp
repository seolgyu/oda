<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3 d-flex justify-content-between align-items-end">
        <div>
            <h2 class="text-white fs-4 fw-bold mb-1">Saved Posts</h2>
            <p class="text-secondary text-sm mb-0">Your personal library of cosmic discoveries.</p>
        </div>
        <span class="text-secondary text-xs pb-1">Total <span class="text-white fw-bold">42</span></span>
    </div>

    <div class="d-flex flex-column gap-2">
        
        <div class="record-item d-flex align-items-stretch overflow-hidden">
            <div class="flex-grow-1 d-flex align-items-center gap-3 p-3 cursor-pointer item-content" onclick="location.href='#';">
                <div class="record-thumbnail rounded-3" 
                     style="background-image: url('https://images.unsplash.com/photo-1464802686167-b939a6910659?auto=format&fit=crop&q=80&w=150');">
                </div>
                
                <div class="flex-grow-1 min-w-0">
                    <div class="d-flex align-items-center gap-2 mb-1 opacity-75">
                        <span class="text-white text-xs fw-bold">Star_Observer</span>
                        <span class="text-secondary text-xs">· 2026.01.05</span>
                    </div>
                    <h4 class="text-white fs-6 fw-bold mb-1 text-truncate">제임스 웹 망원경이 포착한 심우주의 신비</h4>
                    <p class="text-secondary text-xs mb-0 text-truncate opacity-50">가장 먼 우주에서 날아온 빛의 기록들을 정리했습니다...</p>
                </div>
            </div>

            <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
                <button type="button" class="btn-save-toggle" onclick="toggleSave(this, 'post_s01')">
                    <span class="material-symbols-outlined fill-icon text-primary">bookmark</span>
                </button>
            </div>
        </div>

        <div class="record-item d-flex align-items-stretch overflow-hidden">
            <div class="flex-grow-1 d-flex align-items-center gap-3 p-3 cursor-pointer item-content" onclick="location.href='#';">
                <div class="record-thumbnail rounded-3 d-flex align-items-center justify-content-center bg-white bg-opacity-5">
                    <span class="material-symbols-outlined text-white opacity-20" style="font-size: 20px;">menu_book</span>
                </div>
                
                <div class="flex-grow-1 min-w-0">
                    <div class="d-flex align-items-center gap-2 mb-1 opacity-75">
                        <span class="text-white text-xs fw-bold">Galactic_Guide</span>
                        <span class="text-secondary text-xs">· 2026.01.02</span>
                    </div>
                    <h4 class="text-white fs-6 fw-bold mb-1 text-truncate">우리 은하 내 거주 가능 행성 탐사 리포트</h4>
                    <p class="text-secondary text-xs mb-0 text-truncate opacity-50">생명체가 존재할 확률이 높은 외계 행성 5곳의 특징입니다.</p>
                </div>
            </div>

            <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
                <button type="button" class="btn-save-toggle" onclick="toggleSave(this, 'post_s02')">
                    <span class="material-symbols-outlined fill-icon text-primary">bookmark</span>
                </button>
            </div>
        </div>

    </div>
</div>

<style>
/* 기존 record-item 스타일 계승 */
.record-item {
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 12px;
    transition: all 0.2s ease;
}
.record-item:hover {
    background: rgba(255, 255, 255, 0.05);
}

.record-thumbnail {
    width: 50px; height: 50px; min-width: 50px;
    background-size: cover; background-position: center;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.action-section {
    width: 80px; min-width: 80px;
}

.btn-save-toggle {
    background: none; border: none; padding: 10px;
    border-radius: 50%; transition: all 0.2s;
    display: flex; align-items: center; justify-content: center;
}
.btn-save-toggle:hover {
    background: rgba(99, 102, 241, 0.15);
}

.fill-icon {
    font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;
}

.text-primary { color: #818cf8 !important; } /* 북마크 강조색 */
</style>

<script>
function toggleSave(btn, postId) {
    const icon = $(btn).find('.material-symbols-outlined');
    
    if (icon.css('font-variation-settings').includes("'FILL' 1")) {
        // 저장 취소
        icon.css('font-variation-settings', "'FILL' 0");
        icon.removeClass('text-primary').addClass('text-secondary');
        $(btn).closest('.record-item').css('opacity', '0.5');
    } else {
        // 다시 저장
        icon.css('font-variation-settings', "'FILL' 1");
        icon.addClass('text-primary').removeClass('text-secondary');
        $(btn).closest('.record-item').css('opacity', '1');
    }
}
</script>