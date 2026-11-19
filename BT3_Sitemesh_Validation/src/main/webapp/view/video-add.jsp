<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Mới Video Sản Phẩm</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-4 bg-white">
                <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                    <div class="d-inline-flex align-items-center justify-content-center bg-danger-subtle text-danger rounded-3 me-3" style="width: 48px; height: 48px;">
                        <i class="bi bi-camera-reels-fill fs-4"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Đăng Tải Video Sản Phẩm</h4>
                        <small class="text-muted">Hỗ trợ nhúng link YouTube Shorts hoặc tải lên file MP4 Multipart</small>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger small py-2 px-3 rounded-3 mb-3">${error}</div>
                </c:if>

                <!-- FORM THÊM MỚI VIDEO CÓ BOOTSTRAP 5 VALIDATION -->
                <form action="${pageContext.request.contextPath}/admin/video/add" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    
                    <div class="row g-3 mb-3">
                        <!-- Mã video -->
                        <div class="col-sm-5">
                            <label for="videoId" class="form-label fw-semibold small text-secondary">
                                Mã Video <small class="text-muted">(Để trống tự sinh)</small>
                            </label>
                            <input type="text" id="videoId" name="videoId" class="form-control" 
                                   value="${not empty param.videoId ? param.videoId : ''}"
                                   placeholder="Ví dụ: VID13, SP01..." maxlength="30" pattern="^[a-zA-Z0-9_-]*$">
                            <div class="invalid-feedback">
                                Mã video chỉ gồm chữ cái, số và dấu gạch.
                            </div>
                        </div>

                        <!-- Tiêu đề video -->
                        <div class="col-sm-7">
                            <label for="title" class="form-label fw-semibold small text-secondary">
                                Tiêu đề sản phẩm / Video <span class="text-danger">*</span>
                            </label>
                            <input type="text" id="title" name="title" class="form-control" 
                                   value="${not empty param.title ? param.title : ''}"
                                   placeholder="Ví dụ: BST Áo Thun Cotton Thoáng Mát..." required minlength="5" maxlength="200" autofocus>
                            <div class="invalid-feedback">
                                Tiêu đề video bắt buộc nhập (tối thiểu 5 ký tự).
                            </div>
                        </div>
                    </div>

                    <!-- Link ảnh Poster -->
                    <div class="mb-3">
                        <label for="posterUrl" class="form-label fw-semibold small text-secondary">
                            Link ảnh Poster trực tuyến (Unsplash, Pexels...)
                        </label>
                        <input type="url" id="posterUrl" name="posterUrl" class="form-control" 
                               value="${not empty param.posterUrl ? param.posterUrl : ''}"
                               placeholder="https://images.unsplash.com/photo-...">
                        <div class="form-text text-muted small">Nhập link ảnh HTTPS trực tiếp hoặc tải file từ máy tính bên dưới.</div>
                    </div>

                    <!-- Upload file Poster -->
                    <div class="mb-3">
                        <label for="posterFile" class="form-label fw-semibold small text-secondary">
                            Hoặc tải ảnh bìa Poster từ máy tính (Upload Multipart):
                        </label>
                        <input type="file" id="posterFile" name="posterFile" class="form-control" accept="image/png, image/jpeg, image/jpg, image/webp">
                    </div>

                    <!-- Link Video YouTube -->
                    <div class="mb-3">
                        <label for="url" class="form-label fw-semibold small text-secondary">
                            Link Video YouTube / Shorts <span class="text-danger">*</span>
                        </label>
                        <input type="text" id="url" name="url" class="form-control" 
                               value="${not empty param.url ? param.url : ''}"
                               placeholder="https://www.youtube.com/watch?v=... hoặc https://www.youtube.com/shorts/..." required>
                        <div class="invalid-feedback">
                            Vui lòng nhập đường dẫn video YouTube hoặc file MP4 hợp lệ.
                        </div>
                    </div>

                    <!-- Upload file Video MP4 -->
                    <div class="mb-3">
                        <label for="videoFile" class="form-label fw-semibold small text-secondary">
                            Hoặc tải tệp Video MP4 từ máy tính (Upload Multipart):
                        </label>
                        <input type="file" id="videoFile" name="videoFile" class="form-control" accept="video/mp4,video/webm">
                    </div>

                    <!-- Mô tả -->
                    <div class="mb-3">
                        <label for="description" class="form-label fw-semibold small text-secondary">
                            Mô tả chi tiết sản phẩm thời trang
                        </label>
                        <textarea id="description" name="description" class="form-control" rows="3" 
                                  placeholder="Nhập thông tin chất liệu vải, kích thước, bảng size, phong cách phối đồ...">${not empty param.description ? param.description : ''}</textarea>
                    </div>

                    <!-- Checkbox active -->
                    <div class="form-check mb-4">
                        <input class="form-check-input" type="checkbox" id="active" name="active" checked>
                        <label class="form-check-label small text-muted" for="active">
                            Kích hoạt hiển thị video này trên trang chủ và kênh video ngay sau khi đăng
                        </label>
                    </div>

                    <!-- Nút bấm -->
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-danger fw-semibold px-4 py-2 rounded-3 shadow-sm">
                            <i class="bi bi-cloud-upload me-1"></i> Đăng Tải Video
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/video/list" class="btn btn-outline-secondary fw-semibold px-3 py-2 rounded-3">
                            <i class="bi bi-x-circle me-1"></i> Hủy Bỏ
                        </a>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

</body>
</html>
