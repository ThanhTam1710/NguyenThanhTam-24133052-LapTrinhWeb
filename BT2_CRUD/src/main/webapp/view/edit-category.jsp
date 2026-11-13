<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Danh Mục - 24133052_NguyenThanhTam</title>
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
        .preview-box {
            margin-bottom: 12px;
            padding: 10px;
            background: #fafafa;
            border: 1px dashed #ccc;
            border-radius: 4px;
        }
        .img-preview {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ddd;
            display: block;
            margin-top: 5px;
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
        .btn-primary { background-color: #0066cc; color: white; }
        .btn-primary:hover { background-color: #004c99; }
        .btn-secondary { background-color: #6c757d; color: white; margin-left: 10px; }
        .btn-secondary:hover { background-color: #5a6268; }
    </style>
</head>
<body>
<div class="form-card">
    <h2>Chỉnh Sửa Danh Mục (Category Edit)</h2>
    <p style="font-size: 13px; color: #666;">Sinh viên: Nguyễn Thành Tâm - 24133052</p>
    <hr style="border: none; border-top: 1px solid #eee; margin-bottom: 20px;">

    <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
        <!-- ID ẩn -->
        <input type="hidden" name="id" value="${category.id}">

        <div class="form-group">
            <label for="name">Tên danh mục:</label>
            <input type="text" id="name" name="name" value="${category.name}" required autofocus>
        </div>

        <div class="form-group">
            <label>Ảnh đại diện hiện tại:</label>
            <div class="preview-box">
                <c:choose>
                    <c:when test="${not empty category.icon}">
                        <img src="${pageContext.request.contextPath}/image?fname=${category.icon}" class="img-preview" alt="${category.name}">
                        <span style="font-size: 12px; color: #666;">File: ${category.icon}</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #888; font-style: italic;">Chưa có ảnh đại diện</span>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <label for="icon">Chọn ảnh mới (nếu muốn đổi):</label>
            <input type="file" id="icon" name="icon" accept="image/*">
        </div>

        <button type="submit" class="btn btn-primary">Cập nhật (Save Changes)</button>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary">Hủy bỏ</a>
    </form>
</div>
</body>
</html>
