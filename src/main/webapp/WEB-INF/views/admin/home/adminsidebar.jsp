<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<aside class="app-sidebar custom-scrollbar">
	<nav class="d-flex flex-column gap-1">
	
		<button class="nav-item active" onclick="location.href='${pageContext.request.contextPath}/admin';">
			<span class="material-symbols-outlined">home</span>
			<span>홈</span>
		</button>

		<hr class="my-3 border-secondary opacity-25">
		<div class="text-xs text-secondary px-3 mb-2 text-uppercase fw-bold">Management</div>

	<!-- 회원 단일(리스트[목록, 검색, 상세조회, 상태-휴먼,중지]로 다 조회 가능) -->
		<div class="nav-group">
		<button class="nav-item nav-toggle">
			<span class="material-symbols-outlined">person</span>
			<span>회원관리</span>
			<span class="material-symbols-outlined arrow">expand_more</span>
      </button>
		
		<div class="nav-sub">
        <a href="${pageContext.request.contextPath}/admin/member/list" class="nav-sub-item">회원계정 관리</a>
      </div>
    </div>
		
		<div class="nav-group">
		<button class="nav-item nav-toggle">
			<span class="material-symbols-outlined">image</span>
			<span>콘텐츠 관리</span>
			<span class="material-symbols-outlined arrow">expand_more</span>
      </button>
      
      <div class="nav-sub">
        <a href="${pageContext.request.contextPath}/admin/content/list" class="nav-sub-item">콘텐츠 관리</a>
      </div>
    </div>
    
		<div class="nav-group">
		<button class="nav-item nav-toggle">
			<span class="material-symbols-outlined"> campaign </span>
			<span>서비스 관리</span>
			<span class="material-symbols-outlined arrow">expand_more</span>
      </button>
      
      <div class="nav-sub">
        <a href="${pageContext.request.contextPath}/admin/notice/list" class="nav-sub-item">공지사항</a>
        <a href="${pageContext.request.contextPath}/admin/inqu/list" class="nav-sub-item">문의사항</a>
        <a href="${pageContext.request.contextPath}/admin/events/list" class="nav-sub-item">이벤트</a>
      </div>
    </div>
      
		<button class="nav-item">
			<span class="material-symbols-outlined">groups_2</span>
			<span>개설 커뮤니티 관리</span>
		</button>

		<hr class="my-3 border-secondary opacity-25">
		<div class="text-xs text-secondary px-3 mb-2 text-uppercase fw-bold">system</div>

		<%-- <div class="nav-item">
			<span class="material-symbols-outlined">settings</span> 
			<a href="${pageContext.request.contextPath}/admin/adminmanage/list" class="nav-sub-item"><span>사용자권한 관리</span></a>
		</div> --%>
		<button class="nav-item">
			<span class="material-symbols-outlined">logout</span> 
			<span>로그아웃</span>
		</button>
	</nav>
</aside>

<script>
  document.querySelectorAll('.nav-toggle').forEach(btn => {
    btn.addEventListener('click', () => {
      btn.closest('.nav-group').classList.toggle('open');
    });
  });
</script>