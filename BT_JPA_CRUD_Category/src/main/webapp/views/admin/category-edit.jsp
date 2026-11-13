<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Category (JPA) - 24133052_NguyenThanhTam</title>
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
        .img-preview {
            width: 120px;
            height: 90px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ddd;
            margin-top: 6px;
            display: block;
        }
        .radio-group { display: flex; gap: 20px; margin-top: 6px; }
        .radio-item { display: flex; align-items: center; gap: 6px; font-weight: normal; }
        .btn-submit {
            background-color: #0066cc;
            color: white;
            padding: 10px 22px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-submit:hover { background-color: #004c99; }
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
    <h2>Chỉnh Sửa Danh Mục (JPA Update)</h2>
    <p style="font-size: 13px; color: #666; margin-bottom: 20px;">Sinh viên: <b>Nguyễn Thành Tâm</b> - MSSV: <b>24133052</b></p>

    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="categoryid" value="${cate.categoryId}">

        <div class="form-group">
            <label for="categoryname">Category Name:</label>
            <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" required autofocus>
        </div>

        <div class="form-group">
            <label for="images">Link Images:</label>
            <input type="text" id="images" name="images" value="${cate.images}">
        </div>

        <div class="form-group">
            <label>Ảnh hiện tại:</label>
            <c:choose>
                <c:when test="${not empty cate.images and cate.images.startsWith('http')}">
                    <c:url value="${cate.images}" var="imgUrl"></c:url>
                    <img class="img-preview" src="${imgUrl}" alt="${cate.categoryname}" />
                </c:when>
                <c:when test="${not empty cate.images}">
                    <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                    <img class="img-preview" src="${imgUrl}" alt="${cate.categoryname}" />
                </c:when>
                <c:otherwise>
                    <span style="color: #888; font-style: italic; font-size: 13px;">Chưa có ảnh</span>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="form-group">
            <label for="images1">Upload Images mới (Nếu muốn thay đổi):</label>
            <input type="file" id="images1" name="images1" accept="image/*">
        </div>

        <div class="form-group">
            <label>Status (Trạng thái):</label>
            <div class="radio-group">
                <label class="radio-item">
                    <input type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}> Hoạt động
                </label>
                <label class="radio-item">
                    <input type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}> Khóa
                </label>
            </div>
        </div>

        <div style="margin-top: 25px;">
            <input type="submit" value="Update (Cập nhật)" class="btn-submit">
            <a href="<c:url value='/admin/categories'/>" class="back-link">Quay lại danh sách</a>
        </div>
    </form>
</div>
</body>
</html>
