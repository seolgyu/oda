<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg mx-auto" style="width: 820px; min-width: 820px; max-width: 100%;">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
        <h2 class="text-white fs-4 fw-bold mb-1">Change Password</h2>
        <p class="text-secondary text-sm mb-0">Update your cosmic access key to keep your account secure.</p>
    </div>

    <form id="passwordForm" class="d-flex flex-column gap-4">
        
        <div class="col-md-8">
            <label class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">Current Password</label>
            <input type="password" name="currentPassword" id="currentPassword" 
                   class="form-control login-input" placeholder="Enter your current password"
                   style="padding-left: 20px !important;">
        </div>

        <div class="col-md-8">
            <div class="border-top border-white border-opacity-10 my-1"></div>
        </div>

        <div class="col-md-8">
            <label class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">New Password</label>
            <input type="password" name="newPassword" id="newPassword" 
                   class="form-control login-input" placeholder="Enter your new password"
                   style="padding-left: 20px !important;">
        </div>

        <div class="col-md-8">
            <label class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">Confirm New Password</label>
            <input type="password" id="confirmPassword" 
                   class="form-control login-input" placeholder="Repeat new password"
                   style="padding-left: 20px !important;">
        </div>

        <div class="d-flex justify-content-between align-items-center pt-4 border-top border-white border-opacity-10 mt-2">
            <p class="text-xs text-secondary mb-0">
                <span class="material-symbols-outlined align-middle" style="font-size: 14px;">lock</span> 
                Ensure your new password is strong and unique.
            </p>
            <button type="button" id="btn-change-password"
                    class="btn btn-primary rounded-pill px-5 fw-bold"
                    style="background: #2563eb; border: none;">Save Changes</button>
        </div>
    </form>
</div>

<script>
    $(function() {
    	$('.login-input').on('input', function() {
            hideFieldError($(this));
        });
    	
        $('#btn-change-password').on('click', function() {
        	const $btn = $('#btn-change-password');
            const $currentPwd = $('#currentPassword');
            const $newPwd = $('#newPassword');
            const $confirmPwd = $('#confirmPassword');
            
            const currentPwd = $currentPwd.val().trim();
            const newPwd = $newPwd.val().trim();
            const confirmPwd = $confirmPwd.val().trim();

            if (!currentPwd ) {
            	showFieldError($currentPwd, "현재 비밀번호를 입력해주세요.");
            	return;
            }

            if (!newPwd ) {
            	showFieldError($newPwd, "새로운 비밀번호를 입력해주세요.");
            	return;
            }

            if (!confirmPwd ) {
            	showFieldError($confirmPwd, "비밀번호 확인란을 입력해주세요.");
            	return;
            }
            
            if (newPwd !== confirmPwd) {
            	showFieldError($confirmPwd, "비밀번호가 일치하지 않습니다.");
                return;
            }
            
            $btn.prop('disabled', true).addClass('opacity-50');

            $.ajax({
                url: '${pageContext.request.contextPath}/member/settings/updatePwd',
                type: 'POST',
                data: {currentPwd: currentPwd, newPwd: newPwd},
                dataType: 'json',
                success: function(data) {
                    if (data.status === "success") {
                    	showToast("success", "비밀번호가 성공적으로 수정되었습니다.");
                    	setTimeout(function() {
                            loadSettings("${pageContext.request.contextPath}/member/settings/pwdChange");
                        }, 800);
                    } else if (data.status === "fail") {
                    	showFieldError($currentPwd, "현재 비밀번호가 올바르지 않습니다.");
                    	$btn.prop('disabled', false).removeClass('opacity-50');
                    } else {
                    	showToast("error", "비밀번호 수정 실패.");
                        $btn.prop('disabled', false).removeClass('opacity-50');
                    }
                },
                error: function() {
                	showToast("error", "서버 에러 발생.");
                	$btn.prop('disabled', false).removeClass('opacity-50');
                }
            });
        });
    });
</script>