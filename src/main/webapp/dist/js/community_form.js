$(function() {
    initFormState();
    enableAppMode();

    $('input[name="com_name"]').on('input', function() {
        checkCommunityName();
    });

    $(document).on('click', '.privacy-card', function() {
        selectPrivacyCard($(this));
    });

    $(document).on('click', '.topic-btn', function() {
        selectTopic($(this));
    });

    $('#createForm, #updateForm').on('submit', function(e) {
        e.preventDefault();
        submitCommunity($(this));
    });
	
	$('#confirm-modal').on('click', function(e) {
		if (e.target === this) closeConfirmModal();
	});
});


function initFormState() {
    const dbIsPrivate = $('#db_is_private').val();
    const dbTopicId = $('#db_category_id').val();


    if (dbIsPrivate !== undefined && dbIsPrivate !== "") {
        $('.privacy-card').each(function() {
            const val = $(this).find('input[name="is_private"]').val();

            if ((dbIsPrivate === "0" && val === "public") || (dbIsPrivate === "1" && val === "private")) {
                selectPrivacyCard($(this));
            }
        });
    }


    if (dbTopicId) {
        const selector = ".topic-btn[data-id='" + dbTopicId + "']";
        $(selector).addClass('selected');
        $('#category_id_input').val(dbTopicId);
    }
}


function checkCommunityName() {
    const $nameInput = $('input[name="com_name"]');
    const name = $nameInput.val().trim();
    const $errorEl = $('#error-com_name, #nameError');

    if (!name) {
        $errorEl.text("커뮤니티 이름을 입력해주세요.").removeClass('text-green-500').addClass('text-red-500').show();
        return;
    }
	
	const fn = function(data) {
		if (data.isDuplicate) {
			$errorEl.text("이미 사용 중인 이름입니다.").removeClass('text-green-500').addClass('text-red-500').show();
		    $nameInput.addClass('border-red-500/50');
		} else {
			$errorEl.text("사용 가능한 이름입니다.").removeClass('text-red-500').addClass('text-green-500').show();
		    $nameInput.removeClass('border-red-500/50');
		}
	};

    ajaxRequest('checkName', 'GET', { com_name: name, community_id: communityId }, 'json', fn);
}


function selectPrivacyCard($selectedCard) {
    $('.privacy-card').removeClass('card-selected border-primary/50 bg-primary/10').addClass('card-unselected border-white/10');
    $('.privacy-card .title-text').removeClass('text-[#a855f7]').addClass('text-white');
    $('.privacy-card .check-container').empty();

    $selectedCard.removeClass('card-unselected border-white/10').addClass('card-selected border-primary/50 bg-primary/10');
    $selectedCard.find('.title-text').removeClass('text-white').addClass('text-[#a855f7]');
    $selectedCard.find('.check-container').html('<span class="material-symbols-outlined text-[#a855f7] text-2xl animate-in fade-in zoom-in duration-200">check_circle</span>');
    $selectedCard.find('input[type="radio"]').prop('checked', true);
}


function selectTopic($btn) {
    $('.topic-btn').removeClass('selected');
    $btn.addClass('selected');
    $('#category_id_input, #selectedTopic').val($btn.attr('data-id'));
}


function submitCommunity($form) {
    const mode = $form.attr('id') === 'updateForm' ? 'update' : 'create';
    const params = $form.serialize();
	const fn = 	function(data) {
		if (data.status === "success") {
	    	alert(mode === 'update' ? "수정되었습니다." : "생성되었습니다.");
	            
	        location.href = "main?community_id=" + (data.community_id || data.dto.community_id);
		} else {
	    	alert("처리 실패: " + (data.message || "데이터 확인 후 다시 시도해주세요."));
		}
	};

    ajaxRequest(mode, 'POST', params, 'json', fn);
}

function toggleFavorite(button, communityId) {
	const url = "checkFavorite";
	const params = "community_id=" + communityId;
	const $button = $(button);
	const $icon = $button.find('.material-symbols-outlined');

	const fn = function(data) {
		if (data.status === "added") {
			$button.addClass("active");
			$icon.attr('style', 'color: #ffca28 !important; font-variation-settings: "FILL" 1, "wght" 700 !important;');
		} else if (data.status === "removed") {
			$button.removeClass("active");
			$icon.attr('style', '');
		} else {
			alert("처리 중 오류가 발생했습니다.");
		}
		updateFavoriteUI();
	};
	ajaxRequest(url, "post", params, 'json', fn);
}

function deleteCommunity(communityId){
	if (!confirm("정말 이 커뮤니티를 삭제하시겠습니까?")) return;
	
	const url = "delete?community_id=" + communityId;
	
	location.href = url;
}

function leaveCommunity(community_id) {
    const $modal = $('#confirm-modal');
    
    // 모달 표시
    $modal.removeClass('hidden');
    
    // 확인 버튼에 탈퇴 액션 바인딩
    $('#modal-confirm-btn').off('click').on('click', function() {
        location.href = "leave?community_id=" + community_id;
    });
}

// 2. 모달 닫기
function closeConfirmModal() {
    $('#confirm-modal').addClass('hidden');
}


function updateFavoriteUI() {
    // 서버에서 즐겨찾기 리스트 HTML 조각만 가져오기
    ajaxRequest("favoritesList", 'GET', {}, 'text', function(html) {
        // management.jsp 우측 컨테이너 업데이트
        $('#right-fav-list').html(html);
        
        // 만약 사이드바도 같은 클래스나 ID를 쓴다면 함께 업데이트됨
        $('.sidebar-fav-area').html(html);
    });
}