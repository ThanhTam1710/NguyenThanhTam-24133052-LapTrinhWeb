package com.myexample.controller;

import com.myexample.service.CategoryService;
import com.myexample.service.impl.CategoryServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/category/delete")
public class CategoryDeleteController extends HttpServlet {
    private final CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            cateService.delete(id);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
