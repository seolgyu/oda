<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="glass-card p-4 shadow-lg mx-auto"
	style="width: 820px; min-width: 820px; max-width: 100%;">
	<div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
		<h2 class="text-white fs-4 fw-bold mb-1">Account Information</h2>
		<p class="text-secondary text-sm mb-0">Manage your cosmic
			credentials and personal information.</p>
	</div>

	<form id="accountForm" class="d-flex flex-column gap-4">

		<div class="row g-3">
			<div class="col-md-6">
				<label
					class="text-white text-xs fw-bold mb-2 d-block opacity-50 text-uppercase tracking-wider">User
					ID</label> <input type="text" name="userId"
					class="form-control login-input opacity-50"
					value="${user.userId}" readonly
					style="cursor: not-allowed; padding-left: 20px !important;">
			</div>
			<div class="col-md-6">
				<label
					class="text-white text-xs fw-bold mb-2 d-block opacity-50 text-uppercase tracking-wider">Email
					Address</label> <input type="email" name="email"
					class="form-control login-input opacity-50" value="${user.email}" readonly
					style="cursor: not-allowed; padding-left: 20px !important;">
			</div>
		</div>

		<div class="row g-3">
			<div class="col-md-6">
				<label
					class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">USERNAME</label>
					<input type="text" name="userName"
					class="form-control login-input" value="${user.userName}" placeholder="Your Name"
					style="padding-left: 20px !important;">
			</div>
			<div class="col-md-6">
				<label
					class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">NICKNAME</label>
				<div class="d-flex gap-2">
					<input type="text" name="userNickname" id="input-nickname"
						class="form-control login-input"
						value="${user.userNickname}" placeholder="Nickname"
						style="flex: 1; padding-left: 20px !important;">
					<button class="btn btn-outline-light px-3 fw-bold" type="button"
						id="btn-check-nickname"
						style="border-color: rgba(255, 255, 255, 0.15); white-space: nowrap; font-size: 0.8rem; border-radius: 0.375rem !important;">
						Check</button>
				</div>
			</div>
		</div>

		<div class="row g-3">
			<div class="col-md-6">
				<label
					class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">Birth
					Date</label> <input type="date" name="birth"
					class="form-control login-input"
					value="${fn:substring(user.birth, 0, 10)}"
					style="padding-left: 20px !important; color-scheme: dark;">
			</div>
			<div class="col-md-6">
				<label
					class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">Phone
					Number</label> <input type="tel" name="tel"
					class="form-control login-input" value="${user.tel}"
					placeholder="010-0000-0000" style="padding-left: 20px !important;">
			</div>
		</div>

		<div class="d-flex flex-column gap-2 pb-2">
			<div>
				<label
					class="text-white text-xs fw-bold mb-2 d-block text-uppercase tracking-wider">Home
					Address</label>
				<div class="d-flex gap-2" style="width: 50%;">
					<input type="text" name="zip" id="zip" value="${user.zip}"
						class="form-control login-input" placeholder="Zip Code" readonly
						onclick="daumPostcode();"
						style="cursor: pointer; padding-left: 20px !important;">
					<button type="button" class="btn btn-outline-light px-3 fw-bold"
						onclick="daumPostcode();"
						style="border-color: rgba(255, 255, 255, 0.15); white-space: nowrap; font-size: 0.8rem; border-radius: 0.375rem !important;">
						SEARCH</button>
				</div>
			</div>
			<input type="text" name="addr1" id="addr1" value="${user.addr1}"
				class="form-control login-input" placeholder="Address" readonly
				style="padding-left: 20px !important;"> <input type="text"
				name="addr2" id="addr2" value="${user.addr2}" class="form-control login-input"
				placeholder="Detailed Address"
				style="padding-left: 20px !important;">
		</div>

		<div
			class="d-flex justify-content-between align-items-center pt-4 border-top border-white border-opacity-10 mt-2">
			<p class="text-xs text-secondary mb-0">
				<span class="material-symbols-outlined align-middle"
					style="font-size: 14px;">verified_user</span> Permanent fields
				cannot be updated.
			</p>
			<button type="button" id="btn-update-account"
				class="btn btn-primary rounded-pill px-5 fw-bold"
				style="background: #2563eb; border: none;">Update Account</button>
		</div>
	</form>
</div>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 1. 카카오 주소 API
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

    $(function() {
        // 2. 닉네임 중복 체크 (AJAX)
        $('#btn-check-nickname').on('click', function() {
            const nickname = $('#input-nickname').val();
            if(!nickname) {
                alert("Please enter a nickname.");
                return;
            }
            
            $.ajax({
                url: '${pageContext.request.contextPath}/member/checkNickname',
                type: 'POST',
                data: { userNickname: nickname },
                success: function(res) {
                    if(res === "available") {
                        alert("This nickname is available.");
                        $('#input-nickname').data('checked', true);
                    } else {
                        alert("This nickname is already in use.");
                        $('#input-nickname').data('checked', false);
                    }
                },
                error: function() { alert("Error connecting to server."); }
            });
        });

        // 3. 계정 정보 업데이트 (AJAX)
        $('#btn-update-account').on('click', function() {
            // 간단한 유효성 검사 예시
            if(!$('#input-nickname').val()) {
                alert("Nickname is required.");
                return;
            }

            const formData = $('#accountForm').serialize();
            
            $.ajax({
                url: '${pageContext.request.contextPath}/member/updateAccount',
                type: 'POST',
                data: formData,
                success: function(res) {
                    if(res === "success") {
                        alert("Account information updated successfully!");
                        location.reload();
                    } else {
                        alert("Update failed. Please check your inputs.");
                    }
                },
                error: function() { alert("Error saving data."); }
            });
        });
    });
</script>