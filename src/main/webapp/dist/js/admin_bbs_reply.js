const replySessionEL = document.querySelector('div#listReply');
const listNode = document.querySelector('div#listReply .list-content');
const postsUrl = replySessionEL.getAttribute('data-postsUrl');
const contextPath = replySessionEL.getAttribute('data-contextPath');
const num = replySessionEL.getAttribute('data-num');
const liked = replySessionEL.getAttribute('data-liked') || '0';


$(function(){
  loadContent(1);
});

function loadContent(page){
	const url = `${postsUrl}/listReply`;
	const params = {num:num, pageNo:page};
	
	const fn = function(data){
		addNewContent(data);
	}
	ajaxRequest(url, 'get', params, 'json', fn);
	/*reply CP, select get, 댓글번호, 페이지번호, @ResponseBody(JSON), fn*/
}

function addNewContent(data) {/*Reply 조회로 부터 data*/
		const listReply = data.listReply;
	   const replyCount = Number(data.replyCount) || 0;
	   const pageNo = Number(data.pageNo) || 0;
	   const total_page = Number(data.total_page) || 0;
	   const paging = data.paging;
	   const sessionMember = data.sessionMember;
	   
	   const htmlText = renderReplies(listReply, sessionMember, pageNo);
	   /*renderReplies : HTML 태그 삽입 함수*/
	   
	  $('div#listReply .reply-count').html(`댓글 ${replyCount}`);
      $('div#listReply .reply-page').html(`[목록, ${pageNo}/${total_page} 페이지]`);
      
      $('div#listReply .list-content').attr('data-pageNo', pageNo);
      $('div#listReply .list-content').attr('data-totalPage', total_page);
      
	  if(replyCount === 0) {
	          $('div#listReply').hide();
	          $('div#listReply .list-content').empty();  // ✅ 수정
	          return;
	      }
	      
	      $('div#listReply').show();
	      $('div#listReply .list-content').html(htmlText);  // ✅ 수정
	      $('div#listReply .page-navigation').html(paging);
	 }
  // 댓글 등록
  $(function(){
     $('button.btnSendReply').click(function(){
        const $tb = $(this).closest('.comment-input-container');
        
        let content = $tb.find('textarea').val().trim();
        if(! content) {
           $tb.find('textarea').focus();
           return false;
        }
        
        const url = `${postsUrl}/insertReply`;
        const params = {num:num, content:content, parentNum:0};
        
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
  
  // 댓글 및 답글 리스트 HTML
  function renderReplies(listReply, sessionMember, pageNo) {
      return listReply.map(vo => {
          const isWriter = sessionMember.userId === vo.userId;
          const isAdmin = sessionMember.userLevel > 50;
          
          // ✅ showReply 로직 수정
          // showReply == 1: 표시됨 (정상) → 버튼은 "숨김"
          // showReply == 0: 숨겨짐 → 버튼은 "표시"
          const showReplyText = vo.showReply == 1 ? "숨김" : "표시";
          const contentClass = vo.showReply == 0 ? 'text-primary text-opacity-50' : '';
          
          console.log('댓글 정보:', {
              replyNum: vo.replyNum,
              showReply: vo.showReply,
              showReplyText: showReplyText,
              contentClass: contentClass,
              isWriter: isWriter,
              isAdmin: isAdmin
          });

          let menuHTML = '';
          if (isWriter) {
              menuHTML = `
                  <div class="deleteReply reply-menu-item" data-replyNum="${vo.replyNum}" data-pageNo="${pageNo}">삭제</div>
                  <div class="hideReply reply-menu-item" data-replyNum="${vo.replyNum}" data-showReply="${vo.showReply}">${showReplyText}</div>
              `;
          } else if (isAdmin) {
              menuHTML = `
                  <div class="deleteReply reply-menu-item" data-replyNum="${vo.replyNum}" data-pageNo="${pageNo}">삭제</div>
                  <div class="blockReply reply-menu-item" data-replyNum="${vo.replyNum}" data-pageNo="${pageNo}">차단</div>
              `;
          } else {
              menuHTML = `
                  <div class="notifyReply reply-menu-item" data-replyNum="${vo.replyNum}">신고</div>
                  <div class="blockReply reply-menu-item" data-replyNum="${vo.replyNum}" data-pageNo="${pageNo}">차단</div>
              `;
          }

          let likedHTML = '';
          if(liked === '1') {
              const likeColor = vo.userLikedReply == 1 ? 'color:red;' : '';
              const dislikeColor = vo.userLikedReply == 0 ? 'color:red;' : '';

              likedHTML = `
                  <button type="button" class="btn btn-light btnSendReplyLike" data-replyNum="${vo.replyNum}" data-replyLike="1" title="좋아요">
                      <i class="bi bi-hand-thumbs-up" style="${likeColor}"></i> <span>${vo.likeCount}</span>
                  </button>
                  <button type="button" class="btn btn-light btnSendReplyLike" data-replyNum="${vo.replyNum}" data-replyLike="0" title="싫어요">
                      <i class="bi bi-hand-thumbs-down" style="${dislikeColor}"></i> <span>${vo.disLikeCount}</span>
                  </button>
              `;
          }

          return `
              <div class="comment-box">
                  <div class="comment-meta">
                      <span class="comment-author">${vo.userName}</span>
                      <span class="comment-date">${vo.reg_date}</span>
                      
                      <div style="margin-left: auto;">
                          <span class="reply-dropdown" style="cursor: pointer; color: #64748B;">
                              <span class="material-symbols-outlined">more_vert</span>
                          </span>
                          <div class="reply-menu d-none" style="position: absolute; background: #1E293B; border: 1px solid #334155; border-radius: 0.375rem; padding: 0.5rem; z-index: 1000; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);">
                              ${menuHTML}
                          </div>
                      </div>
                  </div>
                  
                  <div class="comment-body ${contentClass}">
                      ${vo.content}
                  </div>
                  
                  <div class="comment-actions">
                      <button type="button" class="btn-reply" data-replyNum="${vo.replyNum}">
                          <span class="material-symbols-outlined">chat_bubble</span>
                          답글 쓰기
                      </button>
                      <button type="button" class="btn-view-replies btnReplyAnswerLayout" data-replyNum="${vo.replyNum}">
                          <span class="material-symbols-outlined">expand_more</span>
                          답글 보기 (<span id="answerCount${vo.replyNum}">${vo.answerCount}</span>)
                      </button>
                      
                      <div style="margin-left: auto; display: flex; gap: 0.5rem;" data-userLikedReply="${vo.userLikedReply}">
                          ${likedHTML}
                      </div>
                  </div>
                  
                  <!-- 답글 컨테이너 -->
                  <div class="re-comment-container reply-answer d-none" style="margin-top: 1rem; padding-left: 1.5rem;">
                      <div id="listReplyAnswer${vo.replyNum}" class="answer-list"></div>
                      <div style="margin-top: 1rem; background: #0F172A; border: 1px solid #334155; border-radius: 0.5rem; padding: 1rem;">
                          <textarea class="comment-textarea" placeholder="답글을 입력하세요..." style="min-height: 60px;"></textarea>
                          <div style="text-align: right; margin-top: 0.5rem;">
                              <button type="button" class="btn btn-register btnSendReplyAnswer" data-replyNum="${vo.replyNum}">답글 등록</button>
                          </div>
                      </div>
                  </div>
              </div>
          `;
      }).join('');
  }