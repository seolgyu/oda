/**
 * 
 */
let page = 1;
let isLoading = false;
let io;


const observerOptions = {
	root: document.querySelector('.feed-scroll-container'),
	rootMargin: '0px',
	threshold: 1.0
};

function loadNextPage(url, renderFunc) {
	if (window.isLoading) return;
	window.isLoading = true;

	const nextPage = window.page + 1;

	$.ajax({
		url: cp + url,
		type: 'GET',
		data: { page: nextPage },
		dataType: 'json',
		success: function(data) {
			if (data.status === 'success' && data.list && data.list.length > 0) {
				let htmlBuffer = "";
				data.list.forEach(item => {
					htmlBuffer += renderFunc(item);
				});

				$('.list-container').append(htmlBuffer);
				$('.list-container').after($('#sentinel'));

				window.page = nextPage;
				window.isLoading = false;
			} else {
				window.isLoading = false;
				if (window.io) window.io.disconnect();
			}
		},
		error: function() {
			window.isLoading = false;
		}
	});
}

function renderLikedPost(list) {
	const thumbnailHtml = list.thumbnail
		? `<div class="record-thumbnail rounded-3 flex-shrink-0" style="background-image: url('${list.thumbnail}');"></div>`
		: `<div class="record-thumbnail rounded-3 d-flex align-items-center justify-content-center flex-shrink-0" 
                    style="background-color: rgba(255, 255, 255, 0.1); border: 1px dashed rgba(255, 255, 255, 0.2);">
                   <span class="material-symbols-outlined text-white opacity-20" style="font-size: 24px;">image</span>
               </div>`;

	return `
        <div class="record-item d-flex align-items-stretch overflow-hidden">
            <div class="flex-grow-1 d-flex align-items-center gap-3 p-3 cursor-pointer item-content" 
                 style="min-width: 0;"
                 onclick="location.href='${window.cp}/post/article?postId=${list.postId}';"> 
                
                ${thumbnailHtml}
                
                <div class="flex-grow-1" style="min-width: 0;">
                    <div class="d-flex align-items-center gap-2 mb-1 opacity-75">
                        <span class="text-white text-xs fw-bold text-truncate">${list.authorNickname}</span>
                        <span class="text-secondary text-xs flex-shrink-0">· ${list.createdDate}</span>
                    </div>
                    <h4 class="text-white fs-6 fw-bold mb-1 text-truncate">${list.title || ''}</h4>
                    <p class="text-secondary text-xs mb-0 text-truncate opacity-50">${list.content || ''}</p>
                </div>
            </div>

            <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10 flex-shrink-0"
                 style="width: 70px;">
                <button type="button" class="btn-like-toggle" onclick="toggleLike(this, '${list.postId}')">
                    <span class="material-symbols-outlined text-danger" 
                          style="font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;">
                        favorite
                    </span>
                </button>
            </div>
        </div>
    `;
}

function renderSavedPost(list) {
    const thumbnailHtml = list.thumbnail
        ? `<div class="record-thumbnail rounded-3 flex-shrink-0" style="background-image: url('${list.thumbnail}');"></div>`
        : `<div class="record-thumbnail rounded-3 d-flex align-items-center justify-content-center flex-shrink-0" 
                    style="background-color: rgba(255, 255, 255, 0.1); border: 1px dashed rgba(255, 255, 255, 0.2);">
                   <span class="material-symbols-outlined text-white opacity-20" style="font-size: 24px;">bookmark</span>
               </div>`;

    return `
        <div class="record-item d-flex align-items-stretch overflow-hidden">
            <div class="flex-grow-1 d-flex align-items-center gap-3 p-3 cursor-pointer item-content" 
                 style="min-width: 0;"
                 onclick="location.href='${window.cp}/post/article?postId=${list.postId}';"> 
                
                ${thumbnailHtml}
                
                <div class="flex-grow-1" style="min-width: 0;">
                    <div class="d-flex align-items-center gap-2 mb-1 opacity-75">
                        <span class="text-white text-xs fw-bold text-truncate">${list.authorNickname}</span>
                        <span class="text-secondary text-xs flex-shrink-0">· ${list.createdDate}</span>
                    </div>
                    <h4 class="text-white fs-6 fw-bold mb-1 text-truncate">${list.title || ''}</h4>
                    <p class="text-secondary text-xs mb-0 text-truncate opacity-50">${list.content || ''}</p>
                </div>
            </div>

            <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10 flex-shrink-0"
                 style="width: 70px;">
                <button type="button" class="btn-save-toggle" onclick="toggleSave(this, '${list.postId}')">
                    <span class="material-symbols-outlined text-warning" 
                          style="font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;">
                        bookmark
                    </span>
                </button>
            </div>
        </div>
    `;
}

