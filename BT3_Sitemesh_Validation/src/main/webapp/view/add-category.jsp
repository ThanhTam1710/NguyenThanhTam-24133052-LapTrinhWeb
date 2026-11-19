<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Danh Mục Sản Phẩm</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                    <div class="d-inline-flex align-items-center justify-content-center bg-success-subtle text-success rounded-3 me-3" style="width: 48px; height: 48px;">
                        <i class="bi bi-folder-plus fs-4"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Thêm Mới Danh Mục</h4>
                        <small class="text-muted">Nhập thông tin danh mục sản phẩm thời trang kinh doanh</small>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger small py-2 px-3 rounded-3 mb-3">${error}</div>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger small py-2 px-3 rounded-3 mb-3">${errorMsg}</div>
                </c:if>

                <!-- FORM THÊM MỚI DANH MỤC CÓ VALIDATION -->
                <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <!-- Tên danh mục -->
                    <div class="mb-3">
                        <label for="name" class="form-label fw-semibold small text-secondary">
                            Tên danh mục sản phẩm <span class="text-danger">*</span>
                        </label>
                        <input type="text" id="name" name="name" class="form-control" 
                               value="${not empty param.name ? param.name : ''}"
                               placeholder="Ví dụ: Áo Thun Nam, Váy Dạ Hội, Trang Sức..." required minlength="2" maxlength="100" autofocus>
                        <div class="invalid-feedback">
                            Tên danh mục không được để trống (tối thiểu từ 2 đến 100 ký tự).
                        </div>
                    </div>

                    <!-- Ảnh minh họa icon -->
                    <div class="mb-4">
                        <label for="icon" class="form-label fw-semibold small text-secondary">
                            Hình ảnh minh họa (Icon / Poster)
                        </label>
                        <input type="file" id="icon" name="icon" class="form-control" accept="image/png, image/jpeg, image/jpg, image/webp">
                        <div class="form-text text-muted small">Hỗ trợ các định dạng ảnh: JPG, PNG, WEBP.</div>
                    </div>

                    <!-- Nút hành động -->
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success fw-semibold px-4 py-2 rounded-3 shadow-sm">
                            <i class="bi bi-plus-circle me-1"></i> Lưu Danh Mục
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary fw-semibold px-3 py-2 rounded-3">
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
