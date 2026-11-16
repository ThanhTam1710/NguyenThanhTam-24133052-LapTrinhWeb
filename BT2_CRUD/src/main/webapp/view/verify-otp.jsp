<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP - 24133052_NguyenThanhTam</title>
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
        .otp-card {
            width: 100%;
            max-width: 440px;
            background: white;
            padding: 35px 30px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
            text-align: center;
        }
        h2 { color: #003366; margin: 0 0 6px 0; }
        .student-text { font-size: 13px; color: #666; margin-bottom: 20px; }
        .alert {
            padding: 12px 14px;
            border-radius: 6px;
            font-size: 13.5px;
            margin-bottom: 18px;
            line-height: 1.4;
            text-align: left;
        }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-warning { background: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .otp-info {
            font-size: 14px;
            color: #555;
            margin-bottom: 22px;
            line-height: 1.5;
        }
        .otp-input-container {
            margin: 20px 0;
        }
        .otp-input {
            width: 100%;
            max-width: 260px;
            padding: 12px;
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 8px;
            text-align: center;
            border: 2px solid #0066cc;
            border-radius: 8px;
            box-sizing: border-box;
            outline: none;
            color: #333;
        }
        .btn-verify {
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
        .btn-verify:hover { background-color: #004c99; }
        .resend-box {
            margin-top: 18px;
            font-size: 13.5px;
            color: #666;
        }
        .resend-box a { color: #d9534f; font-weight: 600; text-decoration: none; }
        .resend-box a:hover { text-decoration: underline; }
        .test-helper-box {
            margin-top: 22px;
            padding: 12px;
            background: #fdfaf2;
            border: 1px dashed #f0ad4e;
            border-radius: 6px;
            font-size: 13px;
            color: #8a6d3b;
            text-align: left;
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
        .back-link {
            display: block;
            margin-top: 20px;
            color: #777;
            text-decoration: none;
            font-size: 13px;
        }
    </style>
</head>
<body>
<div class="otp-card">
    <h2>XÁC THỰC MÃ OTP</h2>
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

    <div class="otp-info">
        Hệ thống đã gửi một mã OTP gồm <b>6 chữ số</b> đến email 
        <c:choose>
            <c:when test="${not empty sessionScope.otp_email}">
                <b>${sessionScope.otp_email}</b>
            </c:when>
            <c:otherwise>của bạn</c:otherwise>
        </c:choose>.
        <br>Vui lòng nhập mã bên dưới để kích hoạt tài khoản (Hiệu lực: 5 phút).
    </div>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="hidden" name="username" value="${sessionScope.otp_username}">

        <div class="otp-input-container">
            <input type="text" name="otp" class="otp-input" maxlength="6" placeholder="------" required autofocus autocomplete="off">
        </div>

        <button type="submit" class="btn-verify">Kích Hoạt Tài Khoản</button>
    </form>

    <div class="resend-box">
        Chưa nhận được mã OTP? 
        <a href="${pageContext.request.contextPath}/verify-otp?action=resend">Gửi lại mã OTP</a>
    </div>

    <!-- Hỗ trợ giảng viên kiểm thử tiện lợi ngay trên máy chấm bài -->
    <c:if test="${not empty sessionScope.debug_otp}">
        <div class="test-helper-box">
            🔔 <b>Hỗ trợ chấm bài / Test nhanh:</b><br>
            Mã OTP vừa được tạo và gửi đến email (đồng thời ghi log Server Console):<br>
            <span class="badge-otp">${sessionScope.debug_otp}</span>
        </div>
    </c:if>

    <a href="${pageContext.request.contextPath}/login" class="back-link">&larr; Quay lại Đăng Nhập</a>
</div>
</body>
</html>
