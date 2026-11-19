<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Fashion Showcase</title>
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #1e3a8a 0%, #0f172a 100%);
            color: white;
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 28px;
        }
        .hero-banner h1 { font-size: 1.6rem; font-weight: 800; }
        .hero-banner p { color: #94a3b8; font-size: 14px; }
        .video-card { transition: transform 0.2s, box-shadow 0.2s; border: none; }
        .video-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(0,0,0,0.1) !important; }
        .poster-wrapper { position: relative; display: block; border-radius: 10px; overflow: hidden; }
        .poster-img { width: 100%; height: 170px; object-fit: cover; }
        .play-overlay {
            position: absolute; inset: 0; display: flex;
            align-items: center; justify-content: center;
            background: rgba(0,0,0,0.25); opacity: 0; transition: opacity 0.2s;
        }
        .poster-wrapper:hover .play-overlay { opacity: 1; }
        .play-btn {
            width: 52px; height: 52px; background: rgba(220,38,38,0.9);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
        }
        .video-title { font-size: 14px; font-weight: 700; color: #0f172a;
            overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .video-meta { font-size: 12px; color: #64748b; margin-top: 4px; }
        .section-label { font-size: 18px; font-weight: 800; }
        .quick-card { display: flex; align-items: center; gap: 14px;
            background: white; border-radius: 12px; padding: 16px 20px;
            border: 1px solid #e2e8f0; text-decoration: none; color: #0f172a;
            transition: all 0.15s; }
        .quick-card:hover { border-color: #2563eb; box-shadow: 0 4px 12px rgba(37,99,235,0.1); }
        .quick-icon { width: 46px; height: 46px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center; font-size: 22px; }
    </style>
</head>
<body>

<div class="container-fluid px-lg-4 py-4">

    <!-- Hero Banner -->
    <div class="hero-banner d-flex justify-content-between align-items-center flex-wrap gap-3">
        <div>
            <h1 class="mb-2">Khám Phá Video Giới Thiệu Sản Phẩm Mới Nhất</h1>
            <p class="mb-0">
                Trưng bày các bộ sưu tập thời trang, quần áo, phụ kiện và sản phẩm bán chạy nhất.<br>
                Sinh viên thực hiện: <strong>Nguyễn Thanh Tâm</strong> (MSSV: 24133052) - GVHD: ThS. Nguyễn Hữu Trung
            </p>
        </div>
        <div class="d-flex gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/video" class="btn btn-primary fw-semibold">
                <i class="bi bi-play-circle me-1"></i>Xem Kênh Video /video
            </a>
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-outline-light fw-semibold">
                + Đăng Video Mới
            </a>
        </div>
    </div>

    <!-- Section: 10 Video Mới Nhất -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="d-flex align-items-center gap-2">
            <span class="section-label">🔥 10 Video Mới Nhất Trên Hệ Thống</span>
            <span class="badge bg-danger">${not empty latestVideos ? latestVideos.size() : 0} Video</span>
        </div>
        <a href="${pageContext.request.contextPath}/video" class="text-primary fw-semibold text-decoration-none" style="font-size:14px;">
            Xem tất cả &rarr;
        </a>
    </div>

    <div class="row row-cols-2 row-cols-md-4 g-3 mb-4">
        <c:choose>
            <c:when test="${not empty latestVideos}">
                <c:forEach items="${latestVideos}" var="v">
                    <div class="col">
                        <div class="card video-card shadow-sm h-100">
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="poster-wrapper">
                                <img src="${not empty v.posterUrl ? v.posterUrl : 'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=600'}"
                                     class="poster-img" alt="${v.title}"
                                     onerror="this.src='https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=600';">
                                <div class="play-overlay">
                                    <div class="play-btn"><i class="bi bi-play-fill text-white fs-4"></i></div>
                                </div>
                            </a>
                            <div class="card-body p-2">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}"
                                   class="video-title d-block text-decoration-none" title="${v.title}">
                                    ${v.title}
                                </a>
                                <div class="video-meta">
                                    <span>👤 ${not empty v.userFullName ? v.userFullName : v.username}</span>
                                    &nbsp;•&nbsp;
                                    <span>👁️ ${v.views} lượt xem</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5 text-muted">
                    <div style="font-size:40px;">🎬</div>
                    <p class="mt-2">Chưa có video nào. Hãy bấm <strong>"Đăng Video Mới"</strong> để thêm video đầu tiên!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Section: Phím tắt chức năng -->
    <div class="mb-3">
        <span class="section-label">⚡ Lối Tắt Đến Các Chức Năng Bài Tập</span>
    </div>

    <div class="row row-cols-1 row-cols-md-4 g-3">
        <div class="col">
            <a href="${pageContext.request.contextPath}/video" class="quick-card">
                <div class="quick-icon" style="background:#fef2f2; color:#ef4444;">🎬</div>
                <div>
                    <div class="fw-bold" style="font-size:14px;">Kênh Video (/video)</div>
                    <div class="text-muted" style="font-size:12px;">Phân trang 6 video/trang</div>
                </div>
            </a>
        </div>
        <div class="col">
            <a href="${pageContext.request.contextPath}/admin/video/list" class="quick-card">
                <div class="quick-icon" style="background:#eff6ff; color:#2563eb;">🛠️</div>
                <div>
                    <div class="fw-bold" style="font-size:14px;">Quản Lý Videos</div>
                    <div class="text-muted" style="font-size:12px;">Thêm, Sửa, Xóa & Upload</div>
                </div>
            </a>
        </div>
        <div class="col">
            <a href="${pageContext.request.contextPath}/admin/category/list" class="quick-card">
                <div class="quick-icon" style="background:#ecfdf5; color:#10b981;">📦</div>
                <div>
                    <div class="fw-bold" style="font-size:14px;">Danh Mục Bán Hàng</div>
                    <div class="text-muted" style="font-size:12px;">CRUD Category MVC</div>
                </div>
            </a>
        </div>
        <div class="col">
            <a href="${pageContext.request.contextPath}/login" class="quick-card">
                <div class="quick-icon" style="background:#fef3c7; color:#d97706;">🔐</div>
                <div>
                    <div class="fw-bold" style="font-size:14px;">Tài Khoản & OTP</div>
                    <div class="text-muted" style="font-size:12px;">Bảo mật BCrypt + Gmail</div>
                </div>
            </a>
        </div>
    </div>

</div>

</body>
</html>
