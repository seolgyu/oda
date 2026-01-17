window.page = 1; // JSP에서 1페이지를 뿌렸으므로 1부터 시작
window.isLoading = false;
window.isEnd = false;
window.io = null;
window.currentSort = 'latest'; 

$(function() {
    // 마이페이지처럼 초기 로드 함수는 생략 (JSP 데이터 활용)
    initInfiniteScroll();

    // [1] 탭 전환 시 (마이페이지 로직 동일)
    $('#compage-tabs button').off('click').on('click', function() {
        if(window.isLoading) return;

        const $this = $(this);
        const newSort = $this.data('sort');
        if(window.currentSort === newSort) return;

        $('#compage-tabs button').removeClass('active-filter').addClass('text-secondary hover-white border-0');
        $this.addClass('active-filter').removeClass('text-secondary hover-white border-0');
        
        window.currentSort = newSort;
        window.page = 0; 
        window.isEnd = false;
        $('#post-list-container').empty(); 
        
        loadNextPage('/community/postList', renderCommunityPost);
    });

    // 레이아웃 전환
    $('.layout-tabs button').on('click', function() {
        const $parent = $(this).parent();
        $parent.find('button').removeClass('active-filter');
        $(this).addClass('active-filter');
        const iconName = $(this).find('.material-symbols-outlined').text().trim();
        const $container = $('#post-list-container');
        if (iconName === 'reorder') {
            $container.addClass('list-mode').removeClass('gap-4').addClass('gap-2');
        } else {
            $container.removeClass('list-mode').removeClass('gap-2').addClass('gap-4');
        }
    });
});

function initInfiniteScroll() {
    if (window.io) window.io.disconnect();
    const $sentinel = document.getElementById('sentinel');
    if (!$sentinel) return;

    window.io = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            // 마이페이지와 동일한 감지 로직
            if (entry.isIntersecting && !window.isLoading && !window.isEnd) {
                loadNextPage('/community/postList', renderCommunityPost);
            }
        });
    }, {
        root: null,
        rootMargin: '400px', // 마이페이지처럼 넉넉하게 잡음
        threshold: 0.01
    });
    window.io.observe($sentinel);
}

window.isLoading = false;
window.isEnd = false;

function loadNextPage(url, renderFunc) {
    if (window.isLoading || window.isEnd) return;
    window.isLoading = true;

    // ⭐ 핵심: 현재 화면에 그려진 게시글의 개수를 센다!
    // 처음에 서버가 5개를 뿌렸으면 5가 될 것이고, 
    // 그 다음엔 10, 15... 식으로 자동으로 늘어남
    const currentCount = $('.post-item-card').length; 

    $.ajax({
        url: window.cp + url,
        type: 'GET',
        data: { 
            offset: currentCount, // 서버가 원하는 이름 'offset'으로 전달
            community_id: window.communityId,
            sort: window.currentSort,
            size: 5 // 다음에도 5개씩 가져오라고 명시
        },
        dataType: 'json',
        success: function(data) {
            const list = data.list || data;
            
            if (list && list.length > 0) {
                // 한 번 더 중복 체크 (방어막)
                const currentIds = $('.post-item-card').map(function() {
                    return String($(this).data('id'));
                }).get();

                let htmlBuffer = "";
                list.forEach(item => {
                    if (!currentIds.includes(String(item.postId))) {
                        htmlBuffer += renderFunc(item);
                    }
                });

                $('#post-list-container').append(htmlBuffer);
            } else {
                window.isEnd = true;
            }
        },
        complete: function() {
            window.isLoading = false;
        }
    });
}

