<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - Nguyễn Thanh Tâm</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --bg-gradient: linear-gradient(135deg, #f0f4f8 0%, #d9e2ec 100%);
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
            background: var(--bg-gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
            color: var(--text-main);
        }
        .card-wrapper {
            width: 100%;
            max-width: 420px;
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08);
            padding: 36px 32px;
            border: 1px solid var(--border-color);
        }
        .brand-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .brand-icon {
            width: 48px;
            height: 48px;
            background: #eff6ff;
            color: var(--primary);
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 10px;
        }
        h2 { font-size: 22px; font-weight: 700; letter-spacing: -0.5px; }
        .student-info { font-size: 13px; color: var(--text-muted); margin-top: 4px; }
        .alert {
            padding: 12px 14px;
            border-radius: 8px;
            font-size: 13.5px;
            margin-bottom: 18px;
            line-height: 1.4;
        }
        .alert-success { background: #f0fdf4; color: #166534; border: 1px solid #bbf7d0; }
        .alert-danger { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }
        .alert-warning { background: #fffbeb; color: #92400e; border: 1px solid #fde68a; }
        .form-group { margin-bottom: 16px; }
        label {
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            margin-bottom: 6px;
            color: #334155;
        }
        input {
            width: 100%;
            padding: 11px 14px;
            font-size: 14px;
            border: 1.5px solid var(--border-color);
            border-radius: 8px;
            background: #f8fafc;
            color: var(--text-main);
            transition: all 0.2s ease;
        }
        input:focus {
            outline: none;
            border-color: var(--primary);
            background: #ffffff;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }
        input.otp-input {
            font-size: 22px;
            font-weight: 700;
            letter-spacing: 8px;
            text-align: center;
            border-color: #dc2626;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: var(--primary);
            color: #ffffff;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 6px;
            transition: background 0.2s ease;
        }
        .btn-submit:hover { background: var(--primary-hover); }
        .links-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 18px;
            font-size: 13px;
        }
        .resend-link {
            color: #ef4444;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
        }
        .resend-link:hover { text-decoration: underline; }
        .resend-link.disabled {
            color: #94a3b8;
            cursor: not-allowed;
            pointer-events: none;
            text-decoration: none;
        }
        .countdown-badge {
            color: #ef4444;
            font-weight: 700;
        }
        .back-link {
            color: var(--primary);
            text-decoration: none;
        }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="card-wrapper">
    <div class="brand-header">
        <div class="brand-icon">🔄</div>
        <h2>Đặt Lại Mật Khẩu</h2>
        <div class="student-info">Sinh viên: <b>Nguyễn Thanh Tâm</b> | MSSV: <b>24133052</b></div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty warning}">
        <div class="alert alert-warning">${warning}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="username" value="${sessionScope.reset_username}">

        <div class="form-group">
            <label for="otp">Mã xác nhận OTP (6 chữ số)</label>
            <input type="text" id="otp" name="otp" class="otp-input" maxlength="6" placeholder="------" required autofocus>
        </div>

        <div class="form-group">
            <label for="newPassword">Mật khẩu mới (tối thiểu 6 ký tự)</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Xác nhận mật khẩu</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
        </div>

        <button type="submit" class="btn-submit">Xác Nhận Đổi Mật Khẩu</button>
    </form>

    <div class="links-row">
        <c:choose>
            <c:when test="${blockResend eq true or sessionScope.reset_resend_count >= 3}">
                <span style="color: #dc2626; font-size: 12px; font-weight: 600;">Hết lượt gửi lại mã</span>
            </c:when>
            <c:otherwise>
                <span>
                    <a id="resendBtn" class="resend-link" href="${pageContext.request.contextPath}/reset-password?action=resend&username=${sessionScope.reset_username}">
                        Gửi lại mã OTP
                    </a>
                    <span id="countdownText" class="countdown-badge" style="display: none;"></span>
                </span>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/login" class="back-link">Quay lại Đăng nhập</a>
    </div>
</div>

<script>
    (function() {
        var resendBtn = document.getElementById('resendBtn');
        var countdownText = document.getElementById('countdownText');
        if (!resendBtn) return;

        var storageKey = 'reset_otp_resend_cooldown';
        var cooldownSec = 30;

        function updateCountdown() {
            var expireAt = parseInt(sessionStorage.getItem(storageKey) || '0', 10);
            var now = Date.now();
            var remaining = Math.ceil((expireAt - now) / 1000);

            if (remaining > 0) {
                resendBtn.classList.add('disabled');
                resendBtn.style.display = 'none';
                countdownText.style.display = 'inline';
                countdownText.innerText = 'Gửi lại sau (' + remaining + 's)';
                setTimeout(updateCountdown, 1000);
            } else {
                resendBtn.classList.remove('disabled');
                resendBtn.style.display = 'inline';
                countdownText.style.display = 'none';
                sessionStorage.removeItem(storageKey);
            }
        }

        <c:if test="${not empty startCooldown or not empty message}">
            sessionStorage.setItem(storageKey, Date.now() + cooldownSec * 1000);
        </c:if>

        resendBtn.addEventListener('click', function(e) {
            if (resendBtn.classList.contains('disabled')) {
                e.preventDefault();
                return false;
            }
            sessionStorage.setItem(storageKey, Date.now() + cooldownSec * 1000);
            resendBtn.classList.add('disabled');
            resendBtn.innerText = 'Đang gửi mã...';
        });

        updateCountdown();
    })();
</script>

</body>
</html>
