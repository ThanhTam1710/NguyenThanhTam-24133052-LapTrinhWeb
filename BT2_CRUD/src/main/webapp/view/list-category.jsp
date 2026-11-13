<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 25px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h2 {
            color: #003366;
            margin-top: 0;
        }
        .student-info {
            background-color: #e8f4fd;
            border-left: 4px solid #0066cc;
            padding: 10px 15px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .btn {
            display: inline-block;
            background-color: #0066cc;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
        }
        .btn:hover { background-color: #004c99; }
        .btn-add { background-color: #28a745; margin-bottom: 15px; }
        .btn-add:hover { background-color: #218838; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: left;
            vertical-align: middle;
        }
        th {
            background-color: #f8f9fa;
            color: #333;
        }
        tr:nth-child(even) { background-color: #fbfbfb; }
        tr:hover { background-color: #f1f5f9; }
        .action-link {
            text-decoration: none;
            color: #0066cc;
            font-weight: 500;
            margin-right: 8px;
        }
        .action-delete {
            color: #dc3545;
        }
        .action-link:hover { text-decoration: underline; }
        .img-thumb {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .no-img {
            color: #999;
            font-style: italic;
            font-size: 13px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Quản Lý Danh Mục (Category CRUD)</h2>
    <div class="student-info">
        Sinh viên thực hiện: <b>Nguyễn Thành Tâm</b> | MSSV: <b>24133052</b> | Lớp: Lập trình Web
    </div>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-add">+ Thêm Mới Danh Mục</a>
        <a href="${pageContext.request.contextPath}/home" class="btn" style="background-color: #6c757d;">&larr; Về Trang Chủ</a>
    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 60px; text-align: center;">STT</th>
                <th style="width: 110px; text-align: center;">Hình Ảnh</th>
                <th>Tên Danh Mục</th>
                <th style="width: 150px; text-align: center;">Hành Động</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty cateList}">
                    <c:forEach items="${cateList}" var="cate" varStatus="stt">
                        <tr>
                            <td style="text-align: center;">${stt.index + 1}</td>
                            <td style="text-align: center;">
                                <c:choose>
                                    <c:when test="${not empty cate.icon}">
                                        <img src="${pageContext.request.contextPath}/image?fname=${cate.icon}" class="img-thumb" alt="${cate.name}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="no-img">Không có ảnh</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><b>${cate.name}</b> (ID: ${cate.id})</td>
                            <td style="text-align: center;">
                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}" class="action-link">Sửa</a>
                                |
                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" class="action-link action-delete" onclick="return confirm('Bạn có chắc muốn xóa danh mục [${cate.name}]?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="4" style="text-align: center; color: #888; padding: 25px;">Chưa có danh mục nào. Hãy bấm "Thêm Mới Danh Mục" ở trên.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>
</body>
</html>
