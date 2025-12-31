<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="head.jsp"%>
</head>
<body>

	<%@ include file="header.jsp"%>

	<div class="app-body">
	
		<%@ include file="sidebar.jsp"%>

		<main class="app-main">
			<div class="space-background">
				<div class="stars"></div>
				<div class="stars2"></div>
				<div class="stars3"></div>
				<div class="planet planet-1"></div>
				<div class="planet planet-2"></div>
			</div>
			<div class="feed-scroll-container custom-scrollbar">
				<div class="feed-wrapper d-flex flex-column gap-4">
					<div class="glass-panel p-3 shadow-lg">
						<div class="d-flex gap-3">
							<div class="avatar-lg text-white fw-bold flex-shrink-0"
								style="background: linear-gradient(to top right, #a855f7, #6366f1);">MK</div>
							<div class="flex-grow-1">
								<input class="create-input text-base"
									placeholder="Share your latest creation..." type="text" />
								<div
									class="d-flex justify-content-between align-items-center mt-2 pt-2 border-top border-secondary border-opacity-25">
									<div class="d-flex gap-2">
										<button class="btn-icon text-gray-400 hover-purple">
											<span class="material-symbols-outlined fs-5">image</span>
										</button>
										<button class="btn-icon text-gray-400 hover-blue">
											<span class="material-symbols-outlined fs-5">movie</span>
										</button>
										<button class="btn-icon text-gray-400 hover-orange">
											<span class="material-symbols-outlined fs-5">schema</span>
										</button>
									</div>
									<button class="action-btn-pill">Post</button>
								</div>
							</div>
						</div>
					</div>
					<div
						class="d-flex align-items-center gap-4 text-xs fw-medium text-gray-500 text-uppercase tracking-widest my-2">
						<div class="flex-grow-1"
							style="height: 1px; background: rgba(255, 255, 255, 0.1);"></div>
						<span>Latest Updates</span>
						<div class="flex-grow-1"
							style="height: 1px; background: rgba(255, 255, 255, 0.1);"></div>
					</div>
					<div class="glass-card shadow-lg group">
						<div
							class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
							<div class="d-flex align-items-center gap-3">
								<div class="avatar-md bg-warning text-white fw-bold">JS</div>
								<div>
									<h3 class="text-sm fw-medium text-white mb-0">Julia Smith</h3>
									<p class="text-xs text-gray-500 mb-0">2 hours ago</p>
								</div>
							</div>
							<button class="btn-icon">
								<span class="material-symbols-outlined">more_horiz</span>
							</button>
						</div>
						<div class="p-3">
							<p class="text-light text-sm mb-3 lh-base"
								style="color: #d1d5db;">Explored a new generative flow
								today. The combination of vector fields and particle systems
								created this amazing nebulae effect. 🌌✨</p>
							<div
								class="ratio ratio-16x9 w-100 rounded-3 overflow-hidden position-relative border border-white border-opacity-10">
								<div class="position-absolute w-100 h-100"
									style="background: linear-gradient(to bottom right, #312e81, #581c87, #000); opacity: 0.8;"></div>
								<div
									class="position-absolute w-100 h-100 d-flex align-items-center justify-content-center">
									<div class="rounded-circle"
										style="width: 8rem; height: 8rem; background: rgba(168, 85, 247, 0.3); filter: blur(40px);"></div>
									<div class="position-absolute rounded-circle"
										style="width: 6rem; height: 6rem; background: rgba(59, 130, 246, 0.2); filter: blur(30px); top: 25%; left: 25%;"></div>
								</div>
								<div
									class="position-absolute bottom-0 end-0 m-3 px-2 py-1 rounded text-xs font-monospace text-white-50 border border-white border-opacity-10"
									style="background: rgba(0, 0, 0, 0.6);">Generation #4291</div>
							</div>
						</div>
						<div
							class="px-3 py-2 d-flex align-items-center justify-content-between"
							style="background: rgba(255, 255, 255, 0.05);">
							<div class="d-flex gap-4">
								<button
									class="d-flex align-items-center gap-2 btn-icon text-xs ps-0">
									<span class="material-symbols-outlined fs-6">favorite</span> 24
								</button>
								<button class="d-flex align-items-center gap-2 btn-icon text-xs">
									<span class="material-symbols-outlined fs-6">chat_bubble</span>
									5
								</button>
							</div>
							<button
								class="d-flex align-items-center gap-1 btn-icon text-xs pe-0">
								<span class="material-symbols-outlined fs-6">share</span> Share
							</button>
						</div>
					</div>
					<div class="glass-card shadow-lg group">
						<div
							class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
							<div class="d-flex align-items-center gap-3">
								<div class="avatar-md bg-success text-white fw-bold"
									style="background-color: #0d9488 !important;">DT</div>
								<div>
									<h3 class="text-sm fw-medium text-white mb-0">David Torres</h3>
									<p class="text-xs text-gray-500 mb-0">5 hours ago</p>
								</div>
							</div>
							<button class="btn-icon">
								<span class="material-symbols-outlined">more_horiz</span>
							</button>
						</div>
						<div class="p-3">
							<p class="text-light text-sm mb-3 lh-base"
								style="color: #d1d5db;">Working on the UI components for the
								new design system. Trying to keep it clean and minimal while
								maintaining accessibility. Thoughts on this palette?</p>
							<div class="row g-2" style="height: 12rem;">
								<div class="col-6 h-100">
									<div
										class="h-100 rounded-3 border border-white border-opacity-10 p-2 position-relative overflow-hidden"
										style="background-color: #1e1e24;">
										<div class="position-absolute top-0 start-0 m-2 d-flex gap-1">
											<div class="rounded-circle bg-danger"
												style="width: 8px; height: 8px;"></div>
											<div class="rounded-circle bg-warning"
												style="width: 8px; height: 8px;"></div>
											<div class="rounded-circle bg-success"
												style="width: 8px; height: 8px;"></div>
										</div>
										<div class="mt-4 d-flex flex-column gap-2">
											<div class="rounded"
												style="height: 8px; width: 75%; background: rgba(255, 255, 255, 0.1);"></div>
											<div class="rounded"
												style="height: 8px; width: 50%; background: rgba(255, 255, 255, 0.1);"></div>
											<div
												class="rounded border border-white border-opacity-10 border-dashed d-flex align-items-center justify-content-center text-xs text-muted"
												style="height: 64px; margin-top: 0.5rem; background: rgba(255, 255, 255, 0.05);">Component
												A</div>
										</div>
									</div>
								</div>
								<div class="col-6 h-100">
									<div
										class="h-100 rounded-3 border border-white border-opacity-10 p-2 position-relative overflow-hidden"
										style="background-color: #1e1e24;">
										<div
											class="d-flex justify-content-between align-items-center mb-3">
											<div class="rounded"
												style="height: 8px; width: 33%; background: rgba(255, 255, 255, 0.2);"></div>
											<div class="rounded-circle bg-primary opacity-50"
												style="width: 16px; height: 16px;"></div>
										</div>
										<div class="d-flex flex-column gap-2">
											<div class="d-flex gap-2">
												<div class="rounded"
													style="width: 32px; height: 32px; background: rgba(255, 255, 255, 0.1);"></div>
												<div class="flex-grow-1 d-flex flex-column gap-1">
													<div class="rounded"
														style="height: 8px; width: 100%; background: rgba(255, 255, 255, 0.1);"></div>
													<div class="rounded"
														style="height: 8px; width: 66%; background: rgba(255, 255, 255, 0.1);"></div>
												</div>
											</div>
											<div class="d-flex gap-2 mt-1">
												<div class="rounded"
													style="width: 32px; height: 32px; background: rgba(255, 255, 255, 0.1);"></div>
												<div class="flex-grow-1 d-flex flex-column gap-1">
													<div class="rounded"
														style="height: 8px; width: 100%; background: rgba(255, 255, 255, 0.1);"></div>
													<div class="rounded"
														style="height: 8px; width: 66%; background: rgba(255, 255, 255, 0.1);"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div
							class="px-3 py-2 d-flex align-items-center justify-content-between"
							style="background: rgba(255, 255, 255, 0.05);">
							<div class="d-flex gap-4">
								<button
									class="d-flex align-items-center gap-2 btn-icon text-xs ps-0">
									<span class="material-symbols-outlined fs-6">favorite</span> 86
								</button>
								<button class="d-flex align-items-center gap-2 btn-icon text-xs">
									<span class="material-symbols-outlined fs-6">chat_bubble</span>
									12
								</button>
							</div>
							<button
								class="d-flex align-items-center gap-1 btn-icon text-xs pe-0">
								<span class="material-symbols-outlined fs-6">share</span> Share
							</button>
						</div>
					</div>
					<div class="glass-card shadow-lg group">
						<div
							class="p-3 d-flex align-items-center justify-content-between border-bottom border-white border-opacity-10">
							<div class="d-flex align-items-center gap-3">
								<div class="avatar-md bg-primary text-white fw-bold"
									style="background-color: #4f46e5 !important;">AL</div>
								<div>
									<h3 class="text-sm fw-medium text-white mb-0">Ada Lovelace</h3>
									<p class="text-xs text-gray-500 mb-0">Yesterday</p>
								</div>
							</div>
							<button class="btn-icon">
								<span class="material-symbols-outlined">more_horiz</span>
							</button>
						</div>
						<div class="p-3">
							<p class="text-light text-sm mb-3 lh-base"
								style="color: #d1d5db;">Just released a new plugin for
								handling complex shader nodes. Check it out in the marketplace!
								It simplifies the workflow by 10x. 🚀</p>
							<div
								class="rounded-3 p-3 border border-white border-opacity-10 d-flex align-items-center gap-3 cursor-pointer"
								style="background: linear-gradient(to right, #111827, #1f2937);">
								<div
									class="rounded-3 d-flex align-items-center justify-content-center border border-opacity-25"
									style="width: 48px; height: 48px; background: rgba(168, 85, 247, 0.2); border-color: #a855f7; color: #c084fc;">
									<span class="material-symbols-outlined fs-3">extension</span>
								</div>
								<div class="flex-grow-1">
									<h4 class="text-white fw-medium text-sm mb-0">Shader Node
										Master</h4>
									<p class="text-gray-400 text-xs mb-0">Version 2.0 • Updated
										yesterday</p>
								</div>
								<button
									class="btn btn-sm text-white text-xs fw-medium rounded-pill"
									style="background: rgba(255, 255, 255, 0.1);">Install</button>
							</div>
						</div>
						<div
							class="px-3 py-2 d-flex align-items-center justify-content-between"
							style="background: rgba(255, 255, 255, 0.05);">
							<div class="d-flex gap-4">
								<button
									class="d-flex align-items-center gap-2 btn-icon text-xs ps-0">
									<span class="material-symbols-outlined fs-6">favorite</span>
									142
								</button>
								<button class="d-flex align-items-center gap-2 btn-icon text-xs">
									<span class="material-symbols-outlined fs-6">chat_bubble</span>
									34
								</button>
							</div>
							<button
								class="d-flex align-items-center gap-1 btn-icon text-xs pe-0">
								<span class="material-symbols-outlined fs-6">share</span> Share
							</button>
						</div>
					</div>
					<div class="text-center py-4">
						<span class="text-secondary small">You've reached the end
							of the feed</span>
					</div>
				</div>
			</div>
			<div class="position-absolute bottom-0 end-0 m-4 z-3">
				<button
					class="d-flex align-items-center gap-2 rounded-pill px-3 py-2 shadow-lg border border-white border-opacity-10"
					style="background: rgba(39, 39, 42, 0.8); backdrop-filter: blur(12px);">
					<div class="d-flex flex-column align-items-start lh-1 me-2">
						<span class="text-uppercase text-muted fw-semibold"
							style="font-size: 10px; letter-spacing: 0.05em;">Tasks</span> <span
							class="text-sm fw-medium text-white-50">0 active</span>
					</div>
					<div
						style="width: 1px; height: 24px; background: rgba(255, 255, 255, 0.1);"></div>
					<div
						class="rounded-circle d-flex align-items-center justify-content-center text-muted ms-1"
						style="width: 24px; height: 24px;">
						<span class="material-symbols-outlined fs-5">chevron_right</span>
					</div>
				</button>
			</div>
			<div
				class="position-absolute bottom-0 start-0 m-4 z-3 d-none d-md-flex align-items-center gap-2 px-3 py-1 rounded-3 border border-white border-opacity-10 text-muted font-monospace text-xs"
				style="background: rgba(39, 39, 42, 0.8); backdrop-filter: blur(12px);">
				<span class="material-symbols-outlined" style="font-size: 14px;">grid_4x4</span>
				<span>492</span>
			</div>
		</main>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/stars.js"></script>
</body>
</html>