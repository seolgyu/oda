<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#a855f7",
                        secondary: "#9333ea",
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-[#050505] text-gray-100 overflow-hidden">

    <%@ include file="/WEB-INF/views/home/header.jsp"%>

    <div class="app-body">
        <%@ include file="/WEB-INF/views/home/sidebar.jsp"%>

        <main class="app-main flex-1">
            <div class="space-background">
                <div class="stars"></div>
                <div class="stars2"></div>
                <div class="stars3"></div>
                <div class="planet planet-1"></div>
                <div class="planet planet-2"></div>
            </div>

            <div class="feed-scroll-container custom-scrollbar w-full">
                <div class="max-w-3xl mx-auto py-12 px-4 relative z-10">
                    
                    <div class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-8 px-2">
                        <div>
                            <div class="flex items-center gap-2 text-gray-500 text-xs mb-2">
                                <span>커뮤니티</span>
                                <span class="material-symbols-outlined text-xs">chevron_right</span>
                                <span class="text-gray-300 font-medium">설정</span>
                            </div>
                            <h1 class="text-3xl font-bold text-white">커뮤니티 설정 편집</h1>
                            <p class="text-gray-400 mt-1">커뮤니티의 정보와 설정을 관리하세요.</p>
                        </div>
                        <button type="button" class="px-5 py-2.5 bg-white/10 hover:bg-white/20 text-white rounded-xl text-sm font-semibold transition-all backdrop-blur-md border border-white/10">
                            커뮤니티 미리보기
                        </button>
                    </div>

                    <div class="neon-card rounded-[2.5rem] overflow-hidden">
                        <form id="updateForm" class="p-8 md:p-12 space-y-12">
                            
                            <input type="hidden" id="db_is_private" value="${dto.is_private}">
						    <input type="hidden" id="db_category_id" value="${dto.category_id}">
						
						    <input type="hidden" name="community_id" value="${dto.community_id}">
						    <input type="hidden" name="category_id" id="category_id_input" value="${dto.category_id}">
						    
						    <input type="hidden" name="icon_image" value="${dto.icon_image}">
							<input type="hidden" name="banner_image" value="${dto.banner_image}">
                            
                            
                            <div class="space-y-8">
                                <div class="border-b border-white/10 pb-3 flex items-center gap-2">
                                    <span class="material-symbols-outlined text-gray-400">info</span>
                                    <h2 class="text-lg font-bold text-white uppercase tracking-wider">커뮤니티 일반 정보</h2>
                                </div>

                                <div class="space-y-3">
								    <label class="text-sm font-medium text-gray-400 ml-1">커뮤니티 배너 이미지</label>
								    <div class="relative h-48 w-full rounded-2xl border-2 border-dashed border-white/10 bg-black/30 flex items-center justify-center cursor-pointer hover:border-primary/50 transition-all group overflow-hidden"
								         onclick="$('#banner-input').click();">
								        
								        <img id="banner-img-view" 
								             src="${dto.banner_image}" 
								             class="absolute inset-0 w-full h-full object-cover transition-transform duration-500 group-hover:scale-105 ${empty dto.banner_image ? 'hidden' : ''}">
								        
								        <div class="absolute inset-0 bg-black/40 flex flex-col items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300 z-10">
								            <span class="material-symbols-outlined text-white text-4xl mb-2">photo_camera</span>
								            <span class="text-sm text-white font-medium">배너 교체하기</span>
								        </div>
								
								        <div id="banner-placeholder" class="flex flex-col items-center gap-2 text-gray-500 ${not empty dto.banner_image ? 'hidden' : ''}">
								            <span class="material-symbols-outlined text-4xl">add_a_photo</span>
								            <span class="text-xs">배너 이미지를 등록하세요</span>
								        </div>
								    </div>
								    <input type="file" id="banner-input" name="bannerFile" class="hidden" accept="image/*">
								</div>
								
								<div class="flex flex-col md:flex-row gap-8">
								    <div class="flex-shrink-0">
								        <label class="text-sm font-medium text-gray-400 ml-1 block mb-3">아이콘</label>
									    <div class="w-28 h-28 rounded-3xl border-2 border-dashed border-white/10 bg-black/30 flex items-center justify-center cursor-pointer hover:border-primary transition-all relative group overflow-hidden" 
									         onclick="$('#avatar-input').click();">
									        
									        <img id="avatar-img-view" 
									             src="${dto.icon_image}" 
									             class="absolute inset-0 w-full h-full object-cover z-0 ${empty dto.icon_image ? 'hidden' : ''}">
									    
									        <div id="avatar-gradient" class="absolute inset-0 bg-gradient-to-br from-primary to-blue-600 opacity-80 z-10 group-hover:opacity-60 transition-opacity ${not empty dto.icon_image ? 'hidden' : ''}"></div>
									        <span class="material-symbols-outlined text-white text-3xl z-20 group-hover:scale-110 transition-transform">edit</span>
									    </div>
									    <input type="file" id="avatar-input" name="iconFile" class="hidden" accept="image/*">
									</div>
                                    
                                    <div class="flex-1 space-y-6">
                                        <div class="space-y-2">
                                            <label class="text-sm font-medium text-gray-400 ml-1">커뮤니티 이름</label>
                                            <input type="text" name="com_name" class="custom-input w-full rounded-xl py-3.5 px-5" value="${dto.com_name}">
                                            <span id="nameError" class="text-xs text-red-500 ml-1"></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="space-y-2">
                                    <label class="text-sm font-medium text-gray-400 ml-1">커뮤니티 소개</label>
                                    <textarea name="com_description" rows="4" class="custom-input w-full rounded-2xl py-4 px-5 resize-none">${dto.com_description}</textarea>
                                    <span id="descError" class="text-xs text-red-500 ml-1"></span>
                                </div>
                            </div>

                            <div class="space-y-6">
                                <div class="border-b border-white/10 pb-3 flex items-center gap-2">
                                    <span class="material-symbols-outlined text-gray-400">shield</span>
                                    <h2 class="text-lg font-bold text-white uppercase tracking-wider">공개 범위</h2>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
								    <label class="privacy-card card-unselected relative flex flex-col p-6 cursor-pointer rounded-2xl">
								        <input type="radio" name="is_private" value="public" class="sr-only"> <div class="flex justify-between items-start mb-4">
								            <span class="material-symbols-outlined text-green-400 text-2xl flex-none">public</span>
								            <div class="check-container w-6 h-6 flex justify-center items-center"></div>
								        </div>
								        <p class="font-bold text-base title-text text-green-400 text-white mb-1">전체 공개</p>
								        <p class="text-xs text-gray-500 leading-relaxed">누구나 보고 게시할 수 있습니다.</p>
								    </label>
								    
								    <label class="privacy-card card-unselected relative flex flex-col p-6 cursor-pointer rounded-2xl">
								        <input type="radio" name="is_private" value="private" class="sr-only">
								        <div class="flex justify-between items-start mb-4">
								            <span class="material-symbols-outlined text-red-400 text-2xl flex-none">lock</span>
								            <div class="check-container w-6 h-6 flex justify-center items-center"></div>
								        </div>
								        <p class="font-bold text-base title-text text-white mb-1">비공개</p>
								        <p class="text-xs text-gray-500 leading-relaxed">나만 보고 게시할 수 있습니다.</p>
								    </label>
								</div>
                            </div>

                            <div class="space-y-6">
                                <div class="border-b border-white/10 pb-3 flex items-center gap-2">
                                    <span class="material-symbols-outlined text-gray-400">label</span>
                                    <h2 class="text-lg font-bold text-white uppercase tracking-wider">커뮤니티 주제</h2>
                                </div>
                                <div class="flex flex-wrap gap-2.5">
                                    <c:forEach var="cate" items="${categories}">
								        <button type="button" 
								                class="topic-btn px-4 py-2.5 rounded-xl text-xs font-medium 
								                       ${cate.category_id == dto.category_id ? 'selected' : ''}"
								                data-id="${cate.category_id}">
								            ${cate.category_name}
								        </button>
								    </c:forEach>
                                </div>
                            </div>

                            <div class="flex flex-col md:flex-row items-center justify-between pt-10 border-t border-white/5 gap-6">
                                <button type="button" class="flex items-center gap-2 text-red-500 hover:text-red-400 px-4 py-2 rounded-xl hover:bg-red-500/10 transition-all text-sm font-bold group" onclick="deleteCommunity('${dto.community_id}')">
                                    <span class="material-symbols-outlined text-lg group-hover:animate-pulse">delete_forever</span>
                                    커뮤니티 삭제
                                </button>
                                
                                <div class="flex items-center gap-4 w-full md:w-auto">
                                    <button type="button" class="flex-1 md:flex-none px-8 py-3.5 text-sm font-bold text-gray-400 hover:text-white transition-colors" onclick="history.back()">취소</button>
                                    <button type="submit" class="flex-1 md:flex-none bg-gradient-to-r from-primary to-secondary hover:from-secondary hover:to-primary px-10 py-3.5 rounded-2xl font-bold text-white shadow-[0_10px_40px_rgba(168,85,247,0.4)] transition-all transform hover:-translate-y-1">
                                        편집 완료
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <div id="confirm-modal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/80 backdrop-blur-sm px-4">
	    <div class="neon-card p-10 rounded-[2.5rem] w-full max-w-[340px] text-center border border-white/10 bg-[#0a0a0a] shadow-2xl">
	        <h3 class="text-2xl font-bold text-white mb-4 tracking-tight">제목</h3>
	        <p class="text-gray-400 mb-10 leading-relaxed font-medium">설명 문구</p>
	        <div class="flex gap-3">
	            <button onclick="closeConfirmModal()" 
	                    class="flex-1 py-3.5 rounded-2xl bg-white/5 text-gray-400 font-semibold hover:bg-white/10 hover:text-white transition-all">
	                취소
	            </button>
	            <button id="modal-confirm-btn" 
	                    class="flex-1 py-3.5 rounded-2xl text-white font-bold shadow-lg transform active:scale-95 transition-all">
	                확인
	            </button>
	        </div>
	    </div>
	</div>
    
    <div id="sessionToast" class="glass-toast flex items-center gap-4">
	    <div class="toast-icon-circle flex-none">
	        <span id="toastIcon" class="material-symbols-outlined text-[20px]">check_circle</span>
	    </div>
	    <div class="flex-1">
	        <p id="toastMessage" class="toast-msg text-sm font-medium text-white/90 mb-0"></p>
	    </div>
	</div>

    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/util-jquery.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/community.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/community_form.js"></script>
</body>
</html>