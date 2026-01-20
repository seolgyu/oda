function searchEvent() {
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

$(function(){
    // 엔터키 검색
    $('input[name="kwd"]').on('keypress', function(e) {
        if(e.key === 'Enter' || e.keyCode === 13) {
            e.preventDefault();
            searchEvent();
        }
    });

	
	$('#btnDeleteList').on('click', function() {
	    // 1. 체크박스 선택 확인
	    const $checked = $('input[name="event_nums"]:checked');
		
		console.log("체크된 개수: " + $checked.length);
		
	    if ($checked.length === 0) {
	        alert('삭제할 항목을 선택하세요.');
	        return;
	    }

	    if (!confirm('선택한 항목을 삭제하시겠습니까?')) return;

	    // 2. HTML에 만든 폼 이름으로 접근
	    const f = document.deleteForm;

	    f.action = "deleteList"; 
	    
	    // 4. 전송
	    f.submit();
	});
});


