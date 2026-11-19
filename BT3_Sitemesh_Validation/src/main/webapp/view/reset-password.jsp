<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5 col-xl-4">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 p-sm-4 bg-white">
                <div class="text-center mb-3">
                    <div class="d-inline-flex align-items-center justify-content-center bg-success-subtle text-success rounded-4 mb-2" style="width: 56px; height: 56px;">
                        <i class="bi bi-key-fill fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Mật Khẩu Mới</h3>
                    <p class="text-muted small mb-0">Thiết lập mật khẩu bảo mật mới cho tài khoản</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger small py-2 px-3 rounded-3 mb-3">${error}</div>
                </c:if>

                <!-- FORM ĐẶT LẠI MẬT KHẨU CÓ VALIDATION -->
                <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label fw-semibold small text-secondary">
                            Mật khẩu mới <span class="text-danger">*</span>
                        </label>
                        <input type="password" id="newPassword" name="newPassword" class="form-control" 
                               placeholder="Tối thiểu 6 ký tự" required minlength="6" maxlength="50" oninput="checkMatch()">
                        <div class="invalid-feedback">
                            Mật khẩu mới phải có tối thiểu 6 ký tự.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="confirmNewPassword" class="form-label fw-semibold small text-secondary">
                            Xác nhận mật khẩu mới <span class="text-danger">*</span>
                        </label>
                        <input type="password" id="confirmNewPassword" name="confirmNewPassword" class="form-control" 
                               placeholder="Nhập lại mật khẩu mới" required minlength="6" maxlength="50" oninput="checkMatch()">
                        <div class="invalid-feedback" id="feedbackMatch">
                            Vui lòng nhập lại mật khẩu mới.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                        <i class="bi bi-check-lg me-1"></i> Lưu Mật Khẩu Mới
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

<script>
    function checkMatch() {
        const p = document.getElementById("newPassword").value;
        const c = document.getElementById("confirmNewPassword");
        const fb = document.getElementById("feedbackMatch");
        if (c.value.length > 0 && p !== c.value) {
            c.setCustomValidity("Không khớp!");
            fb.textContent = "Mật khẩu xác nhận không khớp!";
        } else {
            c.setCustomValidity("");
            fb.textContent = "Vui lòng nhập lại mật khẩu mới.";
        }
    }
</script>

</body>
</html>