function renderCommunityPost(item) {
    const cp = window.cp;
    const isListMode = $('#post-list-container').hasClass('list-mode');
    const listViewDisplay = isListMode ? 'flex' : 'none';
    const cardViewDisplay = isListMode ? 'none' : 'block';

    const likedClass = item.likedByUser ? 'text-danger' : '';
    const likedFill = item.likedByUser ? 1 : 0;
    const hasImages = item.fileList && item.fileList.length > 0;
    const firstImg = hasImages ? item.fileList[0].filePath : null;

    let cardMediaHtml = '';
    if (hasImages) {
        if (item.fileList.length > 1) {
            const carouselId = `carousel-${item.postId}`;
            cardMediaHtml = `
                <div class="p-3 pt-0">
                    <div id="${carouselId}" class="carousel slide post-carousel" data-bs-ride="false">
                        <div class="carousel-indicators">
                            ${item.fileList.map((_, idx) => `<button type="button" data-bs-target="#${carouselId}" data-bs-slide-to="${idx}" class="${idx === 0 ? 'active' : ''}"></button>`).join('')}
                        </div>
                        <div class="carousel-inner">
                            ${item.fileList.map((file, idx) => `
                                <div class="carousel-item ${idx === 0 ? 'active' : ''}">
                                    <div class="ratio ratio-16x9"><img src="${file.filePath}" class="d-block w-100 object-fit-cover"></div>
                                </div>`).join('')}
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#${carouselId}" data-bs-slide="prev"><span class="material-symbols-outlined fs-4">chevron_left</span></button>
                        <button class="carousel-control-next" type="button" data-bs-target="#${carouselId}" data-bs-slide="next"><span class="material-symbols-outlined fs-4">chevron_right</span></button>
                    </div>
                </div>`;
        } else {
            cardMediaHtml = `<div class="p-3 pt-0"><div class="post-carousel"><div class="ratio ratio-16x9"><img src="${firstImg}" class="d-block w-100 object-fit-cover"></div></div></div>`;
        }
    }

    return `
        <div class="glass-card shadow-lg group mb-4 post-item-card" data-id="${item.postId}">
            <div class="list-view-item p-3" style="display: ${listViewDisplay};">
                <div class="d-flex align-items-start gap-3 w-100">
                    <div class="flex-shrink-0 thumbnail-box" style="width: 90px; height: 90px;">
                        ${firstImg ? `<img src="${firstImg}" class="w-100 h-100 object-fit-cover rounded-3 border border-white border-opacity-10">` : `<div class="w-100 h-100 rounded-3 d-flex align-items-center justify-content-center border border-white border-opacity-10" style="background: rgba(255, 255, 255, 0.05);"><span class="material-symbols-outlined opacity-20">image</span></div>`}
                    </div>
                    <div class="flex-grow-1 overflow-hidden d-flex flex-column justify-content-between" style="min-height: 90px;">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <span class="text-white fw-bold text-sm">${item.authorNickname}</span>
                                <span class="ms-auto text-xs text-gray-500">${item.createdDate}</span>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card-view-item" style="display: ${cardViewDisplay};">
                <div class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                    <div class="d-flex align-items-center gap-3">
                        <div class="avatar-md bg-info text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden" style="width: 40px; height: 40px; border-radius: 10px; background: linear-gradient(135deg, #6366f1, #a855f7);">
                            ${item.authorProfileImage ? `<img src="${item.authorProfileImage}" class="w-100 h-100 object-fit-cover">` : `<span>${item.authorNickname ? item.authorNickname.substring(0, 1) : 'U'}</span>`}
                        </div>
                        <div>
                            <h3 class="text-sm fw-medium text-white mb-0">${item.authorNickname}</h3>
                            <p class="text-xs text-gray-500 mb-0">${item.createdDate}</p>
                        </div>
                    </div>
                </div>
                <div class="p-3 pb-2">
                    ${item.title ? `<h4 class="text-white fs-6 fw-bold mb-1">${item.title}</h4>` : ''}
                    <p class="text-light text-sm mb-0 lh-base" style="white-space: pre-wrap;">${item.content}</p>
                </div>
                ${cardMediaHtml}
                <div class="px-3 py-2 d-flex align-items-center justify-content-between border-top border-white border-opacity-10" style="background: rgba(255, 255, 255, 0.05);">
                    <div class="d-flex gap-4">
                        <button class="btn-icon d-flex align-items-center gap-1" onclick="toggleLike(this, '${item.postId}')">
                            <span class="material-symbols-outlined fs-5 ${likedClass}" style="font-variation-settings: 'FILL' ${likedFill};">favorite</span>
                            <span class="text-xs opacity-75 like-count">${item.likeCount}</span>
                        </button>
                        <button class="btn-icon d-flex align-items-center gap-1" onclick="location.href='${cp}/post/article?postId=${item.postId}';">
                            <span class="material-symbols-outlined fs-5">chat_bubble</span>
                            <span class="text-xs opacity-75">${item.commentCount}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;
}