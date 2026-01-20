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
});