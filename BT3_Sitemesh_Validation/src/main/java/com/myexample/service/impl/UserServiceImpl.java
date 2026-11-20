package com.myexample.service.impl;

import com.myexample.dao.UserDAO;
import com.myexample.dao.impl.UserDAOImpl;
import com.myexample.model.User;
import com.myexample.service.UserService;
import com.myexample.util.EmailUtil;
import com.myexample.util.PasswordUtil;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Random;

/**
 * Tầng nghiệp vụ User Service
 * Xử lý: Đăng ký + OTP kích hoạt, Đăng nhập với mật khẩu mã hóa, Quên mật khẩu
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public class UserServiceImpl implements UserService {

    private final UserDAO userDao = new UserDAOImpl();

    @Override
    public boolean login(String username, String password) {
        User user = checkLogin(username, password);
        return user != null && user.getStatus() == 1;
    }

    @Override
    public User checkLogin(String username, String password) {
        return userDao.checkLogin(username, password);
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        return registerWithOtp(username, password, email, fullname, phone);
    }

    @Override
    public boolean registerWithOtp(String username, String password, String email, String fullname, String phone) {
        if (checkExistUsername(username) || checkExistEmail(email)) {
            return false;
        }

        // Sinh mã OTP 6 chữ số ngẫu nhiên
        String otp = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000); // Có hiệu lực 5 phút

        // Mã hóa mật khẩu với BCrypt Hash
        String hashedPassword = PasswordUtil.hashPassword(password);

        // Tạo tài khoản với status = 0 (Chưa kích hoạt, chờ xác nhận OTP)
        User user = new User();
        user.setUserName(username);
        user.setPassWord(hashedPassword);
        user.setEmail(email);
        user.setFullName(fullname);
        user.setPhone(phone);
        user.setRoleid(2); // Role người dùng thông thường
        user.setCreatedDate(new Date(System.currentTimeMillis()));
        user.setStatus(0); // Chưa kích hoạt
        user.setCode(otp);
        user.setOtpExpiry(expiry);

        // Lưu vào CSDL
        userDao.insert(user);

        // Gửi email chứa mã OTP đến người dùng
        EmailUtil.sendOtpEmail(email, otp, "register");

        return true;
    }

    @Override
    public boolean verifyAccount(String usernameOrEmail, String otp) {
        return userDao.verifyOtp(usernameOrEmail, otp);
    }

    @Override
    public boolean resendOtp(String usernameOrEmail, String actionType) {
        User user = userDao.get(usernameOrEmail);
        if (user == null) {
            return false;
        }

        String otp = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);

        userDao.updateOtp(user.getUserName(), otp, expiry);
        EmailUtil.sendOtpEmail(user.getEmail(), otp, actionType);
        return true;
    }

    @Override
    public boolean sendForgotPasswordOtp(String emailOrUsername) {
        User user = userDao.get(emailOrUsername);
        if (user == null) {
            return false;
        }

        String otp = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);

        userDao.updateOtp(user.getUserName(), otp, expiry);
        EmailUtil.sendOtpEmail(user.getEmail(), otp, "forgot");
        return true;
    }

    @Override
    public boolean resetPassword(String emailOrUsername, String otp, String newPassword) {
        User user = userDao.get(emailOrUsername);
        if (user == null || user.getCode() == null) {
            return false;
        }

        // Kiểm tra mã OTP khớp và thời hạn
        if (!otp.trim().equals(user.getCode().trim())) {
            return false;
        }
        if (user.getOtpExpiry() != null && System.currentTimeMillis() > user.getOtpExpiry().getTime()) {
            return false; // Hết hạn
        }

        // Mã hóa mật khẩu mới và lưu vào CSDL
        String hashedNewPassword = PasswordUtil.hashPassword(newPassword);
        userDao.updatePassword(user.getUserName(), hashedNewPassword);
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public boolean updateProfile(User user) {
        if (user == null || user.getUserName() == null) {
            return false;
        }
        userDao.updateProfile(user);
        return true;
    }

    @Override
    public boolean sendUpdateEmailOtp(String username, String newEmail) {
        if (username == null || newEmail == null) {
            return false;
        }
        User user = userDao.get(username);
        if (user == null) {
            return false;
        }

        // Sinh mã OTP 6 số
        String otp = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000); // 5 phút

        userDao.updateOtp(user.getUserName(), otp, expiry);
        EmailUtil.sendOtpEmail(newEmail, otp, "update_email");
        return true;
    }

    @Override
    public boolean verifyAndUpdateEmail(String username, String newEmail, String otp) {
        if (username == null || newEmail == null || otp == null) {
            return false;
        }
        User user = userDao.get(username);
        if (user == null || user.getCode() == null) {
            return false;
        }

        // Kiểm tra mã OTP khớp và còn hạn
        if (!otp.trim().equals(user.getCode().trim())) {
            return false;
        }
        if (user.getOtpExpiry() != null && System.currentTimeMillis() > user.getOtpExpiry().getTime()) {
            return false; // Hết hạn
        }

        // Hợp lệ -> Cập nhật email mới
        userDao.updateEmail(username, newEmail);
        return true;
    }

    @Override
    public boolean sendProfileOtp(String username, String targetEmail) {
        if (username == null || targetEmail == null) {
            return false;
        }
        User user = userDao.get(username);
        if (user == null) {
            return false;
        }

        // Sinh mã OTP 6 số
        String otp = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000); // 5 phút

        userDao.updateOtp(user.getUserName(), otp, expiry);
        EmailUtil.sendOtpEmail(targetEmail, otp, "update_profile");
        return true;
    }

    @Override
    public boolean verifyAndUpdateFullProfile(User user, String otp) {
        if (user == null || user.getUserName() == null || otp == null) {
            return false;
        }
        User dbUser = userDao.get(user.getUserName());
        if (dbUser == null || dbUser.getCode() == null) {
            return false;
        }

        // Kiểm tra mã OTP khớp và còn hạn
        if (!otp.trim().equals(dbUser.getCode().trim())) {
            return false;
        }
        if (dbUser.getOtpExpiry() != null && System.currentTimeMillis() > dbUser.getOtpExpiry().getTime()) {
            return false;
        }

        userDao.updateFullProfile(user);
        return true;
    }
}
