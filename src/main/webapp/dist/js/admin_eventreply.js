const replySessionEL = document.querySelector('div#listReply');
const listNode = document.querySelector('div#listReply .list-content');
const postsUrl = replySessionEL.getAttribute('data-postsUrl');
const contextPath = replySessionEL.getAttribute('data-contextPath');
const num = replySessionEL.getAttribute('data-num');
const liked = replySessionEL.getAttribute('data-liked') || '0';

$(function(){
	loadContent(1);
});

function loadContent(page) {
	const url = `${postsUrl}/listReply`;
	const params = {num:num, pageNo:page};
	
	const fn = function(data) {
		addNewContent(data);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

function addNewContent(data) {
	const listReply = data.listReply;
	const replyCount = Number(data.replyCount) || 0;
	const pageNo = Number(data.pageNo) || 0;
	const total_page = Number(data.total_page) || 0;
	const paging = data.paging;
	const sessionMember = data.sessionMember;
	
	const htmlText = renderReplies(listReply, sessionMember, pageNo);
	
	$('div#listReply .reply-count').html(`댓글 ${replyCount}`);
	$('div#listReply .reply-page').html(`[목록, ${pageNo}/${total_page} 페이지]`);
	
	$('div#listReply .list-content').attr('data-pageNo', pageNo);
	$('div#listReply .list-content').attr('data-totalPage', total_page);
	
	if(replyCount === 0) {
		$('div#listReply').hide();
		$('div#listReply .list-content > table > tbody').empty();
		
		return;
	}
	
	$('div#listReply').show();
	$('div#listReply .list-content > table > tbody').html(htmlText);
	$('div#listReply .page-navigation').html(paging);
}

// 댓글 등록
$(function(){
	$('button.btnSendReply').click(function(){
		
		const $container = $(this).closest('.comment-input-container');
		let content = $container.find('.comment-textarea').val().trim();
		
		if(!content) {
		      $container.find('.comment-textarea').focus();
		            return false;
		        }
		
				const url = `${postsUrl}/insertReply`;
				        const params = {
				            num: num, 
				            content: content, 
				            parentNum: 0
				        };
				        
				        const fn = function(data) {
				            $container.find('.comment-textarea').val('');
				            if(data.state === 'true' || data.state === 'ture') {
				                loadContent(1); // 리스트 새로고침
				            } else {
				                alert('등록 실패');
				            }
				        };
				        
				        ajaxRequest(url, 'post', params, 'json', fn);
				    });
				});

// 삭제, 신고 메뉴
$(function(){
	$('div.reply').on('click', '.reply-dropdown', function(){
		const $menu = $(this).next('.reply-menu');
		
		let isHidden = $menu.hasClass('d-none');
		
		if(isHidden) {
			$('div.reply .reply-menu').not('.d-none').addClass('d-none');
			
			$menu.removeClass('d-none');
			
			let pos = $(this).offset();
			$menu.offset({left: pos.left-70, top: pos.top + 20});
		} else {
			$menu.addClass('d-none');
		}
	});

	$('div.reply').on('click', function(e){
		if($(e.target.parentNode).hasClass('reply-dropdown')) {
			return false;
		}
		
		$('div.reply .reply-menu').not('.d-none').addClass('d-none');
	});
	
});

// 댓글 삭제
$(function(){
	$('div.reply').on('click', '.deleteReply', function(){
		if(! confirm('게시글을 삭제하시겠습니까 ?')) {
			return false;
		}
		
		let replyNum = $(this).attr('data-replyNum');
		let page = $(this).attr('data-pageNo');
		
		const url = `${postsUrl}/deleteReply`;
		let params = {replyNum:replyNum, mode:'reply'};
		
		const fn = function(data) {
			loadContent(page);
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 댓글 좋아요 / 싫어요
$(function(){
	$('div.reply').on('click', 'button.btnSendReplyLike', function(){
		const $btn = $(this);
		
		let isUserLiked = $btn.parent('td').attr('data-userLikedReply') !== '-1';
		if(isUserLiked) {
			alert('게시글 공감여부가 등록되었습니다.');
			return false;
		}
		
		let replyNum = $btn.attr('data-replyNum');
		let replyLike = $btn.attr('data-replyLike');
		
		let msg = '게시글이 마음에 들지 않으십니까 ? ';
		if(replyLike === '1') {
			msg = '게시글에 공감하십니까 ? ';
		}
		
		if(! confirm(msg)) {
			return false;
		}
		
		const url = `${postsUrl}/insertReplyLike`;
		let params = {replyNum: replyNum, replyLike:replyLike};
		
		const fn = function(data) {
			let state = data.state;
			
			if(state === 'true') {
				let likeCount = data.likeCount;
				let disLikeCount = data.disLikeCount;
				
				$btn.parent('td').attr('data-userLikedReply', replyLike);
				$btn.find('i').css('color', 'red');
				
				$btn.parent('td').children().eq(0).find('span').html(likeCount);
				$btn.parent('td').children().eq(1).find('span').html(disLikeCount);
			} else if(state === 'liked') {
				alert('공감 여부는 한번만 가능합니다.');
			} else {
				alert('공감 여부 처리가 실패했습니다.');
			}
			
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 댓글별 답글 리스트
function listReplyAnswer(parentNum) {
	const url = `${postsUrl}/listReplyAnswer`;
	let params = 'parentNum=' + parentNum;
	
	const fn = function(data) {
		addNewAnswer(data, parentNum);
	};
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

function addNewAnswer(data, parentNum) {
	let selector;
	
	const sessionMember = data.sessionMember;
	const count = data.count;
	const listReplyAnswer = data.listReplyAnswer;
	
	// 댓글의 답글 개수
	selector = 'span#answerCount' + parentNum;
	$(selector).html(count);
	
	// 댓글의 답글 리스트
	const htmlText = renderReplyAnswers(listReplyAnswer, sessionMember);
	selector = 'div#listReplyAnswer' + parentNum;
	$(selector).html(htmlText);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$('div.reply').on('click', 'button.btnReplyAnswerLayout', function(){
		const $tr = $(this).closest('tr').next();
		
		let replyNum = $(this).attr('data-replyNum');
		
		if($tr.hasClass('d-none')) {
			// 답글 리스트
			listReplyAnswer(replyNum);
		}
		
		$tr.toggleClass('d-none');
		
	});
});

// 댓글별 답글 등록
$(function(){
	$('div.reply').on('click', 'button.btnSendReplyAnswer', function(){
		let replyNum = $(this).attr('data-replyNum');
		const $td = $(this).closest('td');
		
		let content = $td.find('textarea').val().trim();
		if( ! content ) {
			$td.find('textarea').focus();
			return false;
		}
		
		const url = `${postsUrl}/insertReply`;
		let params = {num: num, content:content, parentNum: replyNum};
		
		const fn = function(data) {
			$td.find('textarea').val('');
			
			let state = data.state;
			
			if(state === 'true') {
				listReplyAnswer(replyNum);
			}
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 댓글별 답글 삭제
$(function(){
	$('div.reply').on('click', '.deleteReplyAnswer', function(){
		if(! confirm('게시물을 삭제하시겠습니까 ? ')) {
		    return false;
		}
		
		let replyNum = $(this).attr('data-replyNum');
		let parentNum = $(this).attr('data-parentNum');
		
		const url = `${postsUrl}/deleteReply`;
		let params = {replyNum:replyNum, mode:'answer'};
		
		const fn = function(data){
			listReplyAnswer(parentNum);
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 댓글 숨김기능
$(function(){
	$('div.reply').on('click', '.hideReply', function(){
		let $menu = $(this);
		
		let replyNum = $(this).attr('data-replyNum');
		let showReply = $(this).attr('data-showReply');
		let msg = '댓글을 숨김 하시겠습니까 ? ';
		if(showReply === '0') {
			msg = '댓글 숨김을 해제 하시겠습니까 ? ';
		}
		if(! confirm(msg)) {
			return false;
		}
		
		showReply = showReply === '1' ? '0' : '1';
		
		const url = `${postsUrl}/replyShowHide`;
		let params = {replyNum:replyNum, showReply:showReply};
		
		const fn = function(data){
			if(data.state === 'true') {
				let $item = $($menu).closest('tr').next('tr').find('td');
				if(showReply === '1') {
					$item.removeClass('text-primary').removeClass('text-opacity-50');
					$menu.attr('data-showReply', '1');
					$menu.text('숨김');
				} else {
					$item.addClass('text-primary').addClass('text-opacity-50');
					$menu.attr('data-showReply', '0');
					$menu.text('표시');
				}
			}
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 답글 숨김기능
$(function(){
	$('div.reply').on('click', '.hideReplyAnswer', function(){
		let $menu = $(this);
		
		let replyNum = $(this).attr('data-replyNum');
		let showReply = $(this).attr('data-showReply');
		
		let msg = '댓글을 숨김 하시겠습니까 ? ';
		if(showReply === '0') {
			msg = '댓글 숨김을 해제 하시겠습니까 ? ';
		}
		if(! confirm(msg)) {
			return false;
		}
		
		showReply = showReply === '1' ? '0' : '1';
		
		const url = `${postsUrl}/replyShowHide`;
		let params = {replyNum:replyNum, showReply:showReply};
		
		const fn = function(data){
			if(data.state === 'true') {
				let $item = $menu.closest('.row').next('div');
				if(showReply === '1') {
					$item.removeClass('text-primary').removeClass('text-opacity-50');
					$menu.attr('data-showReply', '1');
					$menu.html('숨김');
				} else {
					$item.addClass('text-primary').addClass('text-opacity-50');
					$menu.attr('data-showReply', '0');
					$menu.html('표시');
				}
			}
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

//-------------------------------------------------------------------------------------------------------------------------
// 댓글 및 답글 리스트 HTML
function renderReplies(listReply, sessionMember, pageNo) {
  const liked = $('#listReply').attr('data-liked');
	
	return listReply.map(vo => {
    const isWriter = sessionMember.userId === vo.userId;
    const isAdmin = sessionMember.userLevel > 50;
    const showReplyText = vo.showReply == 1 ? "숨김" : "표시";
    const contentClass = vo.showReply == 0 ? 'text-primary text-opacity-50' : '';

    let menuHTML = '';
    if (isWriter) {
      menuHTML = `
        <div class="deleteReply reply-menu-item" data-replyNum="${vo.comment_id}" data-pageNo="${pageNo}">삭제</div>
        <div class="hideReply reply-menu-item" data-replyNum="${vo.comment_id}" data-showReply="${vo.showReply}">${showReplyText}</div>
      `;
    } else if (isAdmin) {
      menuHTML = `
        <div class="deleteReply reply-menu-item" data-replyNum="${vo.comment_id}" data-pageNo="${pageNo}">삭제</div>
        <div class="blockReply reply-menu-item" data-replyNum="${vo.comment_id}" data-pageNo="${pageNo}">차단</div>
      `;
    } else {
      menuHTML = `
        <div class="notifyReply reply-menu-item" data-replyNum="${vo.comment_id}">신고</div>
        <div class="blockReply reply-menu-item" data-replyNum="${vo.comment_id}" data-pageNo="${pageNo}">차단</div>
      `;
    }
	
	let likedHTML = '&nbsp;';
	if(liked === '1') {
		const likeColor = vo.userLikedReply == 1 ? 'color:red;' : '';
		
		likedHTML = `
			<button type="button" class="btn btn-light btnSendReplyLike" data-replyNum="${vo.comment_id}" data-replyLike="1" title="좋아요">
				<i class="bi bi-hand-thumbs-up" style="${likeColor}"></i> <span>${vo.likeCount}</span>
			</button>	
		`;
	}

	return `
	            <div class="comment-box">
	                <div class="comment-meta">
	                    <span class="comment-author">${vo.userName}</span>
	                    <span class="comment-date">${vo.created_date}</span>
						<div class="reply-menu">${menuHTML}</div>
	                </div>
					<div class="comment-body ${contentClass}">
					    ${vo.showReply == 0 ? '관리자에 의해 숨겨진 댓글입니다.' : vo.content}
					</div>
					<div class="comment-actions">${likedHTML}
	                <div class="comment-actions">
	                    <button class="btn-reply btnReplyAnswerLayout" data-replyNum="${vo.comment_id}">
	                        <span class="material-symbols-outlined">chat_bubble</span> 답글 쓰기
	                    </button>
	                </div>
	                </div>
	        `;
	    }).join('');
	}

function renderReplyAnswers(listReplyAnswer, sessionMember) {
  return listReplyAnswer.map(vo => {
    const isWriter = sessionMember.userId === vo.userId;
    const isAdmin = sessionMember.userLevel > 50;
    const showReplyText = vo.showReply == 1 ? "숨김" : "표시";
    const contentClass = vo.showReply == 0 ? 'text-primary text-opacity-50' : '';

    let menuHTML = '';
    if (isWriter) {
      menuHTML = `
        <div class="deleteReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">삭제</div>
        <div class="hideReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-showReply="${vo.showReply}">${showReplyText}</div>
      `;
    } else if (isAdmin) {
      menuHTML = `
        <div class="deleteReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">삭제</div>
        <div class="blockReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">차단</div>
      `;
    } else {
      menuHTML = `
        <div class="notifyReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}">신고</div>
        <div class="blockReplyAnswer reply-menu-item" data-replyNum="${vo.replyNum}" data-parentNum="${vo.parentNum}">차단</div>
      `;
    }

    return `
		<div class="border-bottom m-1">
			<div class="row p-1">
				<div class="col-auto">
					<div class="row reply-writer">
						<div class="col-1"><i class="bi bi-person-circle text-muted icon"></i></div>
						<div class="col ms-2 align-self-center">
							<div class="name">${vo.userName}</div>
							<div class="date">${vo.reg_date}</div>
						</div>
					</div>
				</div>
				
				<div class="col align-self-center text-end">
					<span class="reply-dropdown"><i class="bi bi-three-dots-vertical"></i></span>
					<div class="reply-menu d-none">
						${menuHTML}
					</div>
				</div>
			</div>
			
			<div class="p-2 ${contentClass}">
				${vo.content}
			</div>
		</div>
    `;
  }).join('');
}
