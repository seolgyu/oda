/**
 * 
 */
window.page = 1;
window.isLoading = false;
window.io = null;
window.currentTab = 'my-posts';

$(function() {
	initInfiniteScroll();

	$('#mypage-tabs button').on('click', function() {
		const target = $(this).data('target');
		if (window.currentTab === target) return;

		$('#mypage-tabs button').removeClass('active-filter').addClass('text-secondary border-0').removeClass('fw-bold');
		$(this).addClass('active-filter').removeClass('text-secondary border-0').addClass('fw-bold');

		window.currentTab = target;
		window.page = 1;
		$('#post-list-container').empty();

		initInfiniteScroll();

		loadNextPage(getTabUrl(), renderMyPost, true);
	});
});

function getTabUrl() {
    return window.currentTab === 'reposts' ? '/member/settings/loadMyReposts' : '/member/settings/loadMyPosts';
}

function initInfiniteScroll() {
	if (window.io) window.io.disconnect();

	const $sentinel = document.getElementById('sentinel');
	const $scrollContainer = document.querySelector('.feed-scroll-container');

	if (!$sentinel) return;

	window.io = new IntersectionObserver((entries) => {
		entries.forEach(entry => {
			if (entry.isIntersecting && !window.isLoading) {
				loadNextPage(getTabUrl(), renderMyPost);
			}
		});
	}, {
		root: $scrollContainer,
		rootMargin: '300px',
		threshold: 0.1
	});

	window.io.observe($sentinel);
}

function loadNextPage(url, renderFunc, isFirst = false) {
	if (window.isLoading) return;
	window.isLoading = true;

	const targetPage = isFirst ? 1 : window.page + 1;

	$.ajax({
		url: window.cp + url,
		type: 'POST',
		data: { page: targetPage, userId: window.userId },
		dataType: 'json',
		success: function(data) {
			if (data.status === 'success' && data.list && data.list.length > 0) {
				let htmlBuffer = "";
				data.list.forEach(item => {
					htmlBuffer += renderFunc(item);
				});

				$('#post-list-container').append(htmlBuffer);
				$('#post-list-container').after($('#sentinel'));

				const carousels = document.querySelectorAll('#post-list-container .carousel');
				carousels.forEach(el => {
					if (!bootstrap.Carousel.getInstance(el)) {
						new bootstrap.Carousel(el, {
							ride: false,
							interval: false
						});
					}
				});

				window.page = targetPage;
				window.isLoading = false;
			} else {
				window.isLoading = false;
				if (window.io) window.io.disconnect();
				if (isFirst && (!data.list || data.list.length === 0)) {
					const emptyMsg = window.currentTab === 'reposts' ? '리포스트한 게시글이 없습니다' : '등록된 게시글이 없습니다';
					const emptyHtml = `
				    	<div class="glass-card py-5 text-center shadow-lg border-0 w-100"
				    		style="background: rgba(255, 255, 255, 0.02); border-radius: 1rem !important;">
				    		<div class="py-4">
				    			<span class="material-symbols-outlined text-secondary opacity-20" style="font-size: 80px;">rocket_launch</span>
				    			<h4 class="text-white mt-3 fw-bold opacity-75">${emptyMsg}</h4>
				    		</div>
				    	</div>`;
					$('#post-list-container').html(emptyHtml);
				}
			}
		},
		error: function() {
			window.isLoading = false;
			showToast("error", "데이터를 불러오는 데 실패했습니다.");
		}
	});
}

