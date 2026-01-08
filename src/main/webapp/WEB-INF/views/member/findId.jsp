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
        <div class="p-5 shadow-lg d-flex flex-column align-items-center gap-4"
            style="width: 100%; max-width: 400px; border-radius: 1rem; backdrop-filter: blur(12px); background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1);">

            <div class="position-relative">
                <div class="rounded-circle d-flex align-items-center justify-content-center shadow-lg"
                    style="width: 100px; height: 100px; background: linear-gradient(to top right, #f43f5e, #fb923c);">
                    <span class="material-symbols-outlined text-white" style="font-size: 3rem;">person_search</span>
                </div>
                <div class="position-absolute top-50 start-50 translate-middle rounded-circle"
                    style="width: 120px; height: 120px; background: rgba(244, 63, 94, 0.4); filter: blur(30px); z-index: -1;"></div>
            </div>

            <div class="text-center mb-2">
                <h2 class="text-white fw-bold fs-4 mb-1">Find Your ID</h2>
                <p class="text-secondary text-xs mb-0" style="font-size: 0.85rem;">Enter your name and email to recover</p>
            </div>

            <form name="findIdForm" method="POST" class="w-100 d-flex flex-column gap-3">
                <div class="position-relative">
                    <span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
                        style="font-size: 1.2rem;">badge</span>
                    <input type="text" name="userName" class="form-control login-input"
                        placeholder="User Name" required>
                </div>

                <div class="position-relative">
                    <span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary"
                        style="font-size: 1.2rem;">mail</span>
                    <input type="email" name="userEmail" class="form-control login-input"
                        placeholder="Email Address" required>
                </div>

                <button type="button" class="btn w-100 fw-bold text-white shadow-md mt-2"
                    style="height: 3rem; border-radius: 0.75rem; background: linear-gradient(to right, #f43f5e, #fb923c); border: none; transition: transform 0.2s;"
                    onclick="sendFindId();">FIND ID</button>
            </form>

            <div id="findIdResult" class="w-100 p-2 text-center fade-in"
                style="background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 0.75rem; color: #fff; font-size: 0.85rem; display: none;">
                <span id="resultText"></span>
            </div>

            <div class="d-flex justify-content-center w-100 mt-2" style="font-size: 0.85rem;">
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