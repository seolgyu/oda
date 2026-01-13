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