function renderCommentList(list) {
	const parentQuoteHtml = list.depth > 1
		? `
        <div class="parent-quote p-3 mb-3 rounded-2"
            style="background: rgba(255, 255, 255, 0.06); border-left: 4px solid rgba(255, 255, 255, 0.2);">
            <div class="d-flex align-items-center gap-2 mb-2">
                <span class="badge rounded-pill text-white"
                    style="background-color: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.1); font-size: 0.65rem; padding: 0.3em 0.7em; letter-spacing: 0.5px;">
                    REPLY TO 
                </span> 
                <span class="text-white fw-bold" style="font-size: 0.8rem;">@${list.parentUserNickname}</span>
            </div>
            <div class="text-white-50 text-sm ps-1"
                style="line-height: 1.5; border-left: 1px solid rgba(255, 255, 255, 0.1); padding-left: 10px;">
                <span class="opacity-75">"${list.parentCommentContent}"</span>
            </div>
        </div>`
		: '';

	const labelText = list.depth > 1 ? 'MY REPLY' : 'MY COMMENT';
	const labelClass = list.depth > 1 ? 'text-info' : 'text-primary';

	return `
        <div class="record-item p-3 overflow-hidden mb-4"
            style="background: rgba(255, 255, 255, 0.02); border: 1px solid rgba(255, 255, 255, 0.05); border-radius: 12px;">

            <div class="d-flex align-items-center gap-3 mb-3 cursor-pointer pb-3 border-bottom border-white border-opacity-10"
                onclick="location.href='${window.cp}/post/article?postId=${list.postId}';">

                <div class="record-thumbnail rounded-3"
                    style="width: 45px; height: 45px; background-image: url('${list.parentThumbnail}'); background-size: cover; background-position: center; flex-shrink: 0;">
                </div>

                <div class="flex-grow-1 min-w-0">
                    <div class="d-flex align-items-center gap-2 mb-1 opacity-50">
                        <span class="text-white text-xs fw-bold">${list.item.authorNickname}</span> 
                        <span class="text-secondary text-xs">· Original Post</span>
                    </div>
                    <h4 class="text-white fs-6 fw-bold mb-0 text-truncate">${list.item.title}</h4>
                </div>

                <span class="material-symbols-outlined text-secondary opacity-30">chevron_right</span>
            </div>

            <div class="d-flex flex-column gap-3 ps-1">
                <div class="comment-group-item d-flex gap-2">
                    <span class="text-secondary opacity-25 mt-1"
                        style="font-family: sans-serif; font-size: 1.2rem;">ㄴ</span>

                    <div class="comment-content-box p-3 rounded-3 flex-grow-1"
                        style="background: rgba(255, 255, 255, 0.04); border: 1px solid rgba(255, 255, 255, 0.08);">
                        
                        ${parentQuoteHtml}

                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <span class="${labelClass} text-xs fw-bold" style="letter-spacing: 0.5px;">${labelText}</span> 
                            <span class="text-secondary text-xs opacity-75">${list.createdDate}</span>
                        </div>
                        <p class="text-white text-sm mb-0 fw-normal"
                            style="line-height: 1.6; opacity: 0.9;">${list.content}</p>
                    </div>
                </div>
            </div>
        </div>
    `;
}

