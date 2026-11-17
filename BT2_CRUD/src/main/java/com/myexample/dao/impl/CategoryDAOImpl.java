package com.myexample.dao.impl;

import com.myexample.connection.DBConnection;
import com.myexample.dao.CategoryDAO;
import com.myexample.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAOImpl extends DBConnection implements CategoryDAO {

    // Danh sách dự phòng bộ nhớ nếu máy tính chưa bật SQL Server
    private static final List<Category> MEMORY_LIST = new ArrayList<>();
    private static int currentId = 10;

    static {
        MEMORY_LIST.add(new Category(1, "Quần Áo Nam", "https://images.unsplash.com/photo-1490114538077-0a7f8cb49891?w=200"));
        MEMORY_LIST.add(new Category(2, "Quần Áo Nữ", "https://images.unsplash.com/photo-1483985988355-763728e1935b?w=200"));
        MEMORY_LIST.add(new Category(3, "Giày Dép Thời Trang", "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=200"));
        MEMORY_LIST.add(new Category(4, "Áo Sơ Mi & Công Sở", "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=200"));
        MEMORY_LIST.add(new Category(5, "Váy Đầm Dự Tiệc", "https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=200"));
        MEMORY_LIST.add(new Category(6, "Quần Jean & Denim", "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=200"));
        MEMORY_LIST.add(new Category(7, "Áo Khoác & Outerwear", "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=200"));
        MEMORY_LIST.add(new Category(8, "Trang Sức & Phụ Kiện", "https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200"));
        MEMORY_LIST.add(new Category(9, "Túi Xách & Balo Nữ", "https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200"));
        MEMORY_LIST.add(new Category(10, "Đồng Hồ & Mắt Kính", "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=200"));
    }

    @Override
    public List<Category> getAll() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("cate_id"));
                c.setName(rs.getString("cate_name"));
                c.setIcon(rs.getString("icons"));
                categories.add(c);
            }
            return categories;
        } catch (Exception e) {
            // Nếu SQL Server chưa kết nối được -> dùng danh sách bộ nhớ tạm
            return new ArrayList<>(MEMORY_LIST);
        }
    }

    @Override
    public Category get(int id) {
        String sql = "SELECT * FROM Category WHERE cate_id = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category c = new Category();
                    c.setId(rs.getInt("cate_id"));
                    c.setName(rs.getString("cate_name"));
                    c.setIcon(rs.getString("icons"));
                    return c;
                }
            }
        } catch (Exception e) {
            for (Category c : MEMORY_LIST) {
                if (c.getId() == id) return c;
            }
        }
        return null;
    }

    @Override
    public Category get(String name) {
        String sql = "SELECT * FROM Category WHERE cate_name = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category c = new Category();
                    c.setId(rs.getInt("cate_id"));
                    c.setName(rs.getString("cate_name"));
                    c.setIcon(rs.getString("icons"));
                    return c;
                }
            }
        } catch (Exception e) {
            for (Category c : MEMORY_LIST) {
                if (c.getName().equalsIgnoreCase(name)) return c;
            }
        }
        return null;
    }

    @Override
    public void insert(Category category) {
        String sql = "INSERT INTO Category(cate_name, icons) VALUES (?, ?)";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getIcon());
            ps.executeUpdate();
        } catch (Exception e) {
            currentId++;
            category.setId(currentId);
            MEMORY_LIST.add(category);
        }
    }

    @Override
    public void edit(Category category) {
        String sql = "UPDATE Category SET cate_name = ?, icons = ? WHERE cate_id = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getIcon());
            ps.setInt(3, category.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            for (int i = 0; i < MEMORY_LIST.size(); i++) {
                if (MEMORY_LIST.get(i).getId() == category.getId()) {
                    MEMORY_LIST.set(i, category);
                    break;
                }
            }
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Category WHERE cate_id = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            MEMORY_LIST.removeIf(c -> c.getId() == id);
        }
    }

    @Override
    public List<Category> search(String keyword) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category WHERE cate_name LIKE ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category c = new Category();
                    c.setId(rs.getInt("cate_id"));
                    c.setName(rs.getString("cate_name"));
                    c.setIcon(rs.getString("icons"));
                    list.add(c);
                }
            }
        } catch (Exception e) {
            for (Category c : MEMORY_LIST) {
                if (c.getName().toLowerCase().contains(keyword.toLowerCase())) {
                    list.add(c);
                }
            }
        }
        return list;
    }
}
