<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6 col-xl-5">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 p-sm-4 bg-white">
                <!-- Header Card -->
                <div class="text-center mb-3">
                    <div class="d-inline-flex align-items-center justify-content-center bg-primary-subtle text-primary rounded-4 mb-2" style="width: 56px; height: 56px;">
                        <i class="bi bi-person-plus-fill fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Đăng Ký Tài Khoản</h3>
                    <p class="text-muted small mb-0">Hệ thống kích hoạt bảo mật qua mã OTP Email</p>
                </div>

                <!-- Thông báo lỗi nếu có từ server -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger d-flex align-items-center small py-2 px-3 rounded-3 mb-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                        <div>${error}</div>
                    </div>
                </c:if>

                <!-- FORM ĐĂNG KÝ VỚI BOOTSTRAP 5 VALIDATION -->
                <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate id="registerForm">
                    
                    <!-- Username -->
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold small text-secondary">
                            Tên đăng nhập <span class="text-danger">*</span>
                        </label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-person"></i></span>
                            <input type="text" id="username" name="username" class="form-control border-start-0 ps-1" 
                                   value="${not empty param.username ? param.username : ''}"
                                   placeholder="Nhập tên đăng nhập (3-20 ký tự)" required minlength="3" maxlength="20" pattern="^[a-zA-Z0-9_]+$" autofocus>
                            <div class="invalid-feedback">
                                Tên đăng nhập từ 3 đến 20 ký tự (chỉ bao gồm chữ, số và dấu gạch dưới).
                            </div>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold small text-secondary">
                            Địa chỉ Email <span class="text-danger">*</span>
                        </label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-envelope"></i></span>
                            <input type="email" id="email" name="email" class="form-control border-start-0 ps-1" 
                                   value="${not empty param.email ? param.email : ''}"
                                   placeholder="example@gmail.com" required maxlength="100">
                            <div class="invalid-feedback">
                                Vui lòng nhập địa chỉ email hợp lệ (ví dụ: thanhtam@gmail.com).
                            </div>
                        </div>
                        <div class="form-text text-muted small">Mã kích hoạt OTP sẽ được gửi về hộp thư này.</div>
                    </div>

                    <!-- Họ và tên + Số điện thoại -->
                    <div class="row g-2 mb-3">
                        <div class="col-sm-6">
                            <label for="fullname" class="form-label fw-semibold small text-secondary">Họ và tên</label>
                            <input type="text" id="fullname" name="fullname" class="form-control" 
                                   value="${not empty param.fullname ? param.fullname : ''}"
                                   placeholder="Nguyễn Thanh Tâm" maxlength="100">
                        </div>
                        <div class="col-sm-6">
                            <label for="phone" class="form-label fw-semibold small text-secondary">Số điện thoại</label>
                            <input type="tel" id="phone" name="phone" class="form-control" 
                                   value="${not empty param.phone ? param.phone : ''}"
                                   placeholder="0987654321" pattern="^0[0-9]{9}$" maxlength="11">
                            <div class="invalid-feedback">
                                Số điện thoại gồm 10 số (bắt đầu bằng số 0).
                            </div>
                        </div>
                    </div>

                    <!-- Mật khẩu & Nhập lại mật khẩu -->
                    <div class="row g-2 mb-3">
                        <div class="col-sm-6">
                            <label for="password" class="form-label fw-semibold small text-secondary">
                                Mật khẩu <span class="text-danger">*</span>
                            </label>
                            <input type="password" id="password" name="password" class="form-control" 
                                   placeholder="Tối thiểu 6 ký tự" required minlength="6" maxlength="50" oninput="checkPasswordMatch()">
                            <div class="invalid-feedback">
                                Mật khẩu phải có ít nhất 6 ký tự.
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <label for="confirmPassword" class="form-label fw-semibold small text-secondary">
                                Xác nhận mật khẩu <span class="text-danger">*</span>
                            </label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                                   placeholder="Nhập lại mật khẩu" required minlength="6" maxlength="50" oninput="checkPasswordMatch()">
                            <div class="invalid-feedback" id="confirmPasswordFeedback">
                                Vui lòng xác nhận lại mật khẩu.
                            </div>
                        </div>
                    </div>

                    <!-- Checkbox điều khoản -->
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="termsCheck" required checked>
                        <label class="form-check-label small text-muted" for="termsCheck">
                            Tôi đồng ý với các quy định bảo mật & điều khoản sử dụng hệ thống.
                        </label>
                        <div class="invalid-feedback">
                            Bạn cần đồng ý với điều khoản để tiếp tục.
                        </div>
                    </div>

                    <!-- Nút bấm Đăng ký -->
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                        <i class="bi bi-envelope-check me-1"></i> Đăng Ký & Nhận Mã OTP
                    </button>
                </form>

                <!-- Footer chuyển sang Đăng nhập -->
                <div class="text-center small text-muted">
                    Đã có tài khoản? 
                    <a href="${pageContext.request.contextPath}/login" class="text-primary fw-bold text-decoration-none">Đăng nhập ngay</a>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    function checkPasswordMatch() {
        const pass = document.getElementById("password").value;
        const confirm = document.getElementById("confirmPassword");
        const feedback = document.getElementById("confirmPasswordFeedback");
        
        if (confirm.value.length > 0 && pass !== confirm.value) {
            confirm.setCustomValidity("Mật khẩu xác nhận không khớp!");
            feedback.textContent = "Mật khẩu xác nhận không khớp với mật khẩu đã nhập!";
        } else {
            confirm.setCustomValidity("");
            feedback.textContent = "Vui lòng xác nhận lại mật khẩu.";
        }
    }
</script>

</body>
</html>
