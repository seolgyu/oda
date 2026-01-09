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
								style="font-size: 3rem;">lock_reset</span>
						</div>
						<div
							class="position-absolute top-50 start-50 translate-middle rounded-circle"
							style="width: 120px; height: 120px; background: rgba(244, 63, 94, 0.4); filter: blur(30px); z-index: -1;"></div>
					</div>

					<div class="text-center mb-2">
						<h2 class="text-white fw-bold fs-4 mb-1">Reset Password</h2>
						<p class="text-secondary text-xs mb-0" style="font-size: 0.85rem;">Verify
							your account to reset password</p>
					</div>

					<form name="findPwdForm" method="POST"
						class="w-100 d-flex flex-column gap-3">
						<div class="position-relative">
							<span
								class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
								style="font-size: 1.2rem;">person</span> <input type="text"
								name="userId" class="form-control login-input"
								placeholder="User ID" required>
						</div>

						<div class="position-relative">
							<span
								class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
								style="font-size: 1.2rem;">badge</span> <input type="text"
								name="userName" class="form-control login-input"
								placeholder="User Name" required>
						</div>

						<div class="position-relative">
							<span
								class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
								style="font-size: 1.2rem;">mail</span> <input type="email"
								name="email" class="form-control login-input"
								placeholder="Email Address" required>
						</div>

						<button type="button" id="sendBtn"
							class="btn w-100 fw-bold text-white shadow-md mt-2"
							style="height: 3rem; border-radius: 0.75rem; background: linear-gradient(to right, #f43f5e, #fb923c); border: none; transition: transform 0.2s;"
							onclick="sendResetPwd();">SEND VERIFICATION CODE</button>

						<div id="authCodeSection" class="w-100 d-flex flex-column gap-3" style="display: none !important;">
							<div class="position-relative">
								<span
									class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
									style="font-size: 1.2rem;">verified_user</span> <input
									type="text" id="authCode" class="form-control login-input"
									placeholder="Enter 6-digit code" maxlength="6">
							</div>

							<button type="button" id="verifyBtn"
								class="btn w-100 fw-bold text-white shadow-md"
								style="height: 3rem; border-radius: 0.75rem; background: linear-gradient(to right, #4f46e5, #7c3aed); border: none;"
								onclick="">VERIFY CODE</button>

							<div class="text-center text-xs"
								style="color: #fb923c; font-size: 0.8rem;">
								Time left: <span id="timer">03:00</span>
							</div>
						</div>
					</form>

					<div id="findPwdResult" class="w-100 p-3 text-center fade-in"
						style="border-radius: 0.75rem; font-size: 0.9rem; display: none; transition: all 0.3s;">

						<div id="resultText" class="fw-medium"></div>
					</div>

					<div class="d-flex justify-content-center w-100 mt-2"
						style="font-size: 0.85rem;">
						<a href="${pageContext.request.contextPath}/member/login"
							class="text-decoration-none text-secondary hover-text-white transition-colors d-flex align-items-center gap-1">
							<span class="material-symbols-outlined" style="font-size: 1rem;">arrow_back</span>
							Back to Login
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
	
	let timer;
	
	function sendResetPwd() {
		const $errorDiv = $("#findIdResult");
	    const $resultText = $("#resultText");
	    const $submitBtn = $("button[onclick='sendResetPwd();']");
	    
	    const $userId = $('input[name=userId]');
	    const $userName = $('input[name=userName]');
	    const $email = $('input[name=email]');
	    
	    const userId = $userId.val().trim();
	    const userName = $userName.val().trim();
	    const email = $email.val().trim();

		if (! userId ) {
			showResult("입력하지 않은 필드가 존재합니다.", "error");
			$userId.focus();
			return;
		}

		if (! userName ) {
			showResult("입력하지 않은 필드가 존재합니다.", "error");
			$userName.focus();
			return;
		}
			
		if(! email ) {
			showResult("입력하지 않은 필드가 존재합니다.", "error");
			$email.focus();
			return;
		}
		
		$submitBtn.prop("disabled", true);

		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/member/findPwdAjax",
			data : {userId: userId, userName: userName, email: email},
			dataType : "json",
			success : function(data) {
				if (data.status === "exist") {
					showResult("인증번호가 전송되었습니다.", "success");
				    
				    $("#sendBtn").text("RESEND CODE");
				    
				    $("#sendBtn").prop("disabled", true);
				    setTimeout(function() {
				        $("#sendBtn").prop("disabled", false);
				    }, 10000);
				    
				    startTimer(180);
				} else if (data.status === "emailSendError") {
	                showResult("이메일 전송에 실패했습니다.", "error");
	                $submitBtn.prop("disabled", false);
	            } else {
	                showResult("일치하는 사용자를 찾을 수 없습니다.", "error");
	                $submitBtn.prop("disabled", false);
	            }
			},
			error : function() {
				showResult("서버 에러가 발생했습니다. 다시 시도해주세요.", "error");
				$submitBtn.prop("disabled", false);
			}
		});
		
		function showResult(msg, type) {
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
	}
	
	function chkAuthCode() {
		
	}
	
	function startTimer(duration) {
	    let timerSeconds = duration;
	    let minutes, seconds;
	    const display = document.querySelector('#timer');

	    if (timer) clearInterval(timer);

	    timer = setInterval(function () {
	        minutes = parseInt(timerSeconds / 60, 10);
	        seconds = parseInt(timerSeconds % 60, 10);

	        minutes = minutes < 10 ? "0" + minutes : minutes;
	        seconds = seconds < 10 ? "0" + seconds : seconds;

	        display.textContent = minutes + ":" + seconds;

	        if (--timerSeconds < 0) {
	            clearInterval(timer);
	            display.textContent = "00:00";
	            display.parentElement.style.color = "#ef4444";
	            
	            $("#authCode").prop("disabled", true);
	            showResult("인증 시간이 만료되었습니다. 다시 시도해주세요.", "error");
	        }
	    }, 1000);
	}
</script>
</body>
</html>