<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
.position-relative {
    position: relative;
    width: 100%;
}

/* 카드 디자인: 가로폭은 유지하되 상하 여백을 대폭 축소 */
.signup-card {
	width: 100%;
	max-width: 420px;
	padding: 1.2rem 2rem !important; /* 상하 여백 최소화 */
	border-radius: 1.25rem;
	backdrop-filter: blur(15px);
	background: rgba(255, 255, 255, 0.04);
	border: 1px solid rgba(255, 255, 255, 0.1);
	position: relative; /* 오버레이의 기준점이 됨 */
    overflow: hidden;
}

/* 입력창 디자인: 높이를 줄이고 간격을 밀착 */
.login-input {
	height: 2.5rem !important; /* 높이를 2.5rem으로 압축 */
	background: rgba(255, 255, 255, 0.05) !important;
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	color: white !important;
	margin-bottom: 0.5rem !important; /* 필드 간 간격을 0.5rem으로 최소화 */
	padding-left: 2.4rem !important; /* 아이콘 크기에 맞춰 왼쪽 여백 소폭 감소 */
    font-size: 0.82rem !important;
}

.input-icon {
    position: absolute;
    /* top: 50% 대신 입력창 높이(2.5rem)의 절반인 1.25rem 근처로 고정 */
    top: 1.25rem !important; 
    left: 0;
    transform: translateY(-50%) !important;
    margin-left: 14px;
    z-index: 10;
    pointer-events: none;
    font-size: 0.95rem !important;
}

/* 상단 영역 최소화 */
.profile-header {
	margin-bottom: 1rem;
}

.profile-header .rounded-circle {
	width: 40px !important;
	height: 40px !important;
	margin-bottom: 0.5rem !important;
}

.profile-header h2 {
	font-size: 1.2rem !important;
}

/* 날짜 선택창 다크모드 대응 */
input[type="date"].login-input {
	color-scheme: dark;
}

/* 주소/우편번호 영역 압축 */
.zip-btn {
	height: 2.5rem !important;
	padding: 0 15px !important;
	background: rgba(255, 255, 255, 0.1);
	border: 1px solid rgba(255, 255, 255, 0.2);
	border-radius: 0.5rem !important;
	font-size: 0.8rem;
	transition: all 0.2s;
}

.submit-btn {
	height: 2.8rem;
	border-radius: 0.6rem;
	background: linear-gradient(to right, #a855f7, #6366f1);
	border: none;
	font-size: 0.9rem;
	font-weight: 700;
	margin-top: 0.5rem;
}

/* 검색 버튼 역할을 하는 span 강조 스타일 */
.zip-search-btn {
    /* 1. 위치 고정 (가장 중요) */
    position: absolute !important;
    top: 50% !important;        /* 부모 높이의 절반 지점 */
    right: 5px !important;      /* 우측 끝에서 살짝 띄움 */
    transform: translateY(-50%) !important; /* 자신의 높이 절반만큼 위로 보정 (완벽 수직 중앙) */
    
    /* 2. 모양 및 색상 */
    display: flex;
    align-items: center;
    justify-content: center;
    height: 1.8rem;             /* 인풋 높이(2.5rem)보다 작게 설정 */
    padding: 0 10px;
    background-color: rgba(255, 255, 255, 0.15);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 4px;
    
    /* 3. 폰트 및 기타 */
    color: white;
    font-size: 0.65rem;
    font-weight: bold;
    cursor: pointer;
    z-index: 10;                /* 인풋보다 위에 오도록 설정 */
    white-space: nowrap;        /* 글자가 줄바꿈되지 않게 함 */
}

.zip-search-btn:hover {
    background-color: rgba(168, 85, 247, 0.5);
    border-color: rgba(255, 255, 255, 0.3);
    transform: translateY(-50%) scale(1.02);
    
}

.zip-search-btn:active {
    transform: translateY(-50%) scale(0.95);
}

.required-dot::after {
    content: '';
    display: inline-block;
    width: 4px;
    height: 4px;
    background-color: #a855f7; /* 보라색 점 */
    border-radius: 50%;
    margin-left: 5px;
    vertical-align: top;
    box-shadow: 0 0 5px rgba(168, 85, 247, 0.8);
}

.error-text {
    color: #ff5555;
    font-size: 0.75rem;
    margin-top: 0.2rem;
    margin-bottom: 0.6rem;
    padding-left: 1.5rem; /* 입력창 아이콘 위치와 정렬 */
    display: flex;
    align-items: center;
    gap: 4px; /* 아이콘과 글자 사이 간격 */
    animation: fadeIn 0.2s ease;
}

.login-input.is-invalid {
    border-color: #ff5555 !important;
    box-shadow: 0 0 8px rgba(255, 85, 85, 0.2) !important;
}

.login-input#zip {
    padding-right: 4.8rem !important;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-5px); }
    to { opacity: 1; transform: translateY(0); }
}

