window.page = 1; 
window.isLoading = false;
window.isEnd = false;
window.io = null;
window.currentSort = 'latest'; 
window.itemTemplate = null;

$(function() {
    // 1. 페이지 로드 시 템플릿 먼저 확보
    if ($('.post-item-card').length > 0) {
        window.itemTemplate = $('.post-item-card').first().clone();
    }

    initInfiniteScroll();

	$('#compage-tabs button').off('click').on('click', function() {
	    if(window.isLoading) return;

	    const $this = $(this);
	    const newSort = $this.data('sort'); 
	    if(window.currentSort === newSort) return;

	    // UI 변경
	    $('#compage-tabs button').removeClass('active-filter').addClass('text-secondary');
	    $this.addClass('active-filter').removeClass('text-secondary');
	    
	    if (!window.itemTemplate && $('.post-item-card').length > 0) {
	        window.itemTemplate = $('.post-item-card').first().clone();
	    }
	    
	    // 상태 초기화
	    window.currentSort = newSort;
	    window.isEnd = false;
	    
	    // ⭐ 중요: empty()를 하지 않고 바로 호출 (대신 'isRefresh' 파라미터 추가)
	    loadNextPage('/community/postList', renderCommunityPost, true); 
	});

    // 레이아웃 변경 (리스트/카드)
    $('.layout-tabs button').on('click', function() {
        const $this = $(this);
        $this.parent().find('button').removeClass('active-filter');
        $this.addClass('active-filter');
        
        const iconName = $this.find('.material-symbols-outlined').text().trim();
        const $container = $('#post-list-container');
        
        if (iconName === 'reorder') {
            $container.addClass('list-mode').removeClass('gap-4').addClass('gap-2');
            $('.list-view-item').show(); $('.card-view-item').hide();
        } else {
            $container.removeClass('list-mode').removeClass('gap-2').addClass('gap-4');
            $('.list-view-item').hide(); $('.card-view-item').show();
        }
    });
});

function initInfiniteScroll() {
    if (window.io) window.io.disconnect();
    const $sentinel = document.getElementById('sentinel');
    if (!$sentinel) return;

    window.io = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            // 로딩 중이 아니고 끝이 아닐 때만 호출
            if (entry.isIntersecting && !window.isLoading && !window.isEnd) {
                loadNextPage('/community/postList', renderCommunityPost);
            }
        });
    }, {
        root: null,
        rootMargin: '200px', // 조금 더 미리 불러오도록 수정
        threshold: 0.01
    });
    window.io.observe($sentinel);
}

function loadNextPage(url, renderFunc, isRefresh = false) {
    if (window.isLoading || window.isEnd) return;
    window.isLoading = true;

    // 리프레시(탭 전환)면 0번부터, 아니면 현재 개수부터
    const currentCount = isRefresh ? 0 : $('#post-list-container .post-item-card').length; 

    $.ajax({
        url: window.cp + url,
        type: 'GET',
        data: { 
            offset: currentCount,
            community_id: window.communityId,
            sort: window.currentSort,
            size: 10
        },
        dataType: 'json',
        success: function(data) {
            const list = data.list || data;
            
            if (list && list.length > 0) {
                let htmlBuffer = $();
                list.forEach(item => {
                    htmlBuffer = htmlBuffer.add(renderFunc(item));
                });

                // ⭐ 핵심: 데이터가 준비된 시점에만 동작
                if (isRefresh) {
                    // 새 데이터를 넣기 직전에만 비워서 깜빡임 최소화
                    $('#post-list-container').html(htmlBuffer); 
                } else {
                    // 무한 스크롤일 때는 기존처럼 뒤에 붙임
                    $('#post-list-container').append(htmlBuffer);
                }
            } else {
                window.isEnd = true;
				if(isRefresh) {
					const emptyHtml = `
							<div class="glass-card py-5 text-center shadow-lg border-0"
								style="background: rgba(255, 255, 255, 0.02); border-radius: 1rem !important; width: 100%;">
								<div class="py-4">
									<span class="material-symbols-outlined text-secondary opacity-20"
										style="font-size: 80px;">rocket_launch</span>
										<h4 class="text-white mt-3 fw-bold opacity-75">등록된 게시글이 없습니다</h4>
								</div>
							</div>
							`;
					$('#post-list-container').html(emptyHtml);
				}
            }
        },
        complete: function() {
            window.isLoading = false;
            // 리프레시 후 높이가 너무 낮으면 sentinel이 안 보일 수 있으니 스크롤 위치 보정 필요 없음
        }
    });
}

