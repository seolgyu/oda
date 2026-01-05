<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="currentUri" value="${pageContext.request.requestURI}" />

<aside class="app-sidebar custom-scrollbar">
	<nav class="d-flex flex-column gap-1">
		<button class="nav-item ${currentUri.contains('/home/') ? 'active' : ''}" onclick="location.href='${pageContext.request.contextPath}/main';">
			<span class="material-symbols-outlined">home</span> <span>홈</span>
		</button>
		<button class="nav-item">
			<span class="material-symbols-outlined">trending_up</span> <span>인기</span>
		</button>

		<hr class="my-3 border-secondary opacity-25">
		<div class="text-xs text-secondary px-3 mb-2 text-uppercase fw-bold">Community</div>

		<button class="nav-item ${currentUri.contains('/community/main') ? 'active' : ''}" 
				onclick="location.href='${pageContext.request.contextPath}/community/main';">
			<span class="material-symbols-outlined">settings_suggest</span> <span>커뮤니티
				관리</span>
		</button>
		<button class="nav-item ${currentUri.contains('/community/create') ? 'active' : ''}" 
				onclick="location.href='${pageContext.request.contextPath}/community/create';">
			<span class="material-symbols-outlined">add_circle</span> <span>커뮤니티
				개설</span>
		</button>
		<button class="nav-item">
			<span class="material-symbols-outlined">group</span> <span>팔로잉</span>
		</button>

		<hr class="my-3 border-secondary opacity-25">
		<div class="text-xs text-secondary px-3 mb-2 text-uppercase fw-bold">Resources</div>

		<button class="nav-item">
			<span class="material-symbols-outlined">campaign</span> <span>공지사항</span>
		</button>
		<button class="nav-item">
			<span class="material-symbols-outlined">help</span> <span>문의하기</span>
		</button>

		<c:if
			test="${not empty sessionScope.member and sessionScope.member.userLevel >= 51}">
			<button class="nav-item mt-auto text-danger"
				onclick="location.href='${pageContext.request.contextPath}/admin';">
				<span class="material-symbols-outlined">admin_panel_settings</span>
				<span>관리자</span>
			</button>
		</c:if>
	</nav>
</aside>