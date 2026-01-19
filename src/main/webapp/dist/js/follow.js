/**
 * 
 */

function toggleFollow(addUserNum, btn) {
    if (typeof isLogin === "undefined" || isLogin === "false") {
        if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
            location.href = window.cp + "/member/login";
        }
        return;
    }

    const $btn = $(btn);
    if ($btn.data('loading')) return;
    $btn.data('loading', true);

    $.ajax({
        url: window.cp + "/follow/followApply",
        type: "POST",
        data: { addUserNum: addUserNum },
        dataType: "json",
        success: function(data) {
            if (data.status === "success") {
                if (data.isFollowing) {
                    $btn.addClass("btn-following").text("Following");
                    showToast("success", (data.addUserId || "사용자") + " 님을 팔로우했습니다.");
                } else {
                    $btn.removeClass("btn-following").text("Follow");
                    showToast("info", "팔로우를 취소했습니다.");
                }
            } else {
				showToast("error", "팔로우 처리에 실패했습니다.");
			}
        },
        error: function() {
            showToast("error", "서버 통신 오류가 발생했습니다.");
        },
        complete: function() {
            $btn.data('loading', false);
        }
    });
}