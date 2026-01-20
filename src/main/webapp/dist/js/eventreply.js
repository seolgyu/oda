const replySessionEL = document.querySelector('div#listReply');
const listNode = document.querySelector('div#listReply .list-content');
const postsUrl = replySessionEL.getAttribute('data-postsUrl');
const contextPath = replySessionEL.getAttribute('data-contextPath');
const event_num = replySessionEL.getAttribute('data-event_num');
const liked = replySessionEL.getAttribute('data-liked') || '0';


$(function(){
   loadContent(1);
});

function loadContent(page) {
   const url = `${postsUrl}/listReply`;
   const params = {event_num:event_num, pageNo:page};
   
   const fn = function(data) {
      addNewContent(data);
   }
   
   ajaxRequest(url, 'get', params, 'json', fn);
}

function addNewContent(data) {
	
	console.log("받은 데이터 전체:", data); // 1. 데이터가 통째로 잘 왔나?
	   console.log("댓글 개수:", data.replyCount); // 2. 개수가 0은 아닌가?
	   
	   const listReply = data.listReply;
	   console.log("리스트 배열:", listReply); // 3. 배열에 8개가 들어있나?
	
   // const listReply = data.listReply;
   const replyCount = Number(data.replyCount) || 0;
   const pageNo = Number(data.pageNo) || 0;
   const total_page = Number(data.total_page) || 0;
   const paging = data.paging;
   const sessionMember = data.sessionMember;
   
   const htmlText = renderReplies(listReply, sessionMember, pageNo);
   
   $('div#listReply .reply-count').html(`<span class="material-symbols-outlined" style="font-size: 1.2rem; vertical-align: middle;">comment</span> 댓글 ${replyCount}개`);
   $('div#listReply .reply-page').html(`${pageNo} / ${total_page} 페이지`);
   
   $('div#listReply .list-content').attr('data-pageNo', pageNo);
   $('div#listReply .list-content').attr('data-totalPage', total_page);
   
   if(replyCount.length === 0) {
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
      const $tb = $(this).closest('table');
      
      let content = $tb.find('textarea').val().trim();
      if(! content) {
         $tb.find('textarea').focus();
         return false;
      }
      
      const url = `${postsUrl}/insertReply`;
      const params = {event_num:event_num, content:content, parent_comment_id:0};
      
      const fn = function(data) {
         $tb.find('textarea').val('');
         
         let state = data.state;
         
         if(state === 'true') {
            loadContent(1);
         } else if(state === 'false') {
            alert('댓글 등록이 실패 했습니다.');
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
		
		if(isHidden){
			$('div.reply .reply-menu').not('.d-none').addClass('d-none');
			$menu.removeClass('d-none');
			
			let pos = $(this).offset();
			$menu.offset({left: pos.left-40, top: pos.top - 15});
		}else{
			$menu.addClass('d-none');
		}
	});
	$('div.reply').on('click', function(e){
		if($(e.target.parentNode).hasClass('reply-dropdown')){
			return false;
		}
		$('div.reply .reply-menu').not('.d-none').addClass('d-none');
	});
});

// 댓글 삭제
$(function(){
	$('div.reply').on('click', '.deleteReply', function(){
		if(! confirm('댓글을 삭제하시겠습니까?')){
			return false;
		}
		
		let comment_id = $(this).attr('data-comment_id');
		let page = $(this).attr('data-pageNo');
		
		const url = `${postsUrl}/deleteReply`;
		let params = {comment_id:comment_id, mode:'reply'};
		
		const fn = function(data){
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
         alert('댓글 공감여부가 등록되었습니다.');
         return false;
      }
      
      let comment_id = $btn.attr('data-comment_id');
      let replyLike = $btn.attr('data-replyLike');
	  
	  console.log('댓글 넘버' + comment_id + ' : ' + '댓글 좋아요여부' + ' : ' + replyLike);
      
      let msg = '댓글이 마음에 들지 않으십니까?';
      if(replyLike === '1') {
         msg = '댓글에 공감하십니까?';
      }
      
      if(! confirm(msg)) {
         return false;
      }
      
      const url = `${postsUrl}/insertReplyLike`;
      let params = {comment_id: comment_id, replyLike: replyLike};
      
      const fn = function(data){
         let state = data.state;
         
         if(state === 'true'){
            let likeCount = data.likeCount;
            let disLikeCount = data.disLikeCount;
			
			console.log('댓글 좋아요 개수' + likeCount);
            
            $btn.parent('td').attr('data-userLikedReply', replyLike);
            $btn.find('i').css('color', '#ef4444');
            
            $btn.parent('td').children().eq(0).find('span').html(likeCount);
            $btn.parent('td').children().eq(1).find('span').html(disLikeCount);
         } else if(state === 'liked'){
            alert('공감 여부는 한번만 가능합니다.');
         } else {
            alert('공감여부 처리가 실패했습니다.');
         }
      }
      
      ajaxRequest(url, 'post', params, 'json', fn);
   });
});

