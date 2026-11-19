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
 * Controller xử lý xác thực mã OTP kích hoạt tài khoản
 * Hỗ trợ: Đếm ngược 30s gửi lại, giới hạn 3 lần gửi lại, giới hạn 3 lần nhập sai OTP
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();
    private final UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(true);

        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            username = (String) session.getAttribute("otp_username");
        }

        // Tìm thông tin người dùng
        User user = null;
        if (username != null && !username.trim().isEmpty()) {
            user = userService.get(username.trim());
        }

        if (user != null) {
            session.setAttribute("otp_username", user.getUserName());
            session.setAttribute("otp_email", user.getEmail());
        } else if (!"resend".equalsIgnoreCase(action)) {
            // Guard: nếu không có thông tin tài khoản thì quay về đăng ký
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        // Xử lý Gửi lại mã OTP (Resend OTP)
        if ("resend".equalsIgnoreCase(action)) {
            if (user == null) {
                req.setAttribute("error", "Phiên xác thực đã hết hạn hoặc không tìm thấy tài khoản. Vui lòng đăng ký lại!");
                req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
                return;
            }

            // 1. Kiểm tra giới hạn số lần gửi lại (tối đa 3 lần)
            Integer resendCount = (Integer) session.getAttribute("otp_resend_count");
            if (resendCount == null) {
                resendCount = 0;
            }

            if (resendCount >= 3) {
                req.setAttribute("error", "Bạn đã yêu cầu gửi lại OTP quá 3 lần! Vui lòng kiểm tra kỹ hộp thư Gmail (" + user.getEmail() + ") bao gồm mục Thư rác/Spam, hoặc quay lại Đăng ký.");
                req.setAttribute("blockResend", true);
                req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
                return;
            }

            // 2. Kiểm tra thời gian hồi (cooldown 30s)
            Long lastResendTime = (Long) session.getAttribute("last_resend_time");
            long now = System.currentTimeMillis();
            if (lastResendTime != null && (now - lastResendTime) < 28000) {
                long waitSec = Math.max(1, (30000 - (now - lastResendTime)) / 1000);
                req.setAttribute("warning", "Vui lòng đợi thêm " + waitSec + " giây trước khi bấm gửi lại mã tiếp theo!");
                req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
                return;
            }

            // 3. Thực hiện gửi lại mã mới (Mã cũ ngay lập tức mất hiệu lực và được thay thế bằng mã mới)
            resendCount++;
            session.setAttribute("otp_resend_count", resendCount);
            session.setAttribute("last_resend_time", now);
            session.removeAttribute("otp_failed_count"); // Reset số lần nhập sai cho mã OTP mới

            boolean resent = userService.resendOtp(user.getUserName(), "register");
            if (resent) {
                req.setAttribute("message", "Mã OTP mới đã được gửi tới email " + user.getEmail() + " (Lần " + resendCount + "/3). Mã cũ đã mất hiệu lực!");
                req.setAttribute("startCooldown", 30);
            } else {
                req.setAttribute("error", "Không thể gửi email OTP lúc này. Vui lòng thử lại sau!");
            }
        }

        req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(true);
        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            username = (String) session.getAttribute("otp_username");
        }

        String otp = req.getParameter("otp");

        if (username == null || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ mã OTP 6 chữ số!");
            req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
            return;
        }

        User user = userService.get(username.trim());
        if (user == null) {
            req.setAttribute("error", "Không tìm thấy thông tin tài khoản. Vui lòng đăng ký lại!");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra OTP
        boolean verified = userService.verifyAccount(user.getUserName(), otp.trim());
        if (verified) {
            // Xác thực thành công: xóa toàn bộ session theo dõi OTP
            session.removeAttribute("otp_username");
            session.removeAttribute("otp_email");
            session.removeAttribute("otp_type");
            session.removeAttribute("otp_resend_count");
            session.removeAttribute("otp_failed_count");
            session.removeAttribute("last_resend_time");
            session.removeAttribute("debug_otp");

            resp.sendRedirect(req.getContextPath() + "/login?message=active_success");
        } else {
            // Xác thực thất bại: đếm số lần nhập sai
            Integer failedCount = (Integer) session.getAttribute("otp_failed_count");
            if (failedCount == null) {
                failedCount = 0;
            }
            failedCount++;
            session.setAttribute("otp_failed_count", failedCount);

            if (failedCount >= 3) {
                // Nhập sai quá 3 lần -> Ngay lập tức vô hiệu hóa mã OTP hiện tại
                userDAO.updateOtp(user.getUserName(), null, null);
                session.removeAttribute("otp_failed_count");
                req.setAttribute("error", "Bạn đã nhập sai mã OTP quá 3 lần! Mã xác thực này đã bị vô hiệu hóa để bảo mật. Vui lòng bấm 'Gửi lại mã OTP' để nhận mã mới.");
            } else {
                int remaining = 3 - failedCount;
                req.setAttribute("error", "Mã OTP không chính xác hoặc đã quá hạn 5 phút! Bạn còn " + remaining + " lần nhập thử trước khi mã bị khóa.");
            }
            req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
        }
    }
}
