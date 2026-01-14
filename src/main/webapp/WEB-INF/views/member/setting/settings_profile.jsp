<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
        <h2 class="text-white fs-4 fw-bold mb-1">Profile Interface</h2>
        <p class="text-secondary text-sm mb-0">Your cosmic identity updates instantly when you select a file or reset.</p>
    </div>

    <div class="d-flex flex-column gap-4">
        <div class="profile-preview-container w-100">
            
            <div id="banner-preview" class="banner-edit-wrapper rounded-4 shadow-lg position-relative">
                <img id="banner-img-view" 
                     src="${user.banner_photo}" 
                     class="w-100 h-100 object-fit-cover ${empty user.banner_photo ? 'd-none' : ''}">
                
                <input type="file" id="banner-input" class="d-none" accept="image/*">
                
                <div class="edit-overlay position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center"
                     style="cursor: pointer;" onclick="$('#banner-input').click();">
                    <div class="edit-btn-style">
                        <span class="material-symbols-outlined">photo_camera</span> 
                        <span>Change Banner</span>
                    </div>
                </div>

                <c:if test="${not empty user.banner_photo}">
                    <button type="button" class="btn-reset-round shadow-sm" id="banner_reset" title="Reset Banner" 
                            onclick="updateImageImmediate('banner', 'delete')">
                        <span class="material-symbols-outlined">restart_alt</span>
                    </button>
                </c:if>
            </div>

            <div class="px-4 d-flex align-items-end gap-3" style="margin-top: -50px;">
                <div class="position-relative">
                    <div id="avatar-preview-box" class="settings-avatar-wrapper shadow-lg" onclick="$('#avatar-input').click();">
                        <img id="avatar-img-view" 
                             src="${user.profile_photo}" 
                             class="w-100 h-100 object-fit-cover ${empty user.profile_photo ? 'd-none' : ''}">

                        <div class="avatar-edit-overlay position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center">
                            <span class="material-symbols-outlined text-white" style="font-size: 32px;">photo_camera</span>
                        </div>
                    </div>
                    <input type="file" id="avatar-input" class="d-none" accept="image/*">
                    
                    <c:if test="${not empty user.profile_photo}">
                        <button type="button" class="btn-reset-round shadow-sm" id="profile_reset" title="Reset Profile"
                                style="bottom: 5px; right: -5px;" onclick="updateImageImmediate('avatar', 'delete')">
                            <span class="material-symbols-outlined">restart_alt</span>
                        </button>
                    </c:if>
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
                Images are automatically saved upon selection.
            </div>
        </div>
    </div>
</div>

<style>
/* 배너 컨테이너 */
.banner-edit-wrapper {
    width: 100%; height: 200px;
    background: linear-gradient(to right, #1e1b4b, #4338ca, #1e1b4b);
    position: relative; border-radius: 1rem; overflow: hidden;
}

/* 아바타 컨테이너 */
.settings-avatar-wrapper {
    width: 125px; height: 125px;
    border-radius: 1rem;
    background: linear-gradient(135deg, #6366f1, #a855f7);
    border: 5px solid #141414; 
    display: flex; align-items: center; justify-content: center;
    position: relative; z-index: 10; cursor: pointer;
    overflow: hidden;
}

/* 리셋 버튼 (동그란 형태) */
.btn-reset-round {
    width: 32px; height: 32px;
    border-radius: 50%;
    background: rgba(15, 15, 15, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.2);
    color: #ff4d4d; /* 붉은색 포인트 */
    display: flex; align-items: center; justify-content: center;
    position: absolute; bottom: 15px; right: 15px;
    z-index: 25; transition: all 0.2s ease;
    backdrop-filter: blur(4px);
    cursor: pointer;
}

.btn-reset-round:hover {
    background: #ff4d4d;
    color: white;
    transform: rotate(-45deg);
    border-color: transparent;
}

/* 이미지 스타일 공통 */
.object-fit-cover {
    object-fit: cover;
    position: absolute;
    top: 0;
    left: 0;
}

/* 오버레이 */
.edit-overlay, .avatar-edit-overlay {
    background: rgba(0, 0, 0, 0.4);
    opacity: 0;
    transition: all 0.2s ease-in-out;
    backdrop-filter: blur(2px);
    z-index: 5;
}
.banner-edit-wrapper:hover .edit-overlay, 
.settings-avatar-wrapper:hover .avatar-edit-overlay {
    opacity: 1;
}

.banner-edit-wrapper:has(.btn-reset-round:hover) .edit-overlay {
    opacity: 0 !important;
    transition: opacity 0.2s ease-in-out;
}

.edit-btn-style {
    background: rgba(0, 0, 0, 0.5);
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: white; padding: 8px 16px; border-radius: 50px;
    display: flex; align-items: center; gap: 8px; font-size: 0.85rem;
}
</style>

<script type="text/javascript">
$(function() {
    window.updateImageImmediate = function(type, action) {
        const formData = new FormData();
        const isDelete = (action === 'delete');

        if (type === 'banner') {
            if (isDelete) formData.append("isBannerDeleted", "true");
            else formData.append("bannerFile", action);
        } else {
            if (isDelete) formData.append("isAvatarDeleted", "true");
            else formData.append("avatarFile", action);
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/member/settings/updateImagesCloud',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(data) {
                if (data.status === "success") {
                    showToast("success", "프로필 사진 및 배너 사진이 성공적으로 수정되었습니다.");
                	setTimeout(function() {
                        loadSettings("${pageContext.request.contextPath}/member/settings/profile");
                    }, 800);
                } else {
                    showToast("error", "수정 실패.");
                }
            },
            error: function() {
                showToast("error", "서버 통신 오류.");
            }
        });
    };
    
    $('#banner-input').on('change', function() {
        if (this.files && this.files[0]) {
            updateImageImmediate('banner', this.files[0]);
        }
    });

    $('#avatar-input').on('change', function() {
        if (this.files && this.files[0]) {
            updateImageImmediate('avatar', this.files[0]);
        }
    });

    $('#banner_reset').on('click', function() {
        updateImageImmediate('banner', 'delete');
    });

    $('#profile-reset').on('click', function() {
        updateImageImmediate('avatar', 'delete');
    });
});
</script>