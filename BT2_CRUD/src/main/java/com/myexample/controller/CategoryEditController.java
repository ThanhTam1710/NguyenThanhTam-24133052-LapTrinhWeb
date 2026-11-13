package com.myexample.controller;

import com.myexample.model.Category;
import com.myexample.service.CategoryService;
import com.myexample.service.impl.CategoryServiceImpl;
import com.myexample.util.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/admin/category/edit")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
public class CategoryEditController extends HttpServlet {
    private final CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            idStr = req.getParameter("cateid");
        }

        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Category category = cateService.get(id);
            req.setAttribute("category", category);
        }
        req.getRequestDispatcher("/view/edit-category.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            idStr = req.getParameter("cateid");
        }
        int id = Integer.parseInt(idStr);

        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            name = req.getParameter("catename");
        }

        Category oldCategory = cateService.get(id);
        String fileOld = (oldCategory != null) ? oldCategory.getIcon() : null;
        String fname = fileOld;

        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            Part part = req.getPart("icon");
            if (part == null || part.getSize() == 0) {
                part = req.getPart("images");
            }

            if (part != null && part.getSize() > 0) {
                String submitted = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String ext = "";
                int idx = submitted.lastIndexOf(".");
                if (idx >= 0) {
                    ext = submitted.substring(idx);
                }
                fname = System.currentTimeMillis() + ext;
                part.write(uploadDir.getAbsolutePath() + File.separator + fname);

                // Xoá file cũ nếu tồn tại
                if (fileOld != null) {
                    File oldFile = new File(uploadDir.getAbsolutePath() + File.separator + fileOld);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Category category = new Category();
        category.setId(id);
        category.setName(name);
        category.setIcon(fname);

        cateService.edit(category);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
