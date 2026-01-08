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

    // ========================================
    // 검색 기능
    // ========================================
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

    // 전역 함수로 등록 (onclick에서 사용)
    window.searchList = searchList;

    // 엔터키 검색
    $('input[name="kwd"]').on('keypress', function(e) {
        if(e.key === 'Enter' || e.keyCode === 13) {
            e.preventDefault();
            searchList();
        }
    });

    // 검색 아이콘 클릭
    $('.search-icon').on('click', function() {
        searchList();
    });

    // ========================================
    // 필터 버튼 클릭 이벤트
    // ========================================
    $('.glass-btn-group .btn').on('click', function(e){
        e.preventDefault(); // ✅ 기본 동작 방지
        
        console.log('버튼 클릭됨'); // ✅ 디버깅용
        
        // 모든 버튼의 active 클래스 제거
        $('.glass-btn-group .btn').removeClass('active');

        // 클릭한 버튼에 active 클래스 추가
        $(this).addClass('active');

        // 버튼의 value 값 또는 텍스트 가져오기
        const stateValue = $(this).val() || $(this).attr('value') || '';
        
        console.log('State Value:', stateValue); // ✅ 디버깅용

        // 현재 검색 조건 가져오기
        const schType = $('select[name="schType"]').val() || 'all';
        const kwd = $('input[name="kwd"]').val() || '';
        const size = $('input[name="size"]').val() || '10';

        // URLSearchParams로 쿼리스트링 생성
        const params = new URLSearchParams();
        params.append('size', size);
        params.append('schType', schType);
        params.append('kwd', kwd);

        // state 값이 있으면 추가 (전체 버튼은 빈 값)
        if(stateValue) {
            params.append('state', stateValue);
        }

        // 페이지 이동
        const pathname = window.location.pathname;
        const url = pathname + '?' + params.toString();
        
        console.log('이동할 URL:', url); // ✅ 디버깅용
        
        location.href = url;
    });
});