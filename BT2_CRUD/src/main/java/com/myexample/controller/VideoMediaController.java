package com.myexample.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;

import com.myexample.util.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controller phục vụ xem ảnh hoặc phát video trực tiếp từ thư mục upload
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/media")
public class VideoMediaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số tên file");
            return;
        }

        File file = new File(Constant.DIR + File.separator + fileName);
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy file");
            return;
        }

        String lower = fileName.toLowerCase();
        if (lower.endsWith(".mp4")) {
            resp.setContentType("video/mp4");
        } else if (lower.endsWith(".webm")) {
            resp.setContentType("video/webm");
        } else if (lower.endsWith(".png")) {
            resp.setContentType("image/png");
        } else if (lower.endsWith(".gif")) {
            resp.setContentType("image/gif");
        } else {
            resp.setContentType("image/jpeg");
        }

        resp.setContentLengthLong(file.length());
        try (FileInputStream in = new FileInputStream(file)) {
            IOUtils.copy(in, resp.getOutputStream());
        }
    }
}
