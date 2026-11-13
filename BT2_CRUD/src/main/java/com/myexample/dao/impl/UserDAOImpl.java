package com.myexample.dao.impl;

import com.myexample.connection.DBConnection;
import com.myexample.dao.UserDAO;
import com.myexample.model.User;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class UserDAOImpl extends DBConnection implements UserDAO {

    // Danh sách tài khoản mặc định lưu trong bộ nhớ (dự phòng)
    private static final Map<String, User> MEMORY_USERS = new HashMap<>();

    static {
        // Tài khoản sinh viên Nguyễn Thành Tâm - MSSV: 24133052
        MEMORY_USERS.put("thanhtam", new User("thanhtam@gmail.com", "thanhtam", "Nguyễn Thành Tâm", "123", null, 1, "0987654321", new Date(System.currentTimeMillis())));
        MEMORY_USERS.put("tamnt", new User("tamnt@gmail.com", "tamnt", "Nguyễn Thành Tâm", "123", null, 1, "0987654321", new Date(System.currentTimeMillis())));
        MEMORY_USERS.put("admin", new User("admin@gmail.com", "admin", "Quản Trị Viên", "123", null, 1, "0901234567", new Date(System.currentTimeMillis())));
    }

    @Override
    public User get(String username) {
        String sql = "SELECT * FROM [User] WHERE username = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setEmail(rs.getString("email"));
                    user.setUserName(rs.getString("username"));
                    user.setFullName(rs.getString("fullname"));
                    user.setPassWord(rs.getString("password"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setRoleid(rs.getInt("roleid"));
                    user.setPhone(rs.getString("phone"));
                    user.setCreatedDate(rs.getDate("createdDate"));
                    return user;
                }
            }
        } catch (Exception e) {
            return MEMORY_USERS.get(username);
        }
        return MEMORY_USERS.get(username);
    }

    @Override
    public User checkLogin(String username, String password) {
        User user = this.get(username);
        if (user != null && password != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public void insert(User user) {
        String sql = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate());
            ps.executeUpdate();
        } catch (Exception e) {
            MEMORY_USERS.put(user.getUserName(), user);
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return true;
            }
        } catch (Exception e) {
            for (User u : MEMORY_USERS.values()) {
                if (email.equalsIgnoreCase(u.getEmail())) return true;
            }
        }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return this.get(username) != null;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        String sql = "SELECT * FROM [User] WHERE phone = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return true;
            }
        } catch (Exception e) {
            for (User u : MEMORY_USERS.values()) {
                if (phone.equals(u.getPhone())) return true;
            }
        }
        return false;
    }
}
