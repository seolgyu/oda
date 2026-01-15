<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ODA Admin - 회원 상세</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <%@ include file="/WEB-INF/views/home/head.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">
<style>
:root {
    --bs-body-font-family: 'Inter', sans-serif;
    --primary-color: #2563EB;
    --primary-hover: #1D4ED8;
    --background-dark: #0F172A;
    --surface-dark: #1E293B;
    --border-dark: #334155;
    --text-muted: #94A3B8;
    --success-color: #10B981;
    --warning-color: #F59E0B;
    --danger-color: #EF4444;
}

/* ==========================================
   기본 레이아웃
   ========================================== */
body {
    font-family: var(--bs-body-font-family);
    background-color: #111827;
    color: #F8FAFC;
    margin: 0;
    padding: 0;
}

/* ==========================================
   브레드크럼 네비게이션
   ========================================== */
.breadcrumb-item + .breadcrumb-item::before {
    color: var(--text-muted);
    content: "chevron_right";
    font-family: 'Material Symbols Outlined';
    font-size: 14px;
    vertical-align: middle;
    display: inline-block; 
    transform: translateY(6px); 
    line-height: 1;
    margin-right: 3px;
    margin-left: 3px;
}

.breadcrumb-item a {
    color: var(--text-muted);
    text-decoration: none;
}

.breadcrumb-item a:hover {
    color: var(--primary-color);
}

.breadcrumb-item.active {
    color: #fff;
}

/* ==========================================
   글래스모피즘 카드
   ========================================== */
.glass-card {
    background: rgba(30, 41, 59, 0.4);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 1rem;
    padding: 2rem;
    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.5);
    margin-bottom: 1.5rem;
}

.glass-card-header {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 1.5rem;
}

.glass-card-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #fff;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.glass-card-body {
    color: #E2E8F0;
}

/* ==========================================
   회원 프로필 영역
   ========================================== */
.member-profile {
    display: flex;
    align-items: center;
    gap: 2rem;
    padding: 2rem;
    background: rgba(15, 23, 42, 0.5);
    border-radius: 0.75rem;
    margin-bottom: 1.5rem;
}

.member-avatar-large {
    width: 6rem;
    height: 6rem;
    border-radius: 1rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: 700;
    font-size: 2rem;
    flex-shrink: 0;
    box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
}

.member-profile-info {
    flex: 1;
}

.member-profile-name {
    font-size: 1.75rem;
    font-weight: 700;
    color: #fff;
    margin-bottom: 0.5rem;
}

.member-profile-id {
    font-size: 1rem;
    color: var(--text-muted);
    margin-bottom: 1rem;
}

.member-profile-badges {
    display: flex;
    gap: 0.75rem;
    flex-wrap: wrap;
}

/* ==========================================
   상태 뱃지
   ========================================== */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
}

.status-badge.active {
    background-color: rgba(16, 185, 129, 0.2);
    color: var(--success-color);
    border: 1px solid rgba(16, 185, 129, 0.3);
}

.status-badge.suspended {
    background-color: rgba(245, 158, 11, 0.2);
    color: var(--warning-color);
    border: 1px solid rgba(245, 158, 11, 0.3);
}

.status-badge.dormant {
    background-color: rgba(107, 114, 128, 0.2);
    color: #9CA3AF;
    border: 1px solid rgba(107, 114, 128, 0.3);
}

.status-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background-color: currentColor;
}

/* ==========================================
   정보 테이블
   ========================================== */
.info-table {
    width: 100%;
}

