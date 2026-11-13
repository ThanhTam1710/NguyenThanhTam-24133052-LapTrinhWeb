package com.myexample.controller;

import java.io.IOException;
import java.util.List;

import com.myexample.model.Category;
import com.myexample.service.CategoryService;
import com.myexample.service.impl.CategoryServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/category/list")
public class CategoryListController extends HttpServlet {
    private final CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> list = cateService.getAll();
        req.setAttribute("cateList", list);
        req.getRequestDispatcher("/view/list-category.jsp").forward(req, resp);
    }
}
