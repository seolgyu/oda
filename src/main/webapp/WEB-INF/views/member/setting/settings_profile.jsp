<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="glass-card p-4 shadow-lg">
	<div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
		<h2 class="text-white fs-4 fw-bold mb-1">Profile Interface</h2>
		<p class="text-secondary text-sm mb-0">Manage how your profile
			looks to other stargazers.</p>
	</div>

	<div class="d-flex flex-column gap-4">
		<div class="d-flex align-items-center gap-4">
			<div
				class="rounded-4 shadow-lg d-flex align-items-center justify-content-center text-white fw-bold fs-2"
				style="width: 100px; height: 100px; background: linear-gradient(135deg, #6366f1, #a855f7);">
				${fn:substring(user.userName, 0, 1)}</div>
			<div>
				<button class="btn btn-sm btn-outline-light rounded-pill px-3 mb-2">Change
					Photo</button>
				<p class="text-xs text-gray-500 mb-0">JPG, GIF or PNG. Max size
					of 800K</p>
			</div>
		</div>

		<div class="row g-3">
			<div class="col-md-6">
				<label class="text-white text-xs fw-bold mb-2 d-block">Display
					Name</label> <input type="text" class="form-control login-input"
					value="${user.userNickname}">
			</div>
			<div class="col-md-6">
				<label class="text-white text-xs fw-bold mb-2 d-block">Location</label>
				<input type="text" class="form-control login-input"
					placeholder="Earth">
			</div>
			<div class="col-12">
				<label class="text-white text-xs fw-bold mb-2 d-block">Bio</label>
				<textarea class="form-control login-input" rows="3"
					placeholder="Tell us about yourself..."></textarea>
			</div>
		</div>

		<div class="d-flex justify-content-end pt-3">
			<button class="btn btn-primary rounded-pill px-5 fw-bold"
				style="background: #2563eb; border: none;">Save Changes</button>
		</div>
	</div>
</div>