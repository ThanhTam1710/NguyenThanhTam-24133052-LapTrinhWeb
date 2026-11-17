<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title} - HCMUTE Video</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --accent: #dc2626;
            --bg-body: #0f172a;
            --card-bg: #1e293b;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --border: #334155;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            min-height: 100vh;
        }
        .navbar {
            background: #1e293b;
            border-bottom: 1px solid var(--border);
            padding: 12px 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .nav-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: white;
        }
        .brand-icon {
            width: 38px;
            height: 38px;
            background: #dc2626;
            color: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }
        .brand-title { font-size: 17px; font-weight: 800; }
        .nav-links { display: flex; align-items: center; gap: 12px; }
        .nav-item {
            text-decoration: none;
            color: #cbd5e1;
            font-size: 13.5px;
            font-weight: 600;
            padding: 8px 14px;
            border-radius: 8px;
            transition: all 0.15s;
        }
        .nav-item:hover { background: #334155; color: white; }
        .student-pill {
            background: rgba(37, 99, 235, 0.2);
            color: #93c5fd;
            border: 1px solid rgba(147, 197, 253, 0.3);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .container {
            max-width: 1280px;
            margin: 24px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 28px;
        }
        @media (max-width: 960px) {
            .container { grid-template-columns: 1fr; }
        }

        /* Player Box */
        .player-container {
            background: #000;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            border: 1px solid var(--border);
            position: relative;
            width: 100%;
            aspect-ratio: 16 / 9;
        }
        .video-player {
            width: 100%;
            height: 100%;
            object-fit: contain;
            background: #000;
        }
        .video-info-box {
            background: var(--card-bg);
            border-radius: 14px;
            padding: 24px;
            margin-top: 18px;
            border: 1px solid var(--border);
        }
        .video-main-title {
            font-size: 22px;
            font-weight: 800;
            line-height: 1.4;
            color: white;
            margin-bottom: 12px;
        }
        .stats-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border);
            font-size: 13.5px;
            color: var(--text-muted);
        }
        .author-box {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 18px;
            margin-bottom: 18px;
        }
        .author-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: 700;
            color: white;
        }
        .author-name { font-weight: 700; color: white; font-size: 15px; }
        .author-sub { font-size: 12.5px; color: var(--text-muted); }
        .description-box {
            background: rgba(15, 23, 42, 0.6);
            border-radius: 10px;
            padding: 16px;
            font-size: 14px;
            line-height: 1.6;
            color: #cbd5e1;
            white-space: pre-line;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* Sidebar Playlist */
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }
        .sidebar-header {
            font-size: 16.5px;
            font-weight: 700;
            color: white;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--border);
        }
        .related-card {
            display: flex;
            gap: 12px;
            text-decoration: none;
            background: var(--card-bg);
            padding: 10px;
            border-radius: 10px;
            border: 1px solid transparent;
            transition: all 0.2s;
        }
        .related-card:hover {
            border-color: #3b82f6;
            transform: translateX(4px);
            background: #243247;
        }
        .related-thumb {
            width: 120px;
            height: 72px;
            border-radius: 6px;
            object-fit: cover;
            background: #0f172a;
            flex-shrink: 0;
        }
        .related-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
        }
        .related-title {
            font-size: 13.5px;
            font-weight: 600;
            color: #f1f5f9;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.35;
        }
        .related-meta {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 4px;
        }
        .btn-action-back {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #334155;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 600;
            margin-top: 14px;
            transition: all 0.2s;
        }
        .btn-action-back:hover { background: #475569; }
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
        <a href="${pageContext.request.contextPath}/home" class="nav-item">&larr; Về Trang Chủ</a>
        <a href="${pageContext.request.contextPath}/video" class="nav-item">Kênh Video (/video)</a>
        <a href="${pageContext.request.contextPath}/admin/video/list" class="nav-item">Quản Lý Videos</a>
        <span class="student-pill">Nguyễn Thanh Tâm | 24133052</span>
    </div>
</header>

<div class="container">
    <!-- Cột Phát Video Chính -->
    <div class="main-column">
        <!-- Player Container: Hỗ trợ YouTube Embed (Shorts/Watch) và HTML5 Video MP4 -->
        <div class="player-container">
            <c:choose>
                <c:when test="${video.youTube}">
                    <iframe src="${video.embedUrl}" width="100%" height="100%" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen style="border:none; width: 100%; height: 100%;"></iframe>
                </c:when>
                <c:when test="${not empty video.url and (video.url.startsWith('http://') or video.url.startsWith('https://'))}">
                    <video controls autoplay class="video-player">
                        <source src="${video.url}" type="video/mp4">
                        Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
                    </video>
                </c:when>
                <c:when test="${not empty video.url}">
                    <!-- Video tải lên server qua Multipart -->
                    <video controls autoplay class="video-player">
                        <source src="${pageContext.request.contextPath}/media?fname=${video.url}" type="video/mp4">
                        Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
                    </video>
                </c:when>
                <c:otherwise>
                    <!-- Video mặc định -->
                    <iframe src="https://www.youtube.com/embed/R9Z8_lJ_g7Y" width="100%" height="100%" frameborder="0" allowfullscreen style="border:none; width: 100%; height: 100%;"></iframe>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Thông Tin Video -->
        <div class="video-info-box">
            <h1 class="video-main-title">${video.title}</h1>

            <div class="stats-bar">
                <div>
                    <span>👁️ <b>${video.views}</b> lượt xem</span> &bull; 
                    <span>Mã sản phẩm: <code>${video.videoId}</code></span> &bull; 
                    <span>Trạng thái: 
                        <c:choose>
                            <c:when test="${video.active}"><span style="color: #4ade80;">Đang kinh doanh</span></c:when>
                            <c:otherwise><span style="color: #f87171;">Tạm ẩn</span></c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div>Đăng ngày: ${video.createdDate}</div>
            </div>

            <div class="author-box">
                <div class="author-avatar">${not empty video.userFullName ? video.userFullName.substring(0, 1) : 'U'}</div>
                <div>
                    <div class="author-name">${not empty video.userFullName ? video.userFullName : 'Nguyễn Thanh Tâm'}</div>
                    <div class="author-sub">Người đăng tải: @${not empty video.username ? video.username : 'syber096'} (User ID: #${video.userId})</div>
                </div>
            </div>

            <div class="description-box">
                <b>Mô tả sản phẩm:</b><br/>
                ${video.description}
            </div>

            <div style="margin-top: 18px; display: flex; gap: 10px;">
                <a href="${pageContext.request.contextPath}/home" class="btn-action-back">&larr; Quay lại Trang chủ</a>
                <a href="${pageContext.request.contextPath}/video" class="btn-action-back">Xem Kênh Video (/video)</a>
                <a href="${pageContext.request.contextPath}/admin/video/edit?id=${video.videoId}" class="btn-action-back" style="background: #2563eb;">Chỉnh sửa video này</a>
            </div>
        </div>
    </div>

    <!-- Cột Danh Sách Gợi Ý Video Thời Trang Khác -->
    <div class="sidebar">
        <div class="sidebar-header">Video Thời Trang Gợi Ý</div>

        <c:forEach items="${relatedVideos}" var="rv">
            <a href="${pageContext.request.contextPath}/video/detail?id=${rv.videoId}" class="related-card">
                <img src="${rv.posterUrl}" class="related-thumb" alt="${rv.title}" onerror="this.src='https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=300';"/>
                <div class="related-body">
                    <div class="related-title">${rv.title}</div>
                    <div class="related-meta">
                        <span>👁️ ${rv.views} views</span>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</div>

</body>
</html>
