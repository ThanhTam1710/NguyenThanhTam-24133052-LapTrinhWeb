<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Videos (CRUD) - Nguyễn Thanh Tâm</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --success: #10b981;
            --danger: #ef4444;
            --bg-body: #f8fafc;
            --card-bg: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            min-height: 100vh;
        }
        .navbar {
            background: #ffffff;
            border-bottom: 1px solid var(--border);
            padding: 12px 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .nav-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--text-dark);
        }
        .brand-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .brand-title { font-size: 17px; font-weight: 800; }
        .nav-links { display: flex; align-items: center; gap: 12px; }
        .nav-item {
            text-decoration: none;
            color: #334155;
            font-size: 13.5px;
            font-weight: 600;
            padding: 8px 14px;
            border-radius: 8px;
            transition: all 0.15s;
        }
        .nav-item:hover, .nav-item.active { background: #eff6ff; color: var(--primary); }
        .student-pill {
            background: #eff6ff;
            color: #1e40af;
            border: 1px solid #bfdbfe;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .container {
            max-width: 1200px;
            margin: 28px auto;
            padding: 0 20px;
        }
        .main-card {
            background: white;
            border-radius: 14px;
            border: 1px solid var(--border);
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            overflow: hidden;
        }
        .card-header {
            padding: 20px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border);
        }
        .card-header h2 {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
        }
        .card-header p {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 3px;
        }
        .btn-add {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 2px 6px rgba(220, 38, 38, 0.3);
            transition: all 0.2s;
        }
        .btn-add:hover { transform: translateY(-1px); box-shadow: 0 4px 10px rgba(220, 38, 38, 0.4); }

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
            padding: 14px 18px;
            border-bottom: 1px solid var(--border);
        }
        td {
            padding: 14px 18px;
            border-bottom: 1px solid var(--border);
            font-size: 13.5px;
            vertical-align: middle;
        }
        tr:hover td { background: #f8fafc; }
        .thumb-img {
            width: 70px;
            height: 48px;
            border-radius: 6px;
            object-fit: cover;
            background: #0f172a;
        }
        .video-title-col {
            font-weight: 700;
            color: #0f172a;
            font-size: 14.5px;
            text-decoration: none;
            display: inline-block;
        }
        .video-title-col:hover { color: var(--primary); text-decoration: underline; }
        .badge-active {
            background: #ecfdf5;
            color: #059669;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-inactive {
            background: #fef2f2;
            color: #dc2626;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .action-btns {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .btn-act {
            padding: 5px 10px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12.5px;
            font-weight: 600;
            transition: all 0.15s;
        }
        .btn-play { background: #fee2e2; color: #dc2626; border: 1px solid #fecaca; }
        .btn-play:hover { background: #fecaca; }
        .btn-edit { background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe; }
        .btn-edit:hover { background: #dbeafe; }
        .btn-del { background: #fef2f2; color: #ef4444; border: 1px solid #fecaca; }
        .btn-del:hover { background: #fee2e2; }
    </style>
</head>
<body>

<header class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand">
        <div class="brand-icon">▶</div>
        <div>
            <div class="brand-title">HCMUTE Video</div>
        </div>
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home" class="nav-item">Trang Chủ</a>
        <a href="${pageContext.request.contextPath}/video" class="nav-item">Kênh Video (/video)</a>
        <a href="${pageContext.request.contextPath}/admin/video/list" class="nav-item active">Quản Lý Videos (CRUD)</a>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="nav-item">Quản Lý Danh Mục</a>
        <span class="student-pill">Nguyễn Thanh Tâm | 24133052</span>
    </div>
</header>

<div class="container">
    <div class="main-card">
        <div class="card-header">
            <div>
                <h2>Quản Lý Danh Sách Videos (CRUD)</h2>
                <p>Danh sách toàn bộ video trong hệ thống. Hỗ trợ xem, thêm mới, sửa, xóa và tải lên file</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn-add">
                + Thêm Mới Video
            </a>
        </div>

        <div style="overflow-x: auto;">
            <table>
                <thead>
                    <tr>
                        <th style="width: 50px; text-align: center;">STT</th>
                        <th style="width: 80px; text-align: center;">Hình Ảnh</th>
                        <th style="width: 100px;">Mã Video</th>
                        <th>Tiêu Đề Video (Bấm để xem/phát)</th>
                        <th style="width: 120px;">Người Đăng</th>
                        <th style="width: 90px; text-align: center;">Lượt Xem</th>
                        <th style="width: 100px; text-align: center;">Trạng Thái</th>
                        <th style="width: 170px; text-align: center;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty videoList}">
                            <c:forEach items="${videoList}" var="v" varStatus="stt">
                                <tr>
                                    <td style="text-align: center; color: #64748b; font-weight: 600;">${stt.index + 1}</td>
                                    <td style="text-align: center;">
                                        <img src="${v.posterUrl}" class="thumb-img" alt="${v.title}" onerror="this.src='https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=200';"/>
                                    </td>
                                    <td><code>#${v.videoId}</code></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title-col">
                                            ${v.title}
                                        </a>
                                    </td>
                                    <td>👤 ${not empty v.userFullName ? v.userFullName : v.username}</td>
                                    <td style="text-align: center; font-weight: 600;">${v.views}</td>
                                    <td style="text-align: center;">
                                        <c:choose>
                                            <c:when test="${v.active}">
                                                <span class="badge-active">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-inactive">Ẩn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align: center;">
                                        <div class="action-btns" style="justify-content: center;">
                                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="btn-act btn-play" title="Xem và phát video">
                                                ▶ Play
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/video/edit?id=${v.videoId}" class="btn-act btn-edit" title="Chỉnh sửa video">
                                                ✏️ Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/video/delete?id=${v.videoId}" class="btn-act btn-del" onclick="return confirm('Bạn có chắc muốn xóa video [${v.title}]?')" title="Xóa video">
                                                🗑️ Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="text-align: center; color: #94a3b8; padding: 40px;">
                                    Chưa có video nào. Bấm <b>"Thêm Mới Video"</b> để đăng tải video đầu tiên.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
