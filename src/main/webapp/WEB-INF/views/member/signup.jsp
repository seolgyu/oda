<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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

			<div class="d-flex justify-content-center align-items-center w-100 py-5"
				style="min-height: calc(100vh - 70px); width: 100%;">
				
				<div class="p-5 shadow-lg d-flex flex-column align-items-center gap-4"
					style="width: 100%; max-width: 500px; border-radius: 1rem; backdrop-filter: blur(12px); background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1);">

					<div class="position-relative">
						<div class="rounded-circle d-flex align-items-center justify-content-center shadow-lg"
							style="width: 100px; height: 100px; background: linear-gradient(to top right, #a855f7, #6366f1);">
							<span class="material-symbols-outlined text-white" style="font-size: 3rem;">person_add</span>
						</div>
						<div class="position-absolute top-50 start-50 translate-middle rounded-circle"
							style="width: 120px; height: 120px; background: rgba(168, 85, 247, 0.4); filter: blur(30px); z-index: -1;"></div>
					</div>

					<div class="text-center mb-2">
						<h2 class="text-white fw-bold fs-4 mb-1">Create Account</h2>
						<p class="text-secondary text-xs mb-0" style="font-size: 0.85rem;">Join us to get started</p>
					</div>
					
					<c:if test="${not empty message}">
						<div class="w-100 p-2 text-center fade-in"
							style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.2); border-radius: 0.75rem; color: #fca5a5; font-size: 0.8rem; animation: shake 0.5s ease-in-out;">
							<span style="vertical-align: middle;">${message}</span>
						</div>
					</c:if>

					<form name="memberForm" method="POST" class="w-100 d-flex flex-column gap-3">

						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">person</span> 
							<input type="text" name="userId" class="form-control login-input" placeholder="User ID" required>
						</div>

						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">lock</span> 
							<input type="password" name="userPwd" class="form-control login-input" placeholder="Password" required>
						</div>

						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">badge</span> 
							<input type="text" name="userName" class="form-control login-input" placeholder="Name" required>
						</div>
						
						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">calendar_month</span> 
							<input type="date" name="birth" class="form-control login-input" placeholder="Birth Date" style="color-scheme: dark;">
						</div>

						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">mail</span> 
							<input type="email" name="email" class="form-control login-input" placeholder="Email Address" required>
						</div>

						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">call</span> 
							<input type="text" name="tel" class="form-control login-input" placeholder="Phone Number">
						</div>

						<div class="d-flex gap-2">
							<div class="position-relative flex-grow-1">
								<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">home</span> 
								<input type="text" name="zip" id="zip" class="form-control login-input" placeholder="Zip Code" readonly>
							</div>
							<button type="button" onclick="daumPostcode();" class="btn text-white shadow-sm"
								style="background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2); white-space: nowrap;">
								Search
							</button>
						</div>

						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">location_on</span> 
							<input type="text" name="addr1" id="addr1" class="form-control login-input" placeholder="Address" readonly>
						</div>

						<div class="position-relative">
							<span class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y ms-3 text-secondary" style="font-size: 1.2rem;">edit_location</span> 
							<input type="text" name="addr2" id="addr2" class="form-control login-input" placeholder="Detailed Address">
						</div>

						<button type="button"
							class="btn w-100 fw-bold text-white shadow-md mt-2"
							style="height: 3rem; border-radius: 0.75rem; background: linear-gradient(to right, #a855f7, #6366f1); border: none; transition: transform 0.2s;"
							onclick="memberOk();">SIGN UP</button>

					</form>

					<div class="d-flex justify-content-center w-100 mt-2" style="font-size: 0.85rem;">
						<span class="text-secondary me-2">Already have an account?</span>
						<a href="${pageContext.request.contextPath}/member/login"
							class="text-decoration-none text-white fw-bold hover-text-white transition-colors">
							Log In
						</a>
					</div>

				</div>
			</div>
		</main>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	
	<script type="text/javascript">
	function memberOk() {
	    const f = document.memberForm;
		
	   	if( ! f.userId.value.trim() ) {
	   		alert("아이디를 입력하세요."); // 디자인에 맞춰 모달로 바꾸거나 간단히 alert 유지
	        f.userId.focus();
	       	return;
   		}
    	if( ! f.userPwd.value.trim() ) {
    		alert("비밀번호를 입력하세요.");
        	f.userPwd.focus();
        	return;
    	}
    	if( ! f.userName.value.trim() ) {
    		alert("이름을 입력하세요.");
        	f.userName.focus();
        	return;
    	}
    	if( ! f.email.value.trim() ) {
    		alert("이메일을 입력하세요.");
        	f.email.focus();
        	return;
    	}

    	f.action = '${pageContext.request.contextPath}/member/signup';
    	f.submit();
	}

    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; 
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') { 
                    fullAddr = data.roadAddress;
                } else { 
                    fullAddr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== ''){ extraAddr += data.bname; }
                    if(data.buildingName !== ''){ extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName); }
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                document.getElementById('zip').value = data.zonecode;
                document.getElementById('addr1').value = fullAddr;
                document.getElementById('addr2').focus();
            }
        }).open();
    }
	</script>
</body>
</html>