.info-table tr {
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.info-table tr:last-child {
    border-bottom: none;
}

.info-table th {
    padding: 1rem 0;
    width: 180px;
    font-weight: 600;
    color: #D1D5DB;
    font-size: 0.9375rem;
    vertical-align: top;
}

.info-table td {
    padding: 1rem 0;
    color: #E2E8F0;
    font-size: 0.9375rem;
}

/* ==========================================
   통계 카드
   ========================================== */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.stat-item {
    background: rgba(15, 23, 42, 0.5);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 0.75rem;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.2s;
}

.stat-item:hover {
    border-color: rgba(37, 99, 235, 0.3);
    background: rgba(15, 23, 42, 0.7);
}

.stat-item-label {
    font-size: 0.875rem;
    color: var(--text-muted);
    margin-bottom: 0.5rem;
}

.stat-item-value {
    font-size: 1.75rem;
    font-weight: 700;
    color: #fff;
}

.stat-item-icon {
    width: 3rem;
    height: 3rem;
    border-radius: 0.75rem;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 1rem;
}

.stat-item-icon.primary {
    background-color: rgba(37, 99, 235, 0.1);
    color: var(--primary-color);
}

.stat-item-icon.success {
    background-color: rgba(16, 185, 129, 0.1);
    color: var(--success-color);
}

.stat-item-icon.warning {
    background-color: rgba(245, 158, 11, 0.1);
    color: var(--warning-color);
}

/* ==========================================
   활동 내역
   ========================================== */
.activity-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.activity-item {
    display: flex;
    align-items: flex-start;
    gap: 1rem;
    padding: 1rem;
    background: rgba(15, 23, 42, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 0.5rem;
    transition: all 0.2s;
}

.activity-item:hover {
    background: rgba(15, 23, 42, 0.5);
    border-color: rgba(255, 255, 255, 0.1);
}

.activity-icon {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}

.activity-icon.post {
    background-color: rgba(37, 99, 235, 0.1);
    color: var(--primary-color);
}

.activity-icon.comment {
    background-color: rgba(16, 185, 129, 0.1);
    color: var(--success-color);
}

.activity-icon.login {
    background-color: rgba(139, 92, 246, 0.1);
    color: #A78BFA;
}

.activity-content {
    flex: 1;
}

.activity-title {
    font-weight: 600;
    color: #F8FAFC;
    margin-bottom: 0.25rem;
}

.activity-description {
    font-size: 0.875rem;
    color: var(--text-muted);
}

.activity-time {
    font-size: 0.8125rem;
    color: var(--text-muted);
    margin-left: auto;
    white-space: nowrap;
}

/* ==========================================
   액션 버튼
   ========================================== */
.action-buttons {
    display: flex;
    gap: 0.75rem;
    justify-content: flex-end;
    padding-top: 1.5rem;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.btn-action {
    padding: 0.625rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 0.9375rem;
    font-weight: 500;
    transition: all 0.2s;
    cursor: pointer;
    border: 1px solid;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-action-primary {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
    color: white;
}

.btn-action-primary:hover {
    background-color: var(--primary-hover);
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

.btn-action-warning {
    background-color: transparent;
    border-color: var(--warning-color);
    color: var(--warning-color);
}

.btn-action-warning:hover {
    background-color: rgba(245, 158, 11, 0.1);
}

.btn-action-danger {
    background-color: transparent;
    border-color: var(--danger-color);
    color: var(--danger-color);
}

.btn-action-danger:hover {
    background-color: rgba(239, 68, 68, 0.1);
}

.btn-action-secondary {
    background-color: transparent;
    border-color: #4B5563;
    color: #D1D5DB;
}

.btn-action-secondary:hover {
    background-color: #374151;
    border-color: #6B7280;
}

/* ==========================================
   차트 영역
   ========================================== */
.chart-container {
    position: relative;
    height: 300px;
    padding: 1rem;
    background: rgba(15, 23, 42, 0.3);
    border-radius: 0.75rem;
}

/* ==========================================
   모달
   ========================================== */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(4px);
    z-index: 9999;
    align-items: center;
    justify-content: center;
}

.modal-overlay.show {
    display: flex;
}

.modal-container {
    background-color: var(--surface-dark);
    border: 1px solid #374151;
    border-radius: 0.75rem;
    width: 90%;
    max-width: 500px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
}

.modal-header {
    padding: 1.5rem;
    border-bottom: 1px solid #374151;
}

.modal-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #fff;
}

.modal-body {
    padding: 1.5rem;
}

.form-group {
    margin-bottom: 1.25rem;
}

.form-group:last-child {
    margin-bottom: 0;
}

.form-label {
    display: block;
    font-size: 0.875rem;
    font-weight: 500;
    color: #D1D5DB;
    margin-bottom: 0.5rem;
}

.form-input,
.form-select,
.form-textarea {
    width: 100%;
    padding: 0.625rem 1rem;
    background-color: rgba(15, 23, 42, 0.5);
    border: 1px solid #334155;
    border-radius: 0.5rem;
    color: #E2E8F0;
    font-size: 0.9375rem;
    transition: all 0.2s ease;
}

.form-textarea {
    resize: vertical;
    min-height: 100px;
}

.form-input:focus,
.form-select:focus,
.form-textarea:focus {
    outline: none;
    border-color: var(--primary-color);
    background-color: rgba(15, 23, 42, 0.8);
    box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
}

.form-select option {
    background-color: #1E293B;
    color: #E2E8F0;
}

.modal-footer {
    padding: 1.5rem;
    border-top: 1px solid #374151;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.btn-modal {
    padding: 0.625rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 0.9375rem;
    font-weight: 500;
    transition: all 0.2s;
    cursor: pointer;
}

.btn-modal-cancel {
    background-color: transparent;
    border: 1px solid #4B5563;
    color: #D1D5DB;
}

.btn-modal-cancel:hover {
    background-color: #374151;
}

.btn-modal-confirm {
    background-color: var(--primary-color);
    border: none;
    color: white;
}

.btn-modal-confirm:hover {
    background-color: var(--primary-hover);
}

/* ==========================================
   반응형 디자인
   ========================================== */
@media (max-width: 768px) {
    .member-profile {
        flex-direction: column;
        text-align: center;
    }
    
    .member-avatar-large {
        width: 5rem;
        height: 5rem;
        font-size: 1.5rem;
    }
    
    .member-profile-badges {
        justify-content: center;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
    }
    
    .action-buttons {
        flex-direction: column;
    }
    
    .btn-action {
        width: 100%;
        justify-content: center;
    }
    
    .info-table th {
        width: 120px;
    }
}
</style>
</head>
<body class="bg-background-dark text-white">

    <div class="space-background">
        <div class="stars"></div>
        <div class="stars2"></div>
        <div class="stars3"></div>
        <div class="planet planet-1"></div>
        <div class="planet planet-2"></div>
    </div>

    <%@ include file="../home/adminheader.jsp" %>

    <div class="app-body">
        <%@ include file="../home/adminsidebar.jsp" %>
        
        <main class="app-main custom-scrollbar">
            <div class="container-fluid p-4 p-md-5" style="max-width: 1300px;">
    
                <!-- 브레드크럼 -->
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">홈</a></li>
                        <li class="breadcrumb-item"><a href="#">회원 관리</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/member/list">회원 목록</a></li>
                        <li class="breadcrumb-item active" aria-current="page">회원 상세</li>
                    </ol>
                </nav>
                <button type="button" class="btn btn-secondary" 
				    onclick="location.href='${pageContext.request.contextPath}/admin/member/list?page=${page}&size=${size}&schType=${schType}&kwd=${kwd}&state=${state}'">
				    목록으로
				</button>

                <!-- 회원 프로필 -->
                <div class="glass-card">
                    <div class="member-profile">
                        <div class="member-avatar-large">김</div>
                        <div class="member-profile-info">
                            <div class="member-profile-name">김철수</div>
                            <div class="member-profile-id">@user001</div>
                            <div class="member-profile-badges">
                                <span class="status-badge active">
                                    <span class="status-dot"></span>
                                    활성
                                </span>
                                <span class="status-badge" style="background-color: rgba(139, 92, 246, 0.2); color: #A78BFA; border: 1px solid rgba(139, 92, 246, 0.3);">
                                    일반 회원
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 활동 통계 -->
                <div class="glass-card">
                    <div class="glass-card-header">
                        <h2 class="glass-card-title">
                            <span class="material-symbols-outlined">bar_chart</span>
                            활동 통계
                        </h2>
                    </div>
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="stat-item-icon primary">
                                <span class="material-symbols-outlined">article</span>
                            </div>
                            <div class="stat-item-label">작성한 게시글</div>
                            <div class="stat-item-value">42</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-icon success">
                                <span class="material-symbols-outlined">comment</span>
                            </div>
                            <div class="stat-item-label">작성한 댓글</div>
                            <div class="stat-item-value">156</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-icon warning">
                                <span class="material-symbols-outlined">login</span>
                            </div>
                            <div class="stat-item-label">로그인 횟수</div>
                            <div class="stat-item-value">324</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-icon primary">
                                <span class="material-symbols-outlined">favorite</span>
                            </div>
                            <div class="stat-item-label">받은 좋아요</div>
                            <div class="stat-item-value">89</div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- 기본 정보 -->
                    <div class="col-lg-6">
                        <div class="glass-card">
                            <div class="glass-card-header">
                                <h2 class="glass-card-title">
                                    <span class="material-symbols-outlined">person</span>
                                    기본 정보
                                </h2>
                            </div>
                            <div class="glass-card-body">
                                <table class="info-table">
                                    <tr>
                                        <th>회원번호</th>
                                        <td>M00001</td>
                                    </tr>
                                    <tr>
                                        <th>아이디</th>
                                        <td>user001</td>
                                    </tr>
                                    <tr>
                                        <th>이름</th>
                                        <td>김철수</td>
                                    </tr>
                                    <tr>
                                        <th>닉네임</th>
                                        <td>코딩왕</td>
                                    </tr>
                                    <tr>
                                        <th>이메일</th>
                                        <td>${memberDto.user_email }</td>
                                    </tr>
                                    <tr>
                                        <th>전화번호</th>
                                        <td>010-1234-5678</td>
                                    </tr>
                                    <tr>
                                        <th>생년월일</th>
                                        <td>1990-05-15</td>
                                    </tr>
                                    <tr>
                                        <th>가입일</th>
                                        <td>2024-01-15 14:23:45</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- 계정 정보 -->
                    <div class="col-lg-6">
                        <div class="glass-card">
                            <div class="glass-card-header">
                                <h2 class="glass-card-title">
                                    <span class="material-symbols-outlined">shield</span>
                                    계정 정보
                                </h2>
                            </div>
                            <div class="glass-card-body">
                                <table class="info-table">
                                    <tr>
                                        <th>계정 상태</th>
                                        <td>
                                            <span class="status-badge active">
                                                <span class="status-dot"></span>
                                                활성
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>최근 로그인</th>
                                        <td>2025-01-14 16:42:31</td>
                                    </tr>
                                    <tr>
                                        <th>로그인 횟수</th>
                                        <td>324회</td>
                                    </tr>
                                    <tr>
                                        <th>비밀번호 변경일</th>
                                        <td>2024-12-20 09:15:22</td>
                                    </tr>
                                    <tr>
                                        <th>이메일 인증</th>
                                        <td>
                                            <span style="color: var(--success-color);">✓ 인증완료</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>휴대폰 인증</th>
                                        <td>
                                            <span style="color: var(--success-color);">✓ 인증완료</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>정지 사유</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th>정지 종료일</th>
                                        <td>-</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 최근 활동 내역 -->
                <div class="glass-card">
                    <div class="glass-card-header">
                        <h2 class="glass-card-title">
                            <span class="material-symbols-outlined">history</span>
                            최근 활동 내역
                        </h2>
                    </div>
                    <div class="glass-card-body">
                        <div class="activity-list">
                            <div class="activity-item">
                                <div class="activity-icon post">
                                    <span class="material-symbols-outlined">article</span>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">게시글 작성</div>
                                    <div class="activity-description">"Java Spring Boot 튜토리얼" 게시글을 작성했습니다</div>
                                </div>
                                <div class="activity-time">2시간 전</div>
                            </div>
                            
                            <div class="activity-item">
                                <div class="activity-icon comment">
                                    <span class="material-symbols-outlined">comment</span>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">댓글 작성</div>
                                    <div class="activity-description">"React 기초 강좌" 게시글에 댓글을 작성했습니다</div>
                                </div>
                                <div class="activity-time">5시간 전</div>
                            </div>
                            
                            <div class="activity-item">
                                <div class="activity-icon login">
                                    <span class="material-symbols-outlined">login</span>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">로그인</div>
                                    <div class="activity-description">시스템에 로그인했습니다</div>
                                </div>
                                <div class="activity-time">1일 전</div>
                            </div>
                            
                            <div class="activity-item">
                                <div class="activity-icon post">
                                    <span class="material-symbols-outlined">article</span>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">게시글 수정</div>
                                    <div class="activity-description">"Python 데이터 분석" 게시글을 수정했습니다</div>
                                </div>
                                <div class="activity-time">2일 전</div>
                            </div>
                            
                            <div class="activity-item">
                                <div class="activity-icon comment">
                                    <span class="material-symbols-outlined">comment</span>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">댓글 작성</div>
                                    <div class="activity-description">"Docker 컨테이너 관리" 게시글에 댓글을 작성했습니다</div>
                                </div>
                                <div class="activity-time">3일 전</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 주간 활동 차트 -->
                <div class="glass-card">
                    <div class="glass-card-header">
                        <h2 class="glass-card-title">
                            <span class="material-symbols-outlined">trending_up</span>
                            주간 활동 추이
                        </h2>
                    </div>
                    <div class="glass-card-body">
                        <div class="chart-container">
                            <canvas id="activityChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- 액션 버튼 -->
                <div class="glass-card">
                    <div class="action-buttons">
                        <button type="button" class="btn-action btn-action-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/member/list';">
                            <span class="material-symbols-outlined">arrow_back</span>
                            목록으로
                        </button>
                        <button type="button" class="btn-action btn-action-warning" onclick="openSuspendModal()">
                            <span class="material-symbols-outlined">block</span>
                            회원 정지
                        </button>
                        <button type="button" class="btn-action btn-action-warning" onclick="setDormant()">
                            <span class="material-symbols-outlined">bedtime</span>
                            휴면 전환
                        </button>
                        <button type="button" class="btn-action btn-action-danger" onclick="deleteMember()">
                            <span class="material-symbols-outlined">delete</span>
                            회원 탈퇴
                        </button>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <!-- 정지 처리 모달 -->
    <div class="modal-overlay" id="suspendModal">
        <div class="modal-container">
            <div class="modal-header">
                <h3 class="modal-title">회원 정지</h3>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label">정지 기간</label>
                    <select class="form-select" id="suspendPeriod">
                        <option value="7">7일</option>
                        <option value="30">30일</option>
                        <option value="90">90일</option>
                        <option value="365">1년</option>
                        <option value="999999">영구</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">정지 사유</label>
                    <textarea class="form-textarea" id="suspendReason" placeholder="정지 사유를 입력하세요"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-modal btn-modal-cancel" onclick="closeModal('suspendModal')">취소</button>
                <button type="button" class="btn-modal btn-modal-confirm" onclick="confirmSuspend()">정지</button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>

    <script>
    // 차트 초기화
    $(document).ready(function() {
        initActivityChart();
    });

    function initActivityChart() {
        const ctx = document.getElementById('activityChart');
        if (!ctx) return;

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['월', '화', '수', '목', '금', '토', '일'],
                datasets: [{
                    label: '게시글',
                    data: [3, 5, 2, 8, 4, 6, 7],
                    borderColor: '#2563EB',
                    backgroundColor: 'rgba(37, 99, 235, 0.1)',
                    tension: 0.4
                }, {
                    label: '댓글',
                    data: [5, 8, 6, 10, 7, 9, 11],
                    borderColor: '#10B981',
                    backgroundColor: 'rgba(16, 185, 129, 0.1)',
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: {
                            color: '#E2E8F0'
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: '#94A3B8'
                        },
                        grid: {
                            color: 'rgba(255, 255, 255, 0.05)'
                        }
                    },
                    x: {
                        ticks: {
                            color: '#94A3B8'
                        },
                        grid: {
                            color: 'rgba(255, 255, 255, 0.05)'
                        }
                    }
                }
            }
        });
    }

    // 모달 열기/닫기
    function openModal(modalId) {
        $('#' + modalId).addClass('show');
    }

    function closeModal(modalId) {
        $('#' + modalId).removeClass('show');
    }

    function openSuspendModal() {
        openModal('suspendModal');
    }

    // 회원 정지
    function confirmSuspend() {
        let period = $('#suspendPeriod').val();
        let reason = $('#suspendReason').val();
        
        if(!reason.trim()) {
            alert('정지 사유를 입력해주세요.');
            return;
        }
        
        let url = '${pageContext.request.contextPath}/admin/member/suspend';
        let params = {
            memberId: 'M00001',
            period: period,
            reason: reason
        };
        
        $.ajax({
            url: url,
            type: 'POST',
            data: params,
            dataType: 'json',
            success: function(data) {
                if(data.state === 'true') {
                    alert('회원 정지가 완료되었습니다.');
                    closeModal('suspendModal');
                    location.reload();
                } else {
                    alert('회원 정지에 실패했습니다.');
                }
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    }

    // 회원 활성화
    function activateMember() {
        if(!confirm('회원을 활성화하시겠습니까?')) {
            return;
        }
        
        let url = '${pageContext.request.contextPath}/admin/member/activate';
        let params = { memberId: 'M00001' };
        
        $.ajax({
            url: url,
            type: 'POST',
            data: params,
            dataType: 'json',
            success: function(data) {
                if(data.state === 'true') {
                    alert('회원이 활성화되었습니다.');
                    location.reload();
                } else {
                    alert('활성화에 실패했습니다.');
                }
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    }

    // 휴면 전환
    function setDormant() {
        if(!confirm('회원을 휴면 상태로 전환하시겠습니까?')) {
            return;
        }
        
        let url = '${pageContext.request.contextPath}/admin/member/dormant';
        let params = { memberId: 'M00001' };
        
        $.ajax({
            url: url,
            type: 'POST',
            data: params,
            dataType: 'json',
            success: function(data) {
                if(data.state === 'true') {
                    alert('휴면 전환이 완료되었습니다.');
                    location.reload();
                } else {
                    alert('휴면 전환에 실패했습니다.');
                }
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    }

    // 회원 탈퇴
    function deleteMember() {
        if(!confirm('정말로 이 회원을 탈퇴 처리하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
            return;
        }
        
        let url = '${pageContext.request.contextPath}/admin/member/delete';
        let params = { memberId: 'M00001' };
        
        $.ajax({
            url: url,
            type: 'POST',
            data: params,
            dataType: 'json',
            success: function(data) {
                if(data.state === 'true') {
                    alert('회원 탈퇴가 완료되었습니다.');
                    location.href = '${pageContext.request.contextPath}/admin/member/list';
                } else {
                    alert('회원 탈퇴에 실패했습니다.');
                }
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    }
    </script>

</body>
</html>