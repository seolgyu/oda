<%-- sidebar_fav_items.jsp --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:forEach var="fav" items="${favList}">
    <div class="flex items-center space-x-3 group cursor-pointer" 
         onclick="location.href='main?community_id=${fav.community_id}';">
        <div class="w-9 h-9 rounded-xl bg-primary/20 flex items-center justify-center text-primary text-[10px] font-bold border border-primary/30 group-hover:bg-primary group-hover:text-white transition-all uppercase shrink-0">
            ${fav.com_short_name}
        </div>
        <span class="text-sm font-medium text-gray-300 group-hover:text-primary transition-colors truncate">r/${fav.com_name}</span>
    </div>
</c:forEach>
<c:if test="${empty favList}">
    <p class="text-xs text-gray-600">즐겨찾기한 커뮤니티가 없습니다.</p>
</c:if>