/* 오버레이 배경 */
.success-overlay {
    position: absolute; /* fixed에서 absolute로 변경 */
    top: 0; 
    left: 0;
    width: 100%; 
    height: 100%;
    background: rgba(15, 23, 42, 0.9);
    backdrop-filter: blur(50px);
    -webkit-backdrop-filter: blur(50px);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 100; /* 카드 내부 요소들보다 위에 배치 */
    border-radius: inherit; /* 카드의 곡률을 그대로 상속 */
    animation: overlayFadeIn 0.6s ease;
}

/* 버튼을 감싸는 wrapper를 input 우측에 강제로 고정 */
.verify-btn-wrapper {
    position: absolute !important;
    top: 1.25rem !important; /* 입력창 높이의 절반 (login-input 높이가 2.5rem일 때) */
    right: 5px !important;
    transform: translateY(-50%) !important;
    z-index: 20; /* 에러 메시지보다 위에 오도록 설정 */
    display: flex;
    align-items: center;
}

/* VERIFY 버튼이 수직 중앙 정렬을 유지하도록 */
#verifyBtn {
    margin: 0 !important;
    position: static !important; /* wrapper가 위치를 잡으므로 버튼은 정적 배치 */
    transform: none !important;
}

/* 전송 중일 때 버튼을 어둡게 만드는 스타일 */
.btn-darken {
    opacity: 0.5 !important;           /* 반투명하게 */
    filter: brightness(0.7) !important; /* 밝기 감소 */
    cursor: not-allowed !important;    /* 마우스 커서 변경 */
    pointer-events: none !important;    /* 클릭 효과 차단 */
}

/* readonly 속성이 들어간 입력창 전용 스타일 */
.login-input[readonly] {
    opacity: 0.7 !important;
    cursor: not-allowed !important; /* default보다는 금지 표시가 '잠금' 느낌을 더 줍니다 */
    background-color: rgba(255, 255, 255, 0.02) !important;
    color: #888 !important; /* 글자색을 살짝 흐리게 하면 더 확실합니다 */
    border-color: rgba(255, 255, 255, 0.1) !important;
    pointer-events: none; /* 클릭이나 포커스 자체를 무시하게 만듭니다 */
}

/* 메시지 박스 */
.success-content {
    text-align: center;
    color: white;
    padding: 20px;
}

.success-icon {
    font-size: 5rem !important;
    color: #a855f7; /* 메인 보라색 */
    margin-bottom: 1rem;
    filter: drop-shadow(0 0 15px rgba(168, 85, 247, 0.5));
}

/* 하단 진행바 애니메이션 */
.loader-line {
    width: 100px;
    height: 3px;
    background: rgba(255, 255, 255, 0.1);
    margin: 20px auto 0;
    position: relative;
    overflow: hidden;
    border-radius: 10px;
}

