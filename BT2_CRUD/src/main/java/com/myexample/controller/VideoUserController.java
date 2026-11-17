package com.myexample.controller;

import java.io.IOException;
import java.util.List;

import com.myexample.model.User;
import com.myexample.model.Video;
import com.myexample.service.VideoService;
import com.myexample.service.impl.VideoServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller hiển thị tất cả video của User và phân trang 6 video/trang
 * URL: /video
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/video")
public class VideoUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int PAGE_SIZE = 6; // Phân trang đúng 6 sản phẩm/video 1 trang theo đề bài
    private final VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId = 1;
        String username = "syber096";
        String fullname = "Nguyễn Thanh Tâm";

        if (session != null && session.getAttribute("account") != null) {
            User u = (User) session.getAttribute("account");
            if (u.getId() > 0) {
                userId = u.getId();
            }
            if (u.getUserName() != null) {
                username = u.getUserName();
            }
            if (u.getFullName() != null) {
                fullname = u.getFullName();
            }
        }

        // Đọc số trang từ tham số ?page=
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {}
        }

        int totalVideos = videoService.countByUserId(userId);
        int totalPages = (int) Math.ceil((double) totalVideos / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Video> videos = videoService.getByUserId(userId, page, PAGE_SIZE);

        req.setAttribute("videoList", videos);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalVideos", totalVideos);
        req.setAttribute("viewUserId", userId);
        req.setAttribute("viewUsername", username);
        req.setAttribute("viewFullname", fullname);

        req.getRequestDispatcher("/view/video-user.jsp").forward(req, resp);
    }
}
