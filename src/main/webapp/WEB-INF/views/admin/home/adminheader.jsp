<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<header class="app-header">
        <a href="${pageContext.request.contextPath}/" class="brand-logo">ODA</a>

        <div class="flex-grow-1 d-flex justify-content-center px-4">
            <input type="text" class="search-bar" placeholder="Search ODA...">
        </div>

        <div class="d-flex align-items-center gap-2">
            <button class="btn btn-custom-outline btn-sm d-none d-lg-block" onclick="location.href='${pageContext.request.contextPath}/member/signup';">회원가입</button>
            <button class="btn btn-custom-primary btn-sm d-none d-lg-block" onclick="location.href='${pageContext.request.contextPath}/member/login'">로그인</button>

            <div class="vr mx-2 text-secondary" style="height: 24px;"></div>

            <button class="btn-icon" title="게시물 작성">
                <span class="material-symbols-outlined">add</span>
            </button>
            <button class="btn-icon" title="알림">
                <span class="material-symbols-outlined">notifications</span>
            </button>

            <div class="dropdown">
                <button class="btn-icon p-0 border-0 ms-1" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="avatar-img d-flex align-items-center justify-content-center text-white small fw-bold">AD</div>
                </button>
                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark shadow-lg mt-2">
                    <li><h6 class="dropdown-header">메인페이지</h6></li>
                    <!-- 
                    <li><a class="dropdown-item d-flex align-items-center gap-2" href="#"><span class="material-symbols-outlined fs-6">person</span> 프로필 보기</a></li>
                    <li><a class="dropdown-item d-flex align-items-center gap-2" href="#"><span class="material-symbols-outlined fs-6">favorite</span> 좋아요 누른 게시물</a></li>
                    <li><hr class="dropdown-divider border-secondary opacity-25"></li>
                    <li><a class="dropdown-item d-flex align-items-center gap-2" href="#"><span class="material-symbols-outlined fs-6">settings</span> 설정</a></li>
                    <li><a class="dropdown-item d-flex align-items-center gap-2 text-danger" href="#"><span class="material-symbols-outlined fs-6">logout</span> 로그아웃</a></li>
                     -->
                </ul>
            </div>
        </div>
    </header>