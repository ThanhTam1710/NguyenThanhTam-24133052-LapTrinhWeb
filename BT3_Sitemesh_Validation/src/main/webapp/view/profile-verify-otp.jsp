<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP Cập Nhật Hồ Sơ</title>
</head>
<body>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">

            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <!-- Header Icon -->
                <div class="text-center mb-3">
                    <div class="d-inline-flex align-items-center justify-content-center bg-warning-subtle text-warning rounded-4 mb-2" style="width: 58px; height: 58px;">
                        <i class="bi bi-shield-lock-fill fs-2"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-1">Xác Thực OTP Cập Nhật Hồ Sơ</h4>
                    <p class="text-muted small mb-0">Hệ thống yêu cầu mã OTP để bảo mật và xác nhận các thay đổi tài khoản</p>
                </div>

                <!-- Bảng tóm tắt các thông tin cập nhật -->
                <div class="card border bg-light rounded-3 p-3 mb-3 small">
                    <div class="fw-bold text-secondary mb-2 d-flex align-items-center">
                        <i class="bi bi-person-lines-fill me-1 text-primary"></i> Thông tin cập nhật:
                    </div>
                    <div class="row g-2">
                        <div class="col-sm-6">
                            <span class="text-muted">Họ và tên:</span> <b class="text-dark">${pendingUser.fullName}</b>
                        </div>
                        <div class="col-sm-6">
                            <span class="text-muted">Số điện thoại:</span> <b class="text-dark">${pendingUser.phone}</b>
                        </div>
                        <div class="col-12">
                            <span class="text-muted">Email tài khoản:</span> <b class="text-primary">${pendingUser.email}</b>
                        </div>
                        <c:if test="${not empty pendingUser.avatar}">
                            <div class="col-12 d-flex align-items-center gap-2 mt-1">
                                <span class="text-muted">Ảnh đại diện mới:</span>
                                <img src="${pendingUser.avatar.startsWith('http') ? pendingUser.avatar : pageContext.request.contextPath.concat('/media?fname=').concat(pendingUser.avatar)}"
                                     class="rounded-circle border" style="width: 28px; height: 28px; object-fit: cover;" alt="Avatar">
                                <small class="text-success fw-semibold"><i class="bi bi-check2"></i> Đã tải lên</small>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Hộp thông báo email nhận mã OTP -->
                <div class="alert alert-info py-2 px-3 rounded-3 small mb-3">
                    <i class="bi bi-envelope-paper-heart me-1"></i> Mã OTP 6 chữ số đã được gửi đến hộp thư: <br>
                    <strong class="text-primary fs-6">${targetEmail}</strong>
                </div>

                <!-- Thông báo thành công (Gửi lại mã) -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success py-2 px-3 rounded-3 small mb-3 d-flex align-items-center">
                        <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                        <div>${message}</div>
                    </div>
                </c:if>

                <!-- Thông báo lỗi nếu có -->
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger py-2 px-3 rounded-3 small mb-3 d-flex align-items-center">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                        <div>${errorMsg}</div>
                    </div>
                </c:if>

                <!-- FORM NHẬP MÃ OTP CÓ BOOTSTRAP 5 VALIDATION -->
                <form action="${pageContext.request.contextPath}/profile/verify-otp" method="post" class="needs-validation" novalidate>
                    <div class="mb-3 text-center">
                        <label for="otp" class="form-label fw-semibold small text-secondary">
                            Nhập mã OTP 6 chữ số xác nhận <span class="text-danger">*</span>
                        </label>
                        <input type="text" id="otp" name="otp" class="form-control form-control-lg text-center fw-bold letter-spacing"
                               style="letter-spacing: 6px; font-size: 24px;"
                               placeholder="------" maxlength="6" pattern="^[0-9]{6}$" required autofocus>
                        <div class="invalid-feedback text-center">
                            Vui lòng nhập đúng 6 chữ số mã OTP.
                        </div>
                        <div class="form-text text-muted small mt-2">
                            Mã có hiệu lực trong vòng <b>5 phút</b>. Vui lòng kiểm tra Hộp thư đến hoặc thư mục Spam.
                        </div>
                    </div>

                    <!-- Nút xác nhận -->
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-2">
                        <i class="bi bi-check2-circle me-1"></i> Xác Nhận OTP & Lưu Hồ Sơ
                    </button>

                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-secondary w-100 py-2 fw-semibold rounded-3">
                        <i class="bi bi-arrow-left me-1"></i> Hủy Bỏ Cập Nhật
                    </a>
                </form>

                <!-- Gửi lại mã OTP (Resend OTP tương tự bài tập 2) -->
                <div class="text-center mt-3 pt-3 border-top">
                    <c:choose>
                        <c:when test="${blockResend eq true or sessionScope.profile_otp_resend_count >= 3}">
                            <div class="text-danger small fw-semibold">
                                <i class="bi bi-exclamation-octagon me-1"></i>Bạn đã yêu cầu gửi lại OTP quá 3 lần! Vui lòng kiểm tra kỹ email (bao gồm mục Spam).
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted small">Chưa nhận được mã? </span>
                            <a id="resendBtn" class="text-decoration-none text-primary fw-semibold small"
                               href="${pageContext.request.contextPath}/profile/verify-otp?action=resend">
                                <i class="bi bi-arrow-repeat me-1"></i>Gửi lại mã OTP
                            </a>
                            <span id="countdownText" class="text-danger small fw-bold" style="display: none;"></span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    (function() {
        var resendBtn = document.getElementById('resendBtn');
        var countdownText = document.getElementById('countdownText');
        if (!resendBtn) return;

        var storageKey = 'profile_otp_resend_cooldown';
        var cooldownSec = 30;

        function updateCountdown() {
            var expireAt = parseInt(sessionStorage.getItem(storageKey) || '0', 10);
            var now = Date.now();
            var remaining = Math.ceil((expireAt - now) / 1000);

            if (remaining > 0) {
                resendBtn.style.display = 'none';
                countdownText.style.display = 'inline';
                countdownText.innerText = 'Gửi lại mã sau (' + remaining + 's)';
                setTimeout(updateCountdown, 1000);
            } else {
                resendBtn.style.display = 'inline';
                countdownText.style.display = 'none';
                sessionStorage.removeItem(storageKey);
            }
        }

        <c:if test="${not empty startCooldown or not empty message}">
            sessionStorage.setItem(storageKey, Date.now() + cooldownSec * 1000);
        </c:if>

        resendBtn.addEventListener('click', function(e) {
            var expireAt = parseInt(sessionStorage.getItem(storageKey) || '0', 10);
            if (expireAt > Date.now()) {
                e.preventDefault();
                return false;
            }
            sessionStorage.setItem(storageKey, Date.now() + cooldownSec * 1000);
            resendBtn.style.pointerEvents = 'none';
            resendBtn.innerText = 'Đang gửi mã...';
        });

        updateCountdown();
    })();
</script>
            </div>

        </div>
    </div>
</div>

</body>
</html>
