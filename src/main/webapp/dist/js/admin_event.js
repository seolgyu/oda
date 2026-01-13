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

    // activestatus 버튼
    $('.glass-btn-group .btn').on('click', function(e) {
		e.preventDefault();
		$('.glass-btn-group .btn').removeClass('active');
		$(this).addClass('active');
		
		const statusValue = $(this).val() || $(this).attr('value') || '';
		const schType = $('select[name="schType"]').val() || 'all';
		const kwd = $('input[name="kwd"]').val() || '';
		const size = $('input[name="size"]').val() || '10';
		
		const params = new URLSearchParams();
		params.append('size', size);
		params.append('schType', schType);
		params.append('kwd', kwd);
		
		if(statusValue){
			params.append('status', statusValue);
		}
		
		const pathname = window.location.pathname;
		const url = pathname + '?' + params.toString();
		
		location.href = url;
    });
	
	
	
    $('form-check-input-all').on('change', function(){
		const isChecked = $(this).prop('checked');
		$('input[name=event_num]').prop('checked', isChecked);
	});
	
	
	$(document).on('change', 'input[name=event_num]', function(){
		const totalCount = $('input[name=event_num]').length;
		const checkedCount = $('input[name=event_num]:checked').length;
		$('.form-check-input-all').prop('checked', totalCount === checkedCount);
	});
	
	function getSearchParams(){
		const urlParams = new URLSearchParams(window.location.search);
		return {
			schType: $('select[name="schType"]').val() || 'all',
			kwd: $('input[name="kwd"]').val() || '',
			status: $('input[name="status"]').val() || '',
			size: $('input[name="size"]').val() || '10',
			page: urlParams.get('page') || '1'
		};
	}
	
	function addHiddenInput(form, name, value){
		if(value){
			$('<input>')
				.attr('type', 'hidden')
				.attr('name', name)
				.val(value)
				.appendTo(form)
		}
	}

	// 검색 조회 시 top고정 리스트 숨기기
	
	// 이벤트 삭제
	$('#btnDeleteList').on('click', function(e) {
	    e.preventDefault();

	    const checkedItems = $('input[name="event_num"]:checked');

	    if(checkedItems.length === 0) {
	        alert('삭제할 이벤트를 선택해주세요.');
	        return;
	    }

	    if(!confirm(`선택한 ${checkedItems.length}개의 이벤트를 삭제하시겠습니까?`)) {
	        return;
	    }

	    const f = document.deleteForm;
	    $(f).empty();

	    checkedItems.each(function() {
	        $(this).clone().appendTo(f);
	    });

	    const params = getSearchParams();
	    addHiddenInput(f, 'schType', params.schType);
	    addHiddenInput(f, 'kwd', params.kwd);
	    addHiddenInput(f, 'state', params.state);
	    addHiddenInput(f, 'size', params.size);
	    addHiddenInput(f, 'page', params.page);

	    const pathname = window.location.pathname;
	    const baseUrl = pathname.substring(0, pathname.lastIndexOf('/'));
	    f.action = baseUrl + '/deleteList';
	    f.submit();
	});

	
});


