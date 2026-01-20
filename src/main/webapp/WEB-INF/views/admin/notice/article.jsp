<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ODA Admin - 공지사항 상세페이지</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/notice_article_style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminnoticereply.css">
    
    <style type="text/css">
    	.reply table.reply-form {
    		/* background: #0f172a !important; */
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

    <%@ include file="../home/adminheader.jsp" %>

    <div class="app-body">
        <%@ include file="../home/adminsidebar.jsp" %>
        
        <main class="app-main custom-scrollbar">
            <div class="container-fluid p-4 p-md-5" style="max-width: 1100px;">
    
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <nav aria-label="breadcrumb">	
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">홈</a></li>
                            <li class="breadcrumb-item"><a href="#">서비스 관리</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/notice/list">공지사항 리스트</a></li>
                            <li aria-current="page" class="breadcrumb-item active">공지사항 상세</li>
                        </ol>
                    </nav>
                    
                    <div class="d-flex gap-2">
                        <c:choose>
                            <c:when test="${sessionScope.member.userId==dto.user_id}">
                                <button type="button" class="btn btn-action btn-outline-custom" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.notice_num}&page=${page}&size=${size}';">
                                    <span class="material-symbols-outlined" style="font-size: 1.1rem; vertical-align: middle;">edit</span>
                                    수정
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-action btn-outline-custom" disabled>
                                    <span class="material-symbols-outlined" style="font-size: 1.1rem; vertical-align: middle;">edit</span>
                                    수정
                                </button>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${sessionScope.member.userId==dto.user_id}">
                                <button type="button" class="btn btn-action btn-outline-custom" onclick="deleteOk();">
                                    <span class="material-symbols-outlined" style="font-size: 1.1rem; vertical-align: middle;">delete</span>
                                    삭제
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-action btn-outline-custom" disabled>
                                    <span class="material-symbols-outlined" style="font-size: 1.1rem; vertical-align: middle;">delete</span>
                                    삭제
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="view-card">
                    <div class="view-header">
                        <h1 class="view-title">${dto.noti_title}</h1>
                        <div class="title-divider"></div>
                        
                        <div class="view-info-bar">
                            <div>
                                <span class="material-symbols-outlined" style="font-size: 1rem; vertical-align: middle;">person</span>
                                ${dto.user_nickname}
                            </div>
                            <div>
                                <span class="material-symbols-outlined" style="font-size: 1rem; vertical-align: middle;">schedule</span>
                                ${dto.noti_reg_date}
                                <span class="mx-2">|</span>
                                <span class="material-symbols-outlined" style="font-size: 1rem; vertical-align: middle;">visibility</span>
                                ${dto.noti_hitCount}
                            </div>
                        </div>
                    </div>
                    
                    <div class="view-content">
                        ${dto.noti_content}
                    </div>
                    
                    <c:if test="${listFile.size() != 0}">
                        <div class="attachment-section">
                            <div class="attachment-header">
                                <span class="material-symbols-outlined">attach_file</span>
                                <span>첨부파일</span>
                                <span class="file-count">(${listFile.size()})</span>
                            </div>
                            <div class="attachment-list">
                                <c:forEach var="vo" items="${listFile}" varStatus="status">
                                    <a href="${pageContext.request.contextPath}/admin/notice/download?fileNum=${vo.fileNum}" 
                                       class="attachment-item">
                                        <span class="material-symbols-outlined">description</span>
                                        <span class="file-name">${vo.originalFilename}</span>
                                        <span class="material-symbols-outlined download-icon">download</span>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="like-button-container">
                        <button type="button" class="btn btn-like btnSendBoardLike">
                            <i class="bi ${isUserLiked ? 'bi-hand-thumbs-up-fill' : 'bi-hand-thumbs-up'}"></i>
                            <span id="boardLikeCount">${dto.boardLikeCount}</span>
                        </button>
                    </div>
                    
                    <div class="navigation-links">
                        <c:if test="${not empty prevDto}">
                            <a class="nav-item-row" href="${pageContext.request.contextPath}/admin/notice/article?${query}&num=${prevDto.notice_num}">
                                <span class="nav-label">
                                    <span class="material-symbols-outlined" style="font-size: 1rem; vertical-align: middle;">arrow_upward</span>
                                    이전글
                                </span>
                                <span class="nav-title"><c:out value="${prevDto.noti_title}"/></span>
                            </a>
                        </c:if>
                        <c:if test="${empty prevDto}">
                            <div class="nav-item-row nav-item-disabled">
                                <span class="nav-label">
                                    <span class="material-symbols-outlined" style="font-size: 1rem; vertical-align: middle;">arrow_upward</span>
                                    이전글
                                </span>
                                <span class="nav-title">이전글이 없습니다.</span>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty nextDto}">
                            <a class="nav-item-row" href="${pageContext.request.contextPath}/admin/notice/article?${query}&num=${nextDto.notice_num}">
                                <span class="nav-label">
                                    <span class="material-symbols-outlined" style="font-size: 1rem; vertical-align: middle;">arrow_downward</span>
                                    다음글
                                </span>
                                <span class="nav-title"><c:out value="${nextDto.noti_title}"/></span>
                            </a>
                        </c:if>
                        <c:if test="${empty nextDto}">
                            <div class="nav-item-row nav-item-disabled">
                                <span class="nav-label">
                                    <span class="material-symbols-outlined" style="font-size: 1rem; vertical-align: middle;">arrow_downward</span>
                                    다음글
                                </span>
                                <span class="nav-title">다음글이 없습니다.</span>
                            </div>
                        </c:if>
                    </div>
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
                                    <textarea class="form-control" name="content" placeholder="댓글을 입력해주세요..."></textarea>
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
                            data-postsUrl="${pageContext.request.contextPath}/admin/notice"
                            data-num="${dto.notice_num}"
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
                    <button class="btn btn-list" onclick="location.href='${pageContext.request.contextPath}/admin/notice/list?${query}';">
                        <span class="material-symbols-outlined" style="font-size: 1.1rem; vertical-align: middle;">list</span>
                        리스트
                    </button>
                </div>

            </div>
        </main>
    </div>
    
    <script type="text/javascript">
        function deleteOk() {
            if(confirm('게시글을 삭제 하시 겠습니까 ? ')) {
                let params = 'num=${dto.notice_num}&${query}';
                let url = '${pageContext.request.contextPath}/admin/notice/delete?' + params;
                location.href = url;
            }
        }
    </script>
    
    <script type="text/javascript">
    // 게시글 공감 여부
    $(function() {
        $('button.btnSendBoardLike').click(function() {
            const $i = $(this).find('i');
            
            // 현재 좋아요 상태 확인 (filled = 이미 좋아요 누른 상태)
            let userLiked = $i.hasClass('bi-hand-thumbs-up-fill');
            let msg = userLiked ? '게시글 좋아요를 취소하시겠습니까?' : '게시글에 공감하시겠습니까?';
            
            if(!confirm(msg)){
                return false;
            }
            
            let url = '${pageContext.request.contextPath}/admin/notice/insertBoardLike';
            let num = '${dto.notice_num}';
            
            // userLiked를 문자열로 변환하여 전달
            let params = {num: num, userLiked: userLiked ? 'true' : 'false'};
            
            const fn = function(data) {
                let state = data.state;
                
                if(state === 'true'){
                    // 성공 시 UI 업데이트
                    if(userLiked){
                        // 좋아요 취소 -> 빈 하트
                        $i.removeClass('bi-hand-thumbs-up-fill').addClass('bi-hand-thumbs-up');
                    } else {
                        // 좋아요 등록 -> 채워진 하트
                        $i.removeClass('bi-hand-thumbs-up').addClass('bi-hand-thumbs-up-fill');
                    }
                    
                    // 좋아요 개수 업데이트
                    let count = data.boardLikeCount;
                    $('#boardLikeCount').text(count);
                    
                } else if(state === 'liked'){
                    alert('게시글 공감은 한번만 가능합니다.');
                } else if(state === 'false'){
                    alert('게시글 공감에 실패했습니다.');
                }
            };
            
            ajaxRequest(url, 'post', params, 'json', fn);
        });
    });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_bbs_reply.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_bbs_util.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/admin_notice.js"></script>

</body>
</html>
