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
 * Controller xử lý Đăng ký tài khoản kèm gửi mã OTP kích hoạt qua Email
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // 1. Kiểm tra rỗng
        if (username == null || email == null || password == null || username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ các thông tin bắt buộc!");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra độ dài mật khẩu
        if (password.length() < 6) {
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            return;
        }

        // 3. Kiểm tra username hợp lệ (chỉ chữ, số, dấu gạch dưới)
        if (!username.trim().matches("^[a-zA-Z0-9_]{3,30}$")) {
            req.setAttribute("error", "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới (3-30 ký tự)!");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            return;
        }

        // 4. Kiểm tra mật khẩu khớp nhau
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            return;
        }

        // 3. Kiểm tra trùng lặp Username hoặc Email
        if (userService.checkExistUsername(username.trim())) {
            req.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại! Vui lòng chọn tên khác.");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistEmail(email.trim())) {
            req.setAttribute("error", "Email '" + email + "' đã được sử dụng! Vui lòng chọn email khác.");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            return;
        }

        // 4. Tiến hành đăng ký và gửi mã OTP qua Email
        boolean success = userService.registerWithOtp(username.trim(), password, email.trim(), fullname != null ? fullname.trim() : username, phone != null ? phone.trim() : "");
        if (success) {
            HttpSession session = req.getSession(true);
            session.setAttribute("otp_username", username.trim());
            session.setAttribute("otp_email", email.trim());
            session.setAttribute("otp_type", "register");

            // Lấy mã OTP vừa sinh để hỗ trợ hiển thị kiểm thử trực quan trên giao diện
            String generatedOtp = EmailUtil.RECENT_OTP_CACHE.get(email.trim());
            session.setAttribute("debug_otp", generatedOtp);

            resp.sendRedirect(req.getContextPath() + "/verify-otp?type=register");
        } else {
            req.setAttribute("error", "Đăng ký thất bại! Có lỗi xảy ra trong quá trình tạo tài khoản.");
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
        }
    }
}
