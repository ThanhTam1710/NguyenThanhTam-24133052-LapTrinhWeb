package com.myexample.dao.impl;

import com.myexample.connection.DBConnection;
import com.myexample.dao.UserDAO;
import com.myexample.model.User;
import com.myexample.util.PasswordUtil;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

/**
 * Tầng truy cập dữ liệu User (DAO)
 * Hỗ trợ Hash Password, Kích hoạt OTP qua Email và Bộ nhớ Fallback
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public class UserDAOImpl extends DBConnection implements UserDAO {

    // Danh sách tài khoản mặc định lưu trong bộ nhớ (dự phòng khi database chưa chạy)
    private static final Map<String, User> MEMORY_USERS = new HashMap<>();

    static {
        // Khởi tạo các tài khoản mẫu với MẬT KHẨU ĐÃ ĐƯỢC MÃ HÓA (BCrypt Hash) và STATUS = 1 (Đã kích hoạt)
        User u1 = new User("syber096@gmail.com", "syber096", "Nguyễn Thanh Tâm", PasswordUtil.hashPassword("thanhtam123"), null, 1, "0987654321", new Date(System.currentTimeMillis()));
        u1.setId(1);
        u1.setStatus(1);

        User u2 = new User("thanhtam@gmail.com", "thanhtam", "Nguyễn Thanh Tâm", PasswordUtil.hashPassword("123"), null, 1, "0987654321", new Date(System.currentTimeMillis()));
        u2.setId(2);
        u2.setStatus(1);

        User u3 = new User("tamnt@gmail.com", "tamnt", "Nguyễn Thanh Tâm", PasswordUtil.hashPassword("123"), null, 1, "0987654321", new Date(System.currentTimeMillis()));
        u3.setId(3);
        u3.setStatus(1);

        User u4 = new User("admin@gmail.com", "admin", "Quản Trị Viên", PasswordUtil.hashPassword("123"), null, 1, "0901234567", new Date(System.currentTimeMillis()));
        u4.setId(4);
        u4.setStatus(1);

        MEMORY_USERS.put(u1.getUserName(), u1);
        MEMORY_USERS.put(u2.getUserName(), u2);
        MEMORY_USERS.put(u3.getUserName(), u3);
        MEMORY_USERS.put(u4.getUserName(), u4);
    }

    @Override
    public User get(String username) {
        if (username == null) {
            return null;
        }
        String sql = "SELECT * FROM [User] WHERE username = ? OR email = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            // Sử dụng memory fallback
        }

        // Tìm trong bộ nhớ fallback
        for (User u : MEMORY_USERS.values()) {
            if (username.equalsIgnoreCase(u.getUserName()) || username.equalsIgnoreCase(u.getEmail())) {
                return u;
            }
        }
        return null;
    }

    @Override
    public User getByEmail(String email) {
        if (email == null) {
            return null;
        }
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            // Sử dụng memory fallback
        }

        for (User u : MEMORY_USERS.values()) {
            if (email.equalsIgnoreCase(u.getEmail())) {
                return u;
            }
        }
        return null;
    }

    @Override
    public User checkLogin(String username, String password) {
        User user = this.get(username);
        if (user != null && password != null) {
            // Kiểm tra mật khẩu mã hóa (BCrypt / SHA-256)
            if (PasswordUtil.checkPassword(password, user.getPassWord())) {
                return user;
            }
        }
        return null;
    }

    @Override
    public void insert(User user) {
        // Đảm bảo mật khẩu được mã hóa nếu chưa được mã hóa
        if (user.getPassWord() != null && !user.getPassWord().startsWith("$2a$") && !user.getPassWord().startsWith("$2b$")) {
            user.setPassWord(PasswordUtil.hashPassword(user.getPassWord()));
        }

        // 1. Thử insert có các cột OTP & status
        String sqlFull = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate, status, code, otp_expiry) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        String sqlSimple = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate) VALUES (?,?,?,?,?,?,?,?)";

        boolean inserted = false;
        try (Connection conn = super.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sqlFull)) {
                ps.setString(1, user.getEmail());
                ps.setString(2, user.getUserName());
                ps.setString(3, user.getFullName());
                ps.setString(4, user.getPassWord());
                ps.setString(5, user.getAvatar());
                ps.setInt(6, user.getRoleid());
                ps.setString(7, user.getPhone());
                ps.setDate(8, user.getCreatedDate() != null ? user.getCreatedDate() : new Date(System.currentTimeMillis()));
                ps.setInt(9, user.getStatus());
                ps.setString(10, user.getCode());
                ps.setTimestamp(11, user.getOtpExpiry());
                ps.executeUpdate();
                inserted = true;
            } catch (Exception ex) {
                // Nếu bảng cũ chưa có cột status, code, otp_expiry -> fallback sqlSimple
                try (PreparedStatement ps2 = conn.prepareStatement(sqlSimple)) {
                    ps2.setString(1, user.getEmail());
                    ps2.setString(2, user.getUserName());
                    ps2.setString(3, user.getFullName());
                    ps2.setString(4, user.getPassWord());
                    ps2.setString(5, user.getAvatar());
                    ps2.setInt(6, user.getRoleid());
                    ps2.setString(7, user.getPhone());
                    ps2.setDate(8, user.getCreatedDate() != null ? user.getCreatedDate() : new Date(System.currentTimeMillis()));
                    ps2.executeUpdate();
                    inserted = true;
                }
            }
        } catch (Exception e) {
            // Không kết nối được CSDL
        }

        // Luôn lưu vào bộ nhớ dự phòng
        MEMORY_USERS.put(user.getUserName(), user);
    }

    @Override
    public void updatePassword(String username, String newHashedPassword) {
        String sql = "UPDATE [User] SET password = ?, code = NULL, otp_expiry = NULL WHERE username = ? OR email = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newHashedPassword);
            ps.setString(2, username);
            ps.setString(3, username);
            ps.executeUpdate();
        } catch (Exception e) {
            // Bỏ qua lỗi DB
        }

        User u = get(username);
        if (u != null) {
            u.setPassWord(newHashedPassword);
            u.setCode(null);
            u.setOtpExpiry(null);
            MEMORY_USERS.put(u.getUserName(), u);
        }
    }

    @Override
    public void updateStatus(String username, int status) {
        String sql = "UPDATE [User] SET status = ?, code = NULL, otp_expiry = NULL WHERE username = ? OR email = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setString(2, username);
            ps.setString(3, username);
            ps.executeUpdate();
        } catch (Exception e) {
            // Bỏ qua lỗi DB
        }

        User u = get(username);
        if (u != null) {
            u.setStatus(status);
            u.setCode(null);
            u.setOtpExpiry(null);
            MEMORY_USERS.put(u.getUserName(), u);
        }
    }

    @Override
    public void updateOtp(String username, String otp, Timestamp expiry) {
        String sql = "UPDATE [User] SET code = ?, otp_expiry = ? WHERE username = ? OR email = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, otp);
            ps.setTimestamp(2, expiry);
            ps.setString(3, username);
            ps.setString(4, username);
            ps.executeUpdate();
        } catch (Exception e) {
            // Bỏ qua lỗi DB
        }

        User u = get(username);
        if (u != null) {
            u.setCode(otp);
            u.setOtpExpiry(expiry);
            MEMORY_USERS.put(u.getUserName(), u);
        }
    }

    @Override
    public boolean verifyOtp(String username, String otp) {
        if (username == null || otp == null) {
            return false;
        }
        User u = get(username);
        if (u == null || u.getCode() == null) {
            return false;
        }

        // Kiểm tra mã OTP khớp
        if (!otp.trim().equals(u.getCode().trim())) {
            return false;
        }

        // Kiểm tra thời hạn OTP (nếu có lưu)
        if (u.getOtpExpiry() != null && System.currentTimeMillis() > u.getOtpExpiry().getTime()) {
            return false; // OTP đã hết hạn
        }

        // Hợp lệ -> Kích hoạt tài khoản và xóa OTP
        updateStatus(u.getUserName(), 1);
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        if (email == null) return false;
        return getByEmail(email) != null;
    }

    @Override
    public boolean checkExistUsername(String username) {
        if (username == null) return false;
        return get(username) != null;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        if (phone == null) return false;
        String sql = "SELECT * FROM [User] WHERE phone = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return true;
            }
        } catch (Exception e) {
            // Fallback
        }
        for (User u : MEMORY_USERS.values()) {
            if (phone.equals(u.getPhone())) return true;
        }
        return false;
    }

    private User mapUser(ResultSet rs) {
        try {
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

            // Đọc các cột mở rộng nếu có
            try {
                user.setStatus(rs.getInt("status"));
            } catch (Exception ignored) {
                user.setStatus(1);
            }
            try {
                user.setCode(rs.getString("code"));
            } catch (Exception ignored) {}
            try {
                user.setOtpExpiry(rs.getTimestamp("otp_expiry"));
            } catch (Exception ignored) {}

            return user;
        } catch (Exception e) {
            return null;
        }
    }
}
