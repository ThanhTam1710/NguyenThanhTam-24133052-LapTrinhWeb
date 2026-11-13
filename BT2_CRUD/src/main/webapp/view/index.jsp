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
            max-width: 720px;
            margin: auto;
            background: white;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        h1 { color: #003366; margin-top: 0; font-size: 26px; }
        .student-badge {
            background-color: #e8f4fd;
            border-left: 5px solid #0066cc;
            padding: 12px 18px;
            margin-bottom: 25px;
            font-size: 15px;
            color: #0c5460;
        }
        .grid-links {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 25px;
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
            box-shadow: 0 4px 12px rgba(0,102,204,0.15);
            transform: translateY(-2px);
        }
        .card-title {
            font-weight: 600;
            font-size: 16px;
            color: #0066cc;
            margin-bottom: 6px;
        }
        .card-desc {
            font-size: 13px;
            color: #666;
        }
        .welcome-user {
            background-color: #d4edda;
            color: #155724;
            padding: 12px 18px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Hệ Thống Thực Hành Lập Trình Web</h1>
    <div class="student-badge">
        Họ và tên: <b>Nguyễn Thành Tâm</b><br>
        Mã số sinh viên: <b>24133052</b><br>
        Bài tập: <b>Login Cookie & Session + CRUD Category (Servlet JDBC)</b>
    </div>

    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <div class="welcome-user">
                Xin chào: <b>${sessionScope.name}</b> (${sessionScope.account.username}) | 
                <a href="${pageContext.request.contextPath}/logout" style="color: #155724; font-weight: bold;">Đăng Xuất</a>
            </div>
        </c:when>
        <c:otherwise>
            <p style="color: #555;">Hệ thống bao gồm đầy đủ các chức năng theo yêu cầu đề bài:</p>
        </c:otherwise>
    </c:choose>

    <div class="grid-links">
        <a href="${pageContext.request.contextPath}/admin/category/list" class="card-link" style="grid-column: span 2; background-color: #fcfdfe; border-color: #b8daff;">
            <div class="card-title">&#128194; 1. Quản Lý Danh Mục (CRUD Category Table)</div>
            <div class="card-desc">Thực hiện đầy đủ: Hiển thị danh sách, Thêm mới, Sửa, Xóa và Upload hình ảnh icon danh mục.</div>
        </a>

        <a href="${pageContext.request.contextPath}/login" class="card-link">
            <div class="card-title">&#128272; 2. Đăng Nhập Kiến Trúc 3 Tầng</div>
            <div class="card-desc">Mô hình Controller - Service - DAO (Đúng vào /home, Sai vào /error).</div>
        </a>

        <a href="${pageContext.request.contextPath}/login-cookie" class="card-link">
            <div class="card-title">&#127850; 3. Đăng Nhập Với Cookie</div>
            <div class="card-desc">Lưu thông tin đăng nhập vào Cookie trình duyệt với thời hạn 30 giây.</div>
        </a>

        <a href="${pageContext.request.contextPath}/login-session" class="card-link">
            <div class="card-title">&#128100; 4. Đăng Nhập Với Session</div>
            <div class="card-desc">Lưu phiên làm việc với HttpSession và trang quản lý tài khoản Profile.</div>
        </a>
    </div>
</div>
</body>
</html>
