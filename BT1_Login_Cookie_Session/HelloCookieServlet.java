package com.myexample.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/hello-cookie")
public class HelloCookieServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        String name = "";
        
        // Nhận toàn bộ cookie từ Browser gửi lên
        Cookie[] cookies = req.getCookies();
        
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("username".equals(c.getName())) {
                    name = c.getValue();
                }
            }
        }

        // Kiểm tra xem có lấy được name từ cookie không
        if (name.equals("")) {
            // Nếu không có cookie (hoặc đã hết hạn 30s), bắt đăng nhập lại
            resp.sendRedirect(req.getContextPath() + "/login-cookie");
        } else {
            out.println("<h2>Xin chào " + name + " (Đọc từ Cookie)</h2>");
            out.println("<p>Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052</p>");
            out.println("<p>Tải lại trang sau 30 giây, bạn sẽ bị bắt đăng nhập lại vì Cookie đã hết hạn!</p>");
            out.println("<br><a href='" + req.getContextPath() + "/login-cookie'>Quay lại trang Đăng Nhập</a>");
        }
    }
}
