<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            width: 100%;
            max-width: 440px;
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
        .desc {
            font-size: 14px;
            color: #555;
            line-height: 1.5;
            margin-bottom: 20px;
        }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #444; font-size: 14px; }
        input[type="text"] {
            width: 100%;
            padding: 11px 12px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 14px;
        }
        input[type="text"]:focus { border-color: #0066cc; outline: none; }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #d9534f;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit:hover { background-color: #c9302c; }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #0066cc;
            text-decoration: none;
            font-size: 13.5px;
        }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="card">
    <h2>QUÊN MẬT KHẨU</h2>
    <div class="student-text">Sinh viên: <b>Nguyễn Thanh Tâm</b> - MSSV: <b>24133052</b></div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="desc">
        Vui lòng nhập <b>Email</b> hoặc <b>Tên đăng nhập</b> tài khoản của bạn. Hệ thống sẽ tạo và gửi mã xác nhận OTP qua email để bạn đặt lại mật khẩu.
    </div>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="form-group">
            <label for="account">Tên đăng nhập hoặc Email:</label>
            <input type="text" id="account" name="account" placeholder="Ví dụ: thanhtam@gmail.com hoặc thanhtam" required autofocus>
        </div>

        <button type="submit" class="btn-submit">Gửi Mã Xác Nhận OTP Qua Email</button>
    </form>

    <a href="${pageContext.request.contextPath}/login" class="back-link">&larr; Quay lại Đăng Nhập</a>
</div>
</body>
</html>
