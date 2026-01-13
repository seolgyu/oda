<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
        <h2 class="text-white fs-4 fw-bold mb-1">Profile Interface</h2>
        <p class="text-secondary text-sm mb-0">Update your cosmic identity and preview the result.</p>
    </div>

    <div class="d-flex flex-column gap-4">
        <div class="profile-preview-container w-100">
            <div id="banner-preview" class="banner-edit-wrapper rounded-4 shadow-lg" onclick="$('#banner-input').click();">
                <div class="banner-bg w-100 h-100" 
                     style="background-image: url('${user.bannerImg}'); background-size: cover; background-position: center;"></div>
                
                <input type="file" id="banner-input" class="d-none" accept="image/*">
                <div class="edit-overlay position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center">
                    <div class="edit-btn-style">
                        <span class="material-symbols-outlined">photo_camera</span> 
                        <span>Change Banner</span>
                    </div>
                </div>
            </div>

            <div class="px-4 d-flex align-items-end gap-3" style="margin-top: -50px;">
                <div class="position-relative">
                    <div id="avatar-preview" class="settings-avatar-wrapper shadow-lg"
                         style="background-image: url('${user.profileImg}');"
                         onclick="$('#avatar-input').click();">
                        
                        <c:if test="${empty user.profileImg}">
                            <span class="text-white fs-1 user-initial"></span>
                        </c:if>

                        <div class="avatar-edit-overlay position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center">
                            <span class="material-symbols-outlined text-white" style="font-size: 32px;">photo_camera</span>
                        </div>
                    </div>
                    <input type="file" id="avatar-input" class="d-none" accept="image/*">
                </div>

                <div class="pb-2">
                    <h1 class="text-white fs-3 fw-bold mb-1">${sessionScope.member.userNickname}</h1>
                    <p class="text-secondary mb-0" style="font-size: 0.9rem;">
                        c/${sessionScope.member.userId} | <span class="text-white fw-bold">14.2k</span> Followers | <span class="text-white fw-bold">8.5k</span> Visitors
                    </p>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-center pt-3 border-top border-white border-opacity-10 mt-2">
            <div class="text-xs text-gray-500">
                <span class="material-symbols-outlined align-middle" style="font-size: 14px;">info</span> 
                This is how your profile appears to other users.
            </div>
            <button class="btn btn-primary rounded-pill px-5 fw-bold" style="background: #2563eb; border: none;">
                Save Changes
            </button>
        </div>
    </div>
</div>

<style>
/* 배너 스타일 */
.banner-edit-wrapper {
    width: 100%; height: 200px;
    background: linear-gradient(to right, #1e1b4b, #4338ca, #1e1b4b);
    position: relative; border-radius: 1rem; overflow: hidden;
    cursor: pointer;
}

/* 프로필 사진 사각형 (마이페이지 일치) */
.settings-avatar-wrapper {
    width: 125px !important; height: 125px !important;
    border-radius: 1rem !important;
    background: linear-gradient(135deg, #6366f1, #a855f7) !important;
    background-size: cover; background-position: center;
    border: 5px solid #141414 !important; 
    display: flex; align-items: center; justify-content: center;
    position: relative; z-index: 10; cursor: pointer;
    overflow: hidden;
}

/* 호버 오버레이 효과 */
.edit-overlay, .avatar-edit-overlay {
    background: rgba(0, 0, 0, 0.4);
    opacity: 0;
    transition: all 0.2s ease-in-out;
    backdrop-filter: blur(2px);
}

.banner-edit-wrapper:hover .edit-overlay, 
.settings-avatar-wrapper:hover .avatar-edit-overlay {
    opacity: 1;
}

/* 배너 내부 버튼 스타일 */
.edit-btn-style {
    background: rgba(0, 0, 0, 0.5);
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: white; padding: 8px 16px; border-radius: 50px;
    display: flex; align-items: center; gap: 8px; font-size: 0.85rem;
}

/* 입력창 스타일 */
.login-input {
    background: rgba(255, 255, 255, 0.05) !important;
    border: 1px solid rgba(255, 255, 255, 0.1) !important;
    color: white !important;
    resize: none;
}
.login-input:focus {
    background: rgba(255, 255, 255, 0.1) !important;
    border-color: #6366f1 !important;
    box-shadow: none;
}
</style>

<script type="text/javascript">
$(function() {
    function readURL(input, targetId) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                if(targetId === '#banner-preview') {
                    $(targetId).find('.banner-bg').css('background-image', 'url(' + e.target.result + ')');
                } else {
                    $(targetId).css('background-image', 'url(' + e.target.result + ')');
                    $(targetId).find('.user-initial').hide();
                }
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $('#banner-input').on('change', function() { readURL(this, '#banner-preview'); });
    $('#avatar-input').on('change', function() { readURL(this, '#avatar-preview'); });
});
</script>