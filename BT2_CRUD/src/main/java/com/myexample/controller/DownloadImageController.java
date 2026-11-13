package com.myexample.controller;

import com.myexample.util.Constant;
import org.apache.commons.io.IOUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet("/image")
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName != null && !fileName.isEmpty()) {
            File file = new File(Constant.DIR + File.separator + fileName);
            if (file.exists()) {
                resp.setContentType("image/jpeg");
                try (FileInputStream in = new FileInputStream(file)) {
                    IOUtils.copy(in, resp.getOutputStream());
                }
            }
        }
    }
}
