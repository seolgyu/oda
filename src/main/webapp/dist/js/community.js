const getCommunityId = function() {
    var $community_id = document.querySelector('input[name="community_id"]');
    if ($community_id) {
        return $community_id.value;
    } else {
        return "";
    }
};
const communityId = getCommunityId();

function enableAppMode() {
    $('body').addClass('community-app-mode');
    if (!$('#app-mode-style').length) {
        $('<style id="app-mode-style">')
            .html(`.community-app-mode { -webkit-user-select: none; user-select: none; }
                   .community-app-mode input, .community-app-mode textarea { -webkit-user-select: text; user-select: text; cursor: text; }`)
            .appendTo('head');
    }
}

function showToast(type, msg) {
    const $toast = $('#sessionToast').length ? $('#sessionToast') : $('.glass-toast');
    const $msg = $('#toastMessage').length ? $('#toastMessage') : $toast.find('.toast-msg'); 
    const $icon = $toast.find('.material-symbols-outlined');
    const $iconCircle = $toast.find('.toast-icon-circle');

    $msg.text(msg);

    if (type === "success") {
        $icon.text('check_circle');
        $iconCircle.css('background', 'linear-gradient(to top right, #22c55e, #10b981)');
    } else if (type === "error") {
        $icon.text('error');
        $iconCircle.css('background', 'linear-gradient(to top right, #ef4444, #f43f5e)');
    } else if (type === "info") {
        $icon.text('info');
        $iconCircle.css('background', 'linear-gradient(to top right, #a855f7, #6366f1)');
    }

    $toast.addClass('show');

    setTimeout(function() {
        $toast.removeClass('show');
    }, 2500);
}