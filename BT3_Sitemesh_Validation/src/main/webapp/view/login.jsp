<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập Hệ Thống</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5 col-xl-4">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 p-sm-4 bg-white">
                <!-- Header Card -->
                <div class="text-center mb-3">
                    <div class="d-inline-flex align-items-center justify-content-center bg-primary-subtle text-primary rounded-4 mb-2" style="width: 56px; height: 56px;">
                        <i class="bi bi-shield-lock-fill fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Đăng Nhập</h3>
                    <p class="text-muted small mb-0">Hệ thống Fashion Showcase - Bài Tập 03</p>
                </div>

                <!-- Thông báo trạng thái -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success d-flex align-items-center small py-2 px-3 rounded-3 mb-3" role="alert">
                        <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                        <div>${message}</div>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger d-flex align-items-center small py-2 px-3 rounded-3 mb-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                        <div>${error}</div>
                    </div>
                </c:if>

                <c:if test="${not empty warning}">
                    <div class="alert alert-warning d-flex align-items-center small py-2 px-3 rounded-3 mb-3" role="alert">
                        <i class="bi bi-exclamation-circle-fill me-2 fs-5"></i>
                        <div>${warning}</div>
                    </div>
                </c:if>

                <!-- FORM ĐĂNG NHẬP CÓ BOOTSTRAP 5 VALIDATION -->
                <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate id="loginForm">
                    <!-- Tên đăng nhập -->
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold small text-secondary">Tên đăng nhập hoặc Email <span class="text-danger">*</span></label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-person"></i></span>
                            <input type="text" id="username" name="username" class="form-control border-start-0 ps-1" 
                                   value="${not empty param.username ? param.username : ''}"
                                   placeholder="Nhập username hoặc email" required minlength="3" maxlength="50" autocomplete="username">
                            <div class="invalid-feedback">
                                Vui lòng nhập tên đăng nhập hoặc email hợp lệ (từ 3 đến 50 ký tự).
                            </div>
                        </div>
                    </div>

                    <!-- Mật khẩu -->
                    <div class="mb-3">
                        <label for="password" class="form-label fw-semibold small text-secondary">Mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-key"></i></span>
                            <input type="password" id="password" name="password" class="form-control border-start-0 border-end-0 ps-1" 
                                   placeholder="Nhập mật khẩu" required minlength="3" maxlength="50" autocomplete="current-password">
                            <button type="button" class="btn btn-outline-secondary border-start-0" id="btnTogglePassword" onclick="togglePasswordVisibility()">
                                <i class="bi bi-eye" id="eyeIcon"></i>
                            </button>
                            <div class="invalid-feedback">
                                Mật khẩu không được để trống (tối thiểu 3 ký tự).
                            </div>
                        </div>
                    </div>

                    <!-- Ghi nhớ & Quên mật khẩu -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="remember" id="remember">
                            <label class="form-check-label small text-muted" for="remember">
                                Ghi nhớ đăng nhập
                            </label>
                        </div>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="text-primary text-decoration-none small fw-semibold">
                            Quên mật khẩu?
                        </a>
                    </div>

                    <!-- Nút Submit -->
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Nhập
                    </button>
                </form>

                <!-- Panel điền nhanh tài khoản kiểm thử -->
                <div class="p-3 bg-light rounded-3 border mb-3">
                    <div class="small fw-bold text-secondary mb-2 d-flex align-items-center">
                        <i class="bi bi-lightning-charge-fill text-warning me-1"></i> Tài khoản kiểm thử nhanh:
                    </div>
                    <div class="d-flex flex-wrap gap-1">
                        <button type="button" class="btn btn-sm btn-outline-primary py-1 px-2" onclick="fillAccount('syber096', 'thanhtam123')">
                            <b>syber096</b> (Admin)
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-secondary py-1 px-2" onclick="fillAccount('thanhtam', '123')">
                            <b>thanhtam</b> (User)
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-dark py-1 px-2" onclick="fillAccount('admin', '123')">
                            <b>admin</b> (Dự phòng)
                        </button>
                    </div>
                </div>

                <!-- Footer liên kết đăng ký -->
                <div class="text-center small text-muted">
                    Chưa có tài khoản? 
                    <a href="${pageContext.request.contextPath}/register" class="text-primary fw-bold text-decoration-none">Đăng ký ngay</a>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    function togglePasswordVisibility() {
        const pass = document.getElementById("password");
        const icon = document.getElementById("eyeIcon");
        if (pass.type === "password") {
            pass.type = "text";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        } else {
            pass.type = "password";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        }
    }

    function fillAccount(u, p) {
        document.getElementById("username").value = u;
        document.getElementById("password").value = p;
        document.getElementById("loginForm").classList.remove("was-validated");
    }
</script>

</body>
</html>
