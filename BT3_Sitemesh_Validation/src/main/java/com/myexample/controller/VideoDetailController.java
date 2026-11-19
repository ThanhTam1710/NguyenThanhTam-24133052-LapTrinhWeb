package com.myexample.controller;

import java.io.IOException;
import java.util.List;

import com.myexample.model.Video;
import com.myexample.service.VideoService;
import com.myexample.service.impl.VideoServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controller hiển thị chi tiết và phát (Play) Video khi người dùng click vào tiêu đề
 * URL: /video/detail?id=...
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/video/detail")
public class VideoDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            id = req.getParameter("videoId");
        }

        if (id == null || id.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Tăng lượt xem cho video
        videoService.updateViews(id.trim());

        Video video = videoService.get(id.trim());
        if (video == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Lấy 5 video gợi ý liên quan
        List<Video> relatedList = videoService.getLatest10();

        req.setAttribute("video", video);
        req.setAttribute("relatedVideos", relatedList);

        req.getRequestDispatcher("/view/video-detail.jsp").forward(req, resp);
    }
}
