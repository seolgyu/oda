/**
 * 
 */
let page = 1;
let isLoading = false;

const observerOptions = {
	root: document.querySelector('.feed-scroll-container'),
	rootMargin: '0px',
	threshold: 1.0
};

const io = new IntersectionObserver((entries, observer) => {
	entries.forEach(entry => {
		if (entry.isIntersecting && !isLoading) {
			loadNextPage();
		}
	});
}, observerOptions);

function loadNextPage() {
	isLoading = true;

	const nextPage = page + 1;

	$.ajax({
		url: cp + '/member/settings/loadLikedPost',
		type: 'GET',
		data: { page: nextPage },
		dataType: 'json',
		success: function(data) {
			if (data.status === 'success' && data.list && data.list.length > 0) {
				let htmlBuffer = "";
				data.list.forEach(item => {
					htmlBuffer += renderLikedPost(item);
				});

				$('#list-container').append(htmlBuffer);
				$('#list-container').after($('#sentinel'));

				page = nextPage;
				isLoading = false;
			} else {
				isLoading = false;
				io.disconnect();
			}
		},
		error: function() {
			isLoading = false;
		}
	});
}

function renderLikedPost(item) {
	const thumbnailHtml = item.thumbnail
		? `<div class="record-thumbnail rounded-3" style="background-image: url('${item.thumbnail}');"></div>`
		: `<div class="record-thumbnail rounded-3 d-flex align-items-center justify-content-center" 
		            style="background-color: rgba(255, 255, 255, 0.1); border: 1px dashed rgba(255, 255, 255, 0.2);">
		           <span class="material-symbols-outlined text-white opacity-20" style="font-size: 24px;">image</span>
		       </div>`;

	return `
		       <div class="record-item d-flex align-items-stretch overflow-hidden">
		           <div class="flex-grow-1 d-flex align-items-center gap-3 p-3 cursor-pointer item-content" 
		                onclick="location.href='${cp}/post/article?postId=${item.postId}';"> ${thumbnailHtml}
		               
		               <div class="flex-grow-1 min-w-0">
		                   <div class="d-flex align-items-center gap-2 mb-1 opacity-75">
		                       <span class="text-white text-xs fw-bold">${item.authorNickname}</span>
		                       <span class="text-secondary text-xs">· ${item.createdDate}</span>
		                   </div>
		                   <h4 class="text-white fs-6 fw-bold mb-1 text-truncate">${item.title}</h4>
		                   <p class="text-secondary text-xs mb-0 text-truncate opacity-50">${item.content}</p>
		               </div>
		           </div>

		           <div class="action-section d-flex align-items-center justify-content-center border-start border-white border-opacity-10">
		               <button type="button" class="btn-like-toggle" onclick="toggleLike(this, '${item.postId}')">
		                   <span class="material-symbols-outlined fill-icon text-danger">favorite</span>
		               </button>
		           </div>
		       </div>
		   `;
}

function startObserve() {
	const sentinel = document.querySelector('#sentinel');
	if (sentinel) {
		io.observe(sentinel);
	} else {
		io.disconnect();
	}
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
			startObserve();
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

// modelToast 알림
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

