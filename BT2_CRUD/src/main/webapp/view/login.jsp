<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống - Nguyễn Thanh Tâm</title>
    <style>
        :root {
            --primary-start: #4f46e5;
            --primary-mid: #3b82f6;
            --primary-end: #06b6d4;
            --btn-gradient: linear-gradient(135deg, #3b82f6 0%, #2563eb 50%, #1d4ed8 100%);
            --btn-hover: linear-gradient(135deg, #2563eb 0%, #1d4ed8 50%, #1e40af 100%);
            --bg-canvas: #0f172a;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border-normal: #cbd5e1;
            --border-focus: #3b82f6;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
            /* Nền chuyển màu ngân hàng & gaming hiện đại */
            background: radial-gradient(circle at 15% 15%, #1e3a8a 0%, transparent 45%),
                        radial-gradient(circle at 85% 85%, #0f766e 0%, transparent 45%),
                        linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            background-attachment: fixed;
            color: #334155;
        }

        .auth-container {
            width: 100%;
            max-width: 430px;
            background: rgba(255, 255, 255, 0.98);
            border-radius: 20px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.35),
                        0 0 0 1px rgba(255, 255, 255, 0.15);
            padding: 36px 32px;
            position: relative;
            backdrop-filter: blur(16px);
        }

        /* Dải màu thương hiệu phía trên thẻ */
        .auth-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 24px;
            right: 24px;
            height: 4px;
            border-radius: 4px;
            background: linear-gradient(90deg, #3b82f6, #06b6d4, #10b981);
        }

        .brand-section {
            text-align: center;
            margin-bottom: 24px;
            padding-top: 4px;
        }

        .brand-logo {
            width: 52px;
            height: 52px;
            margin: 0 auto 12px auto;
            border-radius: 14px;
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            border: 1px solid #bfdbfe;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #2563eb;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.15);
        }

        .brand-section h2 {
            font-size: 24px;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: -0.5px;
        }

        .student-subtext {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 6px;
        }

        .student-subtext span {
            font-weight: 700;
            color: #1e293b;
        }

        /* Thông báo trạng thái */
        .banner {
            padding: 12px 14px;
            border-radius: 10px;
            font-size: 13.5px;
            margin-bottom: 20px;
            line-height: 1.45;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .banner-success {
            background-color: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .banner-danger {
            background-color: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .banner-warning {
            background-color: #fffbeb;
            color: #92400e;
            border: 1px solid #fde68a;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            margin-bottom: 7px;
            color: #334155;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            width: 20px;
            height: 20px;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            pointer-events: none;
            transition: color 0.2s;
        }

        .form-control {
            width: 100%;
            padding: 12px 42px 12px 44px;
            font-size: 14.5px;
            border: 1.5px solid var(--border-normal);
            border-radius: 10px;
            background: #f8fafc;
            color: #0f172a;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--border-focus);
            background: #ffffff;
            box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.16);
        }

        .form-control:focus + .input-icon {
            color: #2563eb;
        }

        .eye-toggle-btn {
            position: absolute;
            right: 12px;
            background: none;
            border: none;
            width: 28px;
            height: 28px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
        }

        .eye-toggle-btn:hover {
            color: #0f172a;
            background: #e2e8f0;
        }

        .options-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13.5px;
            margin: 8px 0 20px 0;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 7px;
            cursor: pointer;
            color: #475569;
            user-select: none;
        }

        .checkbox-container input {
            width: 16px;
            height: 16px;
            accent-color: #2563eb;
            cursor: pointer;
        }

        .link-forgot {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .link-forgot:hover {
            text-decoration: underline;
        }

        /* Nút bấm Đăng nhập phong cách Fintech/Game hiện đại */
        .btn-submit-main {
            width: 100%;
            padding: 13px;
            background: var(--btn-gradient);
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: 0.3px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 0 6px 18px rgba(37, 99, 235, 0.35);
            transition: all 0.2s ease;
        }

        .btn-submit-main:hover {
            background: var(--btn-hover);
            box-shadow: 0 8px 22px rgba(37, 99, 235, 0.45);
            transform: translateY(-1px);
        }

        .btn-submit-main:active {
            transform: translateY(1px);
        }

        /* Thẻ điền nhanh tài khoản kiểm thử */
        .quick-fill-panel {
            margin-top: 22px;
            padding: 12px 14px;
            background: #f1f5f9;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .quick-fill-title {
            font-size: 12.5px;
            font-weight: 600;
            color: #475569;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .quick-fill-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
        }

        .quick-btn {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            padding: 7px 10px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 600;
            color: #1e293b;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.15s ease;
        }

        .quick-btn:hover {
            border-color: #3b82f6;
            background: #eff6ff;
            color: #1d4ed8;
            box-shadow: 0 2px 6px rgba(59, 130, 246, 0.15);
        }

        .quick-btn .badge-role {
            font-size: 10px;
            background: #dbeafe;
            color: #1e40af;
            padding: 1px 5px;
            border-radius: 4px;
        }

        .bottom-links {
            text-align: center;
            margin-top: 20px;
            font-size: 13.5px;
            color: var(--text-muted);
        }

        .bottom-links a {
            color: #059669;
            font-weight: 700;
            text-decoration: none;
        }

        .bottom-links a:hover {
            text-decoration: underline;
        }

        .return-home {
            display: block;
            text-align: center;
            margin-top: 14px;
            font-size: 13px;
            color: #64748b;
            text-decoration: none;
            transition: color 0.15s;
        }

        .return-home:hover {
            color: #0f172a;
        }
    </style>
</head>
<body>

<div class="auth-container">
    <div class="brand-section">
        <!-- Logo SVG phong cách Ngân hàng / Ứng dụng hiện đại -->
        <div class="brand-logo">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
            </svg>
        </div>
        <h2>Đăng Nhập</h2>
        <div class="student-subtext">Sinh viên: <span>Nguyễn Thanh Tâm</span> | MSSV: <span>24133052</span></div>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty message}">
        <div class="banner banner-success">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
            <div>${message}</div>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="banner banner-danger">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
            <div>${error}</div>
        </div>
    </c:if>

    <c:if test="${not empty warning}">
        <div class="banner banner-warning">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
            <div>${warning}</div>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <!-- Trường Tên đăng nhập -->
        <div class="form-group">
            <label for="username">Tên đăng nhập hoặc Email</label>
            <div class="input-wrapper">
                <span class="input-icon">
                    <!-- SVG User Outline -->
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                </span>
                <input type="text" id="username" name="username" class="form-control" placeholder="Nhập username hoặc email" required autofocus autocomplete="username">
            </div>
        </div>

        <!-- Trường Mật khẩu -->
        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <div class="input-wrapper">
                <span class="input-icon">
                    <!-- SVG Lock Outline -->
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                </span>
                <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required autocomplete="current-password">
                <button type="button" class="eye-toggle-btn" onclick="togglePasswordVisibility()" title="Ẩn/Hiện mật khẩu">
                    <!-- SVG Eye Outline -->
                    <svg id="eyeIcon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                        <circle cx="12" cy="12" r="3"></circle>
                    </svg>
                </button>
            </div>
        </div>

        <!-- Tùy chọn Ghi nhớ & Quên mật khẩu -->
        <div class="options-bar">
            <label class="checkbox-container">
                <input type="checkbox" name="remember">
                <span>Ghi nhớ đăng nhập</span>
            </label>
            <a href="${pageContext.request.contextPath}/forgot-password" class="link-forgot">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn-submit-main">Đăng Nhập</button>
    </form>

    <!-- Thẻ điền nhanh tài khoản kiểm thử dạng Fintech Pill -->
    <div class="quick-fill-panel">
        <div class="quick-fill-title">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
            Tài khoản kiểm thử nhanh:
        </div>
        <div class="quick-fill-buttons">
            <button type="button" class="quick-btn" onclick="fillAccount('syber096', 'thanhtam123')">
                <span>syber096</span>
                <span class="badge-role">Admin</span>
            </button>
            <button type="button" class="quick-btn" onclick="fillAccount('thanhtam', '123')">
                <span>thanhtam</span>
                <span class="badge-role">Admin</span>
            </button>
        </div>
    </div>

    <div class="bottom-links">
        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký mới</a>
    </div>

    <a href="${pageContext.request.contextPath}/home" class="return-home">&larr; Quay lại Trang Chủ</a>
</div>

<script>
    function togglePasswordVisibility() {
        const pass = document.getElementById('password');
        const icon = document.getElementById('eyeIcon');
        if (pass.type === 'password') {
            pass.type = 'text';
            icon.innerHTML = '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line>';
        } else {
            pass.type = 'password';
            icon.innerHTML = '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle>';
        }
    }

    function fillAccount(u, p) {
        document.getElementById('username').value = u;
        document.getElementById('password').value = p;
        document.getElementById('password').focus();
    }
</script>

</body>
</html>
