<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="glass-card p-4 shadow-lg">
    <div class="mb-4 border-bottom border-white border-opacity-10 pb-3">
        <h2 class="text-white fs-4 fw-bold mb-1">Account Information</h2>
        <p class="text-secondary text-sm mb-0">Update your account credentials and personal information.</p>
    </div>

    <div class="d-flex flex-column gap-5">
        <section>
            <h3 class="text-white text-xs fw-bold text-uppercase tracking-widest mb-3 opacity-75">Basic Info</h3>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="text-white text-xs fw-bold mb-2 d-block opacity-50">User ID (Permanent)</label>
                    <input type="text" class="form-control login-input opacity-50" value="${user.userId}" readonly style="cursor: not-allowed;">
                </div>
                <div class="col-md-6">
                    <label class="text-white text-xs fw-bold mb-2 d-block">Full Name</label>
                    <input type="text" class="form-control login-input" value="${user.userName}">
                </div>
                <div class="col-md-6">
                    <label class="text-white text-xs fw-bold mb-2 d-block">Email Address</label>
                    <input type="email" class="form-control login-input" value="${user.email}">
                </div>
                <div class="col-md-6">
                    <label class="text-white text-xs fw-bold mb-2 d-block">Phone Number</label>
                    <input type="tel" class="form-control login-input" value="${user.tel}" placeholder="010-0000-0000">
                </div>
            </div>
        </section>

        <section class="pt-2">
            <h3 class="text-white text-xs fw-bold text-uppercase tracking-widest mb-3 opacity-75 text-warning">Security Settings</h3>
            <div class="row g-3">
                <div class="col-12">
                    <label class="text-white text-xs fw-bold mb-2 d-block">Current Password</label>
                    <input type="password" class="form-control login-input" placeholder="Confirm your current password">
                </div>
                <div class="col-md-6">
                    <label class="text-white text-xs fw-bold mb-2 d-block">New Password</label>
                    <input type="password" class="form-control login-input" placeholder="At least 8 characters">
                </div>
                <div class="col-md-6">
                    <label class="text-white text-xs fw-bold mb-2 d-block">Confirm New Password</label>
                    <input type="password" class="form-control login-input" placeholder="Re-type new password">
                </div>
            </div>
        </section>

        <div class="d-flex justify-content-between align-items-center pt-3 border-top border-white border-opacity-10">
            <p class="text-xs text-secondary mb-0">Last updated: 2 hours ago</p>
            <button class="btn btn-primary rounded-pill px-5 fw-bold" style="background: #2563eb; border: none;">
                Update Account
            </button>
        </div>
    </div>
</div>