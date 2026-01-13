<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3 d-flex justify-content-between align-items-end">
        <div>
            <h2 class="text-white fs-4 fw-bold mb-1">My Comments</h2>
            <p class="text-secondary text-sm mb-0">Review your cosmic conversations and thoughts.</p>
        </div>
        <span class="text-secondary text-xs pb-1">Total <span class="text-white fw-bold">84</span> Comments</span>
    </div>

    <div class="d-flex flex-column gap-3">
        
        <div class="record-item p-3 overflow-hidden cursor-pointer" onclick="location.href='#';">
            <div class="d-flex align-items-center gap-3 mb-3">
                <div class="record-thumbnail rounded-3" 
                     style="background-image: url('https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?auto=format&fit=crop&q=80&w=150');">
                </div>
                <div class="flex-grow-1 min-w-0">
                    <div class="d-flex align-items-center gap-2 mb-1 opacity-50">
                        <span class="text-white text-xs fw-bold">Cosmos_Explorer</span>
                        <span class="text-secondary text-xs">· Original Post</span>
                    </div>
                    <h4 class="text-white fs-6 fw-bold mb-0 text-truncate">신비로운 안드로메다 은하의 관측 기록</h4>
                </div>
            </div>

            <div class="d-flex gap-2 ps-2">
                <span class="text-secondary opacity-50" style="font-family: sans-serif;">ㄴ</span>
                <div class="comment-content-box p-3 rounded-3 flex-grow-1" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
                    <div class="d-flex justify-content-between align-items-start mb-1">
                        <span class="text-primary text-xs fw-bold">My Comment</span>
                        <span class="text-secondary text-xs opacity-50">2026.01.12</span>
                    </div>
                    <p class="text-white text-sm mb-0 opacity-85">정말 멋진 기록이네요! 저도 이번 주말에 망원경을 들고 나가봐야겠습니다. 좋은 정보 감사합니다.</p>
                </div>
            </div>
        </div>

        <div class="record-item p-3 overflow-hidden cursor-pointer" onclick="location.href='#';">
            <div class="d-flex align-items-center gap-3 mb-3">
                <div class="record-thumbnail rounded-3 d-flex align-items-center justify-content-center bg-white bg-opacity-5">
                    <span class="material-symbols-outlined text-white opacity-20" style="font-size: 20px;">article</span>
                </div>
                <div class="flex-grow-1 min-w-0">
                    <div class="d-flex align-items-center gap-2 mb-1 opacity-50">
                        <span class="text-white text-xs fw-bold">Nebula_Hunter</span>
                        <span class="text-secondary text-xs">· Original Post</span>
                    </div>
                    <h4 class="text-white fs-6 fw-bold mb-0 text-truncate">초보자를 위한 천체 망원경 구매 가이드</h4>
                </div>
            </div>

            <div class="d-flex gap-2 ps-2">
                <span class="text-secondary opacity-50">ㄴ</span>
                <div class="comment-content-box p-3 rounded-3 flex-grow-1" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
                    <div class="d-flex justify-content-between align-items-start mb-1">
                        <span class="text-primary text-xs fw-bold">My Comment</span>
                        <span class="text-secondary text-xs opacity-50">2026.01.10</span>
                    </div>
                    <p class="text-white text-sm mb-0 opacity-85">입문자에게 딱 필요한 정보들이네요. 혹시 100만원 이하 제품 중에서도 추천해주실 만한게 더 있을까요?</p>
                </div>
            </div>
        </div>

    </div>
</div>

<style>
/* 기존 record-item 스타일 계승 및 보정 */
.record-item {
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 16px;
    transition: all 0.2s ease;
}

.record-item:hover {
    background: rgba(255, 255, 255, 0.04);
    border-color: rgba(99, 102, 241, 0.2);
}

.cursor-pointer { cursor: pointer; }

.record-thumbnail {
    width: 45px;
    height: 45px;
    min-width: 45px;
    background-size: cover;
    background-position: center;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.text-primary { color: #818cf8 !important; }

.text-truncate {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* 댓글 박스 호버 효과 */
.record-item:hover .comment-content-box {
    border-color: rgba(99, 102, 241, 0.3) !important;
    background: rgba(255, 255, 255, 0.05) !important;
}
</style>