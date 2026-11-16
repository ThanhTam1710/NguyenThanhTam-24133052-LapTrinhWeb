<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - Nguyễn Thanh Tâm</title>
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
        .register-card {
            width: 100%;
            max-width: 440px;
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08);
            padding: 32px 28px;
            border: 1px solid var(--border-color);
        }
        .brand-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .brand-icon {
            width: 44px;
            height: 44px;
            background: #eff6ff;
            color: var(--primary);
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 8px;
        }
        h2 { font-size: 22px; font-weight: 700; letter-spacing: -0.5px; }
        .student-info { font-size: 13px; color: var(--text-muted); margin-top: 4px; }
        .alert {
            padding: 11px 14px;
            border-radius: 8px;
            font-size: 13.5px;
            margin-bottom: 16px;
            line-height: 1.4;
        }
        .alert-danger { background-color: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .form-group {
            margin-bottom: 14px;
        }
        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #334155;
        }
        input {
            width: 100%;
            padding: 10px 12px;
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
        .footer-action {
            text-align: center;
            margin-top: 18px;
            font-size: 13.5px;
            color: var(--text-muted);
        }
        .footer-action a {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
        }
        .footer-action a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="register-card">
    <div class="brand-header">
        <div class="brand-icon">📝</div>
        <h2>Đăng Ký Tài Khoản</h2>
        <div class="student-info">Sinh viên: <b>Nguyễn Thanh Tâm</b> | MSSV: <b>24133052</b></div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label for="username">Tên đăng nhập (*)</label>
            <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required autofocus>
        </div>

        <div class="form-group">
            <label for="email">Địa chỉ Email (*)</label>
            <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input type="text" id="fullname" name="fullname" placeholder="Nguyễn Thanh Tâm">
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="text" id="phone" name="phone" placeholder="0987654321">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="password">Mật khẩu (*)</label>
                <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Xác nhận (*)</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại" required>
            </div>
        </div>

        <button type="submit" class="btn-submit">Đăng Ký & Nhận Mã OTP</button>
    </form>

    <div class="footer-action">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>
</div>

</body>
</html>
