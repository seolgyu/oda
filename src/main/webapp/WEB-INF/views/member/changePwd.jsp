<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
</head>
<body>

	<%@ include file="../home/header.jsp"%>

	<div class="app-body">

		<%@ include file="../home/sidebar.jsp"%>

		<main class="app-main">
			<div class="space-background">
				<div class="stars"></div>
				<div class="stars2"></div>
				<div class="stars3"></div>
				<div class="planet planet-1"></div>
				<div class="planet planet-2"></div>
			</div>

			<div class="d-flex justify-content-center align-items-center w-100"
				style="min-height: calc(100vh - 70px); width: 100%;">
				<div
					class="p-5 shadow-lg d-flex flex-column align-items-center gap-4"
					style="width: 100%; max-width: 400px; border-radius: 1rem; backdrop-filter: blur(12px); background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1);">

					<div class="position-relative">
						<div
							class="rounded-circle d-flex align-items-center justify-content-center shadow-lg"
							style="width: 100px; height: 100px; background: linear-gradient(to top right, #f43f5e, #fb923c);">
							<span class="material-symbols-outlined text-white"
								style="font-size: 3rem;">lock</span>
						</div>
						<div
							class="position-absolute top-50 start-50 translate-middle rounded-circle"
							style="width: 120px; height: 120px; background: rgba(244, 63, 94, 0.4); filter: blur(30px); z-index: -1;"></div>
					</div>

					<div class="text-center mb-2">
						<h2 class="text-white fw-bold fs-4 mb-1">New Password</h2>
						<p class="text-secondary text-xs mb-0" style="font-size: 0.85rem;">Please
							enter your new password</p>
					</div>

					<form name="resetPwdForm" method="POST" onsubmit="return false;"
						class="w-100 d-flex flex-column gap-3">
						<div class="position-relative">
							<span
								class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
								style="font-size: 1.2rem;">lock</span> <input type="password"
								name="userPwd" class="form-control login-input"
								placeholder="New Password" required>
						</div>

						<div class="position-relative">
							<span
								class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
								style="font-size: 1.2rem;">task_alt</span> <input
								type="password" name="userPwdCheck"
								class="form-control login-input"
								placeholder="Confirm New Password" required>
						</div>

						<button type="button" id="updatePwdBtn"
							class="btn w-100 fw-bold text-white shadow-md mt-2"
							style="height: 3rem; border-radius: 0.75rem; background: linear-gradient(to right, #f43f5e, #fb923c); border: none; transition: transform 0.2s;"
							onclick="updatePwd();">UPDATE PASSWORD</button>
					</form>

					<div id="resetResult" class="w-100 p-3 text-center fade-in"
						style="border-radius: 0.75rem; font-size: 0.9rem; display: none; transition: all 0.3s;">
						<div id="resultText" class="fw-medium"></div>
					</div>

					<div class="d-flex justify-content-center w-100 mt-2"
						style="font-size: 0.85rem;">
						<a href="${pageContext.request.contextPath}/member/login"
							class="text-decoration-none text-secondary hover-text-white transition-colors d-flex align-items-center gap-1">
							<span class="material-symbols-outlined" style="font-size: 1rem;">arrow_back</span>
							Cancel and Login
						</a>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	
	<script type="text/javascript">
	
	function updatePwd() {
	    const $submitBtn = $("#updatePwdBtn");
	    const $userPwd = $('input[name=userPwd]');
	    const $userPwdCheck = $('input[name=userPwdCheck]');
	    
	    const userPwd = $userPwd.val().trim();
	    const userPwdCheck = $userPwdCheck.val().trim();

	    if( ! userPwd) {
	    	showResult("비밀번호를 입력해주세요.", "error");
    		$userPwd.focus();
        	return;
    	} else if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test(userPwd)) {
    		showResult("영문, 숫자, 특수문자 포함 8 ~ 16자여야 합니다.", "error");
    		$userPwd.focus();
        	return;
    	}
    	
    	if (userPwd !== userPwdCheck) {
            showResult("비밀번호가 일치하지 않습니다.", "error");
            $userPwdCheck.focus();
            return;
        }
		
		$submitBtn.prop("disabled", true);

		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/member/changePwdSubmit",
			data : {userPwd: userPwd},
			dataType : "json",
			success : function(data) {
				if (data.status === "success") {
					$("input[name=userPwd], input[name=userPwdCheck]").prop("disabled", true);
					
					$submitBtn
		            .css("background", "#22c55e")
		            .text("SUCCESS ✓");
		        
		        	setTimeout(function() {
		            	location.href = "${pageContext.request.contextPath}/member/login";
		        	}, 1000);
				} else {
	                showResult("세션이 만료되었습니다. 처음부터 다시 시도해주세요.", "error");
	                $submitBtn.prop("disabled", false);
				}
			},
			error : function() {
				showResult("서버 에러가 발생했습니다. 다시 시도해주세요.", "error");
				$submitBtn.prop("disabled", false);
			}
		});
	};
	
	function showResult(msg, type) {
		const $errorDiv = $("#resetResult");		
		const $resultText = $("#resultText");
		
        $errorDiv.hide();
        if (type === "success") {
            $errorDiv.css({
                "background": "rgba(16, 185, 129, 0.15)",
                "border": "1px solid rgba(16, 185, 129, 0.3)",
                "color": "#34d399"
            });
        } else {
            $errorDiv.css({
                "background": "rgba(244, 63, 94, 0.1)",
                "border": "1px solid rgba(244, 63, 94, 0.2)",
                "color": "#fb7185"
            });
        }
        $resultText.html(msg);
        $errorDiv.fadeIn(300);
    }
	
	</script>
</body>
</html>