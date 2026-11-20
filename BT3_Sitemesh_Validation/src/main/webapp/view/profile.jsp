<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân - ${user.fullName}</title>
    <style>
        .avatar-preview-box {
            position: relative;
            width: 130px;
            height: 130px;
            margin: 0 auto 15px auto;
        }
        .avatar-img-circle {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ffffff;
            box-shadow: 0 4px 14px rgba(0,0,0,0.12);
        }
        .avatar-fallback-circle {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            font-size: 52px;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 4px solid #ffffff;
            box-shadow: 0 4px 14px rgba(0,0,0,0.12);
        }
        .badge-upload-btn {
            position: absolute;
            bottom: 2px;
            right: 2px;
            background: #2563eb;
            color: white;
            border-radius: 50%;
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            transition: transform 0.2s;
        }
        .badge-upload-btn:hover {
            transform: scale(1.1);
            background: #1d4ed8;
        }
    </style>
</head>
<body>

<div class="container py-4" style="max-width: 900px; margin: auto;">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Hồ Sơ Cá Nhân</li>
        </ol>
    </nav>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center shadow-sm rounded-3 mb-3" role="alert">
            <i class="bi bi-check-circle-fill fs-5 me-2"></i>
            <div>${successMsg}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center shadow-sm rounded-3 mb-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
            <div>${errorMsg}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Cột trái: Tóm tắt thông tin người dùng -->
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 text-center p-4 h-100 bg-white">
                <div class="avatar-preview-box">
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <img src="${user.avatar.startsWith('http') ? user.avatar : pageContext.request.contextPath.concat('/media?fname=').concat(user.avatar)}"
                                 id="avatarPreviewImg" class="avatar-img-circle" alt="${user.fullName}"
                                 onerror="this.style.display='none'; document.getElementById('avatarFallback').style.display='flex';">
                            <div id="avatarFallback" class="avatar-fallback-circle" style="display:none;">
                                ${not empty user.fullName ? user.fullName.substring(0,1).toUpperCase() : 'U'}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <img src="" id="avatarPreviewImg" class="avatar-img-circle" style="display:none;" alt="Avatar">
                            <div id="avatarFallback" class="avatar-fallback-circle">
                                ${not empty user.fullName ? user.fullName.substring(0,1).toUpperCase() : 'U'}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <label for="imageFile" class="badge-upload-btn" title="Chọn ảnh đại diện mới">
                        <i class="bi bi-camera-fill"></i>
                    </label>
                </div>

                <h5 class="fw-bold text-dark mb-1">${user.fullName}</h5>
                <p class="text-muted small mb-2">@${user.userName}</p>

                <div class="mb-3">
                    <span class="badge ${user.roleid == 1 ? 'bg-danger-subtle text-danger border border-danger-subtle' : 'bg-primary-subtle text-primary border border-primary-subtle'} px-3 py-1.5 rounded-pill">
                        <i class="bi ${user.roleid == 1 ? 'bi-shield-check' : 'bi-person-check'} me-1"></i>
                        ${user.roleid == 1 ? 'Quản Trị Viên (Admin)' : 'Thành Viên (User)'}
                    </span>
                </div>

                <hr class="my-3 text-secondary opacity-25">

                <div class="text-start small">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted"><i class="bi bi-envelope me-1"></i>Email:</span>
                        <span class="fw-semibold text-truncate ms-2" style="max-width: 150px;">${user.email}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted"><i class="bi bi-telephone me-1"></i>Điện thoại:</span>
                        <span class="fw-semibold">${not empty user.phone ? user.phone : 'Chưa cập nhật'}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted"><i class="bi bi-calendar-check me-1"></i>Ngày tham gia:</span>
                        <span class="fw-semibold">${user.createdDate}</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-muted"><i class="bi bi-shield-check me-1"></i>Trạng thái:</span>
                        <span class="badge bg-success-subtle text-success border border-success-subtle">Đang hoạt động</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cột phải: Form cập nhật thông tin -->
        <div class="col-md-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                    <div class="d-inline-flex align-items-center justify-content-center bg-primary-subtle text-primary rounded-3 me-3" style="width: 44px; height: 44px;">
                        <i class="bi bi-person-gear fs-4"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Chỉnh Sửa Thông Tin Cá Nhân</h4>
                        <small class="text-muted">Quản lý và cập nhật thông tin tài khoản của bạn</small>
                    </div>
                </div>

                <!-- FORM CẬP NHẬT PROFILE CÓ VALIDATION -->
                <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="profileForm">

                    <!-- Tên đăng nhập (Readonly) -->
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold small text-secondary">Tên đăng nhập (Không thể thay đổi)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-lock-fill"></i></span>
                            <input type="text" id="username" class="form-control bg-light" value="${user.userName}" readonly disabled>
                        </div>
                    </div>

                    <!-- Họ và tên -->
                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold small text-secondary">
                            Họ và tên <span class="text-danger">*</span>
                        </label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-person"></i></span>
                            <input type="text" id="fullname" name="fullname" class="form-control"
                                   value="${user.fullName}" required minlength="2" maxlength="100"
                                   placeholder="Nhập họ và tên đầy đủ...">
                            <div class="invalid-feedback">Họ và tên không được để trống (tối thiểu 2 ký tự).</div>
                        </div>
                    </div>

                    <!-- Số điện thoại -->
                    <div class="mb-3">
                        <label for="phone" class="form-label fw-semibold small text-secondary">
                            Số điện thoại liên lạc <span class="text-danger">*</span>
                        </label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-telephone"></i></span>
                            <input type="tel" id="phone" name="phone" class="form-control"
                                   value="${user.phone}" required pattern="^0[0-9]{9}$"
                                   placeholder="Ví dụ: 0987654321">
                            <div class="invalid-feedback">Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số.</div>
                        </div>
                    </div>

                    <!-- Địa chỉ Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold small text-secondary">
                            Địa chỉ Email <span class="text-danger">*</span>
                        </label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-envelope"></i></span>
                            <input type="email" id="email" name="email" class="form-control"
                                   value="${user.email}" required
                                   data-original-email="${user.email}"
                                   oninput="handleEmailChange(this)"
                                   placeholder="Nhập địa chỉ email...">
                            <div class="invalid-feedback">Vui lòng nhập định dạng email hợp lệ.</div>
                        </div>
                        <div class="form-text text-muted small mt-1">
                            Mã OTP xác nhận sẽ được gửi đến email này để xác thực thay đổi.
                        </div>
                    </div>

                    <!-- Mật khẩu xác nhận tài khoản (Bắt buộc khi đổi email) -->
                    <div class="mb-3" id="passwordConfirmGroup">
                        <label for="currentPassword" class="form-label fw-semibold small text-secondary d-flex justify-content-between align-items-center">
                            <span>Mật khẩu tài khoản <span id="pwdRequiredStar" class="text-danger" style="display:none;">*</span></span>
                            <span id="pwdHintBadge" class="badge bg-secondary-subtle text-secondary fw-normal">Chỉ cần nhập nếu đổi Email</span>
                        </label>
                        <div class="input-group has-validation">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-key"></i></span>
                            <input type="password" id="currentPassword" name="currentPassword" class="form-control"
                                   placeholder="Nhập mật khẩu hiện tại của tài khoản..." autocomplete="current-password">
                            <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordVisibility('currentPassword', 'eyeIconPwd')">
                                <i class="bi bi-eye" id="eyeIconPwd"></i>
                            </button>
                            <div class="invalid-feedback" id="pwdInvalidFeedback">
                                Vui lòng nhập mật khẩu tài khoản hiện tại để xác nhận đổi email.
                            </div>
                        </div>
                        <div class="form-text text-muted small mt-1" id="pwdHelpText">
                            Để bảo mật, bạn cần xác thực mật khẩu tài khoản khi thay đổi sang địa chỉ email mới.
                        </div>
                    </div>

                    <!-- Upload Ảnh đại diện -->
                    <div class="mb-4">
                        <label for="imageFile" class="form-label fw-semibold small text-secondary">
                            Ảnh đại diện mới
                        </label>
                        <div class="input-group">
                            <input type="file" id="imageFile" name="imageFile" class="form-control"
                                   accept="image/png, image/jpeg, image/jpg, image/webp"
                                   onchange="previewSelectedImage(event)">
                        </div>
                        <div class="form-text text-muted small">
                            Định dạng hỗ trợ: JPG, PNG, WEBP (tối đa 15MB).
                        </div>
                    </div>

                    <!-- Nút bấm hành động -->
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary fw-semibold px-4 py-2 rounded-3 shadow-sm">
                            <i class="bi bi-save me-1"></i> Lưu Cập Nhật Hồ Sơ
                        </button>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary fw-semibold px-3 py-2 rounded-3">
                            <i class="bi bi-arrow-left me-1"></i> Về Trang Chủ
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>

<script>
    function previewSelectedImage(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const previewImg = document.getElementById('avatarPreviewImg');
                const fallback = document.getElementById('avatarFallback');
                previewImg.src = e.target.result;
                previewImg.style.display = 'block';
                if (fallback) fallback.style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    }

    function handleEmailChange(input) {
        const originalEmail = input.getAttribute('data-original-email');
        const currentVal = input.value.trim().toLowerCase();
        const pwdInput = document.getElementById('currentPassword');
        const pwdStar = document.getElementById('pwdRequiredStar');
        const pwdBadge = document.getElementById('pwdHintBadge');

        if (currentVal && currentVal !== originalEmail.toLowerCase()) {
            pwdStar.style.display = 'inline';
            pwdBadge.className = 'badge bg-warning text-dark ms-1 fw-semibold';
            pwdBadge.innerHTML = '<i class="bi bi-shield-lock-fill me-1"></i>Bắt buộc nhập mật khẩu khi đổi Email';
            pwdInput.required = true;
        } else {
            pwdStar.style.display = 'none';
            pwdBadge.className = 'badge bg-secondary-subtle text-secondary ms-1 fw-normal';
            pwdBadge.innerText = 'Chỉ cần nhập nếu đổi Email';
            pwdInput.required = false;
        }
    }

    function togglePasswordVisibility(fieldId, iconId) {
        const field = document.getElementById(fieldId);
        const icon = document.getElementById(iconId);
        if (field.type === 'password') {
            field.type = 'text';
            icon.classList.remove('bi-eye');
            icon.classList.add('bi-eye-slash');
        } else {
            field.type = 'password';
            icon.classList.remove('bi-eye-slash');
            icon.classList.add('bi-eye');
        }
    }
</script>

</body>
</html>
