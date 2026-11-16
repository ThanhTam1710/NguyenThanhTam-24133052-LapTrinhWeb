<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 40px 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
        }
        h1 { color: #003366; margin-top: 0; font-size: 26px; }
        .student-badge {
            background-color: #e8f4fd;
            border-left: 5px solid #0066cc;
            padding: 14px 18px;
            margin-bottom: 25px;
            font-size: 14.5px;
            color: #0c5460;
            line-height: 1.5;
        }
        .welcome-user {
            background-color: #d4edda;
            color: #155724;
            padding: 12px 18px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-logout {
            background-color: #dc3545;
            color: white;
            padding: 6px 14px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }
        .btn-logout:hover { background-color: #bd2130; }
        .grid-links {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-top: 20px;
        }
        .card-link {
            display: block;
            padding: 18px;
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            text-decoration: none;
            color: #333;
            transition: all 0.2s;
        }
        .card-link:hover {
            border-color: #0066cc;
            box-shadow: 0 4px 14px rgba(0,102,204,0.15);
            transform: translateY(-2px);
        }
        .card-title {
            font-weight: 600;
            font-size: 15.5px;
            color: #0066cc;
            margin-bottom: 6px;
        }
        .card-desc {
            font-size: 13px;
            color: #666;
            line-height: 1.4;
        }
        .highlight-card {
            border-color: #28a745;
            background-color: #fcfdfd;
        }
        .highlight-card .card-title { color: #28a745; }
    </style>
</head>
<body>
<div class="container">
    <h1>Hệ Thống Thực Hành Lập Trình Web</h1>
    <div class="student-badge">
        Họ và tên: <b>Nguyễn Thanh Tâm</b> | MSSV: <b>24133052</b><br>
        Môn học: <b>Lập trình Web (WEBPR330479)</b> - Giảng viên: <b>ThS. Nguyễn Hữu Trung</b><br>
        Tính năng mới: <b>Kích hoạt OTP qua Email, Mật khẩu mã hóa (Hash Password), Quên mật khẩu & Đăng xuất</b>
    </div>

    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <div class="welcome-user">
                <div>
                    Xin chào: <b>${sessionScope.name}</b> (Username: <code>${sessionScope.account.username}</code>)
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Đăng Xuất</a>
            </div>
        </c:when>
        <c:otherwise>
            <div style="margin-bottom: 15px; color: #555;">
                Bạn chưa đăng nhập. Chọn chức năng bên dưới để kiểm thử hệ thống:
            </div>
        </c:otherwise>
    </c:choose>

    <div class="grid-links">
        <a href="${pageContext.request.contextPath}/register" class="card-link highlight-card">
            <div class="card-title">&#128231; 1. Đăng Ký Tài Khoản & OTP Email</div>
            <div class="card-desc">Tạo tài khoản mới, mật khẩu được mã hóa tự động và hệ thống gửi mã OTP 6 số qua email để kích hoạt.</div>
        </a>

        <a href="${pageContext.request.contextPath}/login" class="card-link highlight-card">
            <div class="card-title">&#128272; 2. Đăng Nhập Với Mật Khẩu Hash</div>
            <div class="card-desc">Kiểm tra đăng nhập bằng mật khẩu đã được mã hóa an toàn (BCrypt). Tài khoản chưa xác thực OTP sẽ bị chặn.</div>
        </a>

        <a href="${pageContext.request.contextPath}/forgot-password" class="card-link highlight-card">
            <div class="card-title">&#128273; 3. Quên Mật Khẩu & Gửi OTP Mail</div>
            <div class="card-desc">Nhập Email/Username, nhận mã OTP khôi phục qua email và đặt lại mật khẩu mới được băm an toàn.</div>
        </a>

        <a href="${pageContext.request.contextPath}/admin/category/list" class="card-link">
            <div class="card-title">&#128194; 4. Quản Lý Danh Mục (CRUD)</div>
            <div class="card-desc">Hiển thị danh sách, thêm, sửa, xóa và upload hình ảnh danh mục theo mô hình 3 tầng MVC.</div>
        </a>

        <a href="${pageContext.request.contextPath}/login-cookie" class="card-link">
            <div class="card-title">&#127850; 5. Đăng Nhập Bằng Cookie</div>
            <div class="card-desc">Ghi nhớ thông tin phiên đăng nhập vào Cookie trình duyệt với thời hạn 30 giây.</div>
        </a>

        <a href="${pageContext.request.contextPath}/login-session" class="card-link">
            <div class="card-title">&#128100; 6. Đăng Nhập Bằng Session & Logout</div>
            <div class="card-desc">Lưu phiên làm việc với HttpSession, trang Profile và chức năng đăng xuất xóa phiên.</div>
        </a>
    </div>
</div>
</body>
</html>
