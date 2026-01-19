<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/home/head.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community_post.css">
</head>
<body>

	<%@ include file="/WEB-INF/views/home/header.jsp"%>

	<div class="app-body">
	
		<%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

		<main class="app-main">
            <div class="space-background">
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="stars3"></div>
                <div class="planet planet-1"></div>
                <div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container custom-scrollbar">
                <div class="d-flex flex-column align-items-center py-4 px-3">
                    
                    <div class="w-100 mb-4" style="max-width: 1100px;">
                        <div class="glass-card overflow-hidden shadow-lg border-0" style="border-radius: 1rem !important;">
                        	<div class="position-relative overflow-hidden"
								style="height: 220px;">
								<c:choose>
									<c:when test="${not empty dto.banner_image}">
										<img
											src="${dto.banner_image}"
											class="w-100 h-100 object-fit-cover" alt="Banner">
									</c:when>
									<c:otherwise>
										<div class="w-100 h-100"
											style="background: linear-gradient(to right, #1e1b4b, #4338ca, #1e1b4b); position: relative;">
											<div class="position-absolute w-100 h-100"
												style="background: url('https://www.transparenttextures.com/patterns/stardust.png'); opacity: 0.3;"></div>
										</div>
									</c:otherwise>
								</c:choose>
								<div class="position-absolute bottom-0 start-0 w-100"
									style="height: 40%; background: linear-gradient(to top, rgba(13, 14, 18, 0.3), transparent); pointer-events: none;">
								</div>
							</div>
                            <div class="px-4 pb-4 pt-4 position-relative" style="background: rgba(13, 14, 18, 0.85); backdrop-filter: blur(10px);">
                                <div class="d-flex align-items-end gap-3">
                                    <div class="rounded-4 border border-4 border-dark shadow-lg d-flex align-items-center justify-content-center text-white fw-bold fs-1" 
                                         style="width: 120px; height: 120px; background: linear-gradient(135deg, #6366f1, #a855f7); margin-top: -60px; position: relative; z-index: 2; overflow: hidden;">
                                        <c:choose>
											<c:when test="${not empty dto.icon_image}">
												<img
													src="${dto.icon_image}"
													class="w-100 h-100 object-fit-cover" alt="Profile">
											</c:when>
											<c:otherwise>
            									${fn:substring(dto.com_name, 0, 1)}
        									</c:otherwise>
										</c:choose>
                                    </div>
                                    <div class="pb-2">
                                        <h1 class="text-white fs-2 fw-bold mb-1">${dto.com_name}</h1>
                                        <p class="text-secondary mb-0">• 가입자 수 ${dto.member_count} • 방문자 수 ${dto.today_visit}</p>
                                    </div>
                                    <div class="ms-auto pb-2 d-flex gap-2">
                                    
                                        <c:choose>
										    <c:when test="${sessionScope.member.memberIdx == dto.user_num}">
										        <button class="btn rounded-pill px-4 fw-bold shadow-sm text-white"
										                style="background-color: #9333ea; border: none; transition: all 0.2s;"
										                onclick="location.href='${pageContext.request.contextPath}/community/management'">
										            내 커뮤니티
										        </button>
										    </c:when>
										    
										    <c:when test="${dto.is_follow == 1}">
										        <button type="button" class="btn btn-join-toggle rounded-pill px-4 fw-bold shadow-sm text-white" 
										                onclick="toggleJoin(this, '${dto.community_id}')"
										                data-joined="true"
										                style="width: 110px; background-color: #9333ea; border: none; transition: all 0.2s;">
										            가입됨
										        </button>
										    </c:when>
										    
										    <c:otherwise>
										        <button type="button" class="btn btn-join-toggle rounded-pill px-4 fw-bold shadow-sm text-white" 
										                onclick="toggleJoin(this, '${dto.community_id}')"
										                data-joined="false"
										                style="width: 110px; background-color: #a855f7; border: none; transition: all 0.2s;">
										            가입하기
										        </button>
										    </c:otherwise>
										</c:choose>
									    
                                        <button class="btn-icon border border-white border-opacity-10 rounded-circle p-2">
                                            <span class="material-symbols-outlined text-white">notifications</span>
                                        </button>
                                        <button class="btn-icon btn-favorite border border-white border-opacity-10 rounded-circle p-2 ${dto.is_favorite == 1 ? 'active' : ''}"
											onclick="toggleFavorite(this, '${dto.community_id}')">
											<span class="material-symbols-outlined text-white" style="${dto.is_favorite == 1 ? 'color: #ffca28 !important; font-variation-settings: \'FILL\' 1, \'wght\' 700 !important;' : ''}">kid_star</span>
										</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-4 w-100" style="max-width: 1100px;">
                        <div class="flex-column gap-4"
							style="width: 730px; min-width: 730px; flex-shrink: 0; display: flex;">

							<div
								class="glass-panel px-3 py-2 d-flex align-items-center justify-content-between shadow-sm">
								<div class="d-flex gap-2" id="compage-tabs">
									<button
										class="btn btn-sm rounded-pill px-3 fw-bold active-filter"
										data-sort="latest">최신순
									</button>
									<button
										class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0"
										data-sort="views">인기순
									</button>
									<button
										class="btn btn-sm rounded-pill px-3 fw-medium text-secondary hover-white border-0"
										data-sort="comments">댓글순
									</button>
								</div>
								<div
									class="layout-tabs d-flex align-items-center gap-2 border-start border-white border-opacity-10 ps-3">
									<button class="btn btn-sm rounded-pill px-3 active-filter">
										<span class="material-symbols-outlined fs-5">view_day</span>
									</button>

									<button class="btn btn-sm rounded-pill px-3">
										<span class="material-symbols-outlined fs-5">reorder</span>
									</button>
								</div>
							</div>

							<div id="post-list-container" class="d-flex flex-column gap-4">
								<c:choose>
									<c:when test="${not empty post}">
										<c:forEach var="item" items="${post}">
											<div class="glass-card shadow-lg group mb-4 post-item-card" data-id="${item.postId}">

												<div class="list-view-item p-3" style="display: none;">
													<div class="d-flex align-items-start gap-3 w-100">
														<div class="flex-shrink-0 thumbnail-box"
															style="width: 90px; height: 90px;">
															<c:choose>
																<c:when test="${not empty item.fileList}">
																	<img src="${item.fileList[0].filePath}"
																		class="w-100 h-100 object-fit-cover rounded-3 border border-white border-opacity-10">
																</c:when>
																<c:otherwise>
																	<div
																		class="w-100 h-100 rounded-3 d-flex align-items-center justify-content-center border border-white border-opacity-10"
																		style="background: rgba(255, 255, 255, 0.05);">
																		<span class="material-symbols-outlined opacity-20">image</span>
																	</div>
																</c:otherwise>
															</c:choose>
														</div>

														<div
															class="flex-grow-1 overflow-hidden d-flex flex-column justify-content-between"
															style="min-height: 90px;">
															<div>
																<div class="d-flex align-items-center gap-2 mb-1">
																	<span class="text-white fw-bold text-sm">${item.authorNickname}</span>
																	<span class="text-secondary text-xs opacity-75">c/${item.authorId}</span>
																	<span class="ms-auto text-xs text-gray-500">${item.createdDate}</span>
																</div>

																<c:if test="${not empty item.title}">
																	<h4
																		class="text-white text-sm fw-bold mb-0 text-truncate">${item.title}</h4>
																</c:if>

																<p
																	class="text-light opacity-50 text-xs mb-2 text-truncate">
																	${item.content}</p>
															</div>

															<div
																class="d-flex align-items-center justify-content-between mt-auto">
																<div class="d-flex gap-3">
																	<button
																		class="btn-icon d-flex align-items-center gap-1 p-0"
																		onclick="toggleLike(this, '${item.postId}')">
																		<span
																			class="material-symbols-outlined fs-6 ${item.likedByUser ? 'text-danger' : ''}"
																			style="font-variation-settings: 'FILL' ${item.likedByUser ? 1 : 0};">favorite</span>
																		<span class="text-xs opacity-75 like-count">${item.likeCount}</span>
																	</button>
																	<button
																		class="btn-icon d-flex align-items-center gap-1 p-0"
																		onclick="location.href='${pageContext.request.contextPath}/post/article?postId=${item.postId}';">
																		<span class="material-symbols-outlined fs-6">chat_bubble</span>
																		<span class="text-xs opacity-75">${item.commentCount}</span>
																	</button>
																	<button class="btn-icon p-0" onclick="toggleRepost('${item.postId}', this);">
																		<span class="material-symbols-outlined fs-6">repeat</span>
																	</button>
																</div>
																<div class="d-flex gap-3 text-white-50">
																	<button class="btn-icon p-0" title="공유하기">
																		<span class="material-symbols-outlined fs-6">share</span>
																	</button>
																	<button class="btn-icon p-0" title="저장하기">
																		<span class="material-symbols-outlined fs-6">bookmark</span>
																	</button>
																	<button class="btn-icon p-0" title="신고하기">
																		<span class="material-symbols-outlined fs-6">report</span>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>

												<div class="card-view-item">
													<div
														class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
														<div class="d-flex align-items-center gap-3">
															<div
																class="avatar-md bg-info text-white fw-bold d-flex align-items-center justify-content-center overflow-hidden"
																style="width: 40px; height: 40px; border-radius: 10px; background: linear-gradient(135deg, #6366f1, #a855f7);">
																<c:choose>
																	<c:when test="${not empty item.authorProfileImage}">
																		<img src="${item.authorProfileImage}"
																			class="w-100 h-100 object-fit-cover">
																	</c:when>
																	<c:otherwise>${fn:substring(item.authorNickname, 0, 1)}</c:otherwise>
																</c:choose>
															</div>
															<div>
																<h3 class="text-sm fw-medium text-white mb-0">${item.authorNickname}</h3>
																<p class="text-xs text-gray-500 mb-0">${item.createdDate}</p>
															</div>
														</div>
														<button class="btn-icon text-white-50">
															<span class="material-symbols-outlined">more_horiz</span>
														</button>
													</div>

													<div class="p-3 pb-2">
														<c:if test="${not empty item.title}">
															<h4 class="text-white fs-6 fw-bold mb-1">${item.title}</h4>
														</c:if>
														<p class="text-light text-sm mb-0 lh-base"
															style="white-space: pre-wrap;">${item.content}</p>
													</div>

													<c:if test="${not empty item.fileList}">
														<div class="p-3 pt-0">
															<c:choose>
																<c:when test="${item.fileList.size() > 1}">
																	<div id="carousel-${item.postId}"
																		class="carousel slide post-carousel"
																		data-bs-ride="false">
																		<div class="carousel-indicators">
																			<c:forEach var="file" items="${item.fileList}"
																				varStatus="status">
																				<button type="button"
																					data-bs-target="#carousel-${item.postId}"
																					data-bs-slide-to="${status.index}"
																					class="${status.first ? 'active' : ''}"></button>
																			</c:forEach>
																		</div>
																		<div class="carousel-inner">
																			<c:forEach var="file" items="${item.fileList}"
																				varStatus="status">
																				<div
																					class="carousel-item ${status.first ? 'active' : ''}">
																					<div class="ratio ratio-16x9">
																						<img src="${file.filePath}"
																							class="d-block w-100 object-fit-cover">
																					</div>
																				</div>
																			</c:forEach>
																		</div>
																		<button class="carousel-control-prev" type="button"
																			data-bs-target="#carousel-${item.postId}"
																			data-bs-slide="prev">
																			<span class="material-symbols-outlined fs-4">chevron_left</span>
																		</button>
																		<button class="carousel-control-next" type="button"
																			data-bs-target="#carousel-${item.postId}"
																			data-bs-slide="next">
																			<span class="material-symbols-outlined fs-4">chevron_right</span>
																		</button>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="post-carousel">
																		<div class="ratio ratio-16x9">
																			<img src="${item.fileList[0].filePath}"
																				class="d-block w-100 object-fit-cover">
																		</div>
																	</div>
																</c:otherwise>
															</c:choose>
														</div>
													</c:if>

													<div
														class="px-3 py-2 d-flex align-items-center justify-content-between border-top border-white border-opacity-10"
														style="background: rgba(255, 255, 255, 0.05);">
														<div class="d-flex gap-4">
															<button class="btn-icon d-flex align-items-center gap-1"
																onclick="toggleLike(this, '${item.postId}')">
																<span
																	class="material-symbols-outlined fs-5 ${item.likedByUser ? 'text-danger' : ''}"
																	style="font-variation-settings: 'FILL' ${item.likedByUser ? 1 : 0};">favorite</span>
																<span class="text-xs opacity-75 like-count">${item.likeCount}</span>
															</button>
															<button class="btn-icon d-flex align-items-center gap-1"
																onclick="location.href='${pageContext.request.contextPath}/post/article?postId=${item.postId}';">
																<span class="material-symbols-outlined fs-5">chat_bubble</span>
																<span class="text-xs opacity-75">${item.commentCount}</span>
															</button>
															<button class="btn-icon" onclick="toggleRepost('${item.postId}', this)">
																<span class="material-symbols-outlined fs-5">repeat</span>
															</button>
														</div>
														<div class="d-flex gap-3 text-white-50">
															<button class="btn-icon" title="공유하기" onclick="copyUrl('${item.postId}')">
																<span class="material-symbols-outlined fs-5">share</span>
															</button>
															<button class="btn-icon" title="저장하기" onclick="toggleSave('${item.postId}', this)">
																<span class="material-symbols-outlined fs-5">bookmark</span>
															</button>
															<button class="btn-icon" title="신고하기" onclick="openReportModal('${item.postId}')">
																<span class="material-symbols-outlined fs-5">report</span>
															</button>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:when>

									<c:otherwise>
										<div class="glass-card py-5 text-center shadow-lg border-0"
											style="background: rgba(255, 255, 255, 0.02); border-radius: 1rem !important;">
											<div class="py-4">
												<span
													class="material-symbols-outlined text-secondary opacity-20"
													style="font-size: 80px;">rocket_launch</span>
												<h4 class="text-white mt-3 fw-bold opacity-75">등록된 게시글이 없습니다</h4>
												<c:if
													test="${not empty sessionScope.member and sessionScope.member.userId eq user.userId}">
													<button
														onclick="location.href='${pageContext.request.contextPath}/post/write';"
														class="btn btn-outline-primary rounded-pill px-4 btn-sm mt-3 fw-bold">
														게시글 작성하기</button>
												</c:if>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</div>

							<div id="sentinel" style="height: 50px;"></div>
						</div>
                        

                        <aside class="d-none d-xl-flex flex-column gap-4" style="width: 320px; flex-shrink: 0;">
						    <div class="glass-card p-4 shadow-lg">
						        <h3 class="text-white text-xs fw-bold text-uppercase tracking-widest mb-3 opacity-75">커뮤니티 자세히 보기</h3>
						        
						        <div class="d-flex align-items-center gap-3 mb-3">
						            <div class="rounded-circle overflow-hidden border border-white border-opacity-10 shadow-sm" style="width: 50px; height: 50px; background: linear-gradient(135deg, #e11d48, #4c1d95);">
						                <div class="w-100 h-100 d-flex align-items-center justify-content-center text-white">
						                    <span class="material-symbols-outlined">flare</span>
						                </div>
						            </div>
						            <h4 class="text-white text-sm fw-bold mb-0">${dto.com_name}</h4>
						        </div>
						        
						        <p class="text-secondary text-xs lh-relaxed mb-4">${dto.com_description}</p>
						        
						        <div class="d-flex gap-4 mb-4 pt-3 border-top border-white border-opacity-10">
						            <div class="d-flex flex-column">
						                <span class="text-white text-sm fw-bold">${dto.member_count}</span>
						                <span class="text-secondary" style="font-size: 10px;">가입자수</span>
						            </div>
						            <div class="d-flex flex-column">
						                <div class="d-flex align-items-center gap-1">
						                    <span class="material-symbols-outlined text-info" style="font-size: 12px;">visibility</span>
						                    <span class="text-white text-sm fw-bold">${dto.total_visit}</span>
						                </div>
						                <span class="text-secondary" style="font-size: 10px;">총방문자수</span>
						            </div>
						        </div>
						
						        <div class="d-flex flex-column gap-2 mb-4">
								    <div class="d-flex align-items-center gap-2 text-secondary">
								        <span class="material-symbols-outlined" style="font-size: 18px;">cake</span>
								        <span style="font-size: 0.85rem;">${dto.created_date}</span>
								    </div>
								    <div class="d-flex align-items-center gap-2 text-secondary">
								        <span class="material-symbols-outlined" style="font-size: 18px;">${dto.is_private == '0' ? 'public' : 'lock'}</span>
								        <span style="font-size: 0.85rem;">${dto.is_private == '0' ? '전체공개' : '비공개'}</span>
								    </div>
								</div>
						
						        <button class="btn w-100 rounded-pill fw-bold py-2 mb-3 text-white" 
								        style="background: linear-gradient(135deg, #a855f7, #9333ea); border: none; transition: transform 0.2s, box-shadow 0.2s;"
								        onclick="checkJoinAndWrite();"
								        onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 12px rgba(168, 85, 247, 0.4)';"
								        onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
								    게시글 쓰기
								</button>
						        
						        <c:if test="${sessionScope.member.memberIdx == dto.user_num}">
								    <div class="text-center pt-2 border-top border-white border-opacity-10">
								        <span class="text-xs fw-bold" 
								              style="cursor: pointer; color: #a855f7; transition: color 0.2s;" 
								              onclick="location.href='${pageContext.request.contextPath}/community/update?community_id=${dto.community_id}';"
								              onmouseover="this.style.color='#c084fc'; this.style.textDecoration='underline';"
								              onmouseout="this.style.color='#a855f7'; this.style.textDecoration='none';">
								            커뮤니티 설정
								        </span>
								    </div>
								</c:if>
						        
						    </div>
						</aside>
						
                    </div> 
            	</div>
            </div>
        </main>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	
	<script>
    // JS 파일들이 참조할 전역 변수
    window.cp = "${pageContext.request.contextPath}";
    window.communityId = "${dto.community_id}"; 
    window.currentSort = "${currentSort}"; // 컨트롤러에서 넘겨받은 정렬 상태
    window.ownerIdx = "${dto.user_num}";
    window.currentUserIdx = "${sessionScope.member.memberIdx}";
    const contextPath = "${pageContext.request.contextPath}";
    const isLogin = "${empty sessionScope.member ? 'false' : 'true'}";
	</script>
	
	<script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/community_post.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/community_form.js"></script>
	
	<script>
	    $(function() {
	        <%-- 세션에 메시지가 남아있다면 --%>
	        <c:if test="${not empty sessionScope.toastMsg}">
	            if (typeof showToast === 'function') {
	                showToast('${sessionScope.toastType}', '${sessionScope.toastMsg}');
	            }
	            
	            <%-- 출력이 끝났으니 세션에서 제거 --%>
	            <% 
	                session.removeAttribute("toastMsg"); 
	                session.removeAttribute("toastType"); 
	            %>
	        </c:if>
	    });
	</script>
	
	<div class="modal fade" id="reportModal" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content glass-card border-0" style="background: rgba(30, 30, 30, 0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.1);">
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
</body>
</html>