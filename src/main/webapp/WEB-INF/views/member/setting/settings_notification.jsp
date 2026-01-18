<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
        <h2 class="text-white fs-4 fw-bold mb-1">Notification Settings</h2>
        <p class="text-secondary text-sm mb-0">Customize your interstellar communication channels.</p>
    </div>
    
    <div class="d-flex flex-column gap-3">
        
        <div class="d-flex justify-content-between align-items-center p-3 rounded-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
            <div class="d-flex align-items-center gap-3">
                <span class="material-symbols-outlined" style="color: #a78bfa; font-size: 24px;">favorite</span>
                <div>
                    <h4 class="text-white fs-6 mb-0">좋아요 알림</h4>
                    <p class="text-secondary text-xs mb-0">내 게시글에 누군가 좋아요를 남기면 알림을 받습니다.</p>
                </div>
            </div>
            <label class="noti-switch-container">
                <input type="checkbox" class="noti-toggle-input" data-type="like" ${options.allowLike ? 'checked' : ''}>
                <span class="noti-switch-slider"></span>
            </label>
        </div>

        <div class="d-flex justify-content-between align-items-center p-3 rounded-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
            <div class="d-flex align-items-center gap-3">
                <span class="material-symbols-outlined" style="color: #a78bfa; font-size: 24px;">chat_bubble</span>
                <div>
                    <h4 class="text-white fs-6 mb-0">댓글 알림</h4>
                    <p class="text-secondary text-xs mb-0">내 게시글에 새로운 댓글이 달리면 알림을 받습니다.</p>
                </div>
            </div>
            <label class="noti-switch-container">
                <input type="checkbox" class="noti-toggle-input" data-type="comment" ${options.allowComment ? 'checked' : ''}>
                <span class="noti-switch-slider"></span>
            </label>
        </div>

        <div class="d-flex justify-content-between align-items-center p-3 rounded-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
            <div class="d-flex align-items-center gap-3">
                <span class="material-symbols-outlined" style="color: #a78bfa; font-size: 24px;">cached</span>
                <div>
                    <h4 class="text-white fs-6 mb-0">리포스트 알림</h4>
                    <p class="text-secondary text-xs mb-0">내 콘텐츠가 다른 유저에 의해 공유되면 알림을 받습니다.</p>
                </div>
            </div>
            <label class="noti-switch-container">
                <input type="checkbox" class="noti-toggle-input" data-type="repost" ${options.allowRepost ? 'checked' : ''}>
                <span class="noti-switch-slider"></span>
            </label>
        </div>

        <div class="d-flex justify-content-between align-items-center p-3 rounded-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
            <div class="d-flex align-items-center gap-3">
                <span class="material-symbols-outlined" style="color: #a78bfa; font-size: 24px;">person_add</span>
                <div>
                    <h4 class="text-white fs-6 mb-0">팔로우 알림</h4>
                    <p class="text-secondary text-xs mb-0">새로운 팔로워가 생기면 알림을 받습니다.</p>
                </div>
            </div>
            <label class="noti-switch-container">
                <input type="checkbox" class="noti-toggle-input" data-type="follow" ${options.allowFollow ? 'checked' : ''}>
                <span class="noti-switch-slider"></span>
            </label>
        </div>

        <div class="d-flex justify-content-between align-items-center p-3 rounded-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
            <div class="d-flex align-items-center gap-3">
                <span class="material-symbols-outlined" style="color: #a78bfa; font-size: 24px;">campaign</span>
                <div>
                    <h4 class="text-white fs-6 mb-0">공지사항 알림</h4>
                    <p class="text-secondary text-xs mb-0">스테이션의 주요 소식과 업데이트 정보를 알려드립니다.</p>
                </div>
            </div>
            <label class="noti-switch-container">
                <input type="checkbox" class="noti-toggle-input" data-type="notice" ${options.allowNotice ? 'checked' : ''} disabled>
                <span class="noti-switch-slider"></span>
            </label>
        </div>

        <div class="d-flex justify-content-between align-items-center p-3 rounded-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);">
            <div class="d-flex align-items-center gap-3">
                <span class="material-symbols-outlined" style="color: #a78bfa; font-size: 24px;">celebration</span>
                <div>
                    <h4 class="text-white fs-6 mb-0">이벤트 알림</h4>
                    <p class="text-secondary text-xs mb-0">기간 한정 미션이나 우주 이벤트 소식을 알려드립니다.</p>
                </div>
            </div>
            <label class="noti-switch-container">
                <input type="checkbox" class="noti-toggle-input" data-type="event" ${options.allowEvent ? 'checked' : ''} disabled>
                <span class="noti-switch-slider"></span>
            </label>
        </div>

    </div>
</div>

<style>
/* 알림 설정 전용 토글 스위치 컨테이너 */
.noti-switch-container {
  position: relative;
  display: inline-block;
  width: 48px;
  height: 24px;
  vertical-align: middle;
}

/* 실제 체크박스는 숨김 */
.noti-switch-container input.noti-toggle-input {
  opacity: 0;
  width: 0;
  height: 0;
}

/* 스위치 배경 (슬라이더) */
.noti-switch-slider {
  position: absolute;
  cursor: pointer;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(255, 255, 255, 0.08);
  transition: all 0.3s ease;
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 34px;
}

/* 스위치 내부 원형 핸들 */
.noti-switch-slider:before {
  position: absolute;
  content: "";
  height: 18px;
  width: 18px;
  left: 2px;
  bottom: 2px;
  background-color: #abb1bf;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  border-radius: 50%;
}

/* 체크되었을 때 (On 상태 - 보라색 테마) */
.noti-toggle-input:checked + .noti-switch-slider {
  background-color: #6d28d9; /* Deep Purple */
  border-color: #8b5cf6;
  box-shadow: 0 0 10px rgba(139, 92, 246, 0.5);
}

.noti-toggle-input:checked + .noti-switch-slider:before {
  background-color: #ffffff;
  transform: translateX(24px);
}

/* 호버 시 테두리 강조 */
.noti-switch-container:hover .noti-switch-slider {
  border-color: rgba(139, 92, 246, 0.5);
}

/* 비활성화 상태 스타일 (AJAX 통신 중) */
.noti-toggle-input:disabled + .noti-switch-slider {
  opacity: 0.5;
  cursor: not-allowed;
}
</style>

<script>
$(function() {
    $('.noti-toggle-input').on('change', function() {
        const $this = $(this);
        const type = $this.data('type'); 
        const isChecked = $this.is(':checked'); 
        const status = isChecked ? 1 : 0;
        
        $this.prop('disabled', true);

        $.ajax({
            url: '${pageContext.request.contextPath}/member/settings/toggleNotiOption',
            type: 'POST',
            data: {
                type: type,
                status: status
            },
            success: function(res) {
                if(res.status === "success") {
                    showToast("success", "알림 설정이 업데이트되었습니다.");
                } else {
                    showToast("error", "변경 사항을 저장하지 못했습니다.");
                    $this.prop('checked', !isChecked);
                }
            },
            error: function() {
                showToast("error", "통신 중 오류가 발생했습니다.");
                $this.prop('checked', !isChecked);
            },
            complete: function() {
                $this.prop('disabled', false);
            }
        });
    });
});
</script>