<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../home/head.jsp"%>
    <style>
       
        .glass-table {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(12px);          
            border-radius: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            overflow: hidden;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        }
       
        .table-transparent {
            --bs-table-bg: transparent !important;
            --bs-table-color: #fff !important;
            margin-bottom: 0;
        }
   
        .table-transparent thead th {
            background-color: rgba(0, 0, 0, 0.3) !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            color: #a855f7; 
            font-weight: 700;
            padding: 1.2rem 1rem;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.05em;
        }


        .table-transparent tbody td {
            background-color: transparent !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            padding: 1rem;
            vertical-align: middle;
            color: #e2e8f0; 
        }

        .table-transparent tbody tr:hover td {
            background-color: rgba(255, 255, 255, 0.1) !important;
            color: #fff;
            transition: background-color 0.2s;
        }

        .post-link {
            text-decoration: none;
            color: inherit;
            display: block;
            width: 100%;
        }
        .post-link:hover {
            color: #a855f7; 
        }

        .page-link-custom {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
        }
        .page-link-custom:hover {
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
        }
        .page-item.active .page-link-custom {
            background: #a855f7;
            border-color: #a855f7;
        }
    </style>
</head>
<body>

    <%@ include file="../home/header.jsp"%>

    <div class="app-body">
        <%@ include file="../home/sidebar.jsp"%>

        <main class="app-main">
            <div class="space-background">
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="planet planet-1"></div>
            </div>

            <div class="container-fluid py-5 px-lg-5" style="min-height: calc(100vh - 70px);">
                
                <div class="d-flex justify-content-between align-items-end mb-4">
                    <div>
                        <h2 class="text-white fw-bold fs-3 mb-1">Community</h2>
                        <p class="text-white-50 mb-0 small">자유롭게 이야기를 나누어보세요.</p>
                    </div>
                    
                    <c:if test="${not empty sessionScope.member}">
                        <button class="btn text-white shadow fw-bold px-4 py-2" 
                                style="background: linear-gradient(to right, #a855f7, #6366f1); border: none; border-radius: 0.5rem;"
                                onclick="location.href='${pageContext.request.contextPath}/post/write';">
                            <span class="material-symbols-outlined align-middle me-1" style="font-size: 1.1rem;">edit</span>
                            New Post
                        </button>
                    </c:if>
                </div>

                <div class="glass-table shadow-lg">
                    <table class="table table-transparent w-100">
                        <thead>
                            <tr class="text-center">
                                <th style="width: 80px;">No.</th>
                                <th class="text-start">Subject</th>
                                <th style="width: 150px;">Writer</th>
                                <th style="width: 120px;">Date</th>
                                <th style="width: 80px;">Views</th>
                                <th style="width: 80px;">Likes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}">
                                <tr class="text-center">
                                    <td class="text-white-50">${dto.postId}</td>
                                    
                                    <td class="text-start fw-bold">
                                        <a href="${pageContext.request.contextPath}/post/article?postId=${dto.postId}" class="post-link">
                                            <c:if test="${dto.postType == 'NOTICE'}">
                                                <span class="badge bg-danger me-2" style="font-size: 0.7rem; vertical-align: middle;">NOTICE</span>
                                            </c:if>
                                            
                                            ${dto.title}
                                            
                                            <c:if test="${dto.commentCount > 0}">
                                                <span class="ms-2 text-a855f7 small" style="font-size: 0.8rem;">
                                                    <span class="material-symbols-outlined align-middle" style="font-size: 0.9rem;">chat_bubble</span>
                                                    ${dto.commentCount}
                                                </span>
                                            </c:if>
                                        </a>
                                    </td>
                                    
                                    <td>
                                        <div class="d-flex align-items-center justify-content-center gap-2">
                                            <span class="material-symbols-outlined fs-6 text-white-50">account_circle</span>
                                            ${dto.authorNickname}
                                        </div>
                                    </td>
                                    
                                    <td class="text-white-50 small">${dto.createdDate}</td>
                                    <td class="text-white-50 small">${dto.viewCount}</td>
                                    <td class="text-white-50 small">${dto.likeCount}</td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-white-50">
                                        <div class="mb-3">
                                            <span class="material-symbols-outlined fs-1 opacity-25">inbox</span>
                                        </div>
                                        등록된 게시글이 없습니다.<br>
                                        첫 번째 게시글의 주인공이 되어보세요!
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-center mt-5">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link page-link-custom rounded-start" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link page-link-custom" href="#">1</a></li>
                            <li class="page-item"><a class="page-link page-link-custom" href="#">2</a></li>
                            <li class="page-item"><a class="page-link page-link-custom" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link page-link-custom rounded-end" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>

            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>