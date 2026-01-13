<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
        <h2 class="text-white fs-4 fw-bold mb-1">Profile Interface</h2>
        <p class="text-secondary text-sm mb-0">Update your cosmic identity and preview the result.</p>
    </div>

    <div class="d-flex flex-column gap-4">
		<div class="profile-preview-container w-100">
            <div id="banner-preview" class="banner-edit-wrapper rounded-4 shadow-lg">
                <img id="banner-img-view" 
                     src="${pageContext.request.contextPath}/uploads/banner/${user.banner_photo}" 
                     class="w-100 h-100 object-fit-cover ${empty user.banner_photo ? 'd-none' : ''}">
                
                <input type="file" id="banner-input" class="d-none" accept="image/*">
                <div class="edit-overlay position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center"
                	style="cursor: pointer;"
                	onclick="$('#banner-input').click();">
                    <div class="edit-btn-style">
                        <span class="material-symbols-outlined">photo_camera</span> 
                        <span>Change Banner</span>
                    </div>
                </div>
            </div>

            <div class="px-4 d-flex align-items-end gap-3" style="margin-top: -50px;">
                <div class="position-relative">
                    <div id="avatar-preview-box" class="settings-avatar-wrapper shadow-lg" onclick="$('#avatar-input').click();">
                        <img id="avatar-img-view" 
                             src="${pageContext.request.contextPath}/uploads/profile/${user.profile_photo}" 
                             class="w-100 h-100 object-fit-cover ${empty user.profile_photo ? 'd-none' : ''}">

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
            <button type="button" class="btn btn-primary rounded-pill px-5 fw-bold btn-save-changes" style="background: #2563eb; border: none;">
                Save Changes
            </button>
        </div>
    </div>
</div>

<style>
/* 배너 컨테이너 */
.banner-edit-wrapper {
    width: 100%; height: 200px;
    background: linear-gradient(to right, #1e1b4b, #4338ca, #1e1b4b);
    position: relative; border-radius: 1rem; overflow: hidden;
    cursor: pointer;
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

.edit-btn-style {
    background: rgba(0, 0, 0, 0.5);
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: white; padding: 8px 16px; border-radius: 50px;
    display: flex; align-items: center; gap: 8px; font-size: 0.85rem;
}
</style>

<script type="text/javascript">
$(function() {
    let bannerFile = null;
    let avatarFile = null;

    // --- <img> 태그용 미리보기 함수 ---
    function readURL(input, imgElementId) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function(e) {
                // src를 변경하고 d-none 클래스를 제거하여 이미지를 보이게 함
                $(imgElementId).attr('src', e.target.result).removeClass('d-none');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    // 파일 선택 이벤트
    $('#banner-input').on('change', function() {
        bannerFile = this.files[0];
        readURL(this, '#banner-img-view');
    });

    $('#avatar-input').on('change', function() {
        avatarFile = this.files[0];
        readURL(this, '#avatar-img-view');
    });

    // 저장 버튼 클릭
    $('.btn-save-changes').on('click', function() {
        let formData = new FormData();
        if (bannerFile) formData.append("bannerFile", bannerFile);
        if (avatarFile) formData.append("avatarFile", avatarFile);

        if (!bannerFile && !avatarFile) {
            showToast("info", "변경사항이 없습니다.");
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/member/settings/updateImages',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(data) {
                if(data.status === "success") {
                    showToast("success", "프로필 설정이 저장되었습니다.");
                    setTimeout(function() {
                    	location.href = "${pageContext.request.contextPath}/member/settings";
                    }, 1000);
                }
            }
        });
    });
});
</script>