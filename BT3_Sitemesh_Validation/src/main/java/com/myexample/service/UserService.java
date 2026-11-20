package com.myexample.service;

import com.myexample.model.User;

public interface UserService {
    boolean login(String username, String password);
    User checkLogin(String username, String password);
    User get(String username);
    void insert(User user);
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);

    // Bổ sung các chức năng OTP và Quên mật khẩu
    boolean registerWithOtp(String username, String password, String email, String fullname, String phone);
    boolean verifyAccount(String usernameOrEmail, String otp);
    boolean resendOtp(String usernameOrEmail, String actionType);
    boolean sendForgotPasswordOtp(String emailOrUsername);
    boolean resetPassword(String emailOrUsername, String otp, String newPassword);

    // Cập nhật thông tin Profile & Đổi email kèm OTP
    boolean updateProfile(User user);
    boolean sendUpdateEmailOtp(String username, String newEmail);
    boolean verifyAndUpdateEmail(String username, String newEmail, String otp);
    boolean sendProfileOtp(String username, String targetEmail);
    boolean verifyAndUpdateFullProfile(User user, String otp);
}
