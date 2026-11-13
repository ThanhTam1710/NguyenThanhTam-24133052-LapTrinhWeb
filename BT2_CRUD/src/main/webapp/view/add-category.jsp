<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục Mới - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            padding: 30px;
        }
        .form-card {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h2 { color: #003366; margin-top: 0; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        input[type="file"] {
            width: 100%;
            padding: 6px;
        }
        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary { background-color: #28a745; color: white; }
        .btn-primary:hover { background-color: #218838; }
        .btn-secondary { background-color: #6c757d; color: white; margin-left: 10px; }
        .btn-secondary:hover { background-color: #5a6268; }
    </style>
</head>
<body>
<div class="form-card">
    <h2>Thêm Danh Mục Mới</h2>
    <p style="font-size: 13px; color: #666;">Sinh viên: Nguyễn Thanh Tâm - 24133052</p>
    <hr style="border: none; border-top: 1px solid #eee; margin-bottom: 20px;">

    <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="name">Tên danh mục:</label>
            <input type="text" id="name" name="name" placeholder="Ví dụ: Đồ Điện Tử, Thời Trang..." required autofocus>
        </div>

        <div class="form-group">
            <label for="icon">Ảnh đại diện (Icon):</label>
            <input type="file" id="icon" name="icon" accept="image/*">
        </div>

        <button type="submit" class="btn btn-primary">Thêm mới</button>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary">Quay lại danh sách</a>
    </form>
</div>
</body>
</html>