function renderCommunityPost(item) {
    if (!window.itemTemplate) return $();

    const $newItem = window.itemTemplate.clone();
    $newItem.attr('data-id', item.postId);
	
	const $profileImgArea = $newItem.find('.avatar-md'); // 카드뷰 프로필
	const $listThumbArea = $newItem.find('.thumbnail-box'); // 리스트뷰 썸네일
	    
	    if (item.authorProfileImage) {
	        $profileImgArea.html(`<img src="${item.authorProfileImage}" class="w-100 h-100 object-fit-cover">`);
	    } else {
	        const firstChar = item.authorNickname ? item.authorNickname.substring(0, 1) : '?';
	        $profileImgArea.html(firstChar);
	    }
		
    // 1. 텍스트 매핑
	$newItem.find('.list-view-item .app-user-trigger.text-white').text(item.authorNickname);
	$newItem.find('.card-view-item h3.text-sm').text(item.authorNickname);
	$newItem.find('.text-secondary.text-xs.opacity-75').text('c/' + item.authorId);
	
    $newItem.find('h4').text(item.title || "");
    $newItem.find('p.text-light').text(item.content || "");
    $newItem.find('.author-name, h3.text-sm').first().text(item.authorNickname);
    $newItem.find('.created-date, .text-gray-500').first().text(item.createdDate);
	
	    if (item.fileList && item.fileList.length > 0) {
	        $listThumbArea.html(`<img src="${item.fileList[0].filePath}" class="w-100 h-100 object-fit-cover rounded-3 border border-white border-opacity-10">`);
	    } else {
	        $listThumbArea.html(`
	            <div class="w-100 h-100 rounded-3 d-flex align-items-center justify-content-center border border-white border-opacity-10" style="background: rgba(255, 255, 255, 0.05);">
	                <span class="material-symbols-outlined opacity-20">image</span>
	            </div>
	        `);
	    }

		    if (item.fileList && item.fileList.length > 0) {
		        $listThumbArea.html(`<img src="${item.fileList[0].filePath}" class="w-100 h-100 object-fit-cover rounded-3 border border-white border-opacity-10">`);
		    } else {
		        $listThumbArea.html(`
		            <div class="w-100 h-100 rounded-3 d-flex align-items-center justify-content-center border border-white border-opacity-10" style="background: rgba(255, 255, 255, 0.05);">
		                <span class="material-symbols-outlined opacity-20">image</span>
		            </div>
		        `);
		    }

		    // --- 3. 이미지 처리 (카드뷰용 캐러셀) ---
		    const $cardImgArea = $newItem.find('.card-view-item > .p-3.pt-0');
		    if (item.fileList && item.fileList.length > 0) {
		        $cardImgArea.show();
		        let imageHtml = '';
		        if (item.fileList.length > 1) {
		            const carouselId = `carousel-ajax-${item.postId}-${Math.floor(Math.random() * 1000)}`;
		            imageHtml = `
		                <div id="${carouselId}" class="carousel slide post-carousel" data-bs-ride="false">
		                    <div class="carousel-indicators">
		                        ${item.fileList.map((_, i) => `<button type="button" data-bs-target="#${carouselId}" data-bs-slide-to="${i}" class="${i === 0 ? 'active' : ''}"></button>`).join('')}
		                    </div>
		                    <div class="carousel-inner">
		                        ${item.fileList.map((file, i) => `
		                            <div class="carousel-item ${i === 0 ? 'active' : ''}">
		                                <div class="ratio ratio-16x9"><img src="${file.filePath}" class="d-block w-100 object-fit-cover"></div>
		                            </div>
		                        `).join('')}
		                    </div>
		                    <button class="carousel-control-prev" type="button" data-bs-target="#${carouselId}" data-bs-slide="prev"><span class="material-symbols-outlined fs-4">chevron_left</span></button>
		                    <button class="carousel-control-next" type="button" data-bs-target="#${carouselId}" data-bs-slide="next"><span class="material-symbols-outlined fs-4">chevron_right</span></button>
		                </div>`;
		            $cardImgArea.html(imageHtml);
		            
		            // 핵심: 부트스트랩 캐러셀 수동 초기화 (작동 안 함 방지)
		            setTimeout(() => {
		                new bootstrap.Carousel(document.getElementById(carouselId));
		            }, 10);
		        } else {
		            imageHtml = `<div class="post-carousel"><div class="ratio ratio-16x9"><img src="${item.fileList[0].filePath}" class="d-block w-100 object-fit-cover"></div></div>`;
		            $cardImgArea.html(imageHtml);
		        }
		    } else {
		        $cardImgArea.hide().empty();
		    }

    // 2. 좋아요 처리 (상태에 따라 클래스 추가/제거 확실히)
    const $likeBtn = $newItem.find('[onclick^="toggleLike"]');
    const $likeIcon = $likeBtn.find('.material-symbols-outlined');
    $likeBtn.find('.like-count').text(item.likeCount);
    
    if (item.likedByUser) {
        $likeIcon.addClass('text-danger').css('font-variation-settings', "'FILL' 1");
    } else {
        $likeIcon.removeClass('text-danger').css('font-variation-settings', "'FILL' 0");
    }

    // 3. 댓글 처리
    $newItem.find('.material-symbols-outlined:contains("chat_bubble")').next('span').text(item.commentCount);

    // 4. 리그램 처리 (이전의 text-success 클래스를 반드시 지워줘야 함)
    const $repostBtn = $newItem.find('.material-symbols-outlined:contains("repeat")').closest('button');
    if (item.repostedByUser) {
        $repostBtn.addClass('text-success');
    } else {
        $repostBtn.removeClass('text-success');
    }

    // 5. 저장 처리 (아이콘 텍스트와 FILL 상태 모두 초기화)
    const $saveBtn = $newItem.find('[onclick^="toggleSave"]');
    const $saveIcon = $saveBtn.find('.material-symbols-outlined');
    if (item.savedByUser) {
        $saveBtn.addClass('text-warning');
        $saveIcon.text('bookmark').css('font-variation-settings', "'FILL' 1");
    } else {
        $saveBtn.removeClass('text-warning');
        $saveIcon.text('bookmark_border').css('font-variation-settings', "'FILL' 0");
    }

    // 7. 이벤트 재바인딩
    $newItem.find('[onclick^="toggleLike"]').attr('onclick', `toggleLike(this, '${item.postId}')`);
    $newItem.find('[onclick^="toggleSave"]').attr('onclick', `toggleSave('${item.postId}', this)`);
    $newItem.find('[onclick^="toggleRepost"]').attr('onclick', `toggleRepost('${item.postId}', this)`);
    $newItem.find('[onclick*="article"]').attr('onclick', `location.href='${window.cp}/post/article?postId=${item.postId}'`);
    $newItem.find('[onclick^="copyUrl"]').attr('onclick', `copyUrl('${item.postId}')`);
    $newItem.find('[onclick^="openReportModal"]').attr('onclick', `openReportModal('${item.postId}')`);

    return $newItem;
}


