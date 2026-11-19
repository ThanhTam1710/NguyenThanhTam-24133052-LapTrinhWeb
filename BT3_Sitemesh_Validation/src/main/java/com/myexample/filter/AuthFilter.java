package com.myexample.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Filter bảo vệ các chức năng quản trị và chức năng cá nhân:
 * Chặn người dùng chưa đăng nhập khi truy cập /admin/* hoặc /video
 * Tự động chuyển hướng về trang /login
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/admin/*", "/video"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("account") != null);

        if (!isLoggedIn) {
            // Lưu lại đường dẫn mong muốn sau khi đăng nhập (tùy chọn)
            String targetUrl = req.getRequestURI();
            if (req.getQueryString() != null) {
                targetUrl += "?" + req.getQueryString();
            }
            req.getSession(true).setAttribute("redirectAfterLogin", targetUrl);

            // Chuyển hướng về trang đăng nhập với thông báo
            resp.sendRedirect(req.getContextPath() + "/login?error=auth_required");
            return;
        }

        // Đã đăng nhập -> Cho phép đi tiếp
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
