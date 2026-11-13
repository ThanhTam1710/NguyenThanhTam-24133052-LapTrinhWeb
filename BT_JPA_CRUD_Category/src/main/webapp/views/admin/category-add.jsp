<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm mới Category (JPA) - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            padding: 30px;
        }
        .form-card {
            max-width: 520px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        h2 { color: #003366; margin-top: 0; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #444; }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        input[type="file"] { padding: 4px 0; }
        .radio-group { display: flex; gap: 20px; margin-top: 6px; }
        .radio-item { display: flex; align-items: center; gap: 6px; font-weight: normal; }
        .btn-submit {
            background-color: #28a745;
            color: white;
            padding: 10px 22px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-submit:hover { background-color: #218838; }
        .back-link {
            display: inline-block;
            margin-left: 12px;
            color: #6c757d;
            text-decoration: none;
            font-size: 14px;
        }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="form-card">
    <h2>Thêm Mới Danh Mục (JPA)</h2>
    <p style="font-size: 13px; color: #666; margin-bottom: 20px;">Sinh viên: <b>Nguyễn Thành Tâm</b> - MSSV: <b>24133052</b></p>

    <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="categoryname">Category Name:</label>
            <input type="text" id="categoryname" name="categoryname" placeholder="Nhập tên danh mục..." required autofocus>
        </div>

        <div class="form-group">
            <label for="images">Link Images (Nếu có URL ngoài):</label>
            <input type="text" id="images" name="images" placeholder="https://example.com/image.jpg">
        </div>

        <div class="form-group">
            <label for="images1">Upload Images (Chọn file ảnh từ máy):</label>
            <input type="file" id="images1" name="images1" accept="image/*">
        </div>

        <div class="form-group">
            <label>Status (Trạng thái):</label>
            <div class="radio-group">
                <label class="radio-item">
                    <input type="radio" id="ston" name="status" value="1" checked> Hoạt động
                </label>
                <label class="radio-item">
                    <input type="radio" id="stoff" name="status" value="0"> Khóa
                </label>
            </div>
        </div>

        <div style="margin-top: 25px;">
            <input type="submit" value="Insert (Thêm mới)" class="btn-submit">
            <a href="<c:url value='/admin/categories'/>" class="back-link">Quay lại danh sách</a>
        </div>
    </form>
</div>
</body>
</html>
