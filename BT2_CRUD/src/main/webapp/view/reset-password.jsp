<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu - 24133052_NguyenThanhTam</title>
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
        .card {
            width: 100%;
            max-width: 450px;
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
        .form-group { margin-bottom: 16px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #444; font-size: 14px; }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 11px 12px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 14px;
        }
        input.otp-field {
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 6px;
            text-align: center;
            border: 2px solid #d9534f;
        }
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
            margin-top: 10px;
            transition: background 0.2s;
        }
        .btn-submit:hover { background-color: #004c99; }
        .test-helper-box {
            margin-top: 20px;
            padding: 12px;
            background: #fdfaf2;
            border: 1px dashed #f0ad4e;
            border-radius: 6px;
            font-size: 13px;
            color: #8a6d3b;
        }
        .badge-otp {
            font-size: 18px;
            font-weight: bold;
            color: #d9534f;
            background: #fff;
            padding: 2px 8px;
            border-radius: 4px;
            border: 1px solid #d9534f;
            display: inline-block;
            margin-top: 4px;
        }
        .links-row {
            display: flex;
            justify-content: space-between;
            margin-top: 18px;
            font-size: 13px;
        }
        .links-row a { color: #0066cc; text-decoration: none; }
        .links-row a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="card">
    <h2>ĐẶT LẠI MẬT KHẨU</h2>
    <div class="student-text">Sinh viên: <b>Nguyễn Thanh Tâm</b> - MSSV: <b>24133052</b></div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <p style="font-size: 13.5px; color: #555; line-height: 1.4;">
        Vui lòng nhập <b>Mã OTP xác nhận</b> đã được gửi đến email 
        <c:choose>
            <c:when test="${not empty sessionScope.reset_email}">
                <b>${sessionScope.reset_email}</b>
            </c:when>
            <c:otherwise>của bạn</c:otherwise>
        </c:choose>
        và thiết lập mật khẩu mới.
    </p>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="username" value="${sessionScope.reset_username}">

        <div class="form-group">
            <label for="otp">Mã xác nhận OTP (6 chữ số):</label>
            <input type="text" id="otp" name="otp" class="otp-field" maxlength="6" placeholder="------" required autofocus>
        </div>

        <div class="form-group">
            <label for="newPassword">Mật khẩu mới (Tự động Hash bảo mật):</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
        </div>

        <button type="submit" class="btn-submit">Xác Nhận & Cập Nhật Mật Khẩu</button>
    </form>

    <div class="links-row">
        <a href="${pageContext.request.contextPath}/reset-password?action=resend">Gửi lại mã OTP</a>
        <a href="${pageContext.request.contextPath}/login">Quay lại Đăng nhập</a>
    </div>

    <c:if test="${not empty sessionScope.debug_otp}">
        <div class="test-helper-box">
            🔔 <b>Hỗ trợ chấm bài / Test nhanh:</b><br>
            Mã OTP đặt lại mật khẩu vừa gửi đến email (và log Server Console):<br>
            <span class="badge-otp">${sessionScope.debug_otp}</span>
        </div>
    </c:if>
</div>
</body>
</html>
