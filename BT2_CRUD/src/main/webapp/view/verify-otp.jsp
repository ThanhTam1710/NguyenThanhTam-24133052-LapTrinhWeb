<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - Nguyễn Thanh Tâm</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
            background: radial-gradient(circle at 15% 15%, #1e3a8a 0%, transparent 45%),
                        radial-gradient(circle at 85% 85%, #0f766e 0%, transparent 45%),
                        linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            background-attachment: fixed;
            color: #334155;
        }
        .card-wrapper {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.98);
            border-radius: 20px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.35);
            padding: 36px 32px;
            text-align: center;
            position: relative;
        }
        .card-wrapper::before {
            content: '';
            position: absolute;
            top: 0;
            left: 24px;
            right: 24px;
            height: 4px;
            border-radius: 4px;
            background: linear-gradient(90deg, #3b82f6, #06b6d4, #10b981);
        }
        .brand-icon {
            width: 52px;
            height: 52px;
            background: #eff6ff;
            color: #2563eb;
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            border: 1px solid #bfdbfe;
        }
        h2 { font-size: 24px; font-weight: 800; color: #0f172a; letter-spacing: -0.5px; }
        .student-info { font-size: 13px; color: #64748b; margin-top: 6px; margin-bottom: 20px; }
        .student-info b { color: #1e293b; }
        .alert {
            padding: 12px 14px;
            border-radius: 10px;
            font-size: 13.5px;
            margin-bottom: 18px;
            text-align: left;
            line-height: 1.45;
        }
        .alert-success { background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-danger { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }
        .alert-warning { background: #fffbeb; color: #92400e; border: 1px solid #fde68a; }
        .desc {
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
            margin-bottom: 22px;
        }
        .otp-input {
            width: 100%;
            max-width: 250px;
            padding: 12px;
            font-size: 26px;
            font-weight: 800;
            letter-spacing: 10px;
            text-align: center;
            border: 2px solid #2563eb;
            border-radius: 12px;
            outline: none;
            color: #0f172a;
            background: #f8fafc;
            margin-bottom: 20px;
            transition: all 0.2s ease;
        }
        .otp-input:focus {
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.16);
        }
        .btn-submit {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 50%, #1d4ed8 100%);
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 0 6px 18px rgba(37, 99, 235, 0.35);
            transition: all 0.2s ease;
        }
        .btn-submit:hover {
            box-shadow: 0 8px 22px rgba(37, 99, 235, 0.45);
            transform: translateY(-1px);
        }
        .resend-box {
            margin-top: 18px;
            font-size: 13.5px;
            color: #64748b;
        }
        .resend-link {
            color: #ef4444;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
            display: inline-block;
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
            display: block;
            margin-top: 16px;
            font-size: 13px;
            color: #94a3b8;
            text-decoration: none;
        }
        .back-link:hover { color: #0f172a; }
    </style>
</head>
<body>

<div class="card-wrapper">
    <div class="brand-icon">
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
            <polyline points="22,6 12,13 2,6"></polyline>
        </svg>
    </div>
    <h2>Xác Thực OTP</h2>
    <div class="student-info">Sinh viên: <b>Nguyễn Thanh Tâm</b> | MSSV: <b>24133052</b></div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty warning}">
        <div class="alert alert-warning">${warning}</div>
    </c:if>

    <div class="desc">
        Mã OTP xác thực gồm 6 số đã gửi tới email<br>
        <b>${not empty sessionScope.otp_email ? sessionScope.otp_email : 'đăng ký của bạn'}</b>.
    </div>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="hidden" name="username" value="${sessionScope.otp_username}">

        <div>
            <input type="text" name="otp" id="otpField" class="otp-input" maxlength="6" placeholder="------" required autofocus autocomplete="one-time-code">
        </div>

        <button type="submit" class="btn-submit">Xác Nhận Kích Hoạt</button>
    </form>

    <div class="resend-box">
        <c:choose>
            <c:when test="${blockResend eq true or sessionScope.otp_resend_count >= 3}">
                <span style="color: #dc2626; font-weight: 600;">Đã vượt quá 3 lần gửi lại mã! Vui lòng kiểm tra kỹ email.</span>
            </c:when>
            <c:otherwise>
                Chưa nhận được mã? 
                <a id="resendBtn" class="resend-link" 
                   href="${pageContext.request.contextPath}/verify-otp?action=resend&username=${sessionScope.otp_username}">
                   Gửi lại mã OTP
                </a>
                <span id="countdownText" class="countdown-badge" style="display: none;"></span>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${pageContext.request.contextPath}/login" class="back-link">&larr; Quay lại Đăng Nhập</a>
</div>

<script>
    (function() {
        var resendBtn = document.getElementById('resendBtn');
        var countdownText = document.getElementById('countdownText');
        if (!resendBtn) return;

        var storageKey = 'otp_resend_cooldown';
        var cooldownSec = 30;

        function updateCountdown() {
            var expireAt = parseInt(sessionStorage.getItem(storageKey) || '0', 10);
            var now = Date.now();
            var remaining = Math.ceil((expireAt - now) / 1000);

            if (remaining > 0) {
                resendBtn.classList.add('disabled');
                resendBtn.style.display = 'none';
                countdownText.style.display = 'inline';
                countdownText.innerText = 'Gửi lại mã sau (' + remaining + 's)';
                setTimeout(updateCountdown, 1000);
            } else {
                resendBtn.classList.remove('disabled');
                resendBtn.style.display = 'inline';
                countdownText.style.display = 'none';
                sessionStorage.removeItem(storageKey);
            }
        }

        // Nếu server vừa gửi lại mã thành công
        <c:if test="${not empty startCooldown or not empty message}">
            sessionStorage.setItem(storageKey, Date.now() + cooldownSec * 1000);
        </c:if>

        // Bắt sự kiện click
        resendBtn.addEventListener('click', function(e) {
            if (resendBtn.classList.contains('disabled')) {
                e.preventDefault();
                return false;
            }
            sessionStorage.setItem(storageKey, Date.now() + cooldownSec * 1000);
            resendBtn.classList.add('disabled');
            resendBtn.innerText = 'Đang gửi mã...';
        });

        // Kiểm tra cooldown lúc tải trang
        updateCountdown();
    })();
</script>

</body>
</html>
