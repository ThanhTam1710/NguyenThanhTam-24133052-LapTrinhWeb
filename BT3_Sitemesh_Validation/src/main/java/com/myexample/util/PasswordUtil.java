package com.myexample.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Tiện ích mã hóa mật khẩu (Password Hashing)
 * Hỗ trợ BCrypt (chuẩn bảo mật cao nhất) và SHA-256
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public class PasswordUtil {

    /**
     * Băm mật khẩu sử dụng thuật toán BCrypt với salt ngẫu nhiên
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null) {
            return null;
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    /**
     * Băm mật khẩu sử dụng SHA-256
     */
    public static String hashSHA256(String plainPassword) {
        if (plainPassword == null) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(plainPassword.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi thuật toán mã hóa SHA-256", e);
        }
    }

    /**
     * So khớp mật khẩu nhập vào với mật khẩu đã mã hóa trong CSDL
     * Tự động nhận diện BCrypt, SHA-256 hoặc Plain Text (tài khoản demo)
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }

        // 1. Kiểm tra theo chuẩn BCrypt
        if (hashedPassword.startsWith("$2a$") || hashedPassword.startsWith("$2b$") || hashedPassword.startsWith("$2y$")) {
            try {
                return BCrypt.checkpw(plainPassword, hashedPassword);
            } catch (Exception e) {
                return false;
            }
        }

        // 2. Kiểm tra theo chuẩn SHA-256 (chuỗi hex 64 ký tự)
        if (hashedPassword.length() == 64) {
            String sha = hashSHA256(plainPassword);
            if (sha.equalsIgnoreCase(hashedPassword)) {
                return true;
            }
        }

        // 3. Fallback: So sánh chuỗi trực tiếp (cho các tài khoản cũ chưa mã hóa)
        return plainPassword.equals(hashedPassword);
    }
}
