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
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
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
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-warning { background: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .form-group { margin-bottom: 16px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #444; font-size: 14px; }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 11px 12px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.2s;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #0066cc;
            outline: none;
        }
        .checkbox-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            margin-bottom: 16px;
        }
        .checkbox-row a { color: #0066cc; text-decoration: none; }
        .checkbox-row a:hover { text-decoration: underline; }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit:hover { background-color: #004c99; }
        .account-hint {
            margin-top: 20px;
            padding: 12px 14px;
            background: #f8f9fa;
            border: 1px dashed #0066cc;
            border-radius: 6px;
            font-size: 13px;
            color: #333;
        }
        .register-box {
            text-align: center;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            font-size: 14px;
        }
        .register-box a { color: #28a745; font-weight: 600; text-decoration: none; }
        .register-box a:hover { text-decoration: underline; }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #777;
            text-decoration: none;
            font-size: 13px;
        }
        .back-link:hover { color: #333; }
    </style>
</head>
<body>
<div class="login-card">
    <h2>ĐĂNG NHẬP</h2>
    <div class="student-text">Sinh viên: <b>Nguyễn Thanh Tâm</b> - MSSV: <b>24133052</b></div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty warning}">
        <div class="alert alert-warning">${warning}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Tên đăng nhập hoặc Email:</label>
            <input type="text" id="username" name="username" placeholder="Nhập username (syber096 hoặc thanhtam)" required autofocus>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
        </div>

        <div class="checkbox-row">
            <label style="font-weight: normal; margin: 0; cursor: pointer;">
                <input type="checkbox" name="remember"> Ghi nhớ đăng nhập
            </label>
            <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn-submit">Đăng Nhập (Bảo Mật Hash)</button>
    </form>

    <div class="account-hint">
        <b>🔑 Tài khoản kiểm thử (Mật khẩu đã Hash BCrypt):</b><br>
        1. <code>syber096</code> / <code>thanhtam123</code> (Admin)<br>
        2. <code>thanhtam</code> / <code>123</code> (Admin)
    </div>

    <div class="register-box">
        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký & Nhận OTP kích hoạt</a>
    </div>

    <a href="${pageContext.request.contextPath}/home" class="back-link">&larr; Quay lại Trang Chủ</a>
</div>
</body>
</html>
