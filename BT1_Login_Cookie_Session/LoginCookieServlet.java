package com.myexample.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login-cookie")
public class LoginCookieServlet extends HttpServlet {
	
	@Override 
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Hien thi form dang nhap
		req.getRequestDispatcher("/view/login-cookie.jsp").forward(req, resp);
	}
	
	@Override 
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		
		String user = req.getParameter("username");
		String pass = req.getParameter("password");
		
		// Tài khoản của sinh viên Nguyễn Thành Tâm: thanhtam / 123 hoặc tamnt / 123
		if (("thanhtam".equalsIgnoreCase(user) || "tamnt".equalsIgnoreCase(user) || "admin".equalsIgnoreCase(user)) && "123".equals(pass)) {
			Cookie cookie = new Cookie("username", user);
			cookie.setMaxAge(30); // Thời gian sống 30 giây
			
			resp.addCookie(cookie);
			resp.sendRedirect(req.getContextPath() + "/hello-cookie");
		}
		else {
			resp.getWriter().println("<h3 style='color:red'>Sai tài khoản hoặc mật khẩu!</h3>");
			resp.getWriter().println("<p>Gợi ý tài khoản: <b>thanhtam</b> / <b>123</b> hoặc <b>tamnt</b> / <b>123</b></p>");
			resp.getWriter().println("<a href='"+req.getContextPath()+"/login-cookie'>Quay lại</a>");
		}
	}
	
}
