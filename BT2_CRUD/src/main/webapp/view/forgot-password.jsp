<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - Nguyễn Thanh Tâm</title>
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
            background: #fef2f2;
            color: #dc2626;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 10px;
        }
        h2 { font-size: 22px; font-weight: 700; letter-spacing: -0.5px; }
        .student-info { font-size: 13px; color: var(--text-muted); margin-top: 4px; }
        .alert-danger {
            padding: 12px 14px;
            border-radius: 8px;
            font-size: 13.5px;
            margin-bottom: 18px;
            background-color: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        .desc {
            font-size: 13.5px;
            color: var(--text-muted);
            line-height: 1.5;
            margin-bottom: 20px;
        }
        .form-group { margin-bottom: 18px; }
        label {
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            margin-bottom: 7px;
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
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #dc2626;
            color: #ffffff;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s ease;
        }
        .btn-submit:hover { background: #b91c1c; }
        .footer-action {
            text-align: center;
            margin-top: 18px;
            font-size: 13.5px;
        }
        .footer-action a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }
        .footer-action a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="card-wrapper">
    <div class="brand-header">
        <div class="brand-icon">🔑</div>
        <h2>Quên Mật Khẩu</h2>
        <div class="student-info">Sinh viên: <b>Nguyễn Thanh Tâm</b> | MSSV: <b>24133052</b></div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert-danger">${error}</div>
    </c:if>

    <div class="desc">
        Nhập <b>Email</b> hoặc <b>Tên đăng nhập</b> tài khoản của bạn để nhận mã OTP đặt lại mật khẩu.
    </div>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="form-group">
            <label for="account">Tài khoản hoặc Email</label>
            <input type="text" id="account" name="account" placeholder="Ví dụ: thanhtam@gmail.com hoặc syber096" required autofocus>
        </div>

        <button type="submit" class="btn-submit">Gửi Mã OTP Qua Email</button>
    </form>

    <div class="footer-action">
        <a href="${pageContext.request.contextPath}/login">&larr; Quay lại Đăng Nhập</a>
    </div>
</div>

</body>
</html>
