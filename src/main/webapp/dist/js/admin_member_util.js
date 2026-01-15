$(function(){
    function searchList() {
        const f = document.searchForm;
        if(!f) {
            return;
        }

        const formData = new FormData(f);
        let params = new URLSearchParams(formData).toString();
        const pathname = window.location.pathname;
        let url = pathname.substring(0, pathname.lastIndexOf('/')) + '/list';

        location.href = url + '?' + params;
    }

    window.searchList = searchList;

    $('input[name="kwd"]').on('keypress', function(e) {
        if(e.key === 'Enter' || e.keyCode === 13) {
            e.preventDefault();
            searchList();
        }
    });
	
$('.glass-btn-group .btn').on('click', function() {
        const state = $(this).val();
        const f = document.searchForm;
        
        if(!f) {
            return;
        }
        
        // state input 값 업데이트
        $('input[name="state"]').val(state);
        
        // 검색 실행
        const formData = new FormData(f);
        let params = new URLSearchParams(formData).toString();
        const pathname = window.location.pathname;
        let url = pathname.substring(0, pathname.lastIndexOf('/')) + '/list';
        
        location.href = url + '?' + params;
    });
});