<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Mục Bán Hàng - Quản Lý</title>
    <style>
        .cate-img { width: 48px; height: 48px; object-fit: cover; border-radius: 8px; border: 1px solid #dee2e6; }
        .no-img-box { width: 48px; height: 48px; background: #f1f5f9; border-radius: 8px;
            display: flex; align-items: center; justify-content: center; font-size: 22px; border: 1px solid #dee2e6; }
    </style>
</head>
<body>

<div class="container-fluid px-lg-4 py-4" style="max-width: 1100px; margin: auto;">

    <!-- Thống kê nhanh -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="rounded-3 d-flex align-items-center justify-content-center"
                         style="width:50px;height:50px;background:#eff6ff;font-size:24px;">📦</div>
                    <div>
                        <div class="fw-bold fs-4">${not empty cateList ? cateList.size() : 0}</div>
                        <div class="text-muted small">Tổng Danh Mục Sản Phẩm</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="rounded-3 d-flex align-items-center justify-content-center"
                         style="width:50px;height:50px;background:#ecfdf5;font-size:24px;">🛡️</div>
                    <div>
                        <div class="fw-bold fs-5 text-success">Bảo Mật Kép</div>
                        <div class="text-muted small">BCrypt Hash + OTP Email</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="rounded-3 d-flex align-items-center justify-content-center"
                         style="width:50px;height:50px;background:#fef3c7;font-size:24px;">📺</div>
                    <div>
                        <div class="fw-bold fs-5 text-warning">Kênh Bán Hàng</div>
                        <div class="text-muted small">Mô hình MVC 3 Tầng</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Thông báo -->
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Main Table Card -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <div>
                <h5 class="mb-0 fw-bold">Danh Sách Danh Mục Sản Phẩm</h5>
                <small class="text-muted">Quản lý các nhóm mặt hàng, danh mục sản phẩm kinh doanh của cửa hàng</small>
            </div>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success fw-semibold">
                <i class="bi bi-plus-lg me-1"></i>Thêm Mới Danh Mục
            </a>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width:70px;">STT</th>
                            <th class="text-center" style="width:90px;">HÌNH ẢNH</th>
                            <th>TÊN DANH MỤC SẢN PHẨM</th>
                            <th class="text-center" style="width:160px;">TRẠNG THÁI</th>
                            <th class="text-center" style="width:180px;">THAO TÁC</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty cateList}">
                                <c:forEach items="${cateList}" var="cate" varStatus="stt">
                                    <tr>
                                        <td class="text-center fw-semibold text-muted">${stt.index + 1}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${not empty cate.iconUrl}">
                                                    <img src="${cate.iconUrl}" class="cate-img" alt="${cate.name}"
                                                         onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                                                    <div class="no-img-box" style="display:none;">🏷️</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-img-box mx-auto">🏷️</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="fw-semibold">${cate.name}</div>
                                            <small class="text-muted">Mã phân loại ID: #${cate.id}</small>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge rounded-pill bg-success-subtle text-success border border-success-subtle px-3 py-2">
                                                Đang kinh doanh
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}"
                                                   class="btn btn-sm btn-warning fw-semibold">
                                                    <i class="bi bi-pencil me-1"></i>Sửa
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}"
                                                   class="btn btn-sm btn-danger fw-semibold"
                                                   onclick="return confirm('Bạn có chắc muốn xóa danh mục [${cate.name}]?')">
                                                    <i class="bi bi-trash me-1"></i>Xóa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <div style="font-size:36px;">📦</div>
                                        <p class="mt-2">Chưa có danh mục nào. Hãy bấm <strong>"Thêm Mới Danh Mục"</strong> ở trên!</p>
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
