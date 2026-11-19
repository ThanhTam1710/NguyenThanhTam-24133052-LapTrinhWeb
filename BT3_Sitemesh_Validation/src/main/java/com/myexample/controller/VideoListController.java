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
 * Controller hiển thị danh sách quản lý CRUD Videos
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/admin/video/list")
public class VideoListController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Video> list = videoService.getAll();
        req.setAttribute("videoList", list);
        req.getRequestDispatcher("/view/video-list.jsp").forward(req, resp);
    }
}
