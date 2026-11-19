package com.myexample.dao;

import java.sql.Timestamp;
import com.myexample.model.User;

public interface UserDAO {
    User get(String username);
    User getByEmail(String email);
    void insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    User checkLogin(String username, String password);

    // Bổ sung các phương thức phục vụ OTP & Đổi mật khẩu
    void updatePassword(String username, String newHashedPassword);
    void updateStatus(String username, int status);
    void updateOtp(String username, String otp, Timestamp expiry);
    boolean verifyOtp(String username, String otp);
}
