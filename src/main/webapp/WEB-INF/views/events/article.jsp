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
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">


<style>
:root {
	--bs-body-font-family: 'Inter', sans-serif;
	--primary-color: #2563EB;
	--primary-hover: #1D4ED8;
	--background-dark: #0F172A;
	--surface-dark: #1E293B;
	--border-dark: #334155;
	--text-muted: #94A3B8;
	--comment-box-bg: #1e293b;
	--heart-red: #EF4444;
}
        body {
            font-family: var(--bs-body-font-family);
            background-color: #111827;
            color: #F8FAFC;
            margin: 0;
            padding: 0;
        }

        .content-wrapper {
            flex: 1;
        }
        
/* 홈 > 서비스관리 > 공지사항 */
.breadcrumb-item + .breadcrumb-item::before {
     color: var(--text-secondary);
     content: "chevron_right";
     font-family: 'Material Symbols Outlined';
     font-size: 14px;
     vertical-align: middle;
     
     display: inline-block; 
     transform: translateY(6px); 
     
     line-height: 1;
     margin-right: 3px;
     margin-left: 3px;
}

.breadcrumb-item a {
     color: var(--text-secondary);
     text-decoration: none;
     line-height: 1;
}
        
.breadcrumb-item a:hover {
     color: var(--primary-color);
}

.breadcrumb-item.active {
     color: #fff;
}

        .view-card {
            background-color: var(--surface-dark);
            border: 1px solid #374151;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .view-header {
            padding: 1.5rem;
            background-color: rgba(255,255,255,0.02);
        }
        .view-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1rem;
            text-align: center;
        }
        .title-divider {
            border-top: 1px solid #374151;
            margin-top: 1rem;
            margin-bottom: 1rem;
        }
        
        .view-info-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #94A3B8;
            font-size: 0.875rem;
        }
        
        .view-info-bardate {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #94A3B8;
            font-size: 0.875rem;
        }
        
        .view-content {
            padding: 2rem 2rem 1rem 2rem;
            min-height: 300px;
            line-height: 1.6;
            color: #E2E8F0;
            border-top: 1px solid #374151;
            border: none;
        }
        
        .view-content > div {
		    max-width: 100%;
		    overflow: hidden;
		    text-align: center;
		}
		
		.view-content img.preview-image {
		    max-width: 70%;
		    height: auto;
		    display: block;
		    justify-content: center;
		    margin: 1.5rem auto;
		}
		
        .like-button-container {
            padding: 2rem 0 3rem 0;
            display: flex;
            justify-content: center;
        }
