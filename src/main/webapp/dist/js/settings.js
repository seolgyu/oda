/**
 * 
 */

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