function toggleLike(btn, postId) {
			if ($(btn).data('loading'))
				return;
			$(btn).data('loading', true);

			const $btn = $(btn);
			const $icon = $btn.find('.material-symbols-outlined');
			const $countSpan = $btn.find('.like-count');

			const isLiked = $icon.hasClass('text-danger');

			$
					.ajax({
						type : "POST",
						url : contextPath + '/member/settings/toggleLike',
						data : {
							postId : postId
						},
						dataType : "json",
						success : function(data) {
							if (data.status === 'success') {
								if (isLiked) {
									$icon.css('font-variation-settings',
											"'FILL' 0");
									$icon.removeClass('text-danger');
									showToast("success", "좋아요를 취소했습니다.");
								} else {
									$icon.css('font-variation-settings',
											"'FILL' 1");
									$icon.addClass('text-danger');
									showToast("success", "좋아요를 눌렀습니다.");
								}

								if (data.likeCount !== undefined) {
									$countSpan.text(data.likeCount);
								}
							} else {
								showToast("error", "좋아요 처리에 실패했습니다.");
							}
						},
						error : function(xhr) {
							showToast("error", "서버 통신 에러.");
							console.error(xhr.responseText);
						},
						complete : function() {
							$btn.data('loading', false);
						}
					});
		}
		
		function copyUrl(postId) {
		    
		    const url = window.location.origin + contextPath + '/post/article?postId=' + postId;

		    if (navigator.clipboard && navigator.clipboard.writeText) {
		        navigator.clipboard.writeText(url).then(() => {
		        	showToast("success", "클립보드에 주소가 복사되었습니다.");
		        }).catch(err => {
		            // 실패 시 구형 방식 시도
		            fallbackCopyTextToClipboard(url);
		        });
		    } else {
		        // 구형 브라우저(또는 HTTP 환경) 대응
		        fallbackCopyTextToClipboard(url);
		    }
		}

		// 구형 브라우저용 복사 함수 (임시 textarea 생성 방식)
		function fallbackCopyTextToClipboard(text) {
		    const textArea = document.createElement("textarea");
		    textArea.value = text;
		    
		    // 화면 밖으로 숨김
		    textArea.style.position = "fixed";
		    textArea.style.left = "-9999px";
		    document.body.appendChild(textArea);
		    textArea.focus();
		    textArea.select();

		    try {
		        const successful = document.execCommand('copy');
		        if (successful) {
		        	showToast("success", "클립보드에 주소가 복사되었습니다.");
		        } else {
		        	showToast("error", "주소 복사에 실패했습니다.");
		        }
		    } catch (err) {
		    	showToast("error", "주소 복사에 실패했습니다.");
		    }
		    document.body.removeChild(textArea);
		}
		
		function openReportModal(postId) {			
			if (isLogin === "false") {
		        if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
		            location.href = contextPath + "/member/login";
		        }
		        return; 
		    }
			
		    $("#reportPostId").val(postId);
		    $("#reportReasonSelect").val("");
		    $("#reportReasonText").val("").hide();
		    
		    const myModal = new bootstrap.Modal(document.getElementById('reportModal'));
		    myModal.show();
		}

		function toggleReportReason(select) {
		    if(select.value === "custom") {
		        $("#reportReasonText").show().focus();
		    } else {
		        $("#reportReasonText").hide();
		    }
		}

		function submitReport() {
		    const postId = $("#reportPostId").val();
		    let reason = $("#reportReasonSelect").val();
		    
		    if(!reason) {
		        showToast("error", "신고 사유를 선택해주세요.");
		        return;
		    }
		    if(reason === "custom") {
		        reason = $("#reportReasonText").val().trim();
		        if(!reason) {
		            showToast("error", "상세 사유를 입력해주세요.");
		            return;
		        }
		    }
		    
		    $.ajax({
		        url: contextPath + "/post/report",
		        type: "post",
		        data: { postId: postId, reason: reason },
		        dataType: "json",
		        success: function(data) {
		            $('#reportModal').modal('hide');
		            if(data.state === "success") {
		                showToast("success", "신고가 접수되었습니다.");
		            } else if(data.state === "login_required") {
		                if(confirm("로그인이 필요합니다.")) location.href = contextPath + "/member/login";
		            } else {
		                showToast("error", "신고 실패");
		            }
		        },
		        error: function() { showToast("error", "서버 에러"); }
		    });
		}
		
		
		function toggleSave(postId, btn) {
			if (isLogin === "false") {
	            if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
	                location.href = contextPath + "/member/login";
	            }
	            return;
	        }

	        $.ajax({
	            url: contextPath + "/post/insertPostSave",
	            type: "post",
	            data: { postId: postId },
	            dataType: "json",
	            success: function(data) {
	                if (data.state === "success") {
	                    const $btn = $(btn);
	                    const $icon = $btn.find("span.material-symbols-outlined");
	                    
	                    if (data.saved) {
	                       
	                        $icon.text("bookmark");
	                        $btn.addClass("text-warning");
							$icon.css('font-variation-settings', "'FILL' 1");
	                        showToast("success", "게시글을 저장했습니다.");
	                    } else {
	                        
	                        $icon.text("bookmark_border");
	                        $btn.removeClass("text-warning");
							$icon.css('font-variation-settings', "'FILL' 0");
	                        showToast("info", "저장을 취소했습니다.");
	                    }
	                } else if (data.state === "login_required") {
	                    location.href = contextPath + "/member/login";
	                }
	            },
	            error: function(e) {
	                console.log(e);
	            }
	        });
	    }
	 
	    function toggleRepost(postId, btn) {
	    	if (isLogin === "false") {
	            if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
	                location.href = contextPath + "/member/login";
	            }
	            return;
	        }
			
			const $thisBtn = $(btn);
			
			$.ajax({
				url: contextPath + "/post/insertPostRepost",
				type: "post",
				data: { postId: postId },
			        dataType: "json",
			        success: function(data) {
			            if (data.state === "success") {
			                if (data.reposted) {
			                    // 전체가 아니라 클릭한 이 버튼만 색깔 변경
			                    $thisBtn.addClass("text-success");
			                    showToast("success", "게시글을 리그램했습니다.");
			                } else {
			                    $thisBtn.removeClass("text-success");
			                    showToast("info", "리그램을 취소했습니다.");
			                }
			            } else if (data.state === "login_required") {
			                location.href = contextPath + "/member/login";
			            }
			        },
			        error: function(e) { console.log(e); }
			    });
	    }
		
		$(function () {
		    // 저장 버튼 초기 상태 동기화
		    $('.btn-save').each(function () {
		        const $btn = $(this);
		        const $icon = $btn.find('.material-symbols-outlined');

		        if ($btn.hasClass('text-warning')) {
		            $icon.text('bookmark');
		            $icon.css('font-variation-settings', "'FILL' 1");
		        } else {
		            $icon.text('bookmark_border');
		            $icon.css('font-variation-settings', "'FILL' 0");
		        }
		    });
		});