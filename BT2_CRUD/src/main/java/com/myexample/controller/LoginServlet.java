package com.myexample.controller;

import java.io.IOException;

import com.myexample.model.User;
import com.myexample.service.UserService;
import com.myexample.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
	private final UserService userService = new UserServiceImpl();
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
    }
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        User u = userService.checkLogin(user, pass);
        if (u != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("account", u);
            session.setAttribute("name", u.getFullName() != null ? u.getFullName() : u.getUserName());
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/error");
        }
    }
}
