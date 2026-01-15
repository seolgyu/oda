<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:forEach var="fav" items="${favList}">
    <div class="flex items-center space-x-3 group cursor-pointer" 
         onclick="location.href='main?community_id=${fav.community_id}';">
        <div class="w-9 h-9 rounded-xl bg-primary/20 flex items-center justify-center text-primary text-[10px] font-bold group-hover:bg-primary group-hover:text-white transition-all uppercase shrink-0 overflow-hidden">
            <c:choose>
				<c:when test="${not empty fav.icon_image}">
					<img
						src="${fav.icon_image}"
						class="w-full h-full object-fit-cover" alt="Profile">
				</c:when>
				<c:otherwise>
            		${fn:substring(fav.com_name, 0, 1)}
        		</c:otherwise>
			</c:choose>
               
        </div>
        <span class="text-sm font-medium text-gray-300 group-hover:text-primary transition-colors truncate">${fav.com_name}</span>
    </div>
</c:forEach>
<c:if test="${empty favList}">
    <p class="text-xs text-gray-600">즐겨찾기한 커뮤니티가 없습니다.</p>
</c:if>