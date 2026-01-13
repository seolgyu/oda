$(function() {
    enableAppMode();
    loadCommunityList();

    $('#community-search').on('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            loadCommunityList();
        }
    });

    $(document).on('click', '.topic-btn', function() {
        const $this = $(this);
        
        if ($this.hasClass('selected')) {
            $this.removeClass('selected');
            $('#category_id_input, #selectedTopic').val(""); 
        } else {
            $('.topic-btn').removeClass('selected');
            $this.addClass('selected');
            $('#category_id_input, #selectedTopic').val($this.attr('data-id'));
        }
        
        loadCommunityList();
    });
});

function loadCommunityList() {
    const keyword = $('#community-search').val() || "";
    const $selectedBtn = $('.topic-btn.selected');
    const category_id = $selectedBtn.length > 0 ? $selectedBtn.attr('data-id') : "";

    ajaxRequest("list_search", 'GET', { keyword, category_id }, 'text', function(data) {
        $('#community-list').html(data);
    });
}