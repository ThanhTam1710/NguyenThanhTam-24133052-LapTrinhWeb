<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kênh Video Của: ${account.fullName}</title>
    <style>
        .video-card { border: none; transition: transform 0.2s, box-shadow 0.2s; }
        .video-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(0,0,0,0.1) !important; }
        .poster-wrapper { position: relative; display: block; border-radius: 10px 10px 0 0; overflow: hidden; }
        .poster-img { width: 100%; height: 170px; object-fit: cover; }
        .play-overlay {
            position: absolute; inset: 0;
            display: flex; align-items: center; justify-content: center;
            background: rgba(0,0,0,0.25); opacity: 0; transition: opacity 0.2s;
        }
        .poster-wrapper:hover .play-overlay { opacity: 1; }
        .play-btn { width: 52px; height: 52px; background: rgba(220,38,38,0.9);
            border-radius: 50%; display: flex; align-items: center; justify-content: center; }
        .video-title { font-size: 14px; font-weight: 700; color: #0f172a;
            overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .channel-header {
            background: linear-gradient(135deg, #1e3a8a 0%, #0f172a 100%);
            color: white; border-radius: 16px; padding: 24px 28px;
        }
        .avatar-circle {
            width: 56px; height: 56px; border-radius: 50%;
            background: #2563eb; display: flex; align-items: center;
            justify-content: center; font-size: 24px; font-weight: 700; color: white;
            border: 3px solid rgba(255,255,255,0.3);
        }
    </style>
</head>
<body>

<div class="container-fluid px-lg-4 py-4" style="max-width: 1200px; margin: auto;">

    <!-- Channel Header -->
    <div class="channel-header mb-4 d-flex justify-content-between align-items-center flex-wrap gap-3">
        <div class="d-flex align-items-center gap-3">
            <div class="avatar-circle">
                ${not empty viewFullname ? viewFullname.substring(0,1).toUpperCase() : 'U'}
            </div>
            <div>
                <h4 class="mb-0 fw-bold">Kênh Video Của: ${not empty viewFullname ? viewFullname : 'Nguyễn Thanh Tâm'}</h4>
                <small class="opacity-75">(@${not empty viewUsername ? viewUsername : 'syber096'})</small><br>
                <small class="opacity-75">Tổng số: <b>${totalVideos}</b> video | Hiển thị <b>6</b> video/trang theo đề bài | Trang <b>${currentPage}</b> / <b>${totalPages}</b></small>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-light fw-semibold">
            <i class="bi bi-plus-lg me-1"></i>Tải Lên Video Mới
        </a>
    </div>

    <!-- Video Grid -->
    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
        <c:choose>
            <c:when test="${not empty videoList}">
                <c:forEach items="${videoList}" var="v">
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
                            <div class="card-body">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}"
                                   class="video-title d-block text-decoration-none mb-2" title="${v.title}">
                                    ${v.title}
                                </a>
                                <p class="text-muted small mb-2 text-truncate">${v.description}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">Mã: #${v.videoId}</small>
                                    <span class="badge bg-primary-subtle text-primary">
                                        <i class="bi bi-eye me-1"></i>${v.views} lượt xem
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5 text-muted">
                    <div style="font-size:48px;">🎬</div>
                    <p class="mt-2">Chưa có video nào trong kênh. Hãy tải lên video đầu tiên!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Phân trang -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Phân trang video">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/video?page=${currentPage - 1}">
                        &larr; Trang Trước
                    </a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <li class="page-item ${p == currentPage ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/video?page=${p}">${p}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/video?page=${currentPage + 1}">
                        Trang Sau &rarr;
                    </a>
                </li>
            </ul>
            <p class="text-center text-muted small">(Tổng cộng ${totalVideos} video - ${videosPerPage} video/trang)</p>
        </nav>
    </c:if>

</div>

</body>
</html>
