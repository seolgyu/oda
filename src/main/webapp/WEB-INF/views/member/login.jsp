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
							style="width: 100px; height: 100px; background: linear-gradient(to top right, #a855f7, #6366f1);">
							<span class="material-symbols-outlined text-white"
								style="font-size: 3rem;">person</span>
						</div>
						<div
							class="position-absolute top-50 start-50 translate-middle rounded-circle"
							style="width: 120px; height: 120px; background: rgba(168, 85, 247, 0.4); filter: blur(30px); z-index: -1;"></div>
					</div>

					<div class="text-center mb-2">
						<h2 class="text-white fw-bold fs-4 mb-1">Welcome Back</h2>
						<p class="text-secondary text-xs mb-0" style="font-size: 0.85rem;">Please
							sign in to continue</p>
					</div>

					<form name="loginForm" action="" method="POST"
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
								style="font-size: 1.2rem;">lock</span> <input type="password"
								name="userPwd" class="form-control login-input"
								placeholder="Password" required>
						</div>

						<button type="button"
							class="btn w-100 fw-bold text-white shadow-md mt-2"
							style="height: 3rem; border-radius: 0.75rem; background: linear-gradient(to right, #a855f7, #6366f1); border: none; transition: transform 0.2s;"
							onclick="sendLoginAjax();">LOG IN</button>

					</form>

					<div id="loginError" class="w-100 p-2 text-center fade-in"
						style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.2); border-radius: 0.75rem; color: #fca5a5; font-size: 0.8rem; display: none; margin-bottom: 15px;">
						<span id="errorText"></span>
					</div>

					<div class="d-flex justify-content-between w-100 mt-2"
						style="font-size: 0.85rem;">
						<a href="#"
							class="text-decoration-none text-secondary hover-text-white transition-colors">
							Forgot Password? </a> <a
							href="${pageContext.request.contextPath}/member/signup"
							class="text-decoration-none text-white fw-bold hover-text-white transition-colors">
							Sign Up </a>
					</div>

					<div class="d-flex align-items-center gap-3 w-100 my-2">
						<div class="flex-grow-1"
							style="height: 1px; background: rgba(255, 255, 255, 0.1);"></div>
						<span class="text-secondary" style="font-size: 0.75rem;">OR</span>
						<div class="flex-grow-1"
							style="height: 1px; background: rgba(255, 255, 255, 0.1);"></div>
					</div>

				</div>
			</div>
			<div class="position-absolute bottom-0 end-0 m-4 z-3">
				<button
					class="d-flex align-items-center gap-2 rounded-pill px-3 py-2 shadow-lg border border-white border-opacity-10"
					style="background: rgba(39, 39, 42, 0.8); backdrop-filter: blur(12px);">
					<div class="d-flex flex-column align-items-start lh-1 me-2">
						<span class="text-uppercase text-muted fw-semibold"
							style="font-size: 10px; letter-spacing: 0.05em;">Tasks</span> <span
							class="text-sm fw-medium text-white-50">0 active</span>
					</div>
					<div
						style="width: 1px; height: 24px; background: rgba(255, 255, 255, 0.1);"></div>
					<div
						class="rounded-circle d-flex align-items-center justify-content-center text-muted ms-1"
						style="width: 24px; height: 24px;">
						<span class="material-symbols-outlined fs-5">chevron_right</span>
					</div>
				</button>
			</div>
			<div
				class="position-absolute bottom-0 start-0 m-4 z-3 d-none d-md-flex align-items-center gap-2 px-3 py-1 rounded-3 border border-white border-opacity-10 text-muted font-monospace text-xs"
				style="background: rgba(39, 39, 42, 0.8); backdrop-filter: blur(12px);">
				<span class="material-symbols-outlined" style="font-size: 14px;">grid_4x4</span>
				<span>492</span>
			</div>
		</main>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script type="text/javascript">
	function sendLogin() {
	    const f = document.loginForm;
		
	   	if( ! f.userId.value.trim() ) {
        f.userId.focus();
       		return;
   		}

    	if( ! f.userPwd.value.trim() ) {
        	f.userPwd.focus();
        	return;
    	}

    	f.action = '${pageContext.request.contextPath}/member/login';
    	f.submit();
	}
	
	function sendLoginAjax() {
	    const f = document.loginForm;
	    const userId = $('input[name=userId]').val();
	    const userPwd = $('input[name=userPwd]').val();
		
	   	if( ! userId.trim() ) {
        	f.userId.focus();
       		return;
   		}

    	if( ! userPwd.trim() ) {
        	f.userPwd.focus();
        	return;
    	}
    	
    	$.ajax({
            url: "${pageContext.request.contextPath}/member/login_json",
            headers: { "AJAX": "true" },
            type: "POST",
            data: { userId: userId, userPwd: userPwd },
            dataType: "json",
            success: function(res) {
                if(res.status === "success") {
                    location.href = "${pageContext.request.contextPath}/";
                } else {
                    $("#errorText").text(res.message);
                    $("#loginError").fadeIn();
                    
                    $('input[name=userPwd]').val('').focus();
                }
            },
            error: function(xhr) {
                console.error("로그인 통신 실패", xhr);
            }
        });
	}
</script>
</body>
</html>