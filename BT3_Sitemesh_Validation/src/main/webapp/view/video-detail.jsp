<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title} - Fashion Showcase</title>
    <style>
        /* Dark player area */
        .player-wrapper {
            background: #000;
            border-radius: 12px;
            overflow: hidden;
            aspect-ratio: 16/9;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .player-wrapper iframe,
        .player-wrapper video {
            width: 100%; height: 100%; border: none; display: block;
        }

        /* Sidebar related */
        .related-card {
            display: flex; gap: 10px; align-items: flex-start;
            text-decoration: none; color: #0f172a;
            padding: 10px; border-radius: 10px; transition: background 0.15s;
            border-bottom: 1px solid #f1f5f9;
        }
        .related-card:hover { background: #f8fafc; color: #0f172a; }
        .related-thumb {
            width: 100px; height: 65px; object-fit: cover;
            border-radius: 8px; flex-shrink: 0;
            border: 1px solid #e2e8f0;
        }
        .related-title { font-size: 13px; font-weight: 700; line-height: 1.4;
            overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .related-meta { font-size: 11.5px; color: #64748b; margin-top: 4px; }
        .author-avatar {
            width: 46px; height: 46px; border-radius: 50%;
            background: #2563eb; display: flex; align-items: center;
            justify-content: center; font-size: 20px; font-weight: 800; color: white;
        }
    </style>
</head>
<body>

<div class="container-fluid px-lg-4 py-4">
    <div class="row g-4">

        <!-- Cột phát video chính -->
        <div class="col-lg-8">

            <!-- Player -->
            <div class="player-wrapper mb-3">
                <c:choose>
                    <c:when test="${video.youTube}">
                        <iframe src="${video.embedUrl}"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                allowfullscreen></iframe>
                    </c:when>
                    <c:when test="${not empty video.url and (video.url.startsWith('http://') or video.url.startsWith('https://'))}">
                        <video controls autoplay>
                            <source src="${video.url}" type="video/mp4">
                            Trình duyệt không hỗ trợ HTML5 Video.
                        </video>
                    </c:when>
                    <c:when test="${not empty video.url}">
                        <video controls autoplay>
                            <source src="${pageContext.request.contextPath}/media?fname=${video.url}" type="video/mp4">
                            Trình duyệt không hỗ trợ HTML5 Video.
                        </video>
                    </c:when>
                    <c:otherwise>
                        <iframe src="https://www.youtube.com/embed/R9Z8_lJ_g7Y"
                                allow="autoplay; encrypted-media" allowfullscreen></iframe>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Thông tin video -->
            <div class="card border-0 shadow-sm mb-3">
                <div class="card-body">
                    <h4 class="fw-bold mb-2">${video.title}</h4>

                    <div class="d-flex flex-wrap gap-3 align-items-center border-bottom pb-3 mb-3 text-muted small">
                        <span><i class="bi bi-eye me-1"></i><strong>${video.views}</strong> lượt xem</span>
                        <span>•</span>
                        <span>Mã sản phẩm: <code>${video.videoId}</code></span>
                        <span>•</span>
                        <span>Trạng thái:
                            <c:choose>
                                <c:when test="${video.active}">
                                    <span class="text-success fw-semibold">Đang kinh doanh</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary fw-semibold">Tạm ẩn</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span class="ms-auto">Đăng ngày: ${video.createdDate}</span>
                    </div>

                    <!-- Author -->
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="author-avatar">
                            ${not empty video.userFullName ? video.userFullName.substring(0,1).toUpperCase() : 'U'}
                        </div>
                        <div>
                            <div class="fw-bold">${not empty video.userFullName ? video.userFullName : 'Nguyễn Thanh Tâm'}</div>
                            <div class="text-muted small">
                                Người đăng tải: @${not empty video.username ? video.username : 'syber096'} (User ID: #${video.userId})
                            </div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="bg-light rounded p-3 mb-3">
                        <strong>Mô tả sản phẩm:</strong><br>
                        ${video.description}
                    </div>

                    <!-- Action buttons -->
                    <div class="d-flex flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại Trang chủ
                        </a>
                        <a href="${pageContext.request.contextPath}/video" class="btn btn-outline-primary btn-sm">
                            <i class="bi bi-collection-play me-1"></i>Xem Kênh Video (/video)
                        </a>
                        <c:if test="${not empty sessionScope.account}">
                            <a href="${pageContext.request.contextPath}/admin/video/edit?id=${video.videoId}"
                               class="btn btn-primary btn-sm">
                                <i class="bi bi-pencil me-1"></i>Chỉnh sửa video này
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar: Video gợi ý -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white fw-bold border-bottom py-3">
                    <i class="bi bi-collection-play-fill text-danger me-2"></i>Video Thời Trang Gợi Ý
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty relatedVideos}">
                            <c:forEach items="${relatedVideos}" var="rv">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${rv.videoId}" class="related-card d-flex">
                                    <img src="${not empty rv.posterUrl ? rv.posterUrl : 'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=300'}"
                                         class="related-thumb" alt="${rv.title}"
                                         onerror="this.src='https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=300';">
                                    <div>
                                        <div class="related-title">${rv.title}</div>
                                        <div class="related-meta">
                                            <i class="bi bi-eye"></i> ${rv.views} views
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="p-4 text-center text-muted">
                                <i class="bi bi-camera-video fs-2 d-block mb-2"></i>
                                Không có video gợi ý.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