.loader-line::after {
    content: '';
    position: absolute;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(to right, #a855f7, #6366f1);
    animation: loading 3s linear forwards;
}

input:-webkit-autofill,
input:-webkit-autofill:hover, 
input:-webkit-autofill:focus, 
input:-webkit-autofill:active {
    /* 배경색을 원하는 색상으로 고정 (예: 흰색 또는 폼 배경색) */
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    /* 글자색 고정 */
    -webkit-text-fill-color: #333 !important;
    /* 테두리 유지 */
    transition: background-color 5000s ease-in-out 0s;
}

@keyframes overlayFadeIn { from { opacity: 0; } to { opacity: 1; } }
@keyframes slideUp { to { transform: translateY(0); opacity: 1; } }
@keyframes loading { to { left: 0; } }
</style>
</head>
<body class="bg-background-dark text-white">

    <div class="space-background">
        <div class="stars"></div><div class="stars2"></div><div class="stars3"></div>
        <div class="planet planet-1"></div><div class="planet planet-2"></div>
    </div>

    <%@ include file="../home/header.jsp"%>

    <div class="app-body">
        <%@ include file="../home/sidebar.jsp"%>

		<main
			class="app-main d-flex justify-content-center align-items-center py-2">
			<div class="signup-card shadow-lg">
				<a href="${pageContext.request.contextPath}/member/login"
					class="position-absolute top-0 start-0 m-3 text-secondary hover-text-white transition-colors"
					style="z-index: 10;"> <span class="material-symbols-outlined"
					style="font-size: 1.2rem;">arrow_back</span>
				</a>

				<div id="successOverlay" class="success-overlay">
					<div class="success-content">
						<span class="material-symbols-outlined success-icon">check_circle</span>
						<h3>Registration Successful!</h3>
						<p>환영합니다! 잠시 후 로그인 페이지로 이동합니다.</p>
						<div class="loader-line"></div>
					</div>
				</div>

				<div class="text-center mb-3">
					<h2 class="text-white fw-bold fs-5 mb-1">Create Account</h2>
					<p class="text-secondary mb-0" style="font-size: 0.75rem;">Join
						us to get started</p>
				</div>

				<form name="memberForm" method="POST" class="w-100">
					<div class="position-relative">
						<span
							class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y input-icon text-secondary">person</span>
						<input type="text" name="userId" class="form-control login-input"
							autocomplete="off" placeholder="User ID">
					</div>

					<div class="position-relative">
						<span
							class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y input-icon text-secondary">lock</span>
						<input type="password" name="userPwd" autocomplete="off"
							class="form-control login-input" placeholder="Password">
					</div>

					<div class="position-relative">
						<span class="material-symbols-outlined input-icon text-secondary">check_circle</span>
						<input type="password" name="userPwd2" autocomplete="off"
							class="form-control login-input" placeholder="Confirm Password *">
					</div>

					<div class="position-relative">
						<span
							class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y input-icon text-secondary">badge</span>
						<input type="text" name="userName" autocomplete="off"
							class="form-control login-input" placeholder="Name">
					</div>

					<div class="position-relative">
						<span
							class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y input-icon text-secondary">face</span>
						<input type="text" name="userNickname" autocomplete="off"
							class="form-control login-input" placeholder="Nickname">
					</div>

					<div class="position-relative">
						<span
							class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y input-icon text-secondary">calendar_today</span>
						<input type="text" name="birth" class="form-control login-input"
							autocomplete="off" placeholder="Birth Date"
							onfocus="this.type='date'; this.max=new Date().toISOString().split('T')[0]"
							onblur="if(!this.value) this.type='text'">
					</div>

					<div class="position-relative">
						<span
							class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y input-icon text-secondary">mail</span>
						<input type="email" id="emailInput" name="email"
							class="form-control login-input" autocomplete="off"
							placeholder="Email Address"> <span id="sendCodeBtn"
							class="zip-search-btn" style="display: none;"
							onclick="sendAuthMail();"> SEND CODE </span>
					</div>

					<div id="emailAuthSection" class="mt-2" style="display: none;">
						<div class="position-relative">
							<span class="material-symbols-outlined input-icon text-secondary">verified_user</span>
							<input type="text" id="authCode" class="form-control login-input"
								placeholder="Verification Code" maxlength="6"
								style="padding-right: 70px !important;"> <span
								class="zip-search-btn" id="verifyBtn"
								onclick="verifyAuthCode();"
								style="position: absolute !important; top: 1.25rem !important; right: 5px !important; transform: translateY(-50%) !important; z-index: 20; height: 1.8rem; display: flex; align-items: center;">
								VERIFY </span>
						</div>

						<div class="text-center mt-2">
							<span id="authTimer"
								style="font-size: 0.85rem; color: #fb923c; font-weight: bold; background: rgba(251, 146, 60, 0.1); padding: 4px 10px; border-radius: 4px; display: inline-block;">
								03:00 </span>
						</div>
					</div>

					<div class="d-flex align-items-center my-1 opacity-50">
						<hr class="flex-grow-1 border-white border-opacity-25">
						<span class="mx-3 text-xs fw-light"
							style="font-size: 0.7rem; letter-spacing: 1px;">OPTIONAL
							INFO</span>
						<hr class="flex-grow-1 border-white border-opacity-25">
					</div>

					<div class="position-relative">
						<span
							class="material-symbols-outlined position-absolute top-50 start-0 translate-middle-y input-icon text-secondary">call</span>
						<input type="text" name="tel" class="form-control login-input"
							autocomplete="off" placeholder="Phone Number">
					</div>

					<div class="position-relative">
						<span class="material-symbols-outlined input-icon text-secondary">home</span>

						<input type="text" name="zip" id="zip" autocomplete="off"
							class="form-control login-input" placeholder="Zip Code" readonly
							onclick="daumPostcode();" style="cursor: pointer;"> <span
							class="zip-search-btn" onclick="daumPostcode();"> SEARCH </span>
					</div>

					<input type="text" name="addr1" id="addr1" autocomplete="off"
						class="form-control login-input" placeholder="Address" readonly>
					<input type="text" name="addr2" id="addr2" autocomplete="off"
						class="form-control login-input" placeholder="Detailed Address">

					<button type="button" id="signupBtn"
						class="btn w-100 fw-bold text-white submit-btn"
						onclick="memberOk();">SIGN UP</button>
				</form>

				<div class="text-center mt-2" style="font-size: 0.75rem;">
					<span class="text-secondary">Already have an account?</span> <a
						href="${pageContext.request.contextPath}/member/login"
						class="text-white fw-bold text-decoration-none ms-1">Log In</a>
				</div>
			</div>
		</main>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	
	<script type="text/javascript">
	
    let authTimerInterval;
    let isMemberOkChecking = false;
    let isEmailVerified = false;
    let isSendingMail = false;
    
    // 상태 값 함수
    const signupStatus = {
    	    idChecked: false,
    	    nicknameChecked: false,
    	    emailVerified: false,
    	    pwdMatched: false,
    	    nameEntered: false,
    	    birthEntered: false,

    	    checkAll: function() {
    	        const isReady = this.idChecked && 
    	                        this.pwdMatched && 
    	                        this.nameEntered && 
    	                        this.nicknameChecked && 
    	                        this.birthEntered &&
    	                        this.emailVerified; 
    	        
    	        $("#signupBtn").prop("disabled", !isReady);
    	    }
    	};
    
    // 필수 입력사항 입력 시 버튼 활성화, 검증이 필요한 입력사항은 입력 값 변경 시 false
    $(document).ready(function() {
        $('input[name=userId], input[name=userNickname], input[name=email]').on('input', function() {
            const name = $(this).attr('name');
            if(name === 'userId') signupStatus.idChecked = false;
            if(name === 'userNickname') signupStatus.nicknameChecked = false;
            if(name === 'email') {
            	signupStatus.emailVerified = false;
            	$("#emailAuthSection").slideUp(200);
            	$("#sendCodeBtn").text("SEND CODE").prop("disabled", false);
            	
            	if (authTimerInterval) {
                    clearInterval(authTimerInterval);
                    $("#authTimer").text("03:00");
                }
            };
            
            signupStatus.checkAll();
        });

        $('input[name=userName], input[name=birth]').on('input', function() {
            const val = $(this).val().trim();
            const name = $(this).attr('name');
            
            if(name === 'userName') signupStatus.nameEntered = val.length > 0;
            if(name === 'birth') signupStatus.birthEntered = val.length > 0;
            
            signupStatus.checkAll();
        });
        
        $('input[name=userPwd], input[name=userPwd2]').on('input', function() {
            signupStatus.pwdMatched = false;
            signupStatus.checkAll();
        });
    });
    
    // 정규식에 일치하는 이메일 입력 시 "SEND CODE" 버튼 생성
    $(function() {
        $("input[name=email]").on("input", function() {
            if (isEmailVerified) return;
            
            const email = $(this).val().trim();
            if (email.length > 0 && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                $("#sendCodeBtn").fadeIn(200);
            } else {
                $("#sendCodeBtn").fadeOut(200);
            }
        });
    });
    
	$(function() {
		// input 입력 또는 변경 시 에러 표시 제거 (최종 단계에서 강제 포커스 된 건 에러를 그대로 띄움)
		$("input").on("focus input change", function() {
		    if (!isMemberOkChecking) {
		        $(this).removeClass("is-invalid");
		        $(this).parent().find('.error-text').remove();
		    }
		});

		// 아이디 입력 검증 ( 실시간 )
	    $("input[name=userId]").on("blur", function() {
	    	const userId = ($(this).val() || "").trim();
	        const $input = $(this);
	        
	        signupStatus.idChecked = false;

	        if (! userId ) {
	        	showFieldError($input[0], "아이디를 입력해주세요.");
	        	signupStatus.checkAll();
	        	return;
	        }
	        if (!/^[a-z][a-z0-9]{4,11}$/.test(userId)) {
	            showFieldError($input[0], "영문 시작, 5~12자 조합이어야 합니다.");
	            signupStatus.checkAll();
	            return;
	        }

	        $.ajax({
	            type: "POST",
	            url: "${pageContext.request.contextPath}/member/checkDuplicate",
	            data: { userId: userId },
	            dataType: "json",
	            success: function(data) {
	                if (data.status === "failId") {
	                	signupStatus.idChecked = false;
	                    showFieldError($input[0], data.message);
	                } else {
	                	signupStatus.idChecked = true;
	                    $input.removeClass("is-invalid");
	                    const existingError = $input[0].parentElement.querySelector('.error-text');
	                    if (existingError) existingError.remove();
	                }
	                signupStatus.checkAll();
	            }
	        });
	    });

	 	// 닉네임 입력 검증 ( 실시간 )
	    $("input[name=userNickname]").on("blur", function() {
	    	const userNickname = ($(this).val() || "").trim();
	        const $input = $(this);
	        
	        signupStatus.nicknameChecked = false;

	        if (! userNickname ) {
	        	showFieldError($input[0], "닉네임을 입력해주세요.");
	        	signupStatus.checkAll();
	        	return;
	        }
	        if (!/^[a-zA-Z0-9가-힣]{2,10}$/.test(userNickname)) {
	            showFieldError($input[0], "닉네임은 특수문자 제외 2~10자여야 합니다.");
	            signupStatus.checkAll();
	            return;
	        }

	        $.ajax({
	            type: "POST",
	            url: "${pageContext.request.contextPath}/member/checkDuplicate",
	            data: { userNickname: userNickname },
	            dataType: "json",
	            success: function(data) {
	                if (data.status === "failNickname") {
	                	signupStatus.nicknameChecked = false;
	                    showFieldError($input[0], data.message);
	                } else {
	                	signupStatus.nicknameChecked = true;
	                    $input.removeClass("is-invalid");
	                    const existingError = $input[0].parentElement.querySelector('.error-text');
	                    if (existingError) existingError.remove();
	                }
	                signupStatus.checkAll();
	            }
	        });
	    });
	    
	 	// 비밀번호 입력 검증 ( 실시간 )
	    $("input[name=userPwd]").on("blur", function() {
	    	const userPwd = $(this).val().trim();
	        const $input = $(this);
	        
	        if (! userPwd ) {
	        	showFieldError($input[0], "비밀번호를 입력해주세요.");
	        	signupStatus.pwdMatched = false;
	        } else if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test(userPwd)) {
	            showFieldError($input[0], "비밀번호는 영문, 숫자, 특수문자 포함 8 ~ 16자여야 합니다.");
	            signupStatus.pwdMatched = false;
	        } else {
	        	chkPwdMatch();
	        }
	        signupStatus.checkAll();
	    });
	    
	    $("input[name=userPwd2]").on("blur", function() {
	    	chkPwdMatch();
	        signupStatus.checkAll();
	    });
	    
	    function chkPwdMatch() {
	    	const $input2 = $('input[name=userPwd2]');
	    	const pwd1 = $('input[name=userPwd]').val().trim();
	    	const pwd2 = $('input[name=userPwd2]').val().trim();
	    	
	    	if(pwd1 === pwd2 && pwd2.length > 0) {
	    		signupStatus.pwdMatched = true;
	            $input2.removeClass("is-invalid");
	            $input2.parent().find('.error-text').remove();
	        } else {
	            signupStatus.pwdMatched = false;
	            if (pwd2.length > 0 && pwd1 !== pwd2) {
	                showFieldError($input2[0], "비밀번호가 일치하지 않습니다.");
	            }
	        }
	    }
	});

    function sendAuthMail() {
    	if (isSendingMail) return;
    	
    	const $input = $("#emailInput");
        const email = $("#emailInput").val().trim();
        const $btn = $("#sendCodeBtn");

        isSendingMail = true;
        $btn.addClass("btn-darken").text("SENDING...");

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/member/sendAuthEmail",
            data: { email: email },
            dataType: "json",
            success: function(data) {
                if(data.status === "success") {
                    $("#emailAuthSection").slideDown(300);
                    startAuthTimer(180);
                    setTimeout(function() {
                    	isSendingMail = false;
                    	if ($("#sendCodeBtn").length > 0) {
                    		$btn.removeClass("btn-darken").text("RESEND");
                        }
                    }, 10000);
                } else if(data.status === "emailSendError"){
                	showFieldError($input[0], "이메일 전송에 실패했습니다. 다시 전송해주세요.");
                	isSendingMail = false;
                	$btn.removeClass("btn-darken").text("SEND CODE");
                } else {
                	showFieldError($input[0], "서버 에러 발생. 다시 전송해주세요.");
                	isSendingMail = false;
                	$btn.removeClass("btn-darken").text("SEND CODE");
                }
            },
            error: function() {
            	showFieldError($input[0], "서버 통신 중 오류 발생.");
            	isSendingMail = false;
            	$btn.removeClass("btn-darken").text("SEND CODE");
            }
        });
    }
    
    function verifyAuthCode() {
    	const $email = $("#emailInput");
    	const $authCode = $("#authCode");
    	const $verifyBtn = $("#verifyBtn");
    	
    	const email = $email.val().trim();
    	const authCode = $authCode.val().trim();
    	
    	$verifyBtn.prop("disabled", true);
    	
    	$.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/member/chkAuthEmail",
            data: { email: email, userCode: authCode },
            success: function(data) {
                if(data.status === "success") {
                	signupStatus.emailVerified = true;
                	if (authTimerInterval) clearInterval(authTimerInterval);
                	$("#emailInput").prop("readonly", true);
                    $("#sendCodeBtn").remove();
                    
                    $verifyBtn
                    .prop("disabled", true)
                    .css({"background": "#22c55e", "border-color": "#22c55e", "color": "white"})
                    .text("VERIFIED ✓");
                    
                	setTimeout(function() {
                    	$("#emailAuthSection").slideUp(300);
                    	signupStatus.checkAll();
                	}, 800);
                } else if(data.status === "expired") {
                	showFieldError($authCode[0], "세션이 만료되었습니다. 다시 시도해주세요.");
                    $verifyBtn.prop("disabled", false);
                } else if(data.status === "invalidEmail") {
                	showFieldError($authCode[0], "현재 이메일이 인증을 요청한 이메일과 다릅니다.");
                    $verifyBtn.prop("disabled", false);
                } else if(data.status === "timeout") {
                	showFieldError($authCode[0], "인증 시간이 초과되었습니다. 다시 요청해주세요.");
                    $verifyBtn.prop("disabled", false);
                } else {
                	showFieldError($authCode[0], "인증에 실패하였습니다.");
	                $verifyBtn.prop("disabled", false);
	            }
            },
            error: function() {
            	showFieldError($authCode[0], "서버 통신 중 오류 발생.");
            	$verifyBtn.prop("disabled", false);
            }
        });
    	
    }
	
	function memberOk() {
		isMemberOkChecking = true;
	    const f = document.memberForm;
	    const btn = document.querySelector("#signupBtn");

	    document.querySelectorAll('.error-text').forEach(el => el.remove());
	    document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
	    
	    if (!signupStatus.idChecked) {
	        showFieldError(f.userId, "아이디 중복 확인이 필요합니다.");
	        f.userId.focus();
	        isMemberOkChecking = false;
	        return;
	    }
	    
	    if (!signupStatus.pwdMatched) {
	        showFieldError(f.userPwd2, "비밀번호가 일치하지 않거나 형식이 올바르지 않습니다.");
	        f.userPwd2.focus();
	        isMemberOkChecking = false;
	        return;
	    }

	    if (!signupStatus.nicknameChecked) {
	        showFieldError(f.userNickname, "닉네임 중복 확인이 필요합니다.");
	        f.userNickname.focus();
	        isMemberOkChecking = false;
	        return;
	    }

	    if (!signupStatus.emailVerified) {
	        showFieldError(f.email, "이메일 인증이 필요합니다.");
	        f.email.focus();
	        isMemberOkChecking = false;
	        return;
	    }

	    if (!f.userName.value.trim()) {
	        showFieldError(f.userName, "이름을 입력해주세요.");
	        f.userName.focus();
	        isMemberOkChecking = false;
	        return;
	    }

	    if (!f.birth.value.trim()) {
	        showFieldError(f.birth, "생년월일을 입력해주세요.");
	        f.birth.focus();
	        isMemberOkChecking = false;
	        return;
	    }

        const url = '${pageContext.request.contextPath}/member/signupAjax';
        
        if(btn) btn.disabled = true;
        
        isMemberOkChecking = false;
    	
    	$.ajax({
            type: "POST",
            url: url,
            data: $("form[name=memberForm]").serialize(),
            dataType: "json",
            success: function(data) {
                if (data.status === "success") {
                    showSuccessOverlay();
                } else if (data.status === "emailFail") {
                	alert(data.message);
                	if(btn) btn.disabled = false;
                } else {
                	alert(data.message);
                	if(btn) btn.disabled = false;
                }
            },
            error: function(e) {
                alert("서버 통신 오류가 발생했습니다.");
                if(btn) btn.disabled = false;
            }
        });
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
    
    function showFieldError(inputElement, message) {
        const existingError = inputElement.parentElement.querySelector('.error-text');
        if (existingError) existingError.remove();

        inputElement.classList.add('is-invalid');
        
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-text d-flex align-items-center gap-1'; // 아이콘과 텍스트 정렬

        errorDiv.innerHTML = `
            <span class="material-symbols-outlined" style="font-size: 0.85rem;">cancel</span>
            <span>\${message}</span>
        `;

        inputElement.parentElement.appendChild(errorDiv);      
    }
    
    function showSuccessOverlay() {
        const overlay = document.getElementById('successOverlay');
        overlay.style.display = 'flex';

        setTimeout(() => {
            location.href = '${pageContext.request.contextPath}/member/login';
        }, 3000);
    }
    

    function startAuthTimer(duration) {
        let timer = duration, minutes, seconds;
        if (authTimerInterval) clearInterval(authTimerInterval);

        authTimerInterval = setInterval(function () {
            minutes = parseInt(timer / 60, 10);
            seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            $("#authTimer").text(minutes + ":" + seconds);

            if (--timer < 0) {
                clearInterval(authTimerInterval);
                $("#authTimer").text("00:00").css("color", "#ff5555");
                alert("인증 시간이 만료되었습니다. 다시 시도해주세요.");
            }
        }, 1000);
    }
    
	</script>
</body>
</html>