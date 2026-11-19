<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực Mã OTP</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5 col-xl-4">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 p-sm-4 bg-white text-center">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary-subtle text-primary rounded-4 mb-2 mx-auto" style="width: 56px; height: 56px;">
                    <i class="bi bi-shield-check fs-3"></i>
                </div>
                <h3 class="fw-bold text-dark mb-1">Xác Thực Mã OTP</h3>
                <p class="text-muted small mb-3">Mã gồm 6 chữ số đã được gửi đến email của bạn</p>

                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success small py-2 px-3 rounded-3 text-start mb-3">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger small py-2 px-3 rounded-3 text-start mb-3">${error}</div>
                </c:if>

                <!-- FORM XÁC THỰC OTP -->
                <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="needs-validation" novalidate>
                    <div class="mb-3 text-start">
                        <label for="otp" class="form-label fw-semibold small text-secondary">
                            Nhập mã OTP 6 số <span class="text-danger">*</span>
                        </label>
                        <input type="text" id="otp" name="otp" class="form-control text-center fw-bold fs-4 tracking-widest" 
                               placeholder="------" required pattern="^[0-9]{6}$" maxlength="6" autofocus autocomplete="one-time-code">
                        <div class="invalid-feedback text-center">
                            Vui lòng nhập đúng mã OTP gồm 6 chữ số.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                        <i class="bi bi-check2-circle me-1"></i> Xác Nhận Kích Hoạt
                    </button>
                </form>

                <div class="d-flex justify-content-between align-items-center small text-muted pt-2 border-top">
                    <a href="${pageContext.request.contextPath}/verify-otp?action=resend" class="text-decoration-none text-primary fw-semibold">
                        <i class="bi bi-arrow-repeat me-1"></i> Gửi lại mã OTP
                    </a>
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none text-secondary">
                        Đăng nhập
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
