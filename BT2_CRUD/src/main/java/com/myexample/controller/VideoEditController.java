package com.myexample.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

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
import jakarta.servlet.http.Part;

/**
 * Controller chỉnh sửa Video qua @MultipartConfig
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/admin/video/edit")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 100,
    maxRequestSize = 1024 * 1024 * 120
)
public class VideoEditController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("id");
        Video v = videoService.get(videoId);
        if (v == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/video/list");
            return;
        }
        req.setAttribute("video", v);
        req.getRequestDispatcher("/view/video-edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String videoId = req.getParameter("videoId");
        Video old = videoService.get(videoId);
        if (old == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/video/list");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String urlInput = req.getParameter("url");
        String posterUrl = req.getParameter("posterUrl");
        String activeStr = req.getParameter("active");
        boolean active = "1".equals(activeStr) || "true".equalsIgnoreCase(activeStr) || "on".equalsIgnoreCase(activeStr);

        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String posterFileName = old.getPoster();
        String videoFileName = old.getUrl();

        try {
            Part posterPart = req.getPart("posterFile");
            if (posterPart != null && posterPart.getSize() > 0 && posterPart.getSubmittedFileName() != null && !posterPart.getSubmittedFileName().trim().isEmpty()) {
                String sub = Paths.get(posterPart.getSubmittedFileName()).getFileName().toString();
                String ext = sub.contains(".") ? sub.substring(sub.lastIndexOf(".")) : ".jpg";
                posterFileName = "poster_" + System.currentTimeMillis() + ext;
                posterPart.write(uploadDir.getAbsolutePath() + File.separator + posterFileName);
            } else if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                posterFileName = posterUrl.trim();
            }

            Part videoPart = req.getPart("videoFile");
            if (videoPart != null && videoPart.getSize() > 0 && videoPart.getSubmittedFileName() != null && !videoPart.getSubmittedFileName().trim().isEmpty()) {
                String sub = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
                String ext = sub.contains(".") ? sub.substring(sub.lastIndexOf(".")) : ".mp4";
                videoFileName = "video_" + System.currentTimeMillis() + ext;
                videoPart.write(uploadDir.getAbsolutePath() + File.separator + videoFileName);
            } else if (urlInput != null && !urlInput.trim().isEmpty()) {
                videoFileName = urlInput.trim();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        old.setTitle(title != null ? title.trim() : old.getTitle());
        old.setDescription(description != null ? description.trim() : old.getDescription());
        old.setPoster(posterFileName);
        old.setUrl(videoFileName);
        old.setActive(active);

        videoService.update(old);

        resp.sendRedirect(req.getContextPath() + "/admin/video/list");
    }
}
