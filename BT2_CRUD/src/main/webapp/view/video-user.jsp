<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kênh Video Của User (/video) - Nguyễn Thanh Tâm</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
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
            max-width: 1150px;
            margin: 28px auto;
            padding: 0 20px;
        }
        .page-header {
            background: white;
            padding: 24px 28px;
            border-radius: 14px;
            border: 1px solid var(--border);
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }
        .user-channel-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .channel-avatar {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: 800;
        }
        .channel-title {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
        }
        .channel-meta {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 4px;
        }
        .btn-add-video {
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
            box-shadow: 0 3px 10px rgba(220, 38, 38, 0.25);
            transition: all 0.2s;
        }
        .btn-add-video:hover {
            transform: translateY(-1px);
            box-shadow: 0 5px 14px rgba(220, 38, 38, 0.35);
        }

        /* Video Grid (6 videos per page) */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
            margin-bottom: 30px;
        }
        @media (max-width: 900px) {
            .video-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 600px) {
            .video-grid { grid-template-columns: 1fr; }
        }
        .video-card {
            background: white;
            border-radius: 14px;
            overflow: hidden;
            border: 1px solid var(--border);
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
            display: flex;
            flex-direction: column;
            transition: all 0.2s;
        }
        .video-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            border-color: #cbd5e1;
        }
        .poster-wrapper {
            position: relative;
            width: 100%;
            height: 180px;
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
        }
        .play-overlay {
            position: absolute;
            width: 46px;
            height: 46px;
            background: rgba(220, 38, 38, 0.9);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }
        .video-card-body {
            padding: 18px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .video-title-link {
            font-size: 15.5px;
            font-weight: 700;
            color: #0f172a;
            text-decoration: none;
            line-height: 1.4;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .video-title-link:hover { color: var(--primary); }
        .video-desc {
            font-size: 13px;
            color: #64748b;
            line-height: 1.4;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .video-meta {
            margin-top: auto;
            padding-top: 10px;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12.5px;
            color: var(--text-muted);
        }

        /* Pagination Bar */
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 30px;
            margin-bottom: 40px;
        }
        .page-btn {
            padding: 8px 14px;
            border-radius: 8px;
            background: white;
            border: 1px solid var(--border);
            color: #334155;
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 600;
            transition: all 0.15s;
        }
        .page-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
        .page-btn.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        .page-btn.disabled {
            color: #cbd5e1;
            pointer-events: none;
            cursor: not-allowed;
        }
        .page-info-pill {
            font-size: 13px;
            color: var(--text-muted);
            margin: 0 10px;
        }
    </style>
</head>
<body>

<header class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand">
        <div class="brand-icon">▶</div>
        <div>
            <div class="brand-title">Fashion Showcase</div>
        </div>
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home" class="nav-item">Trang Chủ</a>
        <a href="${pageContext.request.contextPath}/video" class="nav-item active">Video Của Tôi (/video)</a>
        <a href="${pageContext.request.contextPath}/admin/video/list" class="nav-item">Quản Lý Videos</a>
        <a href="${pageContext.request.contextPath}/admin/category/list" class="nav-item">Quản Lý Danh Mục</a>
        <span class="student-pill">Nguyễn Thanh Tâm | 24133052</span>
    </div>
</header>

<div class="container">
    <div class="page-header">
        <div class="user-channel-info">
            <div class="channel-avatar">
                ${viewFullname.substring(0, 1)}
            </div>
            <div>
                <div class="channel-title">Kênh Video Của: ${viewFullname} (@${viewUsername})</div>
                <div class="channel-meta">
                    Tổng số: <b>${totalVideos} video</b> | Hiển thị: <b>6 video / trang</b> theo đề bài | Trang: <b>${currentPage} / ${totalPages}</b>
                </div>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/admin/video/add" class="btn-add-video">
            + Tải Lên Video Mới
        </a>
    </div>

    <!-- 6 Videos per page -->
    <div class="video-grid">
        <c:choose>
            <c:when test="${not empty videoList}">
                <c:forEach items="${videoList}" var="v">
                    <div class="video-card">
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="poster-wrapper">
                            <img src="${v.posterUrl}" class="poster-img" alt="${v.title}" onerror="this.src='https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=600';"/>
                            <div class="play-overlay">▶</div>
                        </a>
                        <div class="video-card-body">
                            <!-- Bấm vào tiêu đề để xem chi tiết và play video -->
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title-link" title="${v.title}">
                                ${v.title}
                            </a>
                            <div class="video-desc">${v.description}</div>
                            <div class="video-meta">
                                <span>Mã: #${v.videoId}</span>
                                <span>👁️ ${v.views} lượt xem</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="grid-column: 1 / -1; text-align: center; padding: 50px 20px; background: white; border-radius: 12px; border: 1px solid var(--border); color: #64748b;">
                    Bạn chưa có video nào trong danh sách. Hãy bấm <b>"Tải Lên Video Mới"</b> để đăng video!
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Phân trang 6 sp / trang -->
    <c:if test="${totalPages > 1}">
        <div class="pagination-wrapper">
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/video?page=${currentPage - 1}" class="page-btn">&larr; Trang Trước</a>
                </c:when>
                <c:otherwise>
                    <span class="page-btn disabled">&larr; Trang Trước</span>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="${pageContext.request.contextPath}/video?page=${i}" class="page-btn ${i eq currentPage ? 'active' : ''}">
                    ${i}
                </a>
            </c:forEach>

            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/video?page=${currentPage + 1}" class="page-btn">Trang Sau &rarr;</a>
                </c:when>
                <c:otherwise>
                    <span class="page-btn disabled">Trang Sau &rarr;</span>
                </c:otherwise>
            </c:choose>

            <span class="page-info-pill">(Tổng cộng ${totalVideos} video - 6 video/trang)</span>
        </div>
    </c:if>
</div>

</body>
</html>