// 댓글별 답글 리스트
function listReplyAnswer(parent_comment_id) {
   const url = `${postsUrl}/listReplyAnswer`;
   let params = 'parent_comment_id=' + parent_comment_id;
   
   const fn = function(data) {
      addNewAnswer(data, parent_comment_id);
   };
   
   ajaxRequest(url, 'get', params, 'json', fn);
}

function addNewAnswer(data, parent_comment_id) {
   let selector;
   
   const sessionMember = data.sessionMember;
   const count = data.count;
   const listReplyAnswer = data.listReplyAnswer;
   
   // 댓글의 답글 개수
   selector = 'span#answerCount' + parent_comment_id;
   $(selector).html(count);
   
   // 댓글의 답글 리스트
   const htmlText = renderReplyAnswers(listReplyAnswer, sessionMember);
   selector = 'div#listReplyAnswer' + parent_comment_id;
   $(selector).html(htmlText);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
   $('div.reply').on('click', 'button.btnReplyAnswerLayout', function(){
      const $tr = $(this).closest('tr').next();
      
      let comment_id = $(this).attr('data-comment_id');
      
      if($tr.hasClass('d-none')) {
         // 답글 리스트
         listReplyAnswer(comment_id);
      }
      
      $tr.toggleClass('d-none');
      
   });
});

// 댓글별 답글 등록
$(function(){
   $('div.reply').on('click', 'button.btnSendReplyAnswer', function(){
      let comment_id = $(this).attr('data-comment_id');
      const $td = $(this).closest('td');
      
      let content = $td.find('textarea').val().trim();
      if( ! content ) {
         $td.find('textarea').focus();
         return false;
      }
      
      const url = `${postsUrl}/insertReply`;
      let params = {event_num: event_num, content:content, parent_comment_id: comment_id};
      
      const fn = function(data) {
         $td.find('textarea').val('');
         
         let state = data.state;
         
         if(state === 'true') {
            listReplyAnswer(comment_id);
         }
      };
      
      ajaxRequest(url, 'post', params, 'json', fn);
   });
});

