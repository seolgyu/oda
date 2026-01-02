<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<aside class="app-sidebar custom-scrollbar">
	<nav class="d-flex flex-column gap-1">
		<button class="nav-item active">
			<span class="material-symbols-outlined">home</span> <span>홈</span>
		</button>

		<hr class="my-3 border-secondary opacity-25">
		<div class="text-xs text-secondary px-3 mb-2 text-uppercase fw-bold">Management</div>

		<button class="nav-item active">
			<span class="material-symbols-outlined">person</span>
			<span>회원관리</span>
		</button>
		<button class="nav-item active">
			<span class="material-symbols-outlined">image</span>
			<span>컨첸츠관리</span>
		</button>
		<button class="nav-item active">
			<span class="material-symbols-outlined"> campaign </span>
			<span>서비스관리</span>
		</button>
		<button class="nav-item active">
			<span class="material-symbols-outlined">groups_2</span>
			<span>개설 커뮤니티 관리</span>
		</button>

		<hr class="my-3 border-secondary opacity-25">
		<div class="text-xs text-secondary px-3 mb-2 text-uppercase fw-bold">system</div>

		<button class="nav-item active">
			<span class="material-symbols-outlined">settings</span> 
			<span>시스템관리</span>
		</button>
		<button class="nav-item active">
			<span class="material-symbols-outlined">logout</span> 
			<span>로그아웃</span>
		</button>
	</nav>
</aside>