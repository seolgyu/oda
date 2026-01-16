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
	
	$(document).on('mouseenter', '.btn-join-toggle', function() {
		const isJoined = $(this).attr('data-joined') === "true";
	    if (isJoined) {
			$(this).text('탈퇴하기').css('background-color', '#a855f7');
		} else {
			$(this).css('background-color', '#9333ea');
		}
	}).on('mouseleave', '.btn-join-toggle', function() {
		const isJoined = $(this).attr('data-joined') === "true";
	    if (isJoined) {
			$(this).text('가입됨').css('background-color', '#9333ea');
		} else {
			$(this).css('background-color', '#a855f7');
		}
	});
	
	$('#confirm-modal').on('click', function(e) {
		if (e.target === this) closeConfirmModal();
	});
	
	$('#banner-input').on('change', function(e) {
		handleImagePreview(e, '#banner-img-view');
	});

	$('#avatar-input').on('change', function(e) {
		handleImagePreview(e, '#avatar-img-view');
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

    ajaxRequest('checkName', 'GET', { com_name: com_name, community_id: community_Id }, 'json', fn);
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

function handleImagePreview(event, previewId) {
    const file = event.target.files[0];
    if (file) {
        if (!file.type.startsWith('image/')) {
            showToast("error", "이미지 파일만 업로드 가능합니다.");
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            $(previewId).attr('src', e.target.result).removeClass('hidden').show();
            
            if (previewId === '#banner-img-view') {
                $('#banner-placeholder').addClass('hidden');
                $('.edit-btn-style').addClass('opacity-20');
            }
            
            if (previewId === '#avatar-img-view') {
                $('#avatar-gradient').addClass('hidden');
            }
        };
        reader.readAsDataURL(file);
    }
}

function updateImageImmediate(type, action) {
    if (action === 'delete') {
        if (!confirm('이미지를 초기화하시겠습니까?')) return;
        
        if (type === 'banner') {
            $('#banner-img-view').addClass('hidden').attr('src', '');
            $('#banner-placeholder').removeClass('hidden');
            $('#banner-input').val('');
            $('input[name="banner_image"]').val(''); 
        } else if (type === 'avatar') {
            $('#avatar-img-view').addClass('hidden').attr('src', '');
            $('#avatar-gradient').removeClass('hidden');
            $('#avatar-input').val('');
            $('input[name="icon_image"]').val('');
        }
        showToast("info", "이미지가 초기화되었습니다. 저장 버튼을 눌러야 반영됩니다.");
    }
}

function submitCommunity($form) {
    const mode = $form.attr('id') === 'updateForm' ? 'update' : 'create';
    let params;
    let isFile = false;

    if (mode === 'update') {
        params = new FormData($form[0]);
        isFile = true;
		
		if ($('#avatar-img-view').hasClass('d-none')) {
			params.append("isIconDeleted", "true");
		}
		if ($('#banner-img-view').hasClass('d-none')) {
			params.append("isBannerDeleted", "true");
		}
		
    } else {
        params = $form.serialize();
        isFile = false;
    }
	
    const fn = function(data) {
        if (data.status === "success") {
            const msg = mode === 'update' ? "설정이 성공적으로 저장되었습니다." : "새로운 커뮤니티가 생성되었습니다.";
            
            showToast("success", msg);
            
            setTimeout(function() {
                location.href = "main?community_id=" + (data.community_id || data.dto.community_id);
            }, 1200);
        } else {
            showToast("error", data.message || "요청 처리에 실패했습니다.");
        }
    };

    ajaxRequest(mode, 'POST', params, 'json', fn, isFile);
}

function toggleFavorite(button, communityId) {
    const $button = $(button);
    const $icon = $button.find('.material-symbols-outlined');
    const url = "checkFavorite";
    const params = { community_id: communityId };

    ajaxRequest(url, 'POST', params, 'json', function(data) {
        if (data.status === "added") {
            $icon.attr('style', 'color: #facc15 !important; font-variation-settings: "FILL" 1, "wght" 700 !important;');
        } else if (data.status === "removed") {
            $icon.attr('style', 'color: #4b5563 !important; font-variation-settings: "FILL" 0, "wght" 400 !important;');
        }
        
        updateFavoriteUI();
    });
}

function updateFavoriteUI() {
    const url = "management_fav";
    
    ajaxRequest(url, 'GET', {}, 'html', function(html) {
        const $rightList = $('#right-fav-list');
        if ($rightList.length > 0) {
            $rightList.html(html);
        }

        const $sidebarList = $('.sidebar-fav-area');
        if ($sidebarList.length > 0) {
            $sidebarList.html(html);
        }

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

function openConfirmModal(title, description, confirmText, confirmColor, confirmAction) {
    const $modal = $('#confirm-modal');
    $modal.find('h3').text(title);
    $modal.find('p').text(description);
    
    const $confirmBtn = $('#modal-confirm-btn');
    $confirmBtn.text(confirmText).css('background-color', confirmColor);

    $modal.removeClass('hidden').fadeIn(200);

    $confirmBtn.off('click').on('click', function() {
        confirmAction();
    });
}

function deleteCommunity(communityId) {
    openConfirmModal(
        '커뮤니티 삭제', 
        '삭제된 커뮤니티는 복구할 수 없습니다. 정말 삭제하시겠습니까?', 
        '삭제하기', 
        '#ef4444', 
        function() {
            location.href = "delete?community_id=" + communityId;
        }
    );
}

function toggleJoin(btn, community_id) {
    const $btn = $(btn);
    const isJoined = $btn.attr('data-joined') === "true";
    const url = isJoined ? "leave" : "join"; 
	const fn = function(data) {
		if(data.status === 'success') {
			if (!isJoined) {
				$btn.attr('data-joined', 'true').text('가입됨');
		        $btn.css('background-color', '#9333ea'); 
		        showToast("success", "커뮤니티에 가입되었습니다.");
		    } else {
				$btn.attr('data-joined', 'false').text('가입하기');
		        $btn.css('background-color', '#a855f7');
		        showToast("success", "탈퇴 처리가 완료되었습니다.");
		    }
		} else {
			showToast("error", "요청 처리에 실패했습니다.");
		}
	};
    ajaxRequest(url, 'GET', { community_id: community_id }, 'json', fn);
}

function leaveCommunity(communityId) {
    openConfirmModal(
        '커뮤니티 탈퇴', 
        '정말로 이 커뮤니티를 탈퇴하시겠습니까?', 
        '탈퇴하기', 
        '#ef4444', 
        function() {
            ajaxRequest("leave", 'GET', { community_id: communityId }, 'json', function(res) {
                if(res.status === 'success') {
                    if(location.pathname.includes('management')) {
                        location.reload(); 
                    } else {
                        $('.btn-join-toggle').attr('data-joined', 'false').text('가입하기');
                        closeConfirmModal();
                        showToast("success", "탈퇴 처리가 완료되었습니다.");
                    }
                }
            });
        }
    );
}

function closeConfirmModal() {
    $('#confirm-modal').fadeOut(200, function() {
        $(this).addClass('hidden');
    });
}

function showToast(type, msg) {
    const $toast = $('#sessionToast').length ? $('#sessionToast') : $('.glass-toast');
    const $msg = $('#toastMessage').length ? $('#toastMessage') : $toast.find('.toast-msg'); 
    const $icon = $toast.find('.material-symbols-outlined');
    const $iconCircle = $toast.find('.toast-icon-circle');

    $msg.text(msg);

    if (type === "success") {
        $icon.text('check_circle');
        $iconCircle.css('background', 'linear-gradient(to top right, #22c55e, #10b981)');
    } else if (type === "error") {
        $icon.text('error');
        $iconCircle.css('background', 'linear-gradient(to top right, #ef4444, #f43f5e)');
    } else if (type === "info") {
        $icon.text('info');
        $iconCircle.css('background', 'linear-gradient(to top right, #a855f7, #6366f1)');
    }

    $toast.addClass('show');

    setTimeout(function() {
        $toast.removeClass('show');
    }, 2500);
}