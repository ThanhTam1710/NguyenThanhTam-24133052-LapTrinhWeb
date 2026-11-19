package com.myexample.controller;

import java.io.IOException;

import com.myexample.dao.impl.UserDAOImpl;
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
 * Controller xử lý Nhập mã OTP và Đổi mật khẩu mới
 * Hỗ trợ: Đếm ngược 30s gửi lại, giới hạn 3 lần gửi lại, giới hạn 3 lần nhập sai OTP
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();
    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(true);

        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            username = (String) session.getAttribute("reset_username");
        }

        User user = null;
        if (username != null && !username.trim().isEmpty()) {
            user = userService.get(username.trim());
        }

        if (user != null) {
            session.setAttribute("reset_username", user.getUserName());
            session.setAttribute("reset_email", user.getEmail());
        } else if (!"resend".equalsIgnoreCase(action)) {
            // Guard: nếu không có thông tin thì quay lại trang forgot-password
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        // Xử lý gửi lại mã OTP (Resend OTP cho quên mật khẩu)
        if ("resend".equalsIgnoreCase(action)) {
            if (user == null) {
                req.setAttribute("error", "Phiên xác thực đã hết hạn. Vui lòng thực hiện lại từ đầu!");
                req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
                return;
            }

            // 1. Kiểm tra giới hạn 3 lần gửi lại
            Integer resendCount = (Integer) session.getAttribute("reset_resend_count");
            if (resendCount == null) {
                resendCount = 0;
            }

            if (resendCount >= 3) {
                req.setAttribute("error", "Bạn đã yêu cầu gửi lại OTP quá 3 lần! Vui lòng kiểm tra kỹ hộp thư Gmail (" + user.getEmail() + ") hoặc thử lại sau.");
                req.setAttribute("blockResend", true);
                req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
                return;
            }

            // 2. Cooldown 30s
            Long lastResendTime = (Long) session.getAttribute("reset_last_resend_time");
            long now = System.currentTimeMillis();
            if (lastResendTime != null && (now - lastResendTime) < 28000) {
                long waitSec = Math.max(1, (30000 - (now - lastResendTime)) / 1000);
                req.setAttribute("warning", "Vui lòng đợi thêm " + waitSec + " giây trước khi bấm gửi lại mã!");
                req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
                return;
            }

            // 3. Gửi lại OTP mới và vô hiệu hóa OTP cũ
            resendCount++;
            session.setAttribute("reset_resend_count", resendCount);
            session.setAttribute("reset_last_resend_time", now);
            session.removeAttribute("reset_failed_count");

            boolean resent = userService.sendForgotPasswordOtp(user.getUserName());
            if (resent) {
                req.setAttribute("message", "Mã OTP mới đã được gửi tới email " + user.getEmail() + " (Lần " + resendCount + "/3). Mã cũ đã mất hiệu lực!");
                req.setAttribute("startCooldown", 30);
            } else {
                req.setAttribute("error", "Không thể gửi email OTP lúc này. Vui lòng thử lại sau!");
            }
        }

        req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(true);
        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            username = (String) session.getAttribute("reset_username");
        }

        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || otp == null || newPassword == null || otp.trim().isEmpty() || newPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ mã OTP và mật khẩu mới!");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra độ dài mật khẩu mới
        if (newPassword.length() < 6) {
            req.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }

        User user = userService.get(username.trim());
        if (user == null) {
            req.setAttribute("error", "Không tìm thấy tài khoản. Vui lòng thao tác lại từ đầu!");
            req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
            return;
        }

        // Chặn trường hợp mật khẩu mới trùng mật khẩu cũ đang sử dụng
        if (com.myexample.util.PasswordUtil.checkPassword(newPassword, user.getPassword())) {
            req.setAttribute("error", "Mật khẩu mới không được trùng với mật khẩu cũ đang sử dụng! Vui lòng chọn mật khẩu khác.");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean resetOk = userService.resetPassword(user.getUserName(), otp.trim(), newPassword);
        if (resetOk) {
            session.removeAttribute("reset_username");
            session.removeAttribute("reset_email");
            session.removeAttribute("reset_resend_count");
            session.removeAttribute("reset_failed_count");
            session.removeAttribute("reset_last_resend_time");
            session.removeAttribute("debug_otp");

            resp.sendRedirect(req.getContextPath() + "/login?message=reset_success");
        } else {
            // Đếm số lần nhập sai
            Integer failedCount = (Integer) session.getAttribute("reset_failed_count");
            if (failedCount == null) {
                failedCount = 0;
            }
            failedCount++;
            session.setAttribute("reset_failed_count", failedCount);

            if (failedCount >= 3) {
                // Nhập sai quá 3 lần -> Vô hiệu hóa OTP ngay lập tức
                userDAO.updateOtp(user.getUserName(), null, null);
                session.removeAttribute("reset_failed_count");
                req.setAttribute("error", "Bạn đã nhập sai mã OTP quá 3 lần! Mã xác thực này đã bị vô hiệu hóa. Vui lòng bấm 'Gửi lại mã OTP' để nhận mã mới.");
            } else {
                int remaining = 3 - failedCount;
                req.setAttribute("error", "Mã OTP không chính xác hoặc đã quá hạn 5 phút! Bạn còn " + remaining + " lần nhập thử trước khi mã bị khóa.");
            }
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
        }
    }
}
