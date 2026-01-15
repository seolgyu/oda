<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:choose>
    <c:when test="${not empty list}">
        <c:forEach var="dto" items="${list}">
            <div class="p-8 flex items-center justify-between border-b border-white/5 hover:bg-white/[0.03] transition-all group">
                <div class="flex items-center space-x-6 flex-1 min-w-0">
                    <div class="w-16 h-16 shrink-0 rounded-2xl overflow-hidden bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white shadow-lg text-2xl font-bold">
                        <c:choose>
                            <c:when test="${not empty dto.icon_image}">
                            	<img src="${dto.icon_image}" class="w-full h-full object-cover">
                            </c:when>
                           	<c:otherwise>
                                <span class="font-bold text-xl">
                                	${fn:substring(dto.com_name, 0, 1)}
                            	</span>
                         	</c:otherwise>
                         </c:choose>
                    </div>
                    <div class="flex-1 min-w-0">
                        <h3 class="text-xl font-bold text-white"> <a href="${pageContext.request.contextPath}/community/main?community_id=${dto.community_id}" 
						       class="block w-full no-underline transition-colors duration-200 group-hover:text-primary truncate"> 
						       ${dto.com_name}
						    </a>
						</h3>
                        <p class="text-gray-400 text-sm mt-1 line-clamp-1 font-light">${dto.com_description}</p>
                        <div class="flex items-center gap-3 mt-2">
                            <span class="text-[11px] text-gray-500 font-medium">${dto.member_count} members</span>
                        </div>
                    </div>
                </div>
                
                <div class="flex items-center gap-2 shrink-0 ml-4">
				    <c:choose>
				        <c:when test="${dto.is_follow == '1' || dto.user_num == sessionScope.member.memberIdx}">
				            <button disabled class="w-32 py-3 bg-white/10 text-gray-500 rounded-xl font-bold flex items-center justify-center gap-2 cursor-default border-none outline-none">
				                <span class="material-symbols-outlined text-sm">check_circle</span> 가입됨
				            </button>
				        </c:when>
				
				        <c:otherwise>
				            <button onclick="joinCommunity('${dto.community_id}')" 
                   					class="w-32 py-3 bg-[#a855f7] hover:bg-[#9333ea] rounded-xl font-bold text-white transition-all flex items-center justify-center gap-2 border-none outline-none">
				                <span class="material-symbols-outlined text-sm">rocket_launch</span> 가입하기
				            </button>
				        </c:otherwise>
				    </c:choose>
				</div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="p-20 text-center">
            <p class="text-gray-500 font-light">커뮤니티를 찾을 수 없습니다.</p>
        </div>
    </c:otherwise>
</c:choose>