function renderFollowItem(dto) {
    const initial = dto.userNickname ? dto.userNickname.charAt(0) : '?';
	const profileHtml = dto.userProfile 
	        ? `<img src="${dto.userProfile}" alt="Profile" class="w-100 h-100 object-fit-cover">`
	        : `<div class="w-100 h-100 d-flex align-items-center justify-content-center text-white fw-bold" 
	                style="background: linear-gradient(135deg, #6366f1, #a855f7); font-size: 1.2rem;">
	               ${initial}
	           </div>`;

    const isFollowing = (window.currentSocialType === 'following' || dto.followStatus); 
    
    const btnClass = isFollowing ? 'btn-following' : '';
    const btnText = isFollowing ? 'Following' : 'Follow';

    const targetNum = (window.currentSocialType === 'follower') ? dto.reqId : dto.addId;

    return `
        <div class="record-item d-flex align-items-stretch overflow-hidden shadow-sm mb-1">
            <div class="flex-grow-1 d-flex align-items-center gap-3 p-3">
                <div class="rounded-circle border border-white border-opacity-10 shadow-sm overflow-hidden flex-shrink-0 app-user-trigger" data-user-id="${dto.userId}"
                     style="width: 50px; height: 50px;">
                    ${profileHtml}
                </div>
                <div class="flex-grow-1 min-w-0">
                    <h4 class="text-white fs-6 fw-bold mb-0 text-truncate app-user-trigger" data-user-id="${dto.userId}">${dto.userNickname}</h4>
                    <p class="text-secondary text-xs mb-0 opacity-50">c/${dto.userId} • ${dto.registerDate}</p>
                </div>
            </div>
            <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
                <button type="button" class="btn-follow-status ${btnClass}" 
                        onclick="toggleFollow('${targetNum}', this)">
                    ${btnText}
                </button>
            </div>
        </div>`;
}

// setting.jsp script
$(function() {
	$('.dropdown-trigger').on('click', function() {
		const $this = $(this);
		const $container = $this.next('.dropdown-container');

		$this.toggleClass('active');

		$container.stop().slideToggle(300, function() {
			if ($container.is(':visible')) {
				$container.css('display', 'flex');
			}
		});
	});
});

$(function() {
	$('.setting-nav-item').on(
		'click',
		function(e) {
			if ($(this).hasClass('dropdown-trigger')
				|| $(this).hasClass('text-danger'))
				return;

			e.preventDefault();

			const url = $(this).data('url');
			if (!url)
				return;

			$('.setting-nav-item')
				.removeClass('active-setting-tab');
			$(this).addClass('active-setting-tab');

			loadSettings(url);
		});
});


function loadSettings(url) {
	$.ajax({
		type: "GET",
		url: url,
		dataType: "html",
		success: function(data) {
			$('#settings-content').html(data);
			page = 1;
			isLoading = false;
		},
		error: function() {
			alert("설정 페이지를 불러오는 데 실패했습니다.");
			$('#settings-content').show();
		}
	});
}


// input 태그 경고 알림 메서드
function showFieldError(input, message) {
	const $input = $(input);
	const $parent = $input.parent();

	hideFieldError($input);

	$input.addClass('is-invalid').css('border-color', '#ef4444');

	const errorHtml = `
        <div class="error-text d-flex align-items-center gap-1 mt-2 text-danger animate__animated animate__fadeIn" 
             style="font-size: 0.75rem; font-weight: 500;">
            <span class="material-symbols-outlined" style="font-size: 0.9rem; font-variation-settings: 'FILL' 1;">error</span>
            <span>${message}</span>
        </div>
    `;

	if ($parent.hasClass('d-flex')) {
		$parent.after(errorHtml);
	} else {
		$input.after(errorHtml);
	}

	$input.focus();
}

function hideFieldError(input) {
	const $input = $(input);
	$input.removeClass('is-invalid').css('border-color', '');

	$input.next('.error-text').remove();
	$input.parent().next('.error-text').remove();
}



