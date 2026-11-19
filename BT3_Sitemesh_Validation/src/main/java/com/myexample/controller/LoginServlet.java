package com.myexample.controller;

import java.io.IOException;

import com.myexample.model.User;
import com.myexample.service.UserService;
import com.myexample.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller xử lý Đăng nhập với mật khẩu được mã hóa (Password Hashing)
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String msg = req.getParameter("message");
        if ("logout_success".equals(msg)) {
            req.setAttribute("message", "Đã đăng xuất thành công khỏi hệ thống!");
        } else if ("active_success".equals(msg)) {
            req.setAttribute("message", "Tài khoản của bạn đã được kích hoạt thành công bằng mã OTP! Vui lòng đăng nhập.");
        } else if ("reset_success".equals(msg)) {
            req.setAttribute("message", "Đổi mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.");
        }

        if ("auth_required".equals(req.getParameter("error"))) {
            req.setAttribute("warning", "Vui lòng đăng nhập để truy cập tính năng quản trị và chức năng cá nhân!");
        }
        req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String remember = req.getParameter("remember");

        // 0. Server-side Validation: Kiểm tra dữ liệu rỗng hoặc không hợp lệ
        if (user == null || user.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
            return;
        }

        user = user.trim();
        User u = userService.get(user);
        if (u == null) {
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra mật khẩu (đã mã hóa)
        User authUser = userService.checkLogin(user, pass);
        if (authUser == null) {
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
            return;
        }

        // 3. Kiểm tra trạng thái kích hoạt tài khoản bằng OTP
        if (authUser.getStatus() == 0) {
            HttpSession session = req.getSession(true);
            session.setAttribute("otp_username", authUser.getUserName());
            session.setAttribute("otp_email", authUser.getEmail());
            req.setAttribute("warning", "Tài khoản chưa được kích hoạt qua mã OTP gửi đến email (" + authUser.getEmail() + ")! Vui lòng nhập mã OTP để kích hoạt.");
            req.getRequestDispatcher("/view/verify-otp.jsp").forward(req, resp);
            return;
        }

        // 4. Đăng nhập thành công
        HttpSession session = req.getSession(true);
        session.setAttribute("account", authUser);
        session.setAttribute("name", authUser.getFullName() != null ? authUser.getFullName() : authUser.getUserName());

        // Xử lý ghi nhớ đăng nhập bằng Cookie nếu được chọn
        if (remember != null && "on".equalsIgnoreCase(remember)) {
            Cookie cookieUser = new Cookie("username", authUser.getUserName());
            cookieUser.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
            resp.addCookie(cookieUser);
        }

        String redirect = (String) session.getAttribute("redirectAfterLogin");
        if (redirect != null && !redirect.isEmpty()) {
            session.removeAttribute("redirectAfterLogin");
            resp.sendRedirect(redirect);
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
