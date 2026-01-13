<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:choose>
    <c:when test="${not empty list}">
        <c:forEach var="dto" items="${list}">
            <div class="p-8 flex items-center justify-between border-b border-white/5 hover:bg-white/[0.03] transition-all group">
                <div class="flex items-center space-x-6">
                    <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white shadow-lg text-2xl font-bold">
                        ${dto.com_name.substring(0,1).toUpperCase()}
                    </div>
                    <div>
                        <h3 class="text-xl font-bold text-white group-hover:text-primary transition-colors">
                            <a href="${pageContext.request.contextPath}/community/main?community_id=${dto.community_id}">r/${dto.com_name}</a>
                        </h3>
                        <p class="text-gray-400 text-sm mt-1 line-clamp-1 font-light">${dto.com_description}</p>
                        <div class="flex items-center gap-3 mt-2">
                            <span class="text-[11px] text-gray-500 font-medium">${dto.member_count} members</span>
                        </div>
                    </div>
                </div>
                
                <button class="bg-[#a855f7] hover:bg-[#9333ea] px-8 py-3 rounded-xl font-bold text-white shadow-[0_5px_20px_rgba(168,85,247,0.3)] transition-all transform hover:-translate-y-1 active:scale-95 flex items-center gap-2">
                    <span class="material-symbols-outlined text-sm">rocket_launch</span> Join
                </button>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="p-20 text-center">
            <p class="text-gray-500 font-light">커뮤니티를 찾을 수 없습니다.</p>
        </div>
    </c:otherwise>
</c:choose>