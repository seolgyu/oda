$(function(){
    // 검색 함수
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

    // 전역으로 노출
    window.searchList = searchList;

    // 엔터키 검색
    $('input[name="kwd"]').on('keypress', function(e) {
        if(e.key === 'Enter' || e.keyCode === 13) {
            e.preventDefault();
            searchList();
        }
    });
	
    // 상태 버튼 클릭
    $('.glass-btn-group .btn').on('click', function() {
        const state = $(this).val();
        const f = document.searchForm;
        
        if(!f) {
            return;
        }
        
        $('input[name="state"]').val(state);
        
        const formData = new FormData(f);
        let params = new URLSearchParams(formData).toString();
        const pathname = window.location.pathname;
        let url = pathname.substring(0, pathname.lastIndexOf('/')) + '/list';
        
        location.href = url + '?' + params;
    });
    
    // 전체 선택 체크박스
    $('#chkAll').change(function() {
        $('.chk').prop('checked', $(this).prop('checked'));
    });
    
    $('.chk').change(function() {
        let total = $('.chk').length;
        let checked = $('.chk:checked').length;
        $('#chkAll').prop('checked', total === checked);
    });
});

// ==========================================
// 일괄 처리 함수들 (전역 스코프)
// ==========================================

// 일괄 휴면 처리
function bulkDormant() {
    const checkedBoxes = document.querySelectorAll('.chk:checked');
    
    if (checkedBoxes.length === 0) {
        alert('휴면 처리할 회원을 선택해주세요.');
        return;
    }
    
    const memberIds = [];
    checkedBoxes.forEach(checkbox => {
        memberIds.push(checkbox.value);
    });
    
    if (!confirm(`선택한 ${memberIds.length}명의 회원을 휴면 상태로 변경하시겠습니까?`)) {
        return;
    }
    
    const contextPath = document.querySelector('input[name="contextPath"]')?.value || '';
    const formData = new FormData();
    formData.append('memberIds', memberIds.join(','));
    formData.append('status', 3);
    
    fetch(contextPath + '/admin/member/updateStatus', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('HTTP error! status: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            alert('선택한 회원을 휴면 처리했습니다.');
            location.reload();
        } else {
            alert('휴면 처리 중 오류가 발생했습니다: ' + (data.message || ''));
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('휴면 처리 중 오류가 발생했습니다: ' + error.message);
    });
}

// 일괄 정지 처리
function bulkSuspend() {
    const checkedBoxes = document.querySelectorAll('.chk:checked');
    
    if (checkedBoxes.length === 0) {
        alert('정지 처리할 회원을 선택해주세요.');
        return;
    }
    
    const memberIds = [];
    checkedBoxes.forEach(checkbox => {
        memberIds.push(checkbox.value);
    });
    
    if (!confirm(`선택한 ${memberIds.length}명의 회원을 정지 상태로 변경하시겠습니까?`)) {
        return;
    }
    
    const contextPath = document.querySelector('input[name="contextPath"]')?.value || '';
    const formData = new FormData();
    formData.append('memberIds', memberIds.join(','));
    formData.append('status', 4);
    
    fetch(contextPath + '/admin/member/updateStatus', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('HTTP error! status: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            alert('선택한 회원을 정지 처리했습니다.');
            location.reload();
        } else {
            alert('정지 처리 중 오류가 발생했습니다: ' + (data.message || ''));
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('정지 처리 중 오류가 발생했습니다: ' + error.message);
    });
}

// 일괄 정상 처리
function bulkActivate() {
    const checkedBoxes = document.querySelectorAll('.chk:checked');
    
    if (checkedBoxes.length === 0) {
        alert('정상 처리할 회원을 선택해주세요.');
        return;
    }
    
    const memberIds = [];
    checkedBoxes.forEach(checkbox => {
        memberIds.push(checkbox.value);
    });
    
    if (!confirm(`선택한 ${memberIds.length}명의 회원을 정상 상태로 변경하시겠습니까?`)) {
        return;
    }
    
    const contextPath = document.querySelector('input[name="contextPath"]')?.value || '';
    const formData = new FormData();
    formData.append('memberIds', memberIds.join(','));
    formData.append('status', 1);
    
    fetch(contextPath + '/admin/member/updateStatus', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('HTTP error! status: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            alert('선택한 회원을 정상 처리했습니다.');
            location.reload();
        } else {
            alert('정상 처리 중 오류가 발생했습니다: ' + (data.message || ''));
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('정상 처리 중 오류가 발생했습니다: ' + error.message);
    });
}