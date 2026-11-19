<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Danh Mục</title>
</head>
<body>

<div class="container py-3">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                    <div class="d-inline-flex align-items-center justify-content-center bg-primary-subtle text-primary rounded-3 me-3" style="width: 48px; height: 48px;">
                        <i class="bi bi-pencil-square fs-4"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Chỉnh Sửa Danh Mục</h4>
                        <small class="text-muted">Cập nhật thông tin danh mục mã ID: #${category.id}</small>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger small py-2 px-3 rounded-3 mb-3">${error}</div>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger small py-2 px-3 rounded-3 mb-3">${errorMsg}</div>
                </c:if>

                <!-- FORM CHỈNH SỬA DANH MỤC CÓ VALIDATION -->
                <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <!-- ID ẩn -->
                    <input type="hidden" name="id" value="${category.id}">

                    <!-- Tên danh mục -->
                    <div class="mb-3">
                        <label for="name" class="form-label fw-semibold small text-secondary">
                            Tên danh mục sản phẩm <span class="text-danger">*</span>
                        </label>
                        <input type="text" id="name" name="name" class="form-control" 
                               value="${category.name}" required minlength="2" maxlength="100" autofocus>
                        <div class="invalid-feedback">
                            Tên danh mục không được để trống (từ 2 đến 100 ký tự).
                        </div>
                    </div>

                    <!-- Ảnh minh họa hiện tại -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-secondary d-block">Ảnh đại diện hiện tại:</label>
                        <div class="p-2 border rounded-3 bg-light d-flex align-items-center gap-3">
                            <c:choose>
                                <c:when test="${not empty category.iconUrl}">
                                    <img src="${category.iconUrl}" class="rounded-2 shadow-sm" style="width: 60px; height: 60px; object-fit: cover;" alt="${category.name}">
                                    <small class="text-muted text-break">Đường dẫn: ${category.icon}</small>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-muted small ps-2"><i class="bi bi-image me-1"></i> Chưa có ảnh đại diện</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Chọn ảnh mới -->
                    <div class="mb-4">
                        <label for="icon" class="form-label fw-semibold small text-secondary">
                            Chọn ảnh thay thế (để trống nếu giữ nguyên):
                        </label>
                        <input type="file" id="icon" name="icon" class="form-control" accept="image/png, image/jpeg, image/jpg, image/webp">
                        <div class="form-text text-muted small">Hỗ trợ các định dạng ảnh: JPG, PNG, WEBP.</div>
                    </div>

                    <!-- Nút hành động -->
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary fw-semibold px-4 py-2 rounded-3 shadow-sm">
                            <i class="bi bi-check-circle me-1"></i> Cập Nhật Thay Đổi
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
