package com.myexample.controller;

import java.io.IOException;

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
 * Controller xử lý Nhập mã OTP và Đổi mật khẩu mới
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        String username = session != null ? (String) session.getAttribute("reset_username") : null;
        String email = session != null ? (String) session.getAttribute("reset_email") : null;

        if ("resend".equalsIgnoreCase(action) && username != null) {
            boolean resent = userService.sendForgotPasswordOtp(username);
            if (resent) {
                req.setAttribute("message", "Mã OTP mới đã được gửi lại vào email của bạn!");
                if (session != null && email != null) {
                    session.setAttribute("debug_otp", EmailUtil.RECENT_OTP_CACHE.get(email));
                }
            }
        }

        req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            if (session != null) {
                username = (String) session.getAttribute("reset_username");
            }
        }

        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || otp == null || newPassword == null || otp.trim().isEmpty() || newPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ mã OTP và mật khẩu mới!");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean resetOk = userService.resetPassword(username.trim(), otp.trim(), newPassword);
        if (resetOk) {
            if (session != null) {
                session.removeAttribute("reset_username");
                session.removeAttribute("reset_email");
                session.removeAttribute("debug_otp");
            }
            resp.sendRedirect(req.getContextPath() + "/login?message=reset_success");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã quá hạn 5 phút! Vui lòng thử lại hoặc bấm 'Gửi lại mã OTP'.");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
        }
    }
}
