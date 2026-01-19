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

$(function() {
    // 페이지 로드 시 URL 파라미터 확인
    const params = new URLSearchParams(window.location.search);
    const joinStatus = params.get('join');
	const leaveStatus = params.get('leave');
    const communityId = params.get('community_id');

    // 디버깅용 (브라우저 콘솔에서 확인 가능)
    console.log("Current Join Status:", joinStatus);

    if (joinStatus === 'success') {
        // 즉시 실행하면 DOM이 덜 그려졌을 수 있으니 아주 약간의 지연(100ms)을 줍니다.
        setTimeout(function() {
            if (typeof showToast === 'function') {
                showToast("success", "성공적으로 가입되었습니다!");
            } else {
                console.error("showToast 함수를 찾을 수 없습니다. header.jsp가 포함되었는지 확인하세요.");
            }
        }, 100);

        // 토스트를 띄운 후, 주소창에서 join=success만 제거하고 community_id는 남겨둠
        if (communityId) {
            const newUrl = window.location.pathname + '?community_id=' + communityId;
            window.history.replaceState({}, '', newUrl);
        }
    }
	
	if (leaveStatus === 'success') {
	        setTimeout(function() {
	            if (typeof showToast === 'function') {
	                showToast("success", "탈퇴 처리가 완료되었습니다.");
	            }
	        }, 100);

	        // 주소창에서 ?leave=success 제거
	        window.history.replaceState({}, '', window.location.pathname);
	    }
    
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
    const com_name = $nameInput.val().trim();
    const $errorEl = $('#error-com_name, #nameError');
	const community_id = $('input[name="community_id"]').val() || "";

    if (!com_name) {
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

    ajaxRequest('checkName', 'GET', { com_name: com_name, community_id: community_id }, 'json', fn);
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
		
		if ($('#avatar-img-view').hasClass('hidden')) {
			params.append("isIconDeleted", "true");
		}
		if ($('#banner-img-view').hasClass('hidden')) {
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

function checkJoinAndWrite() {
    // 1. 가입 여부 확인 (버튼의 data-joined 속성 참조)
    const $joinBtn = $('.btn-join-toggle');
    const isJoined = $joinBtn.attr('data-joined') === 'true';
    
    // 2. 관리자(커뮤니티 생성자) 여부 확인
    // main.jsp에서 dto.user_num으로 넘겨준 값이 관리자의 idx입니다.
    const isOwner = (window.ownerIdx == window.currentUserIdx); // 전역변수 설정 필요

    if (!isJoined && !isOwner) {
        // 커뮤니티 가입이 안 되어 있으면 토스트 메시지 출력
        if (typeof showToast === 'function') {
            showToast('error', '커뮤니티 가입 후 게시글을 작성할 수 있습니다.');
        } else {
            alert('커뮤니티 가입 후 게시글을 작성할 수 있습니다.');
        }
        return;
    }
	const comName = encodeURIComponent("${dto.com_name}");
    // 3. 통과 시 이동 (community_id 파라미터 포함)
    location.href = window.cp + "/post/write?community_id=" + window.communityId + "&com_name=" + comName;
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
                        location.href = location.pathname + "?leave=success"; 
                    } else {
                        $('.btn-join-toggle').attr('data-joined', 'false').text('가입하기');
                        closeConfirmModal();
                        showToast("success", "탈퇴 처리가 완료되었습니다.");
                    }
                } else{
					showToast("error", "탈퇴 처리에 실패했습니다.");
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