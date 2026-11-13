package com.myexample.controller;

import java.io.IOException;

import com.myexample.service.UserService;
import com.myexample.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
	private UserService userService = new UserServiceImpl();
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
    }
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        // Gọi tầng Service để kiểm tra
        if (userService.login(user, pass)) {
            // Đúng -> Chuyển hướng về /home
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            // Sai -> Chuyển hướng về /error
            resp.sendRedirect(req.getContextPath() + "/error");
        }
    }
}
