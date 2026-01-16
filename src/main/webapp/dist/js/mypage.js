/**
 * 
 */
window.page = 1;
window.isLoading = false;
window.io = null;

$(function() {
    initInfiniteScroll();
});

function initInfiniteScroll() {
    if (window.io) window.io.disconnect();
    
    const $sentinel = document.getElementById('sentinel');
    const $scrollContainer = document.querySelector('.feed-scroll-container');

    if (!$sentinel) return;

    window.io = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting && !window.isLoading) {
                loadNextPage('/member/settings/loadMyPosts', renderMyPost);
            }
        });
    }, {
        root: $scrollContainer,
        rootMargin: '200px',
        threshold: 0.1
    });

    window.io.observe($sentinel);
}

function loadNextPage(url, renderFunc) {
    if (window.isLoading) return;
    window.isLoading = true;

    const nextPage = window.page + 1;

    $.ajax({
        url: window.cp + url,
        type: 'POST',
        data: { page: nextPage, userId: window.userId },
        dataType: 'json',
        success: function(data) {
            if (data.status === 'success' && data.list && data.list.length > 0) {
                let htmlBuffer = "";
                data.list.forEach(item => {
                    htmlBuffer += renderFunc(item);
                });

				$('#post-list-container').append(htmlBuffer);
				$('#post-list-container').after($('#sentinel'));

                window.page = nextPage;
                window.isLoading = false;
            } else {
                window.isLoading = false;
                if(window.io) window.io.disconnect();
            }
        },
        error: function() {
            window.isLoading = false;
        }
    });
}

function renderMyPost(item) {
    const images = item.fileList ? item.fileList.map(file => file.filePath) : [];
    
    let mediaHtml = "";
    if (images.length > 0) {
        const carouselId = `carousel-${item.postId}`;
        if (images.length > 1) {
            mediaHtml = `
                <div class="p-3 pt-0">
                    <div id="${carouselId}" class="carousel slide post-carousel" data-bs-ride="false">
                        <div class="carousel-indicators">
                            ${images.map((_, idx) => `
                                <button type="button" data-bs-target="#${carouselId}" data-bs-slide-to="${idx}" 
                                        class="${idx === 0 ? 'active' : ''}"></button>
                            `).join('')}
                        </div>
                        <div class="carousel-inner">
                            ${images.map((path, idx) => `
                                <div class="carousel-item ${idx === 0 ? 'active' : ''}">
                                    <div class="ratio ratio-16x9">
                                        <img src="${path}" class="d-block w-100 object-fit-cover" alt="Post Image">
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
            mediaHtml = `
                <div class="p-3 pt-0">
                    <div class="post-carousel">
                        <div class="ratio ratio-16x9">
                            <img src="${images[0]}" class="d-block w-100 object-fit-cover" alt="Post Image">
                        </div>
                    </div>
                </div>`;
        }
    }

    return `
        <div class="glass-card shadow-lg group mb-4">
            <div class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                <div class="d-flex align-items-center gap-3">
                    <div class="avatar-md bg-info text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden" 
                         style="width:40px; height:40px; border-radius:10px; background: linear-gradient(135deg, #6366f1, #a855f7);">
                        ${item.authorProfileImage 
                            ? `<img src="${item.authorProfileImage}" class="w-100 h-100 object-fit-cover">` 
                            : (item.authorNickname ? item.authorNickname.substring(0, 1) : 'U')}
                    </div>
                    <div>
                        <h3 class="text-sm fw-medium text-white mb-0">${item.authorNickname || '익명'}</h3>
                        <p class="text-xs text-gray-500 mb-0">${item.createdDate}</p>
                    </div>
                </div>
                <button class="btn-icon text-white-50"><span class="material-symbols-outlined">more_horiz</span></button>
            </div>

            <div class="p-3 pb-2">
                ${item.title ? `<h4 class="text-white fs-6 fw-bold mb-1">${item.title}</h4>` : ''}
                <p class="text-light text-sm mb-0 lh-base" style="white-space: pre-wrap;">${item.content}</p>
            </div>

            ${mediaHtml}

            <div class="px-3 py-2 d-flex align-items-center justify-content-between border-top border-white border-opacity-10"
                 style="background: rgba(255, 255, 255, 0.05);">

                <div class="d-flex gap-4">
					<button class="btn-icon d-flex align-items-center gap-1"
						onclick="toggleLike(this, '${item.postId}')">
							<span
								class="material-symbols-outlined fs-5 ${item.likedByUser ? 'text-danger' : ''}"
								style="font-variation-settings: 'FILL' ${item.likedByUser ? 1 : 0};">
								favorite </span> <span class="text-xs opacity-75 like-count">${item.likeCount}</span>
					</button>
                    <button class="btn-icon d-flex align-items-center gap-1" onclick="location.href='${window.cp}/post/article?postId=${item.postId}';">
                        <span class="material-symbols-outlined fs-5">chat_bubble</span>
                        <span class="text-xs opacity-75">${item.commentCount || 0}</span>
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
    `;
}

function showToast(type, msg) {
	const $toast = $('#sessionToast');
	const $title = $('#toastTitle');
	const $icon = $('#toastIcon');

	$('#toastMessage').text(msg);

	if (type === "success") {
		$title.text('SUCCESS').css('color', '#4ade80');
		$icon.text('check_circle');
	}
	else if (type === "info") {
		$title.text('INFO').css('color', '#8B5CF6');
		$icon.text('info');
	}
	else if (type === "error") {
		$title.text('ERROR').css('color', '#f87171');
		$icon.text('error');
	}

	$toast.addClass('show');

	setTimeout(function() {
		$toast.removeClass('show');
	}, 2500);
}