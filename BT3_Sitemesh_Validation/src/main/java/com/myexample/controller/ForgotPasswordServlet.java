package com.myexample.controller;

import java.io.IOException;

import com.myexample.model.User;
import com.myexample.service.UserService;
import com.myexample.service.impl.UserServiceImpl;
import com.myexample.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller xử lý Quên mật khẩu & gửi mã OTP qua Email
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String account = req.getParameter("account");
        if (account == null || account.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập Email hoặc Tên đăng nhập của bạn!");
            req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
            return;
        }

        User user = userService.get(account.trim());
        if (user == null) {
            req.setAttribute("error", "Tài khoản hoặc Email '" + account + "' không tồn tại trong hệ thống!");
            req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
            return;
        }

        // Tạo và gửi mã OTP qua email
        boolean sent = userService.sendForgotPasswordOtp(user.getUserName());
        if (sent) {
            HttpSession session = req.getSession(true);
            session.setAttribute("reset_username", user.getUserName());
            session.setAttribute("reset_email", user.getEmail());
            session.setAttribute("debug_otp", EmailUtil.RECENT_OTP_CACHE.get(user.getEmail()));

            resp.sendRedirect(req.getContextPath() + "/reset-password");
        } else {
            req.setAttribute("error", "Không thể gửi email OTP lúc này. Vui lòng thử lại sau!");
            req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
        }
    }
}
