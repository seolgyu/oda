$(function() {
    initFormState();
    if (typeof enableAppMode === 'function') enableAppMode();

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
    const $button = $(button);
    const $icon = $button.find('.material-symbols-outlined');
    const url = "checkFavorite";
    const params = { community_id: communityId };

    // ajaxRequest(url, method, requestParams, responseType, callback)
    ajaxRequest(url, 'POST', params, 'json', function(data) {
        if (data.status === "added") {
            $icon.attr('style', 'color: #facc15 !important; font-variation-settings: "FILL" 1, "wght" 700 !important;');
        } else if (data.status === "removed") {
            $icon.attr('style', 'color: #4b5563 !important; font-variation-settings: "FILL" 0, "wght" 400 !important;');
        }
        
        // 동기화 함수 호출
        updateFavoriteUI();
    });
}

function updateFavoriteUI() {
    const url = "management_fav";
    
    // HTML 조각을 받아와야 하므로 responseType은 'html'
    ajaxRequest(url, 'GET', {}, 'html', function(html) {
        // 1. 오른쪽 리스트 갱신
        const $rightList = $('#right-fav-list');
        if ($rightList.length > 0) {
            $rightList.html(html);
        }

        // 2. 사이드바 갱신
        const $sidebarList = $('.sidebar-fav-area');
        if ($sidebarList.length > 0) {
            $sidebarList.html(html);
        }

        // 3. 왼쪽 별 아이콘 색상 동기화
        const favoriteIds = [];
        const $temp = $('<div>').append(html);
        $temp.find('[onclick*="community_id="]').each(function() {
            const match = $(this).attr('onclick').match(/community_id=(\d+)/);
            if (match) favoriteIds.push(match[1]);
        });

        $('.btn-favorite').each(function() {
            const $btn = $(this);
            const onclickAttr = $btn.attr('onclick') || "";
            const idMatch = onclickAttr.match(/'(\d+)'/);
            
            if (idMatch) {
                const currentId = idMatch[1];
                const $starIcon = $btn.find('.material-symbols-outlined');
                
                if (favoriteIds.includes(currentId)) {
                    $starIcon.attr('style', 'color: #facc15 !important; font-variation-settings: "FILL" 1, "wght" 700 !important;');
                    $starIcon.removeClass('text-gray-600').addClass('text-yellow-400');
                } else {
                    $starIcon.attr('style', 'color: #4b5563 !important; font-variation-settings: "FILL" 0, "wght" 400 !important;');
                    $starIcon.removeClass('text-yellow-400').addClass('text-gray-600');
                }
            }
        });
    });
}

function toggleJoin(button, communityId) {
    const $btn = $(button);
    // 버튼에 active 클래스가 있으면 이미 가입된 상태
    const isMember = $btn.hasClass('active');
    
    if (isMember) {
        // 탈퇴 처리
        if (!confirm("정말 커뮤니티를 탈퇴하시겠습니까?")) return;
        
        ajaxRequest('leave', 'POST', { community_id: communityId }, 'json', function(data) {
            if (data.status === "success") {
                alert("탈퇴 처리가 완료되었습니다.");
                location.reload(); // 가입자 수 갱신을 위해 새로고침
            } else {
                alert(data.message || "탈퇴 처리 중 오류가 발생했습니다.");
            }
        });
    } else {
        // 가입 처리
        if (!confirm("이 커뮤니티에 가입하시겠습니까?")) return;
        
        ajaxRequest('join', 'POST', { community_id: communityId }, 'json', function(data) {
            if (data.status === "success") {
                alert("성공적으로 가입되었습니다!");
                location.reload(); // 가입자 수 갱신을 위해 새로고침
            } else {
                alert(data.message || "가입 처리 중 오류가 발생했습니다.");
            }
        });
    }
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