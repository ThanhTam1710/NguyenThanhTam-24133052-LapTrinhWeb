package com.myexample.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login-session")
public class LoginSessionServlet extends HttpServlet {
	
	@Override 
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/view/login-session.jsp").forward(req, resp);
	}
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        // Tài khoản sinh viên Nguyễn Thanh Tâm: syber096 / thanhtam123 hoặc thanhtam / 123
        boolean isValid = ("syber096".equalsIgnoreCase(user) && "thanhtam123".equals(pass))
                || (("thanhtam".equalsIgnoreCase(user) || "tamnt".equalsIgnoreCase(user) || "admin".equalsIgnoreCase(user)) && "123".equals(pass));

        if (isValid) {
            HttpSession session = req.getSession();
            session.setAttribute("name", user);
            
            resp.sendRedirect(req.getContextPath() + "/profile");
        } else {
            resp.getWriter().println("<h3 style='color:red'>Tài khoản hoặc mật khẩu không chính xác!</h3>");
            resp.getWriter().println("<p>Gợi ý: <b>thanhtam</b> / <b>123</b> hoặc <b>tamnt</b> / <b>123</b></p>");
            req.getRequestDispatcher("/view/login-session.jsp").include(req, resp);
        }
	}
}
