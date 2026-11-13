<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục (JPA) - 24133052_NguyenThanhTam</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 25px;
        }
        .container {
            max-width: 960px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        h2 { color: #003366; margin-top: 0; }
        .student-banner {
            background-color: #e8f4fd;
            border-left: 4px solid #0066cc;
            padding: 10px 16px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .btn {
            display: inline-block;
            background-color: #0066cc;
            color: white;
            padding: 9px 18px;
            text-decoration: none;
            border-radius: 5px;
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
        th { background-color: #f8f9fa; color: #333; }
        tr:nth-child(even) { background-color: #fbfbfb; }
        tr:hover { background-color: #f1f5f9; }
        .img-thumb {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .status-active {
            color: #28a745;
            font-weight: bold;
            background: #e6f7e6;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 13px;
        }
        .status-locked {
            color: #dc3545;
            font-weight: bold;
            background: #ffe6e6;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 13px;
        }
        .action-link {
            text-decoration: none;
            color: #0066cc;
            font-weight: 500;
            margin-right: 6px;
        }
        .action-delete { color: #dc3545; }
        .action-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <h2>Quản Lý Danh Mục (JPA 3.0 & Hibernate 6.x)</h2>
    <div class="student-banner">
        Sinh viên thực hiện: <b>Nguyễn Thanh Tâm</b> | MSSV: <b>24133052</b> | Công nghệ: <b>JPA 3.0 + Jakarta Servlet 6.0</b>
    </div>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
        <a href="<c:url value='/admin/category/add'/>" class="btn btn-add">+ Add Category (Thêm mới)</a>
    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 50px; text-align: center;">STT</th>
                <th style="width: 120px; text-align: center;">Images</th>
                <th>Category Name</th>
                <th style="width: 120px; text-align: center;">Status</th>
                <th style="width: 140px; text-align: center;">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listcate}" var="cate" varStatus="STT">
                <tr>
                    <td style="text-align: center;">${STT.index + 1}</td>
                    <td style="text-align: center;">
                        <c:choose>
                            <c:when test="${not empty cate.images and cate.images.startsWith('http')}">
                                <c:url value="${cate.images}" var="imgUrl"></c:url>
                                <img class="img-thumb" src="${imgUrl}" alt="${cate.categoryname}" />
                            </c:when>
                            <c:when test="${not empty cate.images}">
                                <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                <img class="img-thumb" src="${imgUrl}" alt="${cate.categoryname}" />
                            </c:when>
                            <c:otherwise>
                                <span style="color: #999; font-style: italic; font-size: 13px;">No Image</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <b>${cate.categoryname}</b>
                        <div style="font-size: 12px; color: #888;">ID: ${cate.categoryId}</div>
                    </td>
                    <td style="text-align: center;">
                        <c:if test="${cate.status == 1}">
                            <span class="status-active">Hoạt động</span>
                        </c:if>
                        <c:if test="${cate.status != 1}">
                            <span class="status-locked">Khóa</span>
                        </c:if>
                    </td>
                    <td style="text-align: center;">
                        <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>" class="action-link">Sửa</a>
                        |
                        <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" class="action-link action-delete" onclick="return confirm('Bạn có chắc muốn xóa category [${cate.categoryname}]?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
