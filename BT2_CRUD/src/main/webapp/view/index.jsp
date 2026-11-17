<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Video & Lập Trình Web - Nguyễn Thanh Tâm</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --secondary: #0f172a;
            --accent: #dc2626;
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
        /* Navbar */
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
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
        .brand-title {
            font-size: 18px;
            font-weight: 800;
            letter-spacing: -0.3px;
        }
        .brand-sub {
            font-size: 12px;
            color: var(--text-muted);
        }
        .nav-links {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .nav-item {
            text-decoration: none;
            color: #334155;
            font-size: 13.5px;
            font-weight: 600;
            padding: 8px 14px;
            border-radius: 8px;
            transition: all 0.15s;
        }
        .nav-item:hover, .nav-item.active {
            background: #eff6ff;
            color: var(--primary);
        }
        .student-pill {
            background: #eff6ff;
            color: #1e40af;
            border: 1px solid #bfdbfe;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .btn-auth {
            padding: 7px 16px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.15s;
        }
        .btn-login {
            background: var(--primary);
            color: white;
        }
        .btn-login:hover { background: var(--primary-hover); }
        .btn-logout {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
        .btn-logout:hover { background: #fee2e2; }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 28px auto;
            padding: 0 20px;
        }

        /* Banner info */
        .hero-banner {
            background: linear-gradient(135deg, #1e3a8a 0%, #0f172a 100%);
            color: white;
            padding: 28px 32px;
            border-radius: 16px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.3);
        }
        .hero-banner h1 {
            font-size: 24px;
            font-weight: 800;
            margin-bottom: 8px;
        }
        .hero-banner p {
            color: #94a3b8;
            font-size: 14px;
            line-height: 1.5;
        }
        .hero-action {
            display: flex;
            gap: 12px;
        }
        .btn-hero {
            background: #2563eb;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s;
        }
        .btn-hero:hover { background: #1d4ed8; }
        .btn-hero-outline {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
        }
        .btn-hero-outline:hover { background: rgba(255, 255, 255, 0.2); }

        /* Section Title */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 20px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #0f172a;
        }
        .badge-count {
            background: #fee2e2;
            color: #dc2626;
            font-size: 13px;
            font-weight: 700;
            padding: 3px 10px;
            border-radius: 12px;
        }

        /* Video Grid (10 Latest Videos) */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 22px;
            margin-bottom: 40px;
        }
        .video-card {
            background: white;
            border-radius: 14px;
            overflow: hidden;
            border: 1px solid var(--border);
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
            display: flex;
            flex-direction: column;
            transition: all 0.25s ease;
        }
        .video-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -6px rgba(0,0,0,0.12);
            border-color: #cbd5e1;
        }
        .poster-wrapper {
            position: relative;
            width: 100%;
            height: 160px;
            background: #0f172a;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .poster-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .video-card:hover .poster-img {
            transform: scale(1.05);
        }
        .play-overlay {
            position: absolute;
            width: 48px;
            height: 48px;
            background: rgba(220, 38, 38, 0.9);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            transition: all 0.2s;
        }
        .video-card:hover .play-overlay {
            transform: scale(1.15);
            background: #dc2626;
        }
        .video-card-body {
            padding: 16px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .video-title-link {
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
            text-decoration: none;
            line-height: 1.4;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            transition: color 0.15s;
        }
        .video-title-link:hover {
            color: var(--primary);
        }
        .video-meta {
            font-size: 12.5px;
            color: var(--text-muted);
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
            border-top: 1px solid #f1f5f9;
        }
        .video-author {
            font-weight: 600;
            color: #475569;
        }
        .video-views {
            display: flex;
            align-items: center;
            gap: 4px;
            color: #64748b;
        }

        /* Quick Management Cards */
        .quick-nav-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-top: 20px;
        }
        .quick-card {
            background: white;
            padding: 16px 20px;
            border-radius: 12px;
            border: 1px solid var(--border);
            text-decoration: none;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 14px;
            transition: all 0.2s;
        }
        .quick-card:hover {
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.1);
        }
        .quick-card-icon {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
        .quick-card-title {
            font-size: 14.5px;
            font-weight: 700;
            color: #0f172a;
        }
        .quick-card-sub {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 2px;
        }
        .footer {
            text-align: center;
            padding: 30px 20px;
            color: var(--text-muted);
            font-size: 13px;
            border-top: 1px solid var(--border);
            margin-top: 40px;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<header class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand">
        <div class="brand-icon">▶</div>
        <div>
            <div class="brand-title">HCMUTE Video</div>
            <div class="brand-sub">Hệ Thống Video Thời Trang & Quản Lý Danh Mục Bán Hàng</div>
        </div>
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home" class="nav-item active">Trang Chủ</a>
        <a href="${pageContext.request.contextPath}/video" class="nav-item">Video Của Tôi (Phân Trang)</a>
        <a href="${pageContext.request.contextPath}/admin/video/list" class="nav-item">Quản Lý Videos (CRUD)</a>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="nav-item">Quản Lý Danh Mục</a>

        <span class="student-pill">Nguyễn Thanh Tâm | 24133052</span>

        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <a href="${pageContext.request.contextPath}/logout" class="btn-auth btn-logout">Đăng Xuất</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn-auth btn-login">Đăng Nhập</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<div class="container">
    <!-- Hero Banner -->
    <div class="hero-banner">
        <div>
            <h1>Khám Phá Video Bài Giảng & Công Nghệ Mới</h1>
            <p>
                Sinh viên thực hiện: <b>Nguyễn Thanh Tâm</b> (MSSV: <b>24133052</b>) - GVHD: <b>ThS. Nguyễn Hữu Trung</b><br>
                Hệ thống hỗ trợ Upload Video & Poster bằng MultipartConfig, phân trang 6 video/trang và phát video trực tuyến.
            </p>
        </div>
        <div class="hero-action">
            <a href="${pageContext.request.contextPath}/video" class="btn-hero">📺 Xem Kênh Video /video</a>
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn-hero-outline">+ Đăng Video Mới</a>
        </div>
    </div>

    <!-- Section 1: 10 Video Mới Nhất Lên Trang Chủ -->
    <div class="section-header">
        <div class="section-title">
            <span>🔥 10 Video Mới Nhất Trên Hệ Thống</span>
            <span class="badge-count">${not empty latestVideos ? latestVideos.size() : 0} Video</span>
        </div>
        <a href="${pageContext.request.contextPath}/video" style="color: var(--primary); text-decoration: none; font-size: 13.5px; font-weight: 600;">Xem tất cả &rarr;</a>
    </div>

    <div class="video-grid">
        <c:choose>
            <c:when test="${not empty latestVideos}">
                <c:forEach items="${latestVideos}" var="v">
                    <div class="video-card">
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="poster-wrapper">
                            <img src="${v.posterUrl}" class="poster-img" alt="${v.title}" onerror="this.src='https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=600';"/>
                            <div class="play-overlay">▶</div>
                        </a>
                        <div class="video-card-body">
                            <!-- Bấm vào tiêu đề để xem chi tiết và play video theo đúng yêu cầu đề bài -->
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title-link" title="${v.title}">
                                ${v.title}
                            </a>
                            <div class="video-meta">
                                <span class="video-author">👤 ${not empty v.userFullName ? v.userFullName : v.username}</span>
                                <span class="video-views">👁️ ${v.views} lượt xem</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #94a3b8; background: white; border-radius: 12px; border: 1px solid var(--border);">
                    Chưa có video nào. Hãy bấm "Đăng Video Mới" để thêm video đầu tiên!
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Section 2: Menu Phím Tắt Tiện Ích Hệ Thống -->
    <div class="section-header" style="margin-top: 30px;">
        <div class="section-title">
            <span>⚡ Lối Tắt Đến Các Chức Năng Bài Tập</span>
        </div>
    </div>

    <div class="quick-nav-grid">
        <a href="${pageContext.request.contextPath}/video" class="quick-card">
            <div class="quick-card-icon" style="background: #fef2f2; color: #ef4444;">🎬</div>
            <div>
                <div class="quick-card-title">Kênh Video (/video)</div>
                <div class="quick-card-sub">Phân trang 6 video/trang</div>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/admin/video/list" class="quick-card">
            <div class="quick-card-icon" style="background: #eff6ff; color: #2563eb;">🛠️</div>
            <div>
                <div class="quick-card-title">Quản Lý Videos</div>
                <div class="quick-card-sub">Thêm, Sửa, Xóa & Upload</div>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="quick-card">
            <div class="quick-card-icon" style="background: #ecfdf5; color: #10b981;">📦</div>
            <div>
                <div class="quick-card-title">Danh Mục Bán Hàng</div>
                <div class="quick-card-sub">CRUD Category MVC</div>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/login" class="quick-card">
            <div class="quick-card-icon" style="background: #fef3c7; color: #d97706;">🔐</div>
            <div>
                <div class="quick-card-title">Tài Khoản & OTP</div>
                <div class="quick-card-sub">Bảo mật BCrypt + Gmail</div>
            </div>
        </a>
    </div>
</div>

<footer class="footer">
    Bài tập Lập Trình Web (WEBPR330479) - Sinh viên: <b>Nguyễn Thanh Tâm</b> (MSSV: <b>24133052</b>) - GVHD: <b>ThS. Nguyễn Hữu Trung</b>
</footer>

</body>
</html>
