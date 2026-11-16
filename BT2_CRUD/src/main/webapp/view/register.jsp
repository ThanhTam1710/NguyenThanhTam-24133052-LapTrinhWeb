<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 30px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-card {
            width: 100%;
            max-width: 480px;
            background: white;
            padding: 35px 30px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        }
        h2 { color: #003366; text-align: center; margin: 0 0 6px 0; }
        .student-text { text-align: center; font-size: 13px; color: #666; margin-bottom: 20px; }
        .alert {
            padding: 12px 14px;
            border-radius: 6px;
            font-size: 13.5px;
            margin-bottom: 18px;
            line-height: 1.4;
        }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .form-group { margin-bottom: 14px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; color: #444; font-size: 13.5px; }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 14px;
        }
        input:focus { border-color: #28a745; outline: none; }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.2s;
        }
        .btn-submit:hover { background-color: #218838; }
        .info-box {
            margin-top: 15px;
            padding: 10px 12px;
            background: #f8f9fa;
            border-left: 4px solid #28a745;
            font-size: 12.5px;
            color: #555;
            line-height: 1.4;
        }
        .footer-link {
            text-align: center;
            margin-top: 18px;
            font-size: 13.5px;
        }
        .footer-link a { color: #0066cc; text-decoration: none; font-weight: 600; }
        .footer-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="register-card">
    <h2>ĐĂNG KÝ TÀI KHOẢN</h2>
    <div class="student-text">Sinh viên: <b>Nguyễn Thanh Tâm</b> - MSSV: <b>24133052</b></div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="info-box">
        💡 <b>Quy trình bảo mật:</b> Sau khi điền thông tin, hệ thống sẽ tự động <b>mã hóa mật khẩu (BCrypt Hash)</b> và <b>gửi mã OTP 6 chữ số qua Email</b> để kích hoạt tài khoản.
    </div>

    <form action="${pageContext.request.contextPath}/register" method="post" style="margin-top: 15px;">
        <div class="form-group">
            <label for="username">Tên đăng nhập (*):</label>
            <input type="text" id="username" name="username" placeholder="Ví dụ: thanhtam2026" required autofocus>
        </div>

        <div class="form-group">
            <label for="email">Địa chỉ Email nhận mã OTP (*):</label>
            <input type="email" id="email" name="email" placeholder="Ví dụ: example@gmail.com" required>
        </div>

        <div class="form-group">
            <label for="fullname">Họ và tên:</label>
            <input type="text" id="fullname" name="fullname" placeholder="Ví dụ: Nguyễn Thanh Tâm">
        </div>

        <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="text" id="phone" name="phone" placeholder="Ví dụ: 0987654321">
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu (*):</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu (sẽ được mã hóa an toàn)" required>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Xác nhận mật khẩu (*):</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
        </div>

        <button type="submit" class="btn-submit">Đăng Ký & Nhận Mã OTP Qua Email</button>
    </form>

    <div class="footer-link">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
    </div>
</div>
</body>
</html>
