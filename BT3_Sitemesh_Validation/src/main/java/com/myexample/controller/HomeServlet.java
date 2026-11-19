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
 * Controller Trang Chủ (/home và /)
 * Hiển thị 10 video mới nhất lên trang chủ theo yêu cầu đề bài
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet(urlPatterns = {"/home", "/"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy 10 video mới nhất hiển thị lên trang chủ
        List<Video> latest10 = videoService.getLatest10();
        req.setAttribute("latestVideos", latest10);

        req.getRequestDispatcher("/view/index.jsp").forward(req, resp);
    }
}
