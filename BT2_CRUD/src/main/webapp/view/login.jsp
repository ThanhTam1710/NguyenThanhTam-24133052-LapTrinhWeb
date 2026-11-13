<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            padding: 40px 20px;
        }
        .login-card {
            max-width: 420px;
            margin: auto;
            background: white;
            padding: 35px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        h2 { color: #003366; text-align: center; margin-top: 0; }
        .student-text { text-align: center; font-size: 13px; color: #666; margin-bottom: 20px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #444; }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn-submit {
            width: 100%;
            padding: 11px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-submit:hover { background-color: #004c99; }
        .account-hint {
            margin-top: 20px;
            padding: 10px 14px;
            background: #f8f9fa;
            border: 1px dashed #ccc;
            border-radius: 4px;
            font-size: 13px;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #666;
            text-decoration: none;
            font-size: 14px;
        }
        .back-link:hover { color: #0066cc; text-decoration: underline; }
    </style>
</head>
<body>
<div class="login-card">
    <h2>Đăng Nhập Hệ Thống</h2>
    <div class="student-text">Sinh viên: <b>Nguyễn Thành Tâm</b> - MSSV: <b>24133052</b></div>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Tài khoản (Username):</label>
            <input type="text" id="username" name="username" placeholder="Nhập tài khoản (thanhtam)" required autofocus>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu (Password):</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu (123)" required>
        </div>

        <button type="submit" class="btn-submit">Đăng Nhập</button>
    </form>

    <div class="account-hint">
        Tài khoản mẫu:<br>
        - Username: <b>thanhtam</b> hoặc <b>admin</b><br>
        - Password: <b>123</b>
    </div>

    <a href="${pageContext.request.contextPath}/home" class="back-link">&larr; Quay lại Trang Chủ</a>
</div>
</body>
</html>
