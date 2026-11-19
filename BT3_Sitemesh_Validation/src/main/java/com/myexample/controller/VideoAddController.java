package com.myexample.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;

import com.myexample.model.User;
import com.myexample.model.Video;
import com.myexample.service.VideoService;
import com.myexample.service.impl.VideoServiceImpl;
import com.myexample.util.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * Controller thêm mới Video có upload file Poster và Video qua @MultipartConfig
 * Hoặc dán trực tiếp link ảnh / link YouTube
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/admin/video/add")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,    // 2MB lưu tạm bộ nhớ
    maxFileSize = 1024 * 1024 * 100,        // Tối đa 100MB cho file video/ảnh
    maxRequestSize = 1024 * 1024 * 120      // Tổng request tối đa 120MB
)
public class VideoAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/video-add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String videoId = req.getParameter("videoId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String urlInput = req.getParameter("url");
        String posterUrl = req.getParameter("posterUrl");
        String activeStr = req.getParameter("active");
        boolean active = "1".equals(activeStr) || "true".equalsIgnoreCase(activeStr) || "on".equalsIgnoreCase(activeStr);

        if (videoId == null || videoId.trim().isEmpty()) {
            videoId = "VID" + (System.currentTimeMillis() % 100000);
        } else {
            videoId = videoId.trim();
        }

        if (title == null || title.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập tiêu đề cho sản phẩm/video!");
            req.getRequestDispatcher("/view/video-add.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra trùng videoId
        if (videoService.get(videoId) != null) {
            req.setAttribute("error", "Mã video '" + videoId + "' đã tồn tại! Vui lòng chọn mã khác.");
            req.getRequestDispatcher("/view/video-add.jsp").forward(req, resp);
            return;
        }

        // Tạo thư mục upload nếu chưa tồn tại
        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String finalPoster = null;
        String finalVideoUrl = null;

        try {
            // 1. Xử lý upload file poster ảnh qua Multipart
            Part posterPart = req.getPart("posterFile");
            if (posterPart != null && posterPart.getSize() > 0 && posterPart.getSubmittedFileName() != null && !posterPart.getSubmittedFileName().trim().isEmpty()) {
                String sub = Paths.get(posterPart.getSubmittedFileName()).getFileName().toString();
                String ext = sub.contains(".") ? sub.substring(sub.lastIndexOf(".")) : ".jpg";
                String posterFileName = "poster_" + System.currentTimeMillis() + ext;
                posterPart.write(uploadDir.getAbsolutePath() + File.separator + posterFileName);
                finalPoster = posterFileName;
            }

            // 2. Xử lý upload file video mp4 qua Multipart
            Part videoPart = req.getPart("videoFile");
            if (videoPart != null && videoPart.getSize() > 0 && videoPart.getSubmittedFileName() != null && !videoPart.getSubmittedFileName().trim().isEmpty()) {
                String sub = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
                String ext = sub.contains(".") ? sub.substring(sub.lastIndexOf(".")) : ".mp4";
                String videoFileName = "video_" + System.currentTimeMillis() + ext;
                videoPart.write(uploadDir.getAbsolutePath() + File.separator + videoFileName);
                finalVideoUrl = videoFileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Nếu không upload file poster, kiểm tra xem có nhập posterUrl không
        if (finalPoster == null) {
            if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                finalPoster = posterUrl.trim();
            } else {
                finalPoster = "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=800";
            }
        }

        // Nếu không upload file video, lấy URL đã nhập hoặc link video YouTube
        if (finalVideoUrl == null) {
            if (urlInput != null && !urlInput.trim().isEmpty()) {
                finalVideoUrl = urlInput.trim();
            } else {
                finalVideoUrl = "https://www.youtube.com/watch?v=R9Z8_lJ_g7Y";
            }
        }

        // Lấy thông tin User đang đăng nhập (hoặc mặc định userId = 1 cho syber096)
        HttpSession session = req.getSession(false);
        int userId = 1;
        String fullname = "Nguyễn Thanh Tâm";
        String username = "syber096";

        if (session != null && session.getAttribute("account") != null) {
            User current = (User) session.getAttribute("account");
            if (current.getId() > 0) {
                userId = current.getId();
            }
            if (current.getFullName() != null) {
                fullname = current.getFullName();
            }
            if (current.getUserName() != null) {
                username = current.getUserName();
            }
        }

        Video v = new Video();
        v.setVideoId(videoId);
        v.setTitle(title.trim());
        v.setPoster(finalPoster);
        v.setUrl(finalVideoUrl);
        v.setDescription(description != null ? description.trim() : "");
        v.setActive(active);
        v.setViews(0);
        v.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        v.setUserId(userId);
        v.setUserFullName(fullname);
        v.setUsername(username);

        videoService.insert(v);

        resp.sendRedirect(req.getContextPath() + "/admin/video/list");
    }
}
