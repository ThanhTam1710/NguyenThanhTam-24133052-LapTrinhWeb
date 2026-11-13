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
    private static int currentId = 3;

    static {
        MEMORY_LIST.add(new Category(1, "Quần Áo Nam", null));
        MEMORY_LIST.add(new Category(2, "Quần Áo Nữ", null));
        MEMORY_LIST.add(new Category(3, "Giày Dép Thời Trang", null));
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
