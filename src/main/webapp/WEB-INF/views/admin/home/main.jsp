<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>ODA Admin Dashboard (Dark Mode)</title>
<link href="https://fonts.googleapis.com" rel="preconnect" />
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&amp;display=swap" rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/home/head.jsp"%>
<!-- admin_sidebar 스타일 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminmain.css">
<!-- admin_main 스타일 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminstyle.css">

</head>
<body class="bg-background-dark font-display text-white min-h-screen flex flex-col relative overflow-hidden">

    <div class="space-background">
        <div class="stars"></div>
        <div class="stars2"></div>
        <div class="stars3"></div>
        <div class="planet planet-1"></div>
        <div class="planet planet-2"></div>
    </div>

	<%@ include file="adminheader.jsp"%>

	<div class="app-body">

		<%@ include file="adminsidebar.jsp"%>

		<main class="app-main custom-scrollbar">

			<div class="main-container">
				<div class="card-dark mb-4 mt-2">
					<div class="d-flex align-items-center gap-3">
						<div
							class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary">
							<span class="material-icons-round">admin_panel_settings</span>
						</div>
						<div>
							<h1 class="h4 fw-bold mb-1">
								반갑습니다, <span class="text-primary">관리자</span>님
							</h1>
							<p class="text-white small mb-0">시스템 현황 및 최근 업데이트 개요입니다.</p>
						</div>
					</div>
				</div>
				<section class="mb-5">
					<div class="d-flex align-items-center gap-2 mb-3">
						<span class="material-icons-round text-primary">groups</span>
						<h2 class="h5 fw-bold mb-0">회원 통계</h2>
					</div>
					<div class="row g-3">
						<div class="col-12 col-md-6 col-xl-3">
							<div
								class="card-dark d-flex justify-content-between align-items-start h-100">
								<div>
									<p class="stat-label">총 가입자 수</p>
									<div class="d-flex align-items-baseline gap-2">
										<span class="stat-value">${list[0].memberCountList}</span> <span
											class="stat-badge bg-blue-soft">${dayDto.memberdaycount}+</span>
									</div>
								</div>
								<div class="stat-icon-wrapper">
									<span class="material-icons-round fs-5">person_add</span>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-6 col-xl-3">
							<div
								class="card-dark d-flex justify-content-between align-items-start h-100">
								<div>
									<p class="stat-label">이용 중인 회원</p>
									<div class="d-flex align-items-baseline gap-2">
										<span class="stat-value">${inDto.inmembercount }</span> <span
											class="stat-badge text-green d-flex align-items-center p-0">
											<span class="material-icons-round"
											style="font-size: 14px; margin-right: 2px;">trending_up</span>
											${logPerDto.loginPercentage }%
										</span>
									</div>
								</div>
								<div class="stat-icon-wrapper">
									<span class="material-icons-round fs-5">how_to_reg</span>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-6 col-xl-3">
							<div
								class="card-dark d-flex justify-content-between align-items-start h-100">
								<div>
									<p class="stat-label">탈퇴 회원 수</p>
									<div class="d-flex align-items-baseline gap-2">
										<span class="stat-value">${drewDto.drewmembercount}</span> <span class="text-orange"
											style="font-size: 0.75rem;">최근 30일</span>
									</div>
								</div>
								<div class="stat-icon-wrapper">
									<span class="material-icons-round fs-5">person_remove</span>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-6 col-xl-3">
							<div
								class="card-dark d-flex justify-content-between align-items-start h-100">
								<div>
									<p class="stat-label">휴면 회원 수</p>
									<div class="d-flex align-items-baseline gap-2">
										<span class="stat-value">${dorDto.dormembercount }</span> <span class="text-orange"
											style="font-size: 0.75rem;">${dorexpDto.dorexpmembercount }명 휴면 처리예정 회원</span>
									</div>
								</div>
								<div class="stat-icon-wrapper">
									<span class="material-icons-round fs-5">snooze</span>
								</div>
							</div>
						</div>
					</div>
				</section>
				<section class="mb-5">
					<div class="row g-4">
						<div class="col-12 col-lg-4">
							<div class="card-dark big-stat-card group">
								<div class="position-relative z-1">
									<div class="d-flex align-items-center gap-2 mb-3 text-light">
										<span class="material-icons-round text-orange"
											style="font-size: 1rem;">cloud_upload</span> <span class="stat-label"
											style="font-size: 0.875rem; font-weight: 500;">콘텐츠 업로드
											수</span>
									</div>
									<h3 class="big-stat-value">${postDto.postcount }</h3>
									<span class="stat-badge bg-yellow-soft"> <span
										class="material-icons-round"
										style="font-size: 12px; margin-right: 4px;">verified</span> 신규
										${recentDto.recentpostcount} 건 등록됨(6시간 이내)
									</span>
								</div>
								<span class="material-icons-round big-stat-bg-icon">folder</span>
							</div>
						</div>
						<div class="col-12 col-lg-4">
							<div class="card-dark big-stat-card group">
								<div class="position-relative z-1">
									<div class="d-flex align-items-center gap-2 mb-3 text-light">
										<span class="material-icons-round"
											style="font-size: 1rem; color: #ec4899;">forum</span> <span class="stat-label"
											style="font-size: 0.875rem; font-weight: 500;">개설 커뮤니티
											수</span>
									</div>
									<h3 class="big-stat-value">${comDto.comCount}</h3>
									<span class="stat-badge bg-purple-soft"> <span
										class="material-icons-round"
										style="font-size: 12px; margin-right: 4px;">trending_up</span>
										+${comDayDto.comDayCount } (24시간 내)
									</span>
								</div>
								<span class="material-icons-round big-stat-bg-icon">groups</span>
							</div>
						</div>
						<div class="col-12 col-lg-4 d-flex flex-column gap-3">
							<div
								class="card-dark flex-fill d-flex flex-column justify-content-between">
								<div class="d-flex justify-content-between align-items-start">
									<span class="stat-label">신고 처리된 콘텐츠 수</span> <span
										class="material-icons-round text-red" style="font-size: 1rem;">error</span>
								</div>
								<div class="d-flex justify-content-between align-items-end mt-2">
									<span class="stat-value fs-2">${reportpostcount.reportpostcount }</span> <span
										class="stat-badge bg-red-soft">처리필요 ${reportcount.reportcount }건</span>
								</div>
							</div>
							<div
								class="card-dark flex-fill d-flex flex-column justify-content-between">
								<div class="d-flex justify-content-between align-items-start">
									<span class="stat-label">비공개 커뮤니티 수</span> <span
										class="material-icons-round text-orange"
										style="font-size: 1rem;">flag</span>
								</div>
								<div class="d-flex justify-content-between align-items-end mt-2">
									<span class="stat-value fs-2">${priDto.comPriCount }</span> 
									<span class="stat-badge bg-red-soft">
										커뮤니티 공개여부</span>
								</div>
							</div>
						</div>
					</div>
				</section>
				<section class="card-dark mb-5">
					<div
						class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center mb-4 gap-3">
						<div>
							<div class="d-flex align-items-center gap-2 mb-1">
								<span class="material-icons-round text-primary fs-5">ssid_chart</span>
								<h2 class="h5 fw-bold mb-0">방문자, 콘텐츠 추이 (주간)</h2>
							</div>
							<p class="text-light small mb-0">지난 7일간의 회원 방문자와 회원 콘텐츠 업로드 변화
								그래프</p>
						</div>
						<div class="d-flex align-items-center gap-3 px-3 py-2 rounded"
							style="background-color: #0f172a;">
							<div class="d-flex align-items-center gap-2">
								<span class="rounded-circle bg-primary"
									style="width: 10px; height: 10px;"></span>
								<div class="d-flex flex-column lh-1">
									<span class="text-light"
										style="font-size: 10px; margin-bottom: 2px;">콘텐츠 등록 수</span> 
									<span class="fw-bold text-light" style="font-size: 0.875rem;" id="totalGeneral">0</span>
								</div>
							</div>
							<div
								style="width: 1px; height: 24px; background-color: var(--border-color);"></div>
							<div class="d-flex align-items-center gap-2">
								<span class="rounded-circle"
									style="width: 10px; height: 10px; background-color: #a855f7;"></span>
								<div class="d-flex flex-column lh-1">
									<span class="text-light"
										style="font-size: 10px; margin-bottom: 2px;">회원 방문자 수</span> 
									<span class="fw-bold text-light" style="font-size: 0.875rem;" id="totalMember">0</span>
								</div>
							</div>
						</div>
					</div>
					<div class="graph-container" style="position: relative; height: 280px;">
						<canvas id="visitorChart"></canvas>
					</div>
				</section>
				<section class="card-dark overflow-hidden p-0">
					<div
						class="p-3 border-bottom border-secondary border-opacity-25 d-flex justify-content-between align-items-center">
						<div class="d-flex align-items-center gap-2">
							<span
								class="material-icons-round text-light bg-purple-soft p-1 rounded fs-6">help_outline</span>
							<h2 class="h6 fw-bold mb-0">새로 등록된 문의사항</h2>
						</div>
						<span
							class="text-decoration-none small text-primary d-flex align-items-center">
							<a href="${pageContext.request.contextPath}/admin/inqu" class="nav-sub-item">전체보기</a>
						</span>
					</div>
					<div class="table-responsive">
						<table class="table-dark-custom">
							<thead>
								<tr>
									<th style="min-width: 200px;">문의 제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>상태</th>
									<th class="text-end">유형</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="fw-medium text-light">로그인이 자꾸 풀립니다</span>
										</div>
									</td>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="avatar-initials bg-primary">KM</span> <span
												class="text-light text-opacity-75">kim_minsu</span>
										</div>
									</td>
									<td class="text-light">2023.10.25</td>
									<td><span class="status-badge status-yellow">답변 대기</span></td>
									<td class="text-end">
										<div
											class="d-flex align-items-center justify-content-end gap-1 text-light">
											<span class="small">비공개</span> <span
												class="material-icons-round" style="font-size: 14px;">lock</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="fw-medium text-light">결제 내역 확인 부탁드립니다</span>
										</div>
									</td>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="avatar-initials bg-info">LJ</span> <span
												class="text-light text-opacity-75">lee_jiwon</span>
										</div>
									</td>
									<td class="text-light">2023.10.24</td>
									<td><span class="status-badge status-blue">처리중</span></td>
									<td class="text-end">
										<div
											class="d-flex align-items-center justify-content-end gap-1 text-light">
											<span class="small">비공개</span> <span
												class="material-icons-round" style="font-size: 14px;">lock</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="ps-3 ms-1 fw-medium text-light">새로운 커뮤니티
												개설 요청</span>
										</div>
									</td>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="avatar-initials bg-success">PJ</span> <span
												class="text-light text-opacity-75">park_jun</span>
										</div>
									</td>
									<td class="text-light">2023.10.23</td>
									<td><span class="status-badge status-blue">처리중</span></td>
									<td class="text-end">
										<div
											class="d-flex align-items-center justify-content-end gap-1 text-primary">
											<span class="small">공개</span> <span
												class="material-icons-round" style="font-size: 14px;">public</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="ps-3 ms-1 fw-medium text-light">앱 다크모드
												설정이 안보여요</span>
										</div>
									</td>
									<td>
										<div class="d-flex align-items-center gap-2">
											<span class="avatar-initials bg-warning text-dark">CS</span>
											<span class="text-light text-opacity-75">choi_sora</span>
										</div>
									</td>
									<td class="text-light">2023.10.22</td>
									<td><span class="status-badge status-green">답변완료</span></td>
									<td class="text-end">
										<div
											class="d-flex align-items-center justify-content-end gap-1 text-primary">
											<span class="small">공개</span> <span
												class="material-icons-round" style="font-size: 14px;">public</span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div
						class="px-3 py-3 border-top border-secondary border-opacity-25 d-flex justify-content-between align-items-center text-light small">
						<span>1-4 of 24</span>
						<div class="d-flex gap-2">
							<button class="pagination-btn">
								<span class="material-icons-round fs-6">chevron_left</span>
							</button>
							<button class="pagination-btn">
								<span class="material-icons-round fs-6">chevron_right</span>
							</button>
						</div>
					</div>
				</section>
			</div>
		</main>
	</div>
	<script>
    // 서버 데이터를 JavaScript 변수로 전달
	    window.chartData = {
	        labels: [
	            <c:forEach var="stats" items="${weeklyStatsList}" varStatus="status">
	                '${stats.dayName}'<c:if test="${!status.last}">,</c:if>
	            </c:forEach>
	        ],
	        noticeCount: [
	            <c:forEach var="stats" items="${weeklyStatsList}" varStatus="status">
	                ${stats.noticeCount}<c:if test="${!status.last}">,</c:if>
	            </c:forEach>
	        ],
	        loginCount: [
	            <c:forEach var="stats" items="${weeklyStatsList}" varStatus="status">
	                ${stats.loginCount}<c:if test="${!status.last}">,</c:if>
	            </c:forEach>
	        ]
	    };
	</script>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/admin_main_chart.js"></script>
</body>
</html>