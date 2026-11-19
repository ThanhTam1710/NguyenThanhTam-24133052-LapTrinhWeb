<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Video - ${video.title}</title>
    <style>
        .preview-thumb {
            max-width: 220px;
            max-height: 130px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            object-fit: cover;
        }
    </style>
</head>
<body>

<div class="container py-4" style="max-width: 760px;">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/video/list">Quản Lý Video</a></li>
            <li class="breadcrumb-item active">Chỉnh Sửa Video</li>
        </ol>
    </nav>

    <!-- Server-side error -->
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white py-3">
            <h5 class="mb-0">
                <i class="bi bi-pencil-square me-2"></i>Chỉnh Sửa Video Sản Phẩm
                <span class="badge bg-white text-primary ms-2 fs-6">#${video.videoId}</span>
            </h5>
            <small class="opacity-75">Người đăng: ${video.userFullName}</small>
        </div>

        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/admin/video/edit"
                  method="post"
                  enctype="multipart/form-data"
                  class="needs-validation" novalidate>

                <input type="hidden" name="videoId" value="${video.videoId}">

                <!-- Tiêu đề -->
                <div class="mb-3">
                    <label for="title" class="form-label fw-semibold">
                        Tên Sản Phẩm / Tiêu Đề Video <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" id="title" name="title"
                           value="${video.title}"
                           required minlength="3" maxlength="255" autofocus
                           placeholder="Nhập tiêu đề video...">
                    <div class="invalid-feedback">Tiêu đề bắt buộc (tối thiểu 3 ký tự).</div>
                </div>

                <!-- Poster URL -->
                <div class="mb-3">
                    <label for="posterUrl" class="form-label fw-semibold">
                        Link Ảnh Poster (URL trực tuyến)
                    </label>
                    <input type="url" class="form-control" id="posterUrl" name="posterUrl"
                           value="${video.poster}"
                           placeholder="https://images.unsplash.com/...">
                    <div class="invalid-feedback">URL ảnh không hợp lệ.</div>
                    <c:if test="${not empty video.poster}">
                        <div class="mt-2">
                            <small class="text-muted">Ảnh hiện tại:</small><br>
                            <img src="${video.poster}" class="preview-thumb mt-1" alt="Poster hiện tại"
                                 onerror="this.style.display='none'">
                        </div>
                    </c:if>
                </div>

                <!-- Upload ảnh mới -->
                <div class="mb-3">
                    <label for="posterFile" class="form-label fw-semibold">
                        Hoặc Tải Lên File Ảnh Bìa Mới
                    </label>
                    <input type="file" class="form-control" id="posterFile" name="posterFile"
                           accept="image/jpeg,image/png,image/webp,image/gif">
                    <div class="form-text">Nếu chọn file sẽ ưu tiên dùng file thay cho URL ở trên.</div>
                </div>

                <!-- YouTube URL -->
                <div class="mb-3">
                    <label for="url" class="form-label fw-semibold">
                        Đường Dẫn Video YouTube <span class="text-danger">*</span>
                    </label>
                    <input type="url" class="form-control" id="url" name="url"
                           value="${video.url}"
                           required
                           placeholder="https://www.youtube.com/watch?v=... hoặc https://youtu.be/...">
                    <div class="invalid-feedback">Vui lòng nhập URL YouTube hợp lệ.</div>
                    <c:if test="${not empty video.url}">
                        <div class="form-text text-truncate">
                            <i class="bi bi-link-45deg"></i> Hiện tại: <span class="text-primary">${video.url}</span>
                        </div>
                    </c:if>
                </div>

                <!-- Upload video file -->
                <div class="mb-3">
                    <label for="videoFile" class="form-label fw-semibold">
                        Hoặc Tải Lên File Video MP4 Mới
                    </label>
                    <input type="file" class="form-control" id="videoFile" name="videoFile"
                           accept="video/mp4,video/webm">
                    <div class="form-text">File MP4/WebM mới sẽ thay thế video hiện tại.</div>
                </div>

                <!-- Mô tả -->
                <div class="mb-3">
                    <label for="description" class="form-label fw-semibold">Mô Tả Sản Phẩm & Video</label>
                    <textarea class="form-control" id="description" name="description"
                              rows="4" maxlength="2000"
                              placeholder="Nhập mô tả chi tiết về sản phẩm...">${video.description}</textarea>
                    <div class="form-text text-end"><span id="descCount">0</span>/2000 ký tự</div>
                </div>

                <!-- Trạng thái -->
                <div class="mb-4">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="active" name="active"
                               ${video.active ? 'checked' : ''}>
                        <label class="form-check-label fw-semibold" for="active">
                            Hiển thị video này trên hệ thống
                        </label>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-save me-2"></i>Lưu Cập Nhật Video
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/video/list"
                       class="btn btn-outline-secondary px-4">
                        <i class="bi bi-arrow-left me-1"></i>Hủy & Quay Lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Đếm ký tự textarea
    const desc = document.getElementById('description');
    const counter = document.getElementById('descCount');
    if (desc && counter) {
        counter.textContent = desc.value.length;
        desc.addEventListener('input', () => { counter.textContent = desc.value.length; });
    }
    // Preview ảnh poster khi nhập URL
    const posterUrlInput = document.getElementById('posterUrl');
    if (posterUrlInput) {
        posterUrlInput.addEventListener('blur', function() {
            const url = this.value.trim();
            if (url) {
                const imgs = document.querySelectorAll('.preview-thumb');
                if (imgs.length) { imgs[0].src = url; imgs[0].style.display = 'block'; }
            }
        });
    }
</script>
</body>
</html>