function renderMyPost(item) {
	const cp = window.cp; // contextPath
	const isListMode = $('#post-list-container').hasClass('list-mode');
	const isRepostTab = window.currentTab === 'reposts';
	
	let repostBadgeHtml = '';
	    if (isRepostTab) {
	        repostBadgeHtml = `
	            <div class="px-3 pt-3 pb-0 d-flex align-items-center gap-2" style="opacity: 0.85;">
	                <div class="d-flex align-items-center gap-1 bg-success bg-opacity-10 px-2 py-1 rounded-pill" 
	                     style="border: 1px solid rgba(25, 135, 84, 0.2);">
	                    <span class="material-symbols-outlined" style="font-size: 14px; color: #198754; font-weight: bold;">repeat</span>
	                    <span style="font-size: 11px; font-weight: 700; color: #198754; letter-spacing: -0.2px;">Reposted</span>
	                </div>
	                <span class="text-secondary" style="font-size: 11px; letter-spacing: -0.3px;">
	                    on ${item.repostDate}
	                </span>
	            </div>
	        `;
	    }

	const listViewDisplay = isListMode ? 'flex' : 'none';
	const cardViewDisplay = isListMode ? 'none' : 'block';

	const likedClass = item.likedByUser ? 'text-danger' : '';
	const likedFill = item.likedByUser ? 1 : 0;

	const hasImages = item.fileList && item.fileList.length > 0;
	const firstImg = hasImages ? item.fileList[0].filePath : null;

	let cardMediaHtml = '';
	if (hasImages) {
		if (item.fileList.length > 1) {
			// 여러 장일 때: 캐러셀 복구
			const carouselId = `carousel-${item.postId}`;
			cardMediaHtml = `
                <div class="p-3 pt-0">
                    <div id="${carouselId}" class="carousel slide post-carousel" data-bs-ride="false">
                        <div class="carousel-indicators">
                            ${item.fileList.map((_, idx) => `
                                <button type="button" data-bs-target="#${carouselId}" data-bs-slide-to="${idx}" 
                                        class="${idx === 0 ? 'active' : ''}"></button>
                            `).join('')}
                        </div>
                        <div class="carousel-inner">
                            ${item.fileList.map((file, idx) => `
                                <div class="carousel-item ${idx === 0 ? 'active' : ''}">
                                    <div class="ratio ratio-16x9">
                                        <img src="${file.filePath}" class="d-block w-100 object-fit-cover">
                                    </div>
                                </div>
                            `).join('')}
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#${carouselId}" data-bs-slide="prev">
                            <span class="material-symbols-outlined fs-4">chevron_left</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#${carouselId}" data-bs-slide="next">
                            <span class="material-symbols-outlined fs-4">chevron_right</span>
                        </button>
                    </div>
                </div>`;
		} else {
			// 한 장일 때
			cardMediaHtml = `
                <div class="p-3 pt-0">
                    <div class="post-carousel">
                        <div class="ratio ratio-16x9">
                            <img src="${firstImg}" class="d-block w-100 object-fit-cover">
                        </div>
                    </div>
                </div>`;
		}
	}

	return `
        <div class="glass-card shadow-lg group mb-4 post-item-card">
			${repostBadgeHtml}
            <div class="list-view-item p-3" style="display: ${listViewDisplay};">
                <div class="d-flex align-items-start gap-3 w-100">
                    <div class="flex-shrink-0 thumbnail-box app-user-trigger" data-user-id="${item.authorId}" style="width: 90px; height: 90px;">
                        ${firstImg
			? `<img src="${firstImg}" class="w-100 h-100 object-fit-cover rounded-3 border border-white border-opacity-10">`
			: `<div class="w-100 h-100 rounded-3 d-flex align-items-center justify-content-center border border-white border-opacity-10" style="background: rgba(255, 255, 255, 0.05);">
                                 <span class="material-symbols-outlined opacity-20">image</span>
                               </div>`
		}
                    </div>

                    <div class="flex-grow-1 overflow-hidden d-flex flex-column justify-content-between" style="min-height: 90px;">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <span class="text-white fw-bold text-sm app-user-trigger" data-user-id="${item.authorId}">${item.authorNickname}</span>
                                <span class="text-secondary text-xs opacity-75">c/${item.authorId}</span>
                                <span class="ms-auto text-xs text-gray-500">${item.timeAgo}</span>
                            </div>
                            ${item.title ? `<h4 class="text-white text-sm fw-bold mb-0 text-truncate">${item.title}</h4>` : ''}
                            <p class="text-light opacity-50 text-xs mb-2 text-truncate">${item.content}</p>
                        </div>

                        <div class="d-flex align-items-center justify-content-between mt-auto">
                            <div class="d-flex gap-3">
                                <button class="btn-icon d-flex align-items-center gap-1 p-0" onclick="toggleLike(this, '${item.postId}')">
                                    <span class="material-symbols-outlined fs-6 ${likedClass}" style="font-variation-settings: 'FILL' ${likedFill};">favorite</span>
                                    <span class="text-xs opacity-75 like-count">${item.likeCount}</span>
                                </button>
                                <button class="btn-icon d-flex align-items-center gap-1 p-0" onclick="location.href='${cp}/post/article?postId=${item.postId}';">
                                    <span class="material-symbols-outlined fs-6">chat_bubble</span>
                                    <span class="text-xs opacity-75">${item.commentCount}</span>
                                </button>
                                <button class="btn-icon p-0"><span class="material-symbols-outlined fs-6">repeat</span></button>
                            </div>
                            <div class="d-flex gap-3 text-white-50">
                                <button class="btn-icon p-0" title="공유하기"><span class="material-symbols-outlined fs-6">share</span></button>
                                <button class="btn-icon p-0" title="저장하기"><span class="material-symbols-outlined fs-6">bookmark</span></button>
                                <button class="btn-icon p-0" title="신고하기"><span class="material-symbols-outlined fs-6">report</span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card-view-item" style="display: ${cardViewDisplay};">
                <div class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                    <div class="d-flex align-items-center gap-3">
                        <div class="avatar-md bg-info text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden app-user-trigger" data-user-id="${item.authorId}" 
                             style="width: 40px; height: 40px; border-radius: 10px; background: linear-gradient(135deg, #6366f1, #a855f7);">
                            ${item.authorProfileImage
			? `<img src="${item.authorProfileImage}" class="w-100 h-100 object-fit-cover">`
			: `<span>${item.authorNickname ? item.authorNickname.substring(0, 1) : 'U'}</span>`
		}
                        </div>
                        <div>
                            <h3 class="text-sm fw-medium text-white mb-0 app-user-trigger" data-user-id="${item.authorId}">${item.authorNickname}</h3>
                            <p class="text-xs text-gray-500 mb-0">${item.timeAgo}</p>
                        </div>
                    </div>
                    <button class="btn-icon text-white-50"><span class="material-symbols-outlined">more_horiz</span></button>
                </div>

                <div class="p-3 pb-2">
                    ${item.title ? `<h4 class="text-white fs-6 fw-bold mb-1">${item.title}</h4>` : ''}
                    <p class="text-light text-sm mb-0 lh-base" style="white-space: pre-wrap;">${item.content}</p>
                </div>

                ${cardMediaHtml}

                <div class="px-3 py-2 d-flex align-items-center justify-content-between border-top border-white border-opacity-10" 
                     style="background: rgba(255, 255, 255, 0.05);">
                    <div class="d-flex gap-4">
                        <button class="btn-icon d-flex align-items-center gap-1" onclick="toggleLike(this, '${item.postId}')">
                            <span class="material-symbols-outlined fs-5 ${likedClass}" style="font-variation-settings: 'FILL' ${likedFill};">favorite</span>
                            <span class="text-xs opacity-75 like-count">${item.likeCount}</span>
                        </button>
                        <button class="btn-icon d-flex align-items-center gap-1" onclick="location.href='${cp}/post/article?postId=${item.postId}';">
                            <span class="material-symbols-outlined fs-5">chat_bubble</span>
                            <span class="text-xs opacity-75">${item.commentCount}</span>
                        </button>
                        <button class="btn-icon"><span class="material-symbols-outlined fs-5">repeat</span></button>
                    </div>
                    <div class="d-flex gap-3 text-white-50">
                        <button class="btn-icon" title="공유하기"><span class="material-symbols-outlined fs-5">share</span></button>
                        <button class="btn-icon" title="저장하기"><span class="material-symbols-outlined fs-5">bookmark</span></button>
                        <button class="btn-icon" title="신고하기"><span class="material-symbols-outlined fs-5">report</span></button>
                    </div>
                </div>
            </div>
        </div>
    `;
}
