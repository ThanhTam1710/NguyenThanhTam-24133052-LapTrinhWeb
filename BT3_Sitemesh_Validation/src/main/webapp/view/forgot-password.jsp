<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5 col-xl-4">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 p-sm-4 bg-white">
                <!-- Header Card -->
                <div class="text-center mb-3">
                    <div class="d-inline-flex align-items-center justify-content-center bg-danger-subtle text-danger rounded-4 mb-2" style="width: 56px; height: 56px;">
                        <i class="bi bi-shield-exclamation fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Khôi Phục Mật Khẩu</h3>
                    <p class="text-muted small mb-0">Nhập email hoặc tên đăng nhập để nhận mã OTP</p>
                </div>

                <!-- Thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger d-flex align-items-center small py-2 px-3 rounded-3 mb-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                        <div>${error}</div>
                    </div>
                </c:if>

                <!-- FORM QUÊN MẬT KHẨU CÓ BOOTSTRAP 5 VALIDATION -->
                <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="identifier" class="form-label fw-semibold small text-secondary">
                            Email hoặc Tên đăng nhập <span class="text-danger">*</span>
                        </label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-envelope"></i></span>
                            <input type="text" id="identifier" name="identifier" class="form-control border-start-0 ps-1" 
                                   value="${not empty param.identifier ? param.identifier : ''}"
                                   placeholder="Nhập email hoặc tên đăng nhập" required minlength="3" maxlength="100" autofocus>
                            <div class="invalid-feedback">
                                Vui lòng nhập email hoặc tên đăng nhập để khôi phục mật khẩu.
                            </div>
                        </div>
                        <div class="form-text text-muted small mt-1">
                            Hệ thống sẽ gửi mã xác thực OTP 6 số đến email tài khoản.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-danger w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                        <i class="bi bi-send me-1"></i> Gửi Mã OTP Xác Nhận
                    </button>
                </form>

                <div class="text-center small text-muted">
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none text-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại Đăng nhập
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
