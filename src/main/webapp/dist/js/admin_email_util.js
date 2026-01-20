function sendStatusMail(email, statusCode) {
    console.log("이메일 함수 접근 테스트");
    console.log("Email:", email);
    console.log("StatusCode:", statusCode);

    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/admin/member/sendStatusEmail",
        data: {
            email: email,
            statusCode: statusCode
        },
        dataType: "json",
        success: function(data) {
            console.log("서버 응답:", data);
            
            if(data.status === "success") {
                console.log("이메일 전송 성공!");
                alert("상태 변경 알림 메일이 발송되었습니다.");
            } else if(data.status === "emailSendError") {
                console.error("이메일 전송 실패");
                alert("이메일 전송에 실패했습니다.");
            } else {
                console.error("서버 에러");
                alert("서버 에러가 발생했습니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 에러:", error);
            console.error("상태:", status);
            console.error("응답:", xhr.responseText);
            alert("서버 통신 중 오류가 발생했습니다.");
        }
    });
	};