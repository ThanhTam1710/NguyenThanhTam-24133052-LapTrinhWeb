<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi Đăng Nhập - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            padding: 50px 20px;
        }
        .error-card {
            max-width: 440px;
            margin: auto;
            background: white;
            padding: 35px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            text-align: center;
        }
        h2 { color: #dc3545; margin-top: 0; }
        p { color: #555; font-size: 15px; line-height: 1.6; }
        .btn-group {
            display: flex;
            gap: 12px;
            justify-content: center;
            margin-top: 25px;
        }
        .btn {
            padding: 10px 18px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        .btn-primary { background-color: #0066cc; color: white; }
        .btn-primary:hover { background-color: #004c99; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .btn-secondary:hover { background-color: #5a6268; }
    </style>
</head>
<body>
<div class="error-card">
    <h2>Đăng Nhập Thất Bại!</h2>
    <p>Tài khoản hoặc mật khẩu bạn nhập không chính xác. Vui lòng kiểm tra lại thông tin.</p>
    <p style="font-size: 13px; color: #888;">Gợi ý: <b>thanhtam</b> / <b>123</b></p>
    
    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Thử lại</a>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Về Trang Chủ</a>
    </div>
</div>
</body>
</html>
