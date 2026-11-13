package com.myexample.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		HttpSession session = req.getSession(false);
		
		if (session != null && session.getAttribute("name") != null) {
			String name = (String) session.getAttribute("name");
			out.print("<h2>Chào bạn, " + name + " đến với trang quản lý tài khoản (Session)</h2>");
			out.print("<p>Sinh viên: <b>Nguyễn Thành Tâm</b> - MSSV: <b>24133052</b></p>");
			out.print("<br><a href='" + req.getContextPath() + "/admin/category/list'>Quản lý danh mục (Category CRUD)</a>");
			out.print("<br><br><a href='" + req.getContextPath() + "/logout'>Đăng Xuất</a>");
		} else {
			out.print("<h3 style='color:red'>Xin vui lòng đăng nhập!</h3>");
			resp.sendRedirect(req.getContextPath() + "/login-session");
		}
	}
}
