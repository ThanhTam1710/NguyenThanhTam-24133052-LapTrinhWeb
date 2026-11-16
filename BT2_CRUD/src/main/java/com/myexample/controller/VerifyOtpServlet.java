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
 * Controller xử lý xác thực mã OTP kích hoạt tài khoản
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);

        String username = session != null ? (String) session.getAttribute("otp_username") : null;
        String email = session != null ? (String) session.getAttribute("otp_email") : null;
        String type = req.getParameter("type");
        if (type == null && session != null) {
            type = (String) session.getAttribute("otp_type");
        }

        // Xử lý gửi lại mã OTP (Resend OTP)
        if ("resend".equalsIgnoreCase(action) && username != null) {
            boolean resent = userService.resendOtp(username, type != null ? type : "register");
            if (resent) {
                req.setAttribute("message", "Mã OTP mới đã được gửi lại vào email của bạn!");
                if (session != null && email != null) {
                    session.setAttribute("debug_otp", EmailUtil.RECENT_OTP_CACHE.get(email));
                }
            } else {
                req.setAttribute("error", "Không thể gửi lại mã OTP. Vui lòng thử lại sau!");
            }
        }

        req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            if (session != null) {
                username = (String) session.getAttribute("otp_username");
            }
        }

        String otp = req.getParameter("otp");

        if (username == null || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ mã OTP 6 chữ số!");
            req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean verified = userService.verifyAccount(username.trim(), otp.trim());
        if (verified) {
            if (session != null) {
                session.removeAttribute("otp_username");
                session.removeAttribute("otp_email");
                session.removeAttribute("otp_type");
                session.removeAttribute("debug_otp");
            }
            resp.sendRedirect(req.getContextPath() + "/login?message=active_success");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã quá thời hạn 5 phút! Vui lòng thử lại hoặc bấm 'Gửi lại mã'.");
            req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
        }
    }
}
