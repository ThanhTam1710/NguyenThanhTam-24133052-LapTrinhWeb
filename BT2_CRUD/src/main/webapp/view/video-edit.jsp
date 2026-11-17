<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Video Sản Phẩm - HCMUTE Video</title>
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
        .current-media {
            font-size: 12.5px;
            color: #2563eb;
            margin-bottom: 8px;
            word-break: break-all;
        }
        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            transition: all 0.2s;
        }
        .btn-submit:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.4);
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
        <h2>Chỉnh Sửa Video Sản Phẩm</h2>
        <p>Mã: <code>#${video.videoId}</code> &bull; Người đăng: <b>${video.userFullName}</b></p>
    </div>

    <form action="${pageContext.request.contextPath}/admin/video/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="videoId" value="${video.videoId}">

        <div class="form-group">
            <label for="title">Tên Sản Phẩm / Tiêu Đề Video (*)</label>
            <input type="text" id="title" name="title" value="${video.title}" required autofocus>
        </div>

        <div class="form-group">
            <label for="posterUrl">Link Ảnh Poster Trực Tuyến (Unsplash / Online Image)</label>
            <input type="text" id="posterUrl" name="posterUrl" value="${video.poster}">
            <c:if test="${not empty video.poster}">
                <div class="current-media">Ảnh hiện tại: <b>${video.poster}</b></div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="posterFile">Hoặc Tải Lên File Ảnh Bìa Mới (Upload Multipart)</label>
            <div class="file-upload-box">
                <input type="file" id="posterFile" name="posterFile" accept="image/*">
                <div class="hint-text">Chọn tệp ảnh mới nếu muốn thay đổi bằng file máy tính.</div>
            </div>
        </div>

        <div class="form-group">
            <label for="url">Đường Dẫn Video YouTube (Shorts hoặc Watch URL) hoặc Link MP4</label>
            <input type="text" id="url" name="url" value="${video.url}">
            <c:if test="${not empty video.url}">
                <div class="current-media">Link/File hiện tại: <b>${video.url}</b></div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="videoFile">Hoặc Tải Lên File Video MP4 Mới (Upload Multipart)</label>
            <div class="file-upload-box">
                <input type="file" id="videoFile" name="videoFile" accept="video/mp4,video/webm">
                <div class="hint-text">Tải lên video MP4 mới từ máy tính để thay thế video cũ.</div>
            </div>
        </div>

        <div class="form-group">
            <label for="description">Mô Tả Sản Phẩm & Video</label>
            <textarea id="description" name="description" rows="4">${video.description}</textarea>
        </div>

        <div class="form-group" style="display: flex; align-items: center; gap: 8px;">
            <input type="checkbox" id="active" name="active" ${video.active ? 'checked' : ''}>
            <label for="active" style="margin-bottom: 0; cursor: pointer;">Hiển thị video này trên hệ thống</label>
        </div>

        <button type="submit" class="btn-submit">Lưu Cập Nhật Video</button>
    </form>

    <a href="${pageContext.request.contextPath}/admin/video/list" class="back-link">&larr; Hủy và quay lại danh sách</a>
</div>

</body>
</html>
