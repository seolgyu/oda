<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ODA 상세페이지</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/main3.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/eventarticle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/eventreply.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">

    <style type="text/css">
    	.reply table.reply-form {
    	
    		background-color: var(--surface-dark);
	border: 1px solid #374151;
	border-radius: 0.5rem;
	overflow: hidden;
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    		/* background: #0f172a !important; */
    		width: 100% !important;
    	}
    	.reply-answer td {
    		background: #0f172a !important;
    	}
    	 
    	.reply .reply-dropdown {
    	 	color: #fff;
    	}
    	.reply-content {
    		color: #fff !important;
    	}
    </style>


</head> 
<body class="bg-background-dark text-white">

	<div class="space-background">
        <div class="stars"></div>
        <div class="stars2"></div>
        <div class="stars3"></div>
        <div class="planet planet-1"></div>
        <div class="planet planet-2"></div>
    </div>

    <%@ include file="../home/header.jsp"%>

    <div class="app-body">
       <%@ include file="../home/sidebar.jsp"%>
        
	<main class="app-main custom-scrollbar">
			<div class="container-fluid p-4 p-md-5" style="max-width: 1100px;">
    
				<div class="d-flex justify-content-between align-items-center mb-4">
				   <nav aria-label="breadcrumb">   
				      <ol class="breadcrumb mb-0">
				         <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">홈</a></li>
				         <li class="breadcrumb-item"><a href="#">서비스 관리</a></li>
				         <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/events/list">리스트</a></li>
				         <li aria-current="page" class="breadcrumb-item active">이벤트 상세</li>
				      </ol>
				   </nav>
				   
				   <div class="d-flex gap-2">
				   		&nbsp;
				   </div>
				</div>
				
					<div class="view-card">
						<div class="view-header">
							<h1 class="view-title">
								<c:out value="${dto.event_title}" default="제목없음"/>
							</h1>
							<div class="title-divider"></div>
							
							<div class="view-info-bar">
								<div>작성일자 : ${dto.created_date}</div>
								<div>조회 : ${dto.ev_hitcount}</div>
							</div>
							<div class="title-divider"></div>
							
							<div class="view-info-bardate" >
								<div>시작일자 : ${dto.start_date} </div>
								<div>종료일자 : ${dto.end_date}</div>
							</div>
						</div>
						
					<div class="view-content">
						<p>${dto.event_content}</p>
						<c:if test="${filelist.size() != 0}">
							<c:forEach var="vo" items="${filelist}" varStatus="status">
								<div>
									<img class="preview-image" src="${pageContext.request.contextPath}/uploads/events/${vo.file_path}">
								</div>
							</c:forEach>
						</c:if>
					</div>
					
					<div class="like-button-container">
					    <button type="button" class="btn btn-like ${isUserLiked ? 'active' : ''}" 
					            onclick="sendLike('${dto.event_num}', this)">
					        <span class="material-symbols-outlined" 
					              style="font-variation-settings: 'FILL' ${isUserLiked ? 1 : 0}, 'wght' 400;">
					            favorite
					        </span>
								<span class="like-count">${boardLikeCount}</span>
					    </button>
					</div>
				
					
					<div class="navigation-links">
						<c:if test="${not empty prevDto}">
							<a class="nav-item-link" href="${pageContext.request.contextPath}/events/article?${query}&event_num=${prevDto.event_num}">
								<span class="nav-label">이전글 : <c:out value="${prevDto.event_title}"/></span>
							</a>
						</c:if>
						
						
						<c:if test="${not empty nextDto}">
							<a class="nav-item-link" href="${pageContext.request.contextPath}/events/article?${query}&event_num=${nextDto.event_num}">
								<span class="nav-label">다음글 : <c:out value="${nextDto.event_title}"/></span>
							</a>
						</c:if>
					</div>
				</div>

               <div class="reply">
                    <form name="replyForm" method="post">
                        <div class="form-header">
                            <span class="bold">
                                <span class="material-symbols-outlined" style="font-size: 1.5rem; vertical-align: middle;">chat</span>
                                댓글(<span class="reply-count">)</span>
                            </span>
                        </div>
                        
                        <table class="reply-form">
                            <tr>
                                <td>
                                    <textarea class="form-control" name="content" placeholder="댓글을 입력해주세요. 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요...."></textarea>
                                </td>
                            </tr>
                            <tr>
                               <td align="right">
                                    <button type="button" class="btn btn-light btnSendReply">
                                        <span class="material-symbols-outlined" style="font-size: 1.1rem; vertical-align: middle;">send</span>
                                        댓글 등록
                                    </button>
                                </td>
                             </tr>
                        </table>
                    </form>
                    
                    <div id="listReply" data-contextPath="${pageContext.request.contextPath}" 
                            data-postsUrl="${pageContext.request.contextPath}/events"
                            data-event_num="${dto.event_num}"
                            data-liked="1">
                        <div class="reply-info">

                            <span class="reply-page"></span>
                        </div>
                        
                        <div class="list-content" data-pageNo="0" data-totalPage="0">
                            <table class="table table-borderless">
                                <tbody></tbody>
                            </table>
                        </div>
                        
                        <div class="list-footer">

                        </div>
                    </div>
                    
                  <div class="action-footer">
					<button class="btn btn-action btn-list" onclick="location.href='${pageContext.request.contextPath}/events/list';">
					<span class="material-symbols-outlined">list</span>
					</button>
				</div>
                    
                </div>
			</div>
		</main>
	</div>


	<script type="text/javascript">
    // 2. 좋아요 함수 (독립적으로 위치)
    function sendLike(event_num, btnElement) {
        const isCurrentlyLiked = btnElement.classList.contains('active');
        const url = "${pageContext.request.contextPath}/events/insertBoardLike";

        const params = new URLSearchParams();
        params.append('event_num', event_num);
        params.append('userLiked', isCurrentlyLiked ? 'true' : 'false');

        fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params
        })
        .then(response => response.json())
        .then(data => {
            if (data.state === "true") {
                const icon = btnElement.querySelector('.material-symbols-outlined');
                
                if (isCurrentlyLiked) {
                    btnElement.classList.remove('active');
                    icon.style.fontVariationSettings = "'FILL' 0, 'wght' 400";
                    showToast("success", '이벤트 "좋아요"가 취소되었습니다.');
                    
                } else {
                    btnElement.classList.add('active');
                    icon.style.fontVariationSettings = "'FILL' 1, 'wght' 400";
                    showToast("success", '이벤트에 "좋아요"를 눌렀습니다');
                } 

                const countSpan = btnElement.querySelector('.like-count');
                if (countSpan) {
                    countSpan.innerText = data.boardLikeCount;
                }
            } else if (data.state === "liked") {
            	showToast("error", '이미 요청된 상황입니다.');
            }
        })
        .catch(error => {
        	showToast("error", '오류가 발생했습니다. 다시 시도해주세요.');
        });
    }
</script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
 	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/eventreply.js"></script>
    
</body>
</html>