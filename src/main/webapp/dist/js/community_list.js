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

let selectedCommunityId = null; 

function joinCommunity(community_id) {
    selectedCommunityId = community_id;
    $('#join-modal').removeClass('hidden');
}

function closeJoinModal() {
    $('#join-modal').addClass('hidden');
    selectedCommunityId = null;
}

$(function() {
	$('#confirm-join-btn').on('click', function() {
	    if (!selectedCommunityId) return;
		const fn = function(data){
			if(data.status === 'success') {
				location.href = "main?community_id=" + data.community_id + "&join=success";
			} else {
				showToast("error", "가입 처리에 실패했습니다. 다시 시도해주세요.");
			}
		};
	    ajaxRequest("join", 'GET', { community_id: selectedCommunityId }, 'json', fn);
	});
    
    $('#join-modal').on('click', function(e) {
        if (e.target === this) closeJoinModal();
    });
});

function showToast(type, msg) {
    const container = document.getElementById('toastContainer');
    if (!container) return; 

    const toastId = 'toast-' + Date.now();
    let title = 'SYSTEM', icon = 'info', color = '#8B5CF6';
    
    if (type === "success") { 
        title = 'SUCCESS'; icon = 'check_circle'; color = '#4ade80'; 
    } else if (type === "error") { 
        title = 'ERROR'; icon = 'error'; color = '#f87171'; 
    }

    // 백슬래시(\)를 모두 제거한 순수 template literal 문법입니다.
    const toastHtml = `
        <div id="${toastId}" class="glass-toast ${type}">
            <div class="d-flex align-items-center gap-3">
                <div class="toast-icon-circle">
                    <span class="material-symbols-outlined fs-5">${icon}</span>
                </div>
                <div class="toast-content">
                    <h4 class="text-xs fw-bold text-uppercase tracking-widest mb-1" style="color: ${color}">${title}</h4>
                    <p class="text-sm text-gray-300 mb-0">${msg}</p>
                </div>
            </div>
        </div>`;

    const $newToast = $(toastHtml);
    $(container).append($newToast);

    setTimeout(() => $newToast.addClass('show'), 50);

    setTimeout(() => {
        $newToast.removeClass('show');
        setTimeout(() => {
            $newToast.animate({
                height: 0, marginTop: 0, marginBottom: 0,
                paddingTop: 0, paddingBottom: 0, opacity: 0
            }, {
                duration: 350,
                easing: "swing",
                complete: function() { $(this).remove(); }
            });
        }, 400);
    }, 2500);
}