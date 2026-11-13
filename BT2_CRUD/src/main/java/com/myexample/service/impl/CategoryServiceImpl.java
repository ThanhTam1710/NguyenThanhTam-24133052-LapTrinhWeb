package com.myexample.service.impl;

import com.myexample.dao.CategoryDAO;
import com.myexample.dao.impl.CategoryDAOImpl;
import com.myexample.model.Category;
import com.myexample.service.CategoryService;
import com.myexample.util.Constant;

import java.io.File;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    private final CategoryDAO categoryDao = new CategoryDAOImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());
        if (oldCategory != null) {
            oldCategory.setName(newCategory.getName());
            if (newCategory.getIcon() != null && !newCategory.getIcon().isEmpty()) {
                // Xoá file ảnh cũ nếu có
                String oldFileName = oldCategory.getIcon();
                if (oldFileName != null) {
                    File file = new File(Constant.DIR + File.separator + oldFileName);
                    if (file.exists()) {
                        file.delete();
                    }
                }
                oldCategory.setIcon(newCategory.getIcon());
            }
            categoryDao.edit(oldCategory);
        } else {
            categoryDao.edit(newCategory);
        }
    }

    @Override
    public void delete(int id) {
        Category oldCategory = categoryDao.get(id);
        if (oldCategory != null && oldCategory.getIcon() != null) {
            File file = new File(Constant.DIR + File.separator + oldCategory.getIcon());
            if (file.exists()) {
                file.delete();
            }
        }
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.search(keyword);
    }
}
