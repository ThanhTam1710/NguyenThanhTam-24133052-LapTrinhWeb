package com.myexample.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/home", "/"})
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        // Nếu đã đăng nhập -> chuyển thẳng vào trang Quản lý danh mục bán hàng
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            return;
        }
        // Chưa đăng nhập -> hiển thị trang chủ đăng nhập / đăng ký
        req.getRequestDispatcher("/view/index.jsp").forward(req, resp);
    }
}
