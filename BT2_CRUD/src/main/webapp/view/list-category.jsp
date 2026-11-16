<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục Bán Hàng - Nguyễn Thanh Tâm</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --success: #10b981;
            --danger: #ef4444;
            --bg-body: #f1f5f9;
            --card-bg: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            min-height: 100vh;
        }
        /* Top Navigation Header */
        .navbar {
            background: #ffffff;
            border-bottom: 1px solid var(--border-color);
            padding: 14px 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--text-dark);
        }
        .brand-icon-box {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .brand-name {
            font-size: 18px;
            font-weight: 800;
            letter-spacing: -0.3px;
            color: #0f172a;
        }
        .brand-sub {
            font-size: 12px;
            color: var(--text-muted);
        }
        .user-nav {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .student-pill {
            background: #eff6ff;
            color: #1e40af;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            border: 1px solid #bfdbfe;
        }
        .user-profile-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #334155;
            background: #f8fafc;
            padding: 6px 12px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }
        .btn-logout {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 600;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-logout:hover {
            background: #fee2e2;
            color: #b91c1c;
        }
        /* Main Container */
        .container {
            max-width: 1100px;
            margin: 28px auto;
            padding: 0 20px;
        }
        /* Metrics row */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .metric-card {
            background: white;
            padding: 18px 20px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }
        .metric-icon {
            width: 46px;
            height: 46px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
        .metric-val {
            font-size: 20px;
            font-weight: 800;
            color: var(--text-dark);
        }
        .metric-label {
            font-size: 12.5px;
            color: var(--text-muted);
            margin-top: 2px;
        }
        /* Main card */
        .main-card {
            background: white;
            border-radius: 14px;
            border: 1px solid var(--border-color);
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            overflow: hidden;
        }
        .card-header {
            padding: 20px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border-color);
            background: #ffffff;
        }
        .card-header h2 {
            font-size: 19px;
            font-weight: 700;
            color: #0f172a;
        }
        .card-header p {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 3px;
        }
        .btn-add {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 2px 6px rgba(16, 185, 129, 0.3);
            transition: all 0.2s;
        }
        .btn-add:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.4);
        }
        /* Table */
        .table-wrapper {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }
        th {
            background: #f8fafc;
            color: #475569;
            font-size: 12.5px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 14px 20px;
            border-bottom: 1px solid var(--border-color);
        }
        td {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
            font-size: 14px;
            vertical-align: middle;
        }
        tr:hover td {
            background: #f8fafc;
        }
        .cate-img {
            width: 56px;
            height: 56px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid var(--border-color);
            background: #f1f5f9;
        }
        .no-img-box {
            width: 56px;
            height: 56px;
            border-radius: 8px;
            background: #f1f5f9;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: #94a3b8;
            border: 1px dashed #cbd5e1;
        }
        .cate-name-text {
            font-weight: 700;
            color: #0f172a;
            font-size: 15px;
        }
        .cate-id-sub {
            font-size: 12.5px;
            color: var(--text-muted);
            margin-top: 2px;
        }
        .badge-status {
            background: #ecfdf5;
            color: #059669;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }
        .action-btns {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-action {
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.15s;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .btn-edit {
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
        }
        .btn-edit:hover { background: #dbeafe; }
        .btn-delete {
            background: #fef2f2;
            color: #ef4444;
            border: 1px solid #fecaca;
        }
        .btn-delete:hover { background: #fee2e2; }
        .footer-note {
            text-align: center;
            margin-top: 24px;
            font-size: 13px;
            color: var(--text-muted);
        }
    </style>
</head>
<body>

<!-- Top Navigation -->
<header class="navbar">
    <a href="${pageContext.request.contextPath}/admin/category/list" class="navbar-brand">
        <div class="brand-icon-box">🛒</div>
        <div>
            <div class="brand-name">HCMUTE SHOP STORE</div>
            <div class="brand-sub">Hệ Thống Bán Hàng Trực Tuyến & Quản Lý Danh Mục</div>
        </div>
    </a>

    <div class="user-nav">
        <span class="student-pill">Nguyễn Thanh Tâm | 24133052</span>
        <div class="user-profile-badge">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
            <span>${not empty sessionScope.name ? sessionScope.name : (not empty sessionScope.account.username ? sessionScope.account.username : 'Quản trị viên')}</span>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                <polyline points="16 17 21 12 16 7"></polyline>
                <line x1="21" y1="12" x2="9" y2="12"></line>
            </svg>
            Đăng Xuất
        </a>
    </div>
</header>

<div class="container">
    <!-- Overview Metrics -->
    <div class="metrics-grid">
        <div class="metric-card">
            <div class="metric-icon" style="background: #eff6ff; color: #2563eb;">📦</div>
            <div>
                <div class="metric-val">${not empty cateList ? cateList.size() : 0}</div>
                <div class="metric-label">Tổng Danh Mục Sản Phẩm</div>
            </div>
        </div>
        <div class="metric-card">
            <div class="metric-icon" style="background: #ecfdf5; color: #10b981;">🛡️</div>
            <div>
                <div class="metric-val" style="font-size: 16px; color: #059669;">Bảo Mật Kép</div>
                <div class="metric-label">BCrypt Hash + OTP Email</div>
            </div>
        </div>
        <div class="metric-card">
            <div class="metric-icon" style="background: #fef3c7; color: #d97706;">🏬</div>
            <div>
                <div class="metric-val" style="font-size: 16px; color: #b45309;">Kênh Bán Hàng</div>
                <div class="metric-label">Mô Hình MVC 3 Tầng</div>
            </div>
        </div>
    </div>

    <!-- Main Content: Category Management -->
    <div class="main-card">
        <div class="card-header">
            <div>
                <h2>Danh Sách Danh Mục Sản Phẩm</h2>
                <p>Quản lý các nhóm mặt hàng, danh mục sản phẩm kinh doanh của cửa hàng</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn-add">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                Thêm Mới Danh Mục
            </a>
        </div>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th style="width: 70px; text-align: center;">STT</th>
                        <th style="width: 90px; text-align: center;">Hình Ảnh</th>
                        <th>Tên Danh Mục Sản Phẩm</th>
                        <th style="width: 150px; text-align: center;">Trạng Thái</th>
                        <th style="width: 170px; text-align: center;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty cateList}">
                            <c:forEach items="${cateList}" var="cate" varStatus="stt">
                                <tr>
                                    <td style="text-align: center; font-weight: 600; color: #64748b;">${stt.index + 1}</td>
                                    <td style="text-align: center;">
                                        <c:choose>
                                            <c:when test="${not empty cate.icon}">
                                                <img src="${pageContext.request.contextPath}/image?fname=${cate.icon}" class="cate-img" alt="${cate.name}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-img-box">🏷️</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="cate-name-text">${cate.name}</div>
                                        <div class="cate-id-sub">Mã phân loại ID: #${cate.id}</div>
                                    </td>
                                    <td style="text-align: center;">
                                        <span class="badge-status">Đang kinh doanh</span>
                                    </td>
                                    <td style="text-align: center;">
                                        <div class="action-btns" style="justify-content: center;">
                                            <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}" class="btn-action btn-edit">
                                                ✏️ Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc muốn xóa danh mục [${cate.name}]?')">
                                                🗑️ Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" style="text-align: center; color: #94a3b8; padding: 40px 20px;">
                                    <div style="font-size: 36px; margin-bottom: 8px;">📦</div>
                                    <div>Chưa có danh mục nào trong hệ thống. Hãy bấm <b>"Thêm Mới Danh Mục"</b> ở trên để tạo.</div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <div class="footer-note">
        Đồ án Lập trình Web (WEBPR330479) - Sinh viên: <b>Nguyễn Thanh Tâm</b> (MSSV: <b>24133052</b>) - GVHD: <b>ThS. Nguyễn Hữu Trung</b>
    </div>
</div>

</body>
</html>
