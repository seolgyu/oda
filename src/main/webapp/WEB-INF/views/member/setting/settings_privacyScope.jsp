<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
        <h2 class="text-white fs-4 fw-bold mb-1">Privacy Scope</h2>
        <p class="text-secondary text-sm mb-0">Control who can see your cosmic journey and manage blocked users.</p>
    </div>

    <form id="privacyForm" class="d-flex flex-column gap-4">
        
        <div class="mb-2">
            <label class="text-white text-xs fw-bold mb-3 d-block text-uppercase tracking-wider">Account Privacy</label>
            <div class="col-md-7">
                <select name="isPrivate" class="form-control login-input custom-select" 
                        style="padding-left: 20px !important; color-scheme: dark; cursor: pointer; appearance: none; -webkit-appearance: none;">
                    <option value="false" ${!user.isPrivate ? 'selected' : ''} style="background: #1a1a1a;">Public (Everyone can see my profile)</option>
                    <option value="true" ${user.isPrivate ? 'selected' : ''} style="background: #1a1a1a;">Private (Only followers can see my profile)</option>
                </select>
                <p class="text-secondary text-xs mt-2 opacity-50">When private, your posts and activity will be hidden from non-followers.</p>
            </div>
        </div>

        <div class="border-top border-white border-opacity-10 my-2"></div>

        <div class="">
            <label class="text-white text-xs fw-bold mb-3 d-block text-uppercase tracking-wider">Block Users</label>
            
            <div class="d-flex gap-2 mb-4">
                <div class="position-relative flex-grow-1">
                    <span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 18px;">person_search</span>
                    <input type="text" id="input-block-user" class="form-control login-input" placeholder="Enter User ID or Nickname to block"
                           style="padding-left: 45px !important;">
                </div>
                <button class="btn btn-outline-danger px-4 fw-bold" type="button" id="btn-add-block"
                        style="border-color: rgba(220, 38, 38, 0.3); white-space: nowrap; font-size: 0.85rem; border-radius: 0.375rem !important;">
                    Block User
                </button>
            </div>

            <div id="block-list-container" class="d-flex flex-column gap-2">
                <p class="text-secondary text-xs mb-2 opacity-50">Blocked users cannot message you or see your posts.</p>
                
                <div class="record-item d-flex align-items-center justify-content-between p-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-circle" style="width: 32px; height: 32px; background: rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center;">
                            <span class="material-symbols-outlined text-secondary" style="font-size: 18px;">block</span>
                        </div>
                        <div>
                            <h4 class="text-white fs-6 fw-bold mb-0">Unfriendly_User</h4>
                            <span class="text-secondary" style="font-size: 0.7rem;">Blocked on 2026.01.13</span>
                        </div>
                    </div>
                    <button type="button" class="btn btn-link text-secondary text-decoration-none text-xs hover-white" onclick="unblock('Unfriendly_User')">Unblock</button>
                </div>
                
                <c:if test="${empty blockedUsers}">
                    <div class="text-center py-4 opacity-20">
                        <p class="text-white text-xs mb-0">No blocked users yet.</p>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-center pt-4 border-top border-white border-opacity-10 mt-3">
            <p class="text-xs text-secondary mb-0">
                <span class="material-symbols-outlined align-middle" style="font-size: 14px;">security</span> 
                Your privacy settings are updated in real-time.
            </p>
            <button type="button" id="btn-save-privacy" class="btn btn-primary rounded-pill px-5 fw-bold" 
                    style="background: #2563eb; border: none;">
                Save Changes
            </button>
        </div>
    </form>
</div>

<style>
/* Select 태그 커스텀 스타일 */
.custom-select {
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='white' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e") !important;
    background-repeat: no-repeat !important;
    background-position: right 1rem center !important;
    background-size: 12px 12px !important;
    padding-right: 2.5rem !important;
}

.custom-select:hover {
    background-color: rgba(255, 255, 255, 0.08) !important;
}

.custom-select option {
    background-color: #1a1a1b !important;
    color: white !important;
}

/* 리스트 아이템 스타일 (이전 기록 페이지들과 통일) */
.record-item {
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 12px;
}

.hover-white:hover { color: white !important; }

/* 텍스트 크기 보정 */
.text-xs { font-size: 0.75rem; }
</style>

<script>
$(function() {
    // 1. 차단 유저 추가 버튼 이벤트
    $('#btn-add-block').on('click', function() {
        const userId = $('#input-block-user').val().trim();
        if(!userId) {
            alert("Please enter a User ID.");
            return;
        }

        if(confirm("Are you sure you want to block this user?")) {
            $.ajax({
                url: '${pageContext.request.contextPath}/member/blockUser',
                type: 'POST',
                data: { blockedId: userId },
                success: function(res) {
                    if(res === "success") {
                        alert("User has been blocked.");
                        loadSettings('${pageContext.request.contextPath}/member/settings/privacy_scope');
                    } else {
                        alert("Could not find the user or block failed.");
                    }
                }
            });
        }
    });

    // 2. 전체 프라이버시 설정 저장
    $('#btn-save-privacy').on('click', function() {
        const formData = $('#privacyForm').serialize();
        
        $.ajax({
            url: '${pageContext.request.contextPath}/member/updatePrivacy',
            type: 'POST',
            data: formData,
            success: function(res) {
                if(res === "success") {
                    alert("Privacy settings updated successfully!");
                }
            }
        });
    });
});

// 차단 해제 함수
function unblock(userId) {
    if(confirm("Unblock this user?")) {
        $.ajax({
            url: '${pageContext.request.contextPath}/member/unblockUser',
            type: 'POST',
            data: { blockedId: userId },
            success: function(res) {
                if(res === "success") {
                    loadSettings('${pageContext.request.contextPath}/member/settings/privacy_scope');
                }
            }
        });
    }
}
</script>