// 댓글별 답글 삭제
$(function(){
	$('div.reply').on('click', '.deleteReplyAnswer', function(){
		if(! confirm('답글을 삭제하시겠습니까?')) {
		    return false;
		}
		
		let comment_id = $(this).attr('data-comment_id');
		let parent_comment_id = $(this).attr('data-parent_comment_id');
		
		const url = `${postsUrl}/deleteReply`;
		let params = {comment_id:comment_id, mode:'answer'};
		
		const fn = function(data){
			listReplyAnswer(parent_comment_id);
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 댓글 숨김기능
$(function(){
	$('div.reply').on('click', '.hideReply', function(){
		let $menu = $(this);
		
		let comment_id = $(this).attr('data-comment_id');
		let showReply = $(this).attr('data-showReply');
		let msg = '댓글을 숨김 하시겠습니까?';
		if(showReply === '0') {
			msg = '댓글 숨김을 해제 하시겠습니까?';
		}
		if(! confirm(msg)) {
			return false;
		}
		
		showReply = showReply === '1' ? '0' : '1';
		
		const url = `${postsUrl}/replyShowHide`;
		let params = {comment_id:comment_id, showReply:showReply};
		
		const fn = function(data){
			if(data.state === 'true') {
				let $item = $($menu).closest('tr').next('tr').find('td');
				if(showReply === '1') {
					$item.removeClass('reply-hidden');
					$menu.attr('data-showReply', '1');
					$menu.text('숨김');
				} else {
					$item.addClass('reply-hidden');
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
		
		let comment_id = $(this).attr('data-comment_id');
		let showReply = $(this).attr('data-showReply');
		
		let msg = '답글을 숨김 하시겠습니까?';
		if(showReply === '0') {
			msg = '답글 숨김을 해제 하시겠습니까?';
		}
		if(! confirm(msg)) {
			return false;
		}
		
		showReply = showReply === '1' ? '0' : '1';
		
		const url = `${postsUrl}/replyShowHide`;
		let params = {comment_id:comment_id, showReply:showReply};
		
		const fn = function(data){
			if(data.state === 'true') {
				let $item = $menu.closest('.reply-answer-item').find('.reply-answer-content');
				if(showReply === '1') {
					$item.removeClass('reply-hidden');
					$menu.attr('data-showReply', '1');
					$menu.html('숨김');
				} else {
					$item.addClass('reply-hidden');
					$menu.attr('data-showReply', '0');
					$menu.html('표시');
				}
			}
		};
		
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});


// ---------------------------------------------
// 댓글 및 답글 리스트 HTML
function renderReplies(listReply, sessionMember, pageNo) {
  return listReply.map(vo => {
    const isWriter = sessionMember.user_id === vo.user_id;
    const isAdmin = sessionMember.userLevel > 50;
    const showReplyText = vo.showReply == 1 ? "숨김" : "표시";
    const contentClass = vo.showReply == 0 ? 'reply-hidden' : '';
	
    let menuHTML = '';
    if (isWriter) {
      menuHTML = `
        <div class="deleteReply reply-menu-item" data-comment_id="${vo.comment_id}" data-pageNo="${pageNo}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">delete</span>
          삭제
        </div>
        <div class="hideReply reply-menu-item" data-comment_id="${vo.comment_id}" data-showReply="${vo.showReply}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">${vo.showReply == 1 ? 'visibility_off' : 'visibility'}</span>
          ${showReplyText}
        </div>
      `;
    } else if (isAdmin) {
      menuHTML = `
        <div class="deleteReply reply-menu-item" data-comment_id="${vo.comment_id}" data-pageNo="${pageNo}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">delete</span>
          삭제
        </div>
        <div class="blockReply reply-menu-item" data-comment_id="${vo.comment_id}" data-pageNo="${pageNo}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">block</span>
          차단
        </div>
      `;
    } else {
      menuHTML = `
        <div class="notifyReply reply-menu-item" data-comment_id="${vo.comment_id}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">report</span>
          신고
        </div>
        <div class="blockReply reply-menu-item" data-comment_id="${vo.comment_id}" data-pageNo="${pageNo}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">block</span>
          차단
        </div>
      `;
    }
   
   let likedHTML = '&nbsp;';
   if(liked === '1') {
      const likeColor = vo.userLikedReply == 1 ? 'color:#ef4444;' : '';
      
      likedHTML = `
         <button type="button" class="btn btnSendReplyLike" data-comment_id="${vo.comment_id}" data-replyLike="1" title="좋아요">
            <i class="bi bi-hand-thumbs-up" style="${likeColor}"></i> <span>${vo.likeCount}</span>
         </button>
      `;
   }

   return `
      <tr class="reply-item-header">
         <td colspan="2">
            <div class="reply-header-wrapper">
               <div class="reply-writer">
                  <span class="material-symbols-outlined user-icon">account_circle</span>
                  <div class="writer-info">
                     <div class="name">${vo.user_nickname}</div>
                     <div class="date">
                        <span class="material-symbols-outlined" style="font-size: 0.875rem;">schedule</span>
                        ${vo.updated_date}
                     </div>
                  </div>
               </div>
               <div class="reply-actions">
                  <span class="reply-dropdown">
                     <span class="material-symbols-outlined">more_vert</span>
                  </span>
                  <div class="reply-menu d-none">
                     ${menuHTML}
                  </div>
               </div>
            </div>
         </td>
      </tr>
      
      <tr class="reply-item-content">
         <td colspan="2" class="reply-content ${contentClass}">${vo.content}</td>
      </tr>
      
      <tr class="reply-item-footer">
         <td>
            <button type="button" class="btn btnReplyAnswerLayout" data-comment_id="${vo.comment_id}">
               <span class="material-symbols-outlined" style="font-size: 1rem;">reply</span>
               답글 <span id="answerCount${vo.comment_id}" class="answer-count-badge">${vo.answerCount}</span>
            </button>
         </td>
         <td align="right" data-userLikedReply="${vo.userLikedReply}">
            ${likedHTML}
         </td>
      </tr>
      
      <tr class="reply-answer d-none">
         <td colspan="2">
            <div class="reply-answer-container">
               <div id="listReplyAnswer${vo.comment_id}" class="answer-list"></div>
               <div class="answer-form">
                  <textarea class="form-control" placeholder="답글을 입력해주세요..."></textarea>
                  <div class="answer-form-footer">
                     <button type="button" class="btn btnSendReplyAnswer" data-comment_id="${vo.comment_id}">
                        <span class="material-symbols-outlined" style="font-size: 1rem;">send</span>
                        답글 등록
                     </button>
                  </div>
               </div>
            </div>
         </td>
      </tr>
     `;
   }).join('');
}

function renderReplyAnswers(listReplyAnswer, sessionMember) {
  return listReplyAnswer.map(vo => {
    const isWriter = sessionMember.user_id === vo.user_id;
    const isAdmin = sessionMember.userLevel > 50;
    const showReplyText = vo.showReply == 1 ? "숨김" : "표시";
    const contentClass = vo.showReply == 0 ? 'reply-hidden' : '';

    let menuHTML = '';
    if (isWriter) {
      menuHTML = `
        <div class="deleteReplyAnswer reply-menu-item" data-comment_id="${vo.comment_id}" data-parent_comment_id="${vo.parent_comment_id}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">delete</span>
          삭제
        </div>
        <div class="hideReplyAnswer reply-menu-item" data-comment_id="${vo.comment_id}" data-showReply="${vo.showReply}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">${vo.showReply == 1 ? 'visibility_off' : 'visibility'}</span>
          ${showReplyText}
        </div>
      `;
    } else if (isAdmin) {
      menuHTML = `
        <div class="deleteReplyAnswer reply-menu-item" data-comment_id="${vo.comment_id}" data-parent_comment_id="${vo.parent_comment_id}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">delete</span>
          삭제
        </div>
        <div class="blockReplyAnswer reply-menu-item" data-comment_id="${vo.comment_id}" data-parent_comment_id="${vo.parent_comment_id}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">block</span>
          차단
        </div>
      `;
    } else {
      menuHTML = `
        <div class="notifyReplyAnswer reply-menu-item" data-comment_id="${vo.comment_id}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">report</span>
          신고
        </div>
        <div class="blockReplyAnswer reply-menu-item" data-comment_id="${vo.comment_id}" data-parent_comment_id="${vo.parent_comment_id}">
          <span class="material-symbols-outlined" style="font-size: 1rem;">block</span>
          차단
        </div>
      `;
    }

    return `
      <div class="reply-answer-item">
         <div class="reply-answer-header">
            <div class="reply-writer">
               <span class="material-symbols-outlined user-icon answer-icon">subdirectory_arrow_right</span>
               <span class="material-symbols-outlined user-icon">account_circle</span>
               <div class="writer-info">
                  <div class="name">${vo.user_nickname}</div>
                  <div class="date">
                     <span class="material-symbols-outlined" style="font-size: 0.875rem;">schedule</span>
                     ${vo.reg_date}
                  </div>
               </div>
            </div>
            
            <div class="reply-actions">
               <span class="reply-dropdown">
                  <span class="material-symbols-outlined">more_vert</span>
               </span>
               <div class="reply-menu d-none">
                  ${menuHTML}
               </div>
            </div>
         </div>
         
         <div class="reply-answer-content ${contentClass}">
            ${vo.content}
         </div>
      </div>
    `;
  }).join('');
}
