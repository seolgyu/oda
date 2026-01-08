// 체크박스 공통 제어
$(function(){
    // 전체 선택/해제
    $('.form-check-input-all').on('change', function(){
        const isChecked = $(this).prop('checked');
        $('.form-check-input').prop('checked', isChecked);
    });

    // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
    $(document).on('change', '.form-check-input', function(){
        const totalCount = $('.form-check-input').length;
        const checkedCount = $('.form-check-input:checked').length;

        $('.form-check-input-all').prop('checked', totalCount === checkedCount);
    });
    
    // ✅ 검색 기능 추가
    function searchList() {
        const f = document.searchForm;
        if(!f || !f.kwd.value.trim()) {
            alert('검색어를 입력하세요.');
            f && f.kwd.focus();
            return;
        }
        
		const formData = new FormData(f);
        let params = new URLSearchParams(formData).toString();
        const pathname = window.location.pathname;
        let url = pathname.substring(0, pathname.lastIndexOf('/')) + '/list';
        
        location.href = url + '?' + params;
    }
    
    // 전역 함수로 등록 (onclick에서 사용)
    window.searchList = searchList;
    
    // 엔터키 검색
    $('input[name="kwd"]').on('keypress', function(e) {
        if(e.key === 'Enter' || e.keyCode === 13) {
            e.preventDefault();
            searchList();
        }
    });
    
    // 검색 아이콘 클릭 (선택사항 - onclick 대체)
    $('.search-icon').on('click', function() {
        searchList();
    });
});