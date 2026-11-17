<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Mới Video Quần Áo Thời Trang - HCMUTE Video</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --bg-body: #f8fafc;
            --card-bg: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            min-height: 100vh;
            padding: 40px 20px;
        }
        .form-card {
            max-width: 680px;
            margin: auto;
            background: white;
            border-radius: 16px;
            border: 1px solid var(--border);
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.06);
            padding: 36px 32px;
        }
        .header-title {
            text-align: center;
            margin-bottom: 24px;
        }
        .header-title h2 { font-size: 22px; font-weight: 800; color: #0f172a; }
        .header-title p { font-size: 13px; color: var(--text-muted); margin-top: 4px; }
        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 13.5px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid var(--border);
            border-radius: 8px;
            font-size: 14px;
            background: #f8fafc;
            transition: all 0.2s;
        }
        input[type="text"]:focus, textarea:focus {
            background: white;
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }
        .file-upload-box {
            border: 2px dashed #cbd5e1;
            padding: 14px;
            border-radius: 8px;
            background: #f8fafc;
        }
        .hint-text {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 4px;
        }
        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
            transition: all 0.2s;
        }
        .btn-submit:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(220, 38, 38, 0.4);
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 18px;
            font-size: 13.5px;
            color: #64748b;
            text-decoration: none;
        }
        .back-link:hover { color: var(--primary); text-decoration: underline; }
    </style>
</head>
<body>

<div class="form-card">
    <div class="header-title">
        <h2>Đăng Tải Video Sản Phẩm Mới</h2>
        <p>Hệ thống HCMUTE Video &bull; Sinh viên: <b>Nguyễn Thanh Tâm</b> | MSSV: <b>24133052</b></p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert-error">${error}</div>
    </c:if>

    <!-- Form upload file theo chuẩn Jakarta Servlet Multipart (@MultipartConfig) hoặc nhập URL trực tuyến -->
    <form action="${pageContext.request.contextPath}/admin/video/add" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="videoId">Mã Video (Tùy chọn, để trống sẽ tự sinh mã)</label>
            <input type="text" id="videoId" name="videoId" placeholder="Ví dụ: VID13, QUANAO01...">
        </div>

        <div class="form-group">
            <label for="title">Tên Sản Phẩm / Tiêu Đề Video (*)</label>
            <input type="text" id="title" name="title" required placeholder="Ví dụ: Set Áo Khoác Hoodie Unisex Nỉ Bông Hàn Quốc..." autofocus>
        </div>

        <div class="form-group">
            <label for="posterUrl">Link Ảnh Poster Trực Tuyến (Unsplash, Pexels, ảnh sản phẩm...)</label>
            <input type="text" id="posterUrl" name="posterUrl" placeholder="https://images.unsplash.com/photo-... hoặc để trống để upload file bên dưới">
        </div>

        <div class="form-group">
            <label for="posterFile">Hoặc Tải File Ảnh Bìa từ Máy tính (Upload Multipart)</label>
            <div class="file-upload-box">
                <input type="file" id="posterFile" name="posterFile" accept="image/*">
                <div class="hint-text">Chọn tệp ảnh (.jpg, .png, .jpeg) từ máy tính làm ảnh đại diện cho sản phẩm.</div>
            </div>
        </div>

        <div class="form-group">
            <label for="url">Đường Dẫn Video YouTube (Shorts hoặc Video Giới Thiệu Quần Áo)</label>
            <input type="text" id="url" name="url" placeholder="Ví dụ: https://www.youtube.com/watch?v=R9Z8_lJ_g7Y hoặc https://www.youtube.com/shorts/...">
            <div class="hint-text">Hỗ trợ tự động nhúng và phát mọi video / shorts thời trang từ YouTube.</div>
        </div>

        <div class="form-group">
            <label for="videoFile">Hoặc Tải File Video MP4 từ Máy tính (Upload Multipart)</label>
            <div class="file-upload-box">
                <input type="file" id="videoFile" name="videoFile" accept="video/mp4,video/webm">
                <div class="hint-text">Upload file video thực tế định dạng MP4 từ thiết bị của bạn.</div>
            </div>
        </div>

        <div class="form-group">
            <label for="description">Mô Tả Chi Tiết Sản Phẩm & Video</label>
            <textarea id="description" name="description" rows="4" placeholder="Nhập chất liệu vải, kiểu dáng, hướng dẫn phối đồ và bảng size..."></textarea>
        </div>

        <div class="form-group" style="display: flex; align-items: center; gap: 8px;">
            <input type="checkbox" id="active" name="active" checked>
            <label for="active" style="margin-bottom: 0; cursor: pointer;">Hiển thị video này trên trang chủ và kênh video ngay sau khi đăng</label>
        </div>

        <button type="submit" class="btn-submit">+ Đăng Tải Video Sản Phẩm</button>
    </form>

    <a href="${pageContext.request.contextPath}/admin/video/list" class="back-link">&larr; Quay lại danh sách quản lý video</a>
</div>

</body>
</html>
