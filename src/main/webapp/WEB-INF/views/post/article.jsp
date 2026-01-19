<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../home/head.jsp"%>
<style>
.article-image { width: 100%; max-height: 600px; object-fit: contain; background-color: rgba(0, 0, 0, 0.2); border-radius: 0.5rem; margin-bottom: 1rem; }
.comment-input { background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); color: #fff; }
.comment-input:focus { background: transparent !important; border-bottom-color: #a855f7 !important; box-shadow: none !important; color: #fff !important; }
.comment-input::placeholder { color: rgba(255, 255, 255, 0.4); text-align: left; }
.article-content { white-space: pre-wrap; word-break: break-all; color: #e2e8f0; line-height: 1.7; }
.hover-pink:hover { color: #ec4899 !important; }
.hover-blue:hover { color: #60a5fa !important; }
.hover-green:hover { color: #4ade80 !important; }
.hover-yellow:hover { color: #facc15 !important; }
.hover-purple:hover { color: #c084fc !important; }
.hover-red:hover { color: #ef4444 !important; }
.hover-opacity-100:hover { opacity: 1 !important; }
.text-pink { color: #ec4899 !important; }
.carousel-control-prev, .carousel-control-next { width: 10%; opacity: 1; }
.carousel-btn-glass { width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(4px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); transition: all 0.3s ease; }
.carousel-control-prev:hover .carousel-btn-glass, .carousel-control-next:hover .carousel-btn-glass { background: rgba(168, 85, 247, 0.6); border-color: #a855f7; transform: scale(1.1); }
.image-wrapper { width: 100%; background-color: rgba(0, 0, 0, 0.2); }
.form-control-sm { background-color: rgba(255, 255, 255, 0.05) !important; border: 1px solid rgba(255, 255, 255, 0.1) !important; color: white !important; }
.form-control-sm:focus { border-color: #a855f7 !important; box-shadow: none !important; }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const carouselEl = document.getElementById('imageCarousel');
        if (!carouselEl) return;
        const items = carouselEl.querySelectorAll('.carousel-item');
        const btnPrev = document.getElementById('btnPrev');
        const btnNext = document.getElementById('btnNext');
        if (items.length <= 1) {
            if (btnPrev) btnPrev.style.display = 'none';
            if (btnNext) btnNext.style.display = 'none';
            return;
        }
        btnPrev.style.display = 'none';
        btnNext.style.display = 'flex';
        carouselEl.addEventListener('slid.bs.carousel', function(e) {
            const currentIndex = e.to;
            const lastIndex = items.length - 1;
            if (currentIndex === 0) btnPrev.style.display = 'none';
            else btnPrev.style.display = 'flex';
            if (currentIndex === lastIndex) btnNext.style.display = 'none';
            else btnNext.style.display = 'flex';
        });
    });
</script>
</head>
<body>

    <%@ include file="../home/header.jsp"%>

    <div class="app-body">
        <%@ include file="../home/sidebar.jsp"%>

        <main class="app-main">
         
            <div class="space-background">
                <div class="stars"></div><div class="stars2"></div><div class="stars3"></div>
                <div class="planet planet-1"></div><div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container custom-scrollbar">
                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-12 col-lg-8 col-xl-7">

                            <div class="d-flex align-items-center gap-2 mb-3 px-1">
                                <button type="button" class="btn-icon text-white" onclick="history.back()">
                                    <span class="material-symbols-outlined">arrow_back</span>
                                </button>
                                <span class="text-white fw-bold fs-5">Post</span>
                            </div>

                            <div class="glass-card shadow-lg mb-4" style="background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 1rem;">

                                <div class="p-4 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar-md text-white fw-bold d-flex align-items-center justify-content-center" style="width: 48px; height: 48px; border-radius: 50%; background: linear-gradient(45deg, #a855f7, #6366f1); overflow: hidden;">
                                            <c:choose>
                                                <c:when test="${not empty memberdto.profile_photo}">
                                                    <c:choose>
                                                        <c:when test="${fn:startsWith(memberdto.profile_photo, 'http')}">
                                                            <img src="${memberdto.profile_photo}" style="width: 100%; height: 100%; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/uploads/profile/${memberdto.profile_photo}" style="width: 100%; height: 100%; object-fit: cover;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="material-symbols-outlined fs-3">person</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div>
                                            <h3 class="text-sm fw-medium text-white mb-0">${not empty memberdto.userNickname ? memberdto.userNickname : memberdto.userId}</h3>
                                            
                                            <%-- [수정] 조회수 숨김 로직 적용 --%>
                                            <p class="text-xs text-gray-500 mb-0">
                                                ${dto.timeAgo}
                                                <c:if test="${dto.showViews == '1' or sessionScope.member.memberIdx == dto.userNum}">
                                                    &bull; 조회 ${dto.viewCount}
                                                </c:if>
                                            </p>
                                        </div>
                                    </div>

                                    <c:if test="${sessionScope.member.memberIdx == memberdto.userIdx}">
                                        <div class="dropdown">
                                            <button class="btn btn-icon text-white" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <span class="material-symbols-outlined">more_horiz</span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-dark glass-dropdown" style="background: rgba(30, 30, 30, 0.9);">
                                                <li><a class="dropdown-item" href="#" onclick="updatePost('${dto.postId}'); return false;">수정</a></li>
                                                <li><a class="dropdown-item text-danger" href="#" onclick="deletePost('${dto.postId}'); return false;">삭제</a></li>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="p-4">
                                    <h4 class="text-white fw-bold mb-4" style="font-size: 1.5rem;">
                                        ${dto.title}
                                        <%-- [추가] 나만 보기 자물쇠 표시 --%>
                                        <c:if test="${dto.state == '나만보기'}">
                                            <span class="material-symbols-outlined align-middle text-warning ms-2" style="font-size: 1.2rem;">lock</span>
                                        </c:if>
                                    </h4>

                                    <c:if test="${not empty dto.fileList}">
                                        <div class="mb-4">
                                            <div id="imageCarousel" class="carousel slide" data-bs-interval="false">
                                                <div class="carousel-inner rounded-3 overflow-hidden">    
																															                                                           
													<c:forEach var="dto" items="${listFile}" varStatus="status">
													    <div class="carousel-item ${status.first ? 'active' : ''}">
													        
													        <%-- 공통 파일에 데이터 전달 --%>
													        <c:set var="mediaPath" value="${dto.filePath}" scope="request" />
													        <c:set var="mediaMode" value="article" scope="request" /> <%-- 'article' 모드 --%>
													        
													        <%-- 공통 파일 호출 --%>
													        <jsp:include page="/WEB-INF/views/post/mediaview.jsp" />
													        
													    </div>
													</c:forEach>																									                                                              
                                                                                            
                                                </div>
                                                <button class="carousel-control-prev" type="button" data-bs-target="#imageCarousel" data-bs-slide="prev" id="btnPrev" style="display: none;">
                                                    <span class="carousel-btn-glass"><span class="material-symbols-outlined fs-4">chevron_left</span></span>
                                                </button>
                                                <button class="carousel-control-next" type="button" data-bs-target="#imageCarousel" data-bs-slide="next" id="btnNext">
                                                    <span class="carousel-btn-glass"><span class="material-symbols-outlined fs-4">chevron_right</span></span>
                                                </button>
                                            </div>
                                        </div>
                                    </c:if>

                                    <div class="article-content">${dto.content}</div>
                                </div>

                                <div class="px-4 py-3 d-flex align-items-center justify-content-between border-top border-white border-opacity-10" style="background: rgba(255, 255, 255, 0.02);">
                                    <div class="d-flex gap-4">
                                        
                                        <%-- [수정] 좋아요 버튼 숨김 처리 --%>
                                        <c:if test="${dto.showLikes == '1' or sessionScope.member.memberIdx == dto.userNum}">
                                            <button type="button" class="d-flex align-items-center gap-2 btn btn-link text-decoration-none p-0 hover-pink ${dto.likedByUser ? 'text-pink' : 'text-white-50'}"
                                                onclick="sendLike('${dto.postId}', this)">
                                                <span class="material-symbols-outlined fs-5">${dto.likedByUser ? 'favorite' : 'favorite_border'}</span>
                                                <span class="small like-count">${dto.likeCount}</span>
                                            </button>
                                        </c:if>

                                        <button class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-blue">
                                            <span class="material-symbols-outlined fs-5">chat_bubble_outline</span>
                                            <span class="small" id="postCommentCount">${dto.commentCount}</span>
                                        </button>
                                        <button class="d-flex align-items-center gap-2 btn btn-link text-decoration-none text-white-50 p-0 hover-green">
                                            <span class="material-symbols-outlined fs-5">repeat</span>
                                        </button>
                                    </div>

									<div class="d-flex gap-3">
									    <button type="button" class="btn btn-link text-decoration-none p-0 hover-yellow ${dto.savedByUser ? 'text-warning' : 'text-white-50'}"
									            onclick="toggleSave('${dto.postId}', this);">
									        <span class="material-symbols-outlined fs-5">
									            ${dto.savedByUser ? 'bookmark' : 'bookmark_border'}
									        </span>
									    </button>
									
									    <button type="button" class="btn btn-link text-decoration-none p-0 hover-green ${dto.repostedByUser ? 'text-success' : 'text-white-50'}"
									            onclick="toggleRepost('${dto.postId}', this);">
									        <span class="material-symbols-outlined fs-5">repeat</span>
									    </button>
									
									    <button type="button" class="btn btn-link text-decoration-none text-white-50 p-0 hover-purple"
									            onclick="copyUrl('${dto.postId}');"> 
									        <span class="material-symbols-outlined fs-5">share</span>
									    </button>
									
									    <button type="button" class="btn btn-link text-decoration-none text-white-50 p-0 hover-red"
									            style="transition: color 0.3s;"
									            onclick="openReportModal('${dto.postId}');">
									        <span class="material-symbols-outlined fs-5">campaign</span>
									    </button>
									</div>                                                            
                                </div>
                            </div>

                            <c:if test="${dto.replyEnabled != '0'}">
                                <div class="glass-card shadow-lg p-4" style="background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 1rem;">
                                    <h5 class="text-white text-sm fw-bold mb-3">Comments</h5>

                                    <div class="d-flex gap-2 mb-4 align-items-start">
                                        <div class="avatar-sm flex-shrink-0 d-flex align-items-center justify-content-center rounded-circle fw-bold text-white overflow-hidden" style="width: 32px; height: 32px; background: linear-gradient(45deg, #a855f7, #6366f1); font-size: 0.8rem;">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.member.avatar}">
                                                    <c:choose>
                                                        <c:when test="${fn:startsWith(sessionScope.member.avatar, 'http')}">
                                                            <img src="${sessionScope.member.avatar}" style="width: 100%; height: 100%; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/uploads/profile/${sessionScope.member.avatar}" style="width: 100%; height: 100%; object-fit: cover;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="material-symbols-outlined" style="font-size: 1.2rem;">person</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="flex-grow-1 position-relative">
                                            <input type="text" id="replyContent" class="form-control comment-input text-white border-0 border-bottom border-secondary rounded-0 px-0 py-1" style="background: transparent; font-size: 0.9rem; box-shadow: none;" placeholder="댓글을 입력하세요...">
                                            <button type="button" onclick="sendReply();" class="btn btn-sm btn-link text-decoration-none text-primary fw-bold position-absolute top-50 end-0 translate-middle-y p-0" style="font-size: 0.85rem;">게시</button>
                                        </div>
                                    </div>

                                    <div id="listReplyDiv" class="mt-4"></div>
                                </div>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <div class="modal fade" id="reportModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-card border-0" style="background: rgba(30, 30, 30, 0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.1);">
                <div class="modal-header border-bottom border-secondary">
                    <h5 class="modal-title text-white">게시글 신고</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="reportPostId">
                    <p class="text-gray-300 mb-3 small">신고 사유를 선택해주세요.</p>
                    <select id="reportReasonSelect" class="form-select bg-dark text-white border-secondary mb-3" onchange="toggleReportReason(this)">
                        <option value="">사유 선택...</option>
                        <option value="스팸/홍보 도배">스팸/홍보 도배</option>
                        <option value="욕설/비하 발언">욕설/비하 발언</option>
                        <option value="음란물/유해 정보">음란물/유해 정보</option>
                        <option value="custom">직접 입력</option>
                    </select>
                    <textarea id="reportReasonText" class="form-control bg-dark text-white border-secondary" rows="4" placeholder="신고 사유를 입력하세요..." style="display: none;"></textarea>
                </div>
                <div class="modal-footer border-top border-secondary">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger btn-sm" onclick="submitReport()">신고하기</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>

    <script type="text/javascript">
        const isLogin = "${not empty sessionScope.member ? 'true' : 'false'}";
        const contextPath = "${pageContext.request.contextPath}";
        const postId = "${dto.postId}";

        $(function() {
            if ("${dto.replyEnabled}" != "0") {
                listReply();
            }
        });

        function listReply() {
            let url = contextPath + "/post/listReply";
            $("#listReplyDiv").load(url + "?postId=" + postId, function() {
                const newCount = $("#dynamicCommentCount").val();
                if (newCount) {
                    $("#postCommentCount").text(newCount);
                }
            });
        }

        function sendReply() {
            if (isLogin === "false") {
                if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
                    location.href = contextPath + '/member/login?redirect=' + encodeURIComponent(location.href);
                }
                return;
            }
            const content = $("#replyContent").val().trim();
            if (!content) {
                alert("댓글 내용을 입력하세요.");
                $("#replyContent").focus();
                return;
            }
            $.ajax({
                url : contextPath + "/post/insertReply",
                type : "post",
                data : { postId : postId, content : content },
                success : function(data) {
                    if (data.trim() === "success") {
                        $("#replyContent").val("");
                        listReply();
                        showToast("success", "댓글이 등록되었습니다.");
                    } else if (data.trim() === "login_required") {
                        location.href = contextPath + '/member/login';
                    } else {
                        showToast("error", "댓글 등록에 실패했습니다.");
                    }
                },
                error : function(e) { console.log(e); }
            });
        }

        function showReplyForm(commentId) {
            $(".reply-form").not("#replyForm-" + commentId).hide();
            const $form = $("#replyForm-" + commentId);
            $form.toggle();
        }

        function sendReplyAnswer(parentCommentId) {
            if (isLogin === "false") {
                alert("로그인이 필요합니다.");
                return;
            }
            const contentObj = $("#replyContent-" + parentCommentId);
            const content = contentObj.val().trim();
            if (!content) {
                alert("댓글 내용을 입력하세요.");
                contentObj.focus();
                return;
            }
            $.ajax({
                url : contextPath + "/post/insertReply",
                type : "post",
                data : { postId : postId, content : content, parentCommentId : parentCommentId },
                success : function(data) {
                    if (data.trim() === "success") {
                        listReply();
                        showToast("success", "댓글이 등록되었습니다.");
                    } else {
                        showToast("error", "댓글 등록 실패.");
                    }
                }
            });
        }

        function toggleEdit(commentId) {
            const viewArea = $("#comment-view-" + commentId);
            const editArea = $("#comment-edit-" + commentId);
            if (editArea.is(":visible")) {
                editArea.hide();
                viewArea.show();
            } else {
                $("[id^='comment-edit-']").hide();
                $("[id^='comment-view-']").show();
                viewArea.hide();
                editArea.show();
            }
        }

        function updateReply(commentId) {
            const content = $("#editContent-" + commentId).val().trim();
            if (!content) {
                alert("수정할 내용을 입력하세요.");
                return;
            }
            $.ajax({
                url : contextPath + "/post/updateReply",
                type : "post",
                data : { commentId : commentId, content : content },
                success : function(data) {
                    if (data.trim() === "success") {
                        listReply();
                        showToast("success", "댓글이 수정되었습니다.");
                    } else if (data.trim() === "login_required") {
                        showToast("error", "로그인이 필요합니다.");
                    } else {
                        showToast("error", "수정 권한이 없거나 실패했습니다.");
                    }
                },
                error : function(e) { console.log(e); }
            });
        }

        function deleteReply(commentId) {
            if (!confirm("댓글을 완전히 삭제하시겠습니까? (대댓글도 함께 삭제됩니다)")) return;
            $.ajax({
                url : contextPath + "/post/deleteReply",
                type : "post",
                data : { commentId : commentId },
                success : function(data) {
                    if (data.trim() === "success") {
                        listReply();
                        showToast("success", "댓글이 삭제되었습니다.");
                    } else {
                        alert("삭제 실패했습니다.");
                        showToast("error", "삭제 실패했습니다.");
                    }
                }
            });
        }

        function sendLike(postId, btn) {
            if (isLogin === "false") {
                if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")) {
                    location.href = contextPath + '/member/login?redirect=' + encodeURIComponent(location.href);
                }
                return;
            }
            $.ajax({
                url : contextPath + "/post/insertPostLike",
                type : "post",
                data : { postId : postId },
                dataType : "json",
                success : function(data) {
                    if (data.state === "success") {
                        const $btn = $(btn);
                        const $icon = $btn.find("span.material-symbols-outlined");
                        const $count = $btn.find(".like-count");
                        $count.text(data.likeCount);
                        if (data.liked) {
                            $icon.text("favorite");
                            $btn.addClass("text-pink");
                            $btn.removeClass("text-white-50");
                            showToast("success", "이 게시글을 좋아합니다.");
                        } else {
                            $icon.text("favorite_border");
                            $btn.removeClass("text-pink");
                            $btn.addClass("text-white-50");
                            showToast("success", "좋아요를 취소했습니다.");
                        }
                    } else if (data.state === "login_required") {
                        location.href = contextPath + '/member/login?redirect=' + encodeURIComponent(location.href);
                        showToast("error", "로그인이 필요합니다.");
                    }
                }
            });
        }

        function sendCommentLike(commentId, btn) {
            if (isLogin === "false") {
                if (confirm("로그인이 필요합니다.")) {
                    location.href = contextPath + '/member/login?redirect=' + encodeURIComponent(location.href);
                }
                return;
            }
            $.ajax({
                url : contextPath + "/post/insertCommentLike",
                type : "post",
                data : { commentId : commentId },
                dataType : "json",
                success : function(data) {
                    if (data.state === "success") {
                        const $btn = $(btn);
                        const $icon = $btn.find("span.material-symbols-outlined");
                        const $count = $btn.find(".like-count");
                        $count.text(data.likeCount > 0 ? data.likeCount : "좋아요");
                        if (data.liked) {
                            $icon.text("favorite");
                            $btn.addClass("text-pink");
                            $btn.removeClass("text-secondary");
                        } else {
                            $icon.text("favorite_border");
                            $btn.removeClass("text-pink");
                            $btn.addClass("text-secondary");
                        }
                    }
                }
            });
        }

        function deletePost(postId) {
            if (confirm("게시글을 삭제하시겠습니까?")) {
                location.href = contextPath + '/post/delete?postId=' + postId;
            }
        }

        function updatePost(postId) {
            location.href = contextPath + '/post/update?postId=' + postId;
        }
        
        function copyUrl(postId) {
            const url = window.location.origin + '${pageContext.request.contextPath}/post/article?postId=' + postId;
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(url).then(() => {
                    showToast("success", "클립보드에 주소가 복사되었습니다.");
                }).catch(err => {
                    fallbackCopyTextToClipboard(url);
                });
            } else {
                fallbackCopyTextToClipboard(url);
            }
        }

        function fallbackCopyTextToClipboard(text) {
            const textArea = document.createElement("textarea");
            textArea.value = text;
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
                            $btn.addClass("text-warning").removeClass("text-white-50");
                            showToast("success", "게시글을 저장했습니다.");
                        } else {
                           
                            $icon.text("bookmark_border");
                            $btn.removeClass("text-warning").addClass("text-white-50");
                            showToast("error", "저장을 취소했습니다.");
                        }
                    } else if (data.state === "login_required") {
                        location.href = contextPath + "/member/login";
                    } else {
                        showToast("error", "오류가 발생했습니다.");
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }

        function toggleRepost(postId, btn) {
            $.ajax({
                url: contextPath + "/post/insertPostRepost",
                type: "post",
                data: { postId: postId },
                dataType: "json",
                success: function(data) {
                    if (data.state === "success") {
                        const $btn = $(btn);
                        
                        if (data.reposted) {
                           
                            $btn.addClass("text-success").removeClass("text-white-50");
                            showToast("success", "게시글을 리그렘했습니다.");
                        } else {
                           
                            $btn.removeClass("text-success").addClass("text-white-50");
                            showToast("error", "리그렘을 취소했습니다.");
                        }
                    } else if (data.state === "login_required") {
                        location.href = contextPath + "/member/login";
                    } else {
                        showToast("error", "오류가 발생했습니다.");
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }
    </script>
</body>
</html>