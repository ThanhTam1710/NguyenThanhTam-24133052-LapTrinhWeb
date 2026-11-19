<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Fashion Showcase (BT03 SiteMesh 3)</title>
    
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f8fafc;
            color: #0f172a;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-wrapper {
            flex: 1 0 auto;
        }
        /* Navbar tùy biến */
        .navbar-custom {
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }
        .brand-badge {
            font-size: 11px;
            font-weight: 700;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            padding: 3px 8px;
            border-radius: 6px;
            margin-left: 6px;
        }
        .nav-link {
            font-weight: 600;
            font-size: 14px;
            color: #334155 !important;
            padding: 8px 14px !important;
            border-radius: 8px;
            transition: all 0.15s ease;
        }
        .nav-link:hover, .nav-link.active {
            color: #2563eb !important;
            background-color: #eff6ff;
        }
        /* Footer */
        .footer-custom {
            flex-shrink: 0;
            background: #ffffff;
            border-top: 1px solid #e2e8f0;
            padding: 32px 0 20px;
            margin-top: 48px;
            font-size: 13.5px;
            color: #64748b;
        }
        /* Style cho Form Validation */
        .was-validated .form-control:invalid, .form-control.is-invalid {
            border-color: #dc3545;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath stroke-linejoin='round' d='M5.8 3.6h.4L6 6.5z'/%3e%3ccircle cx='6' cy='8.2' r='.6' fill='%23dc3545' stroke='none'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right calc(0.375em + 0.1875rem) center;
            background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
        }
        .invalid-feedback {
            font-size: 12.5px;
            font-weight: 500;
            color: #dc3545;
            margin-top: 4px;
        }
    </style>

    <!-- Điểm nhúng HEAD từ trang con -->
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- 1. Header / Navbar Decorator Bootstrap -->
    <header class="navbar-custom sticky-top">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid px-lg-4">
                <a class="navbar-brand d-flex align-items-center text-dark text-decoration-none fw-bold" href="${pageContext.request.contextPath}/home">
                    <span class="d-inline-flex align-items-center justify-content-center bg-danger text-white rounded-3 me-2" style="width: 38px; height: 38px;">
                        <i class="bi bi-play-fill fs-4"></i>
                    </span>
                    <span>Fashion Showcase</span>
                    <span class="brand-badge">SiteMesh 3</span>
                </a>

                <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house-door me-1"></i> Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/video">
                                <i class="bi bi-collection-play me-1"></i> Video Của Tôi
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/video/list">
                                <i class="bi bi-camera-video me-1"></i> Quản Lý Videos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/category/list">
                                <i class="bi bi-tags me-1"></i> Quản Lý Danh Mục
                            </a>
                        </li>
                    </ul>

                    <!-- Khu vực người dùng / Đăng nhập -->
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-light text-secondary border px-3 py-2 fw-medium d-none d-xl-inline-block">
                            <i class="bi bi-person-badge text-primary me-1"></i> Nguyễn Thanh Tâm | 24133052
                        </span>

                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                                <div class="dropdown">
                                    <button class="btn btn-outline-primary btn-sm dropdown-toggle fw-semibold rounded-pill px-3 py-1.5" type="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle me-1"></i>
                                        ${not empty sessionScope.name ? sessionScope.name : sessionScope.account.userName}
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 rounded-3 mt-2">
                                        <li class="px-3 py-2 border-bottom">
                                            <div class="fw-bold">${sessionScope.name}</div>
                                            <small class="text-muted">@${sessionScope.account.userName}</small>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/video">
                                                <i class="bi bi-film me-2 text-primary"></i> Kênh video cá nhân
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/category/list">
                                                <i class="bi bi-grid me-2 text-success"></i> Quản lý danh mục
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider my-1"></li>
                                        <li>
                                            <a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm px-3 fw-semibold rounded-pill">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Nhập
                                </a>
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-secondary btn-sm px-3 fw-semibold rounded-pill">
                                    <i class="bi bi-person-plus me-1"></i> Đăng Ký
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- 2. Điểm nhúng BODY chính từ trang con qua SiteMesh 3 -->
    <main class="main-wrapper py-4">
        <sitemesh:write property='body'/>
    </main>

    <!-- 3. Footer Decorator Bootstrap -->
    <footer class="footer-custom">
        <div class="container-fluid px-lg-4">
            <div class="row g-4 pb-3">
                <div class="col-md-5">
                    <div class="fw-bold fs-6 text-dark d-flex align-items-center mb-2">
                        <i class="bi bi-layers-fill text-primary me-2"></i>
                        Bài Tập 03: SiteMesh Decorator 3 & Form Validation
                    </div>
                    <p class="mb-2">
                        Ứng dụng Java Servlet 6.0 trên nền tảng Apache Tomcat 10.1, tích hợp thư viện SiteMesh 3 để trang trí giao diện Bootstrap 5 tự động và hoàn thiện hệ thống kiểm tra tính hợp lệ dữ liệu (Validation) ở cả 2 phía Client và Server.
                    </p>
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle">SiteMesh 3.3.0</span>
                    <span class="badge bg-success-subtle text-success border border-success-subtle ms-1">Bootstrap 5.3.3</span>
                    <span class="badge bg-info-subtle text-info border border-info-subtle ms-1">Jakarta EE 10</span>
                </div>

                <div class="col-md-3">
                    <div class="fw-bold text-dark mb-2">Chức Năng Đã Validation</div>
                    <ul class="list-unstyled mb-0">
                        <li class="mb-1"><i class="bi bi-check2-circle text-success me-1"></i> Đăng Nhập (Login Form)</li>
                        <li class="mb-1"><i class="bi bi-check2-circle text-success me-1"></i> Đăng Ký Tài Khoản (Register Form)</li>
                        <li class="mb-1"><i class="bi bi-check2-circle text-success me-1"></i> Quên Mật Khẩu & OTP (Forgot Form)</li>
                        <li class="mb-1"><i class="bi bi-check2-circle text-success me-1"></i> Thêm Mới Danh Mục & Video (Insert Form)</li>
                        <li class="mb-1"><i class="bi bi-check2-circle text-success me-1"></i> Chỉnh Sửa Dữ Liệu (Edit Form)</li>
                    </ul>
                </div>

                <div class="col-md-4 text-md-end">
                    <div class="fw-bold text-dark mb-1">Trường Đại Học Sư Phạm Kỹ Thuật TP.HCM (HCMUTE)</div>
                    <div class="mb-1">Môn học: <b>Lập trình Web (WEBPR330479)</b></div>
                    <div class="mb-1">Giảng viên hướng dẫn: <b>ThS. Nguyễn Hữu Trung</b></div>
                    <div class="text-primary fw-semibold">Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052</div>
                </div>
            </div>

            <div class="pt-3 border-top text-center text-muted" style="font-size: 12.5px;">
                © 2026 Fashion Showcase. Bản quyền bài tập thuộc về Nguyễn Thanh Tâm (24133052) - HCMUTE.
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Script Kích hoạt Bootstrap Form Validation toàn cục cho mọi Form có class .needs-validation -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            'use strict';
            // Bắt tất cả các form cần validate
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        });
    </script>
</body>
</html>
