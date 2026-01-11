$(function(){
	function search() {
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

    // 검색
    window.search = search;

    // 엔터키 검색
    $('input[name="kwd"]').on('keypress', function(e) {
        if(e.key === 'Enter' || e.keyCode === 13) {
            e.preventDefault();
            search();
        }
    });

    // 검색 아이콘 클릭
    $('.search-icon').on('click', function() {
        searchList();
    });
	
    $('.glass-btn-group .btn').on('click', function(e){
        e.preventDefault(); 
        
        console.log('버튼 클릭됨'); 
        
        // 모든 버튼의 active 클래스 제거
        $('.glass-btn-group .btn').removeClass('activestatus');

        // 클릭한 버튼에 active 클래스 추가
        $(this).addClass('activestatus');

        // 버튼의 value 값 또는 텍스트 가져오기
        const activestatus = $(this).val() || $(this).attr('value') || '';
        
        // 현재 검색 조건 가져오기
        const schType = $('select[name="schType"]').val() || 'all';
        const kwd = $('input[name="kwd"]').val() || '';
        const size = $('input[name="size"]').val() || '10';

        // URLSearchParams로 쿼리스트링 생성
        const params = new URLSearchParams();
        params.append('size', size);
        params.append('schType', schType);
        params.append('kwd', kwd);

        
        if(activestatus) {
            params.append('activestatus', activestatus);
        }

        // 페이지 이동
        const pathname = window.location.pathname;
        const url = pathname + '?' + params.toString();
	
        
        console.log('이동할 URL:', url);
        
        location.href = url;
		
		});

	// 검색 조회 시 top고정 리스트 숨기기

	
	// 클릭한 이벤트로 이동
	$('.eventlink').on('click', function() {
	    const no = $(this).data('no');
	    location.href = '/event/detail?no=' + no;
	});
});


