<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Videos - Admin</title>
    <style>
        .video-thumb { width: 72px; height: 50px; object-fit: cover; border-radius: 6px; border: 1px solid #dee2e6; }
        .no-thumb { width: 72px; height: 50px; background: #1e293b; border-radius: 6px;
            display: flex; align-items: center; justify-content: center; color: #94a3b8; font-size: 18px; }
    </style>
</head>
<body>

<div class="container-fluid px-lg-4 py-4" style="max-width: 1200px; margin: auto;">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold mb-0">Quản Lý Videos</h4>
            <small class="text-muted">CRUD Video - Thêm, sửa, xóa và quản lý toàn bộ video</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-primary fw-semibold">
            <i class="bi bi-plus-lg me-1"></i>Thêm Video Mới
        </a>
    </div>

    <!-- Thông báo -->
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle-fill me-2"></i>${successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th style="width:50px;" class="text-center">#</th>
                            <th style="width:80px;" class="text-center">THUMB</th>
                            <th>TIÊU ĐỀ / MÔ TẢ</th>
                            <th style="width:120px;">NGƯỜI ĐĂNG</th>
                            <th style="width:80px;" class="text-center">LƯỢT XEM</th>
                            <th style="width:120px;" class="text-center">TRẠNG THÁI</th>
                            <th style="width:160px;" class="text-center">THAO TÁC</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty videoList}">
                                <c:forEach items="${videoList}" var="v" varStatus="idx">
                                    <tr>
                                        <td class="text-center text-muted fw-semibold">${idx.index + 1}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${not empty v.posterUrl}">
                                                    <img src="${v.posterUrl}" class="video-thumb" alt="${v.title}"
                                                         onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                                                    <div class="no-thumb" style="display:none;">▶</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-thumb">▶</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="fw-semibold text-truncate" style="max-width:280px;" title="${v.title}">
                                                ${v.title}
                                            </div>
                                            <small class="text-muted">Mã: ${v.videoId}</small>
                                        </td>
                                        <td>
                                            <small>${not empty v.userFullName ? v.userFullName : v.username}</small>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-secondary">${v.views}</span>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${v.active}">
                                                    <span class="badge rounded-pill bg-success-subtle text-success border border-success-subtle">Đang hiển thị</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge rounded-pill bg-secondary-subtle text-secondary border">Ẩn</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center gap-1">
                                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}"
                                                   class="btn btn-sm btn-outline-primary" title="Xem">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/video/edit?id=${v.videoId}"
                                                   class="btn btn-sm btn-warning" title="Sửa">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/video/delete?id=${v.videoId}"
                                                   class="btn btn-sm btn-danger" title="Xóa"
                                                   onclick="return confirm('Xóa video [${v.title}]?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <div style="font-size:36px;">🎬</div>
                                        <p class="mt-2">Chưa có video nào. Hãy bấm <strong>"Thêm Video Mới"</strong>!</p>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

</body>
</html>