.btn-like {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        border: 1.5px solid #4B5563;
        color: #D1D5DB;
        border-radius: 2rem;
        padding: 0.6rem 2rem;
        font-weight: 600;
        transition: all 0.2s ease;
        cursor: pointer;
    }

    /* 마우스 호버 시 */
    .btn-like:hover {
        border-color: var(--heart-red);
        color: var(--heart-red);
    }

    /* 좋아요 활성화(active) 상태 */
    .btn-like.active {
        border-color: var(--heart-red);
        color: var(--heart-red);
        background-color: rgba(239, 68, 68, 0.1);
    }

    /* 아이콘 기본 설정 */
    .btn-like .material-symbols-outlined {
        font-size: 20px;
        font-variation-settings: 'FILL' 0, 'wght' 400;
        transition: font-variation-settings 0.2s ease;
    }

    /* active 상태일 때 아이콘 채우기 */
    .btn-like.active .material-symbols-outlined {
        font-variation-settings: 'FILL' 1, 'wght' 400;
        color: var(--heart-red);
    }
        .content-image-placeholder {
            max-width: 100%;
            margin: 1.5rem 0;
            border-radius: 0.375rem;
            border: 1px solid #334155;
        }
        .navigation-links {
            border-top: 1px solid #374151;
        }
        .nav-item-link {
            padding: 0.75rem 1.5rem;
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #94A3B8;
            font-size: 0.875rem;
            transition: background-color 0.2s;
        }
        .nav-item-link:hover {
            background-color: rgba(255,255,255,0.05);
            color: #fff;
        }
        .nav-item-link:not(:last-child) {
            border-bottom: 1px solid #374151;
        }
        .nav-label {
            font-weight: 600;
            margin-right: 1rem;
            color: #D1D5DB;
            min-width: 60px;
        }
        .action-footer {
            padding: 1.5rem;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
        .btn-action {
            padding: 0.5rem 1.50rem;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: 0.375rem;
            transition: all 0.2s;
        }
        .btn-outline-custom {
            border: 1px solid #4B5563;
            color: #FFFFFF;
            background: transparent;
        }
        .btn-outline-custom:hover {
            background-color: #374151;
            color: #fff;
        }
        .btn-list {
            background-color: #334155;
            border: 1px solid #475569;
            color: #F8FAFC;
        }
        .btn-list:hover {
            background-color: #475569;
            color: #fff;
        }
        .comments-section {
            padding: 2rem 1.5rem;
            border-top: 1px solid #374151;
            background-color: rgba(0,0,0,0.1);
        }
        .comment-header {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .comment-input-container {
            margin-bottom: 2rem;
            background: #0F172A;
            border: 1px solid #334155;
            border-radius: 0.5rem;
            padding: 1rem;
        }
        .comment-textarea {
            background: transparent;
            border: none;
            color: #F1F5F9;
            width: 100%;
            resize: none;
            min-height: 80px;
            font-size: 0.9375rem;
        }
        .comment-textarea:focus {
            outline: none;
        }
        .comment-input-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 0.5rem;
        }
        .btn-register {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.4rem 1.25rem;
            font-size: 0.875rem;
            border-radius: 0.375rem;
        }
        .btn-register:hover {
            background-color: var(--primary-hover);
            color: white;
        }
        .comment-list {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }
        .comment-box {
            background-color: var(--comment-box-bg);
            border: 1px solid #334155;
            border-radius: 0.5rem;
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
        }
        .comment-meta {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            gap: 0.75rem;
        }
        .comment-author {
            font-weight: 600;
            font-size: 0.875rem;
            color: #F8FAFC;
        }
        .comment-date {
            font-size: 0.75rem;
            color: #94A3B8;
        }
        .reply-count-trigger {
            cursor: pointer;
            text-decoration: none;
            color: var(--primary-color);
            margin-left: 0.25rem;
        }
        .reply-count-trigger:hover {
            text-decoration: underline;
        }
        .comment-body {
            font-size: 0.9375rem;
            color: #CBD5E1;
            line-height: 1.5;
            margin-bottom: 0.5rem;
        }
        .comment-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        .btn-reply, .btn-view-replies {
            background: none;
            border: none;
            color: #64748B;
            font-size: 0.75rem;
            padding: 0;
            display: flex;
            align-items: center;
            gap: 0.25rem;
            cursor: pointer;
            transition: color 0.2s;
        }
        .btn-reply:hover, .btn-view-replies:hover {
            color: #94A3B8;
        }
        .re-comment-container {
            margin-top: 1rem;
            padding-left: 1.5rem;
            display: none;
            flex-direction: column;
            gap: 1.25rem;
        }
        .reply-toggle-check {
            display: none;
        }
        .reply-toggle-check:checked ~ .re-comment-container {
            display: flex;
        }
        .re-comment-item {
            padding: 0;
            display: flex;
            flex-direction: column;
            background: transparent;
            border: none;
        }
        .material-symbols-outlined {
            font-size: 1.1rem;
        }
        
        .hover-pink:hover { 
        	color: #ec4899 !important; 
        }
    	.reply table.reply-form {
    		background: #0f172a !important;
    		width: 100% !important;
    	}
    	.reply-answer td {
    		background: #0f172a !important;
    	 }
    	 
    	 .reply .reply-dropdown {
    	 	color: #fff;
    	 	
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
	

               <div class="reply">
                    <form name="replyForm" method="post">
                        <div class="form-header">
                            <span class="bold">
                                <span class="material-symbols-outlined" style="font-size: 1.5rem; vertical-align: middle;">chat</span>
                                댓글
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
                            <span class="reply-count"></span>
                            <span class="reply-page"></span>
                        </div>
                        
                        <div class="list-content" data-pageNo="0" data-totalPage="0">
                            <table class="table table-borderless">
                                <tbody></tbody>
                            </table>
                        </div>
                        
                        <div class="list-footer">
                            <div class="page-navigation"></div>
                        </div>
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
	    // 좋아요 함수 (독립적으로 위치)
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
		            } else {
		                btnElement.classList.add('active');
		                icon.style.fontVariationSettings = "'FILL' 1, 'wght' 400";
		            }
		
		            // 개수 업데이트 (class 기준)
		            const countSpan = btnElement.querySelector('.like-count');
		            if (countSpan) {
		                countSpan.innerText = data.boardLikeCount;
		            }
		        } else if (data.state === "liked") {
		            alert("이미 널~ 좋아해.");
		        }
		    })
		    .catch(error => {
		        console.error('Error:', error);
		    });
	        
	    }
	</script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
 	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/eventreply.js"></script>
    
</body>
</html>