package com.myexample.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;

import com.myexample.model.User;
import com.myexample.service.UserService;
import com.myexample.service.impl.UserServiceImpl;
import com.myexample.util.CloudinaryUtil;
import com.myexample.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * Controller Quản lý Hồ sơ cá nhân (Profile):
 * BẤT KỲ CẬP NHẬT NÀO (Họ tên, SĐT, Email mới, Ảnh đại diện)
 * ĐỀU YÊU CẦU XÁC THỰC MÃ OTP GỬI VỀ EMAIL ĐỂ HOÀN TẤT
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@WebServlet(urlPatterns = {"/profile", "/profile/verify-otp"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB lưu bộ nhớ đệm
    maxFileSize = 1024 * 1024 * 15,       // Tối đa 15MB cho file ảnh
    maxRequestSize = 1024 * 1024 * 25     // Tổng request tối đa 25MB
)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=auth_required");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        User freshUser = userService.get(sessionUser.getUserName());
        if (freshUser == null) {
            freshUser = sessionUser;
        }
        req.setAttribute("user", freshUser);

        String path = req.getServletPath();

        // 1. Trang nhập mã OTP xác thực cập nhật Profile
        if ("/profile/verify-otp".equals(path)) {
            User pendingUser = (User) session.getAttribute("pending_update_user");
            String targetEmail = (String) session.getAttribute("pending_target_email");

            if (pendingUser == null || targetEmail == null) {
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            // Xử lý gửi lại mã OTP (Resend OTP tương tự Bài tập 02)
            String action = req.getParameter("action");
            if ("resend".equalsIgnoreCase(action)) {
                Integer resendCount = (Integer) session.getAttribute("profile_otp_resend_count");
                if (resendCount == null) {
                    resendCount = 0;
                }

                if (resendCount >= 3) {
                    req.setAttribute("errorMsg", "Bạn đã yêu cầu gửi lại OTP quá 3 lần! Vui lòng kiểm tra kỹ hộp thư (" + targetEmail + ") bao gồm mục Thư rác/Spam.");
                    req.setAttribute("blockResend", true);
                } else {
                    Long lastResendTime = (Long) session.getAttribute("profile_last_resend_time");
                    long now = System.currentTimeMillis();
                    if (lastResendTime != null && (now - lastResendTime) < 28000) {
                        long waitSec = Math.max(1, (30000 - (now - lastResendTime)) / 1000);
                        req.setAttribute("errorMsg", "Vui lòng đợi thêm " + waitSec + " giây trước khi bấm gửi lại mã tiếp theo!");
                    } else {
                        resendCount++;
                        session.setAttribute("profile_otp_resend_count", resendCount);
                        session.setAttribute("profile_last_resend_time", now);

                        // Gửi lại mã OTP mới
                        userService.sendProfileOtp(sessionUser.getUserName(), targetEmail);
                        req.setAttribute("message", "Mã OTP mới đã được gửi lại tới email: " + targetEmail + " (Lần " + resendCount + "/3). Mã cũ đã mất hiệu lực!");
                        req.setAttribute("startCooldown", 30);
                    }
                }
            }

            req.setAttribute("pendingUser", pendingUser);
            req.setAttribute("targetEmail", targetEmail);
            req.getRequestDispatcher("/view/profile-verify-otp.jsp").forward(req, resp);
            return;
        }

        // 2. Trang chính /profile
        String msg = req.getParameter("message");
        if ("profile_updated".equals(msg)) {
            req.setAttribute("successMsg", "Xác thực OTP thành công! Toàn bộ thông tin hồ sơ của bạn đã được cập nhật.");
        }

        req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=auth_required");
            return;
        }

        User current = (User) session.getAttribute("account");
        String path = req.getServletPath();

        // =========================================================================
        // BƯỚC 2: XỬ LÝ NHẬP MÃ OTP XÁC NHẬN CẬP NHẬT
        // =========================================================================
        if ("/profile/verify-otp".equals(path)) {
            String otpInput = req.getParameter("otp");
            User pendingUser = (User) session.getAttribute("pending_update_user");
            String targetEmail = (String) session.getAttribute("pending_target_email");

            if (pendingUser == null || targetEmail == null || otpInput == null || otpInput.trim().isEmpty()) {
                req.setAttribute("errorMsg", "Vui lòng nhập đúng 6 chữ số mã OTP!");
                req.setAttribute("targetEmail", targetEmail);
                req.getRequestDispatcher("/view/profile-verify-otp.jsp").forward(req, resp);
                return;
            }

            // Xác thực mã OTP và cập nhật toàn bộ thông tin mới vào CSDL
            boolean isSuccess = userService.verifyAndUpdateFullProfile(pendingUser, otpInput.trim());

            if (isSuccess) {
                // Cập nhật lại session người dùng với dữ liệu mới
                User updatedUser = userService.get(current.getUserName());
                if (updatedUser != null) {
                    session.setAttribute("account", updatedUser);
                    session.setAttribute("name", updatedUser.getFullName());
                }

                // Xóa dữ liệu tạm trong session
                session.removeAttribute("pending_update_user");
                session.removeAttribute("pending_target_email");
                session.removeAttribute("profile_otp_resend_count");
                session.removeAttribute("profile_last_resend_time");

                resp.sendRedirect(req.getContextPath() + "/profile?message=profile_updated");
            } else {
                req.setAttribute("errorMsg", "Mã xác thực OTP không chính xác hoặc đã hết hạn (5 phút)! Vui lòng thử lại.");
                req.setAttribute("targetEmail", targetEmail);
                req.getRequestDispatcher("/view/profile-verify-otp.jsp").forward(req, resp);
            }
            return;
        }

        // =========================================================================
        // BƯỚC 1: NHẬN FORM UPDATE PROFILE -> VALIDATION -> GỬI OTP VỀ EMAIL
        // =========================================================================
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String currentPassword = req.getParameter("currentPassword");

        // Server-side Validation
        if (fullname == null || fullname.trim().isEmpty() || fullname.trim().length() < 2) {
            req.setAttribute("errorMsg", "Họ và tên bắt buộc và phải có ít nhất 2 ký tự!");
            req.setAttribute("user", current);
            req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
            return;
        }

        if (phone == null || !phone.trim().matches("^0[0-9]{9}$")) {
            req.setAttribute("errorMsg", "Số điện thoại không hợp lệ (phải bắt đầu bằng số 0 và có đúng 10 chữ số)!");
            req.setAttribute("user", current);
            req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
            return;
        }

        if (email == null || !email.trim().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            req.setAttribute("errorMsg", "Địa chỉ email không đúng định dạng!");
            req.setAttribute("user", current);
            req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
            return;
        }

        fullname = fullname.trim();
        phone = phone.trim();
        email = email.trim();

        // Kiểm tra nếu đổi email thì BẮT BUỘC PHẢI NHẬP MẬT KHẨU TÀI KHOẢN VÀ EMAIL MỚI CHƯA ĐƯỢC DÙNG
        boolean isEmailChanged = !email.equalsIgnoreCase(current.getEmail());
        if (isEmailChanged) {
            if (currentPassword == null || currentPassword.trim().isEmpty()) {
                req.setAttribute("errorMsg", "Khi thay đổi địa chỉ email, bạn bắt buộc phải nhập mật khẩu tài khoản hiện tại để xác nhận danh tính!");
                req.setAttribute("user", current);
                req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
                return;
            }

            User authUser = userService.checkLogin(current.getUserName(), currentPassword.trim());
            if (authUser == null) {
                req.setAttribute("errorMsg", "Mật khẩu tài khoản không chính xác! Không thể thay đổi địa chỉ email.");
                req.setAttribute("user", current);
                req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
                return;
            }

            User existUser = userService.get(email);
            if (existUser != null && !existUser.getUserName().equalsIgnoreCase(current.getUserName())) {
                req.setAttribute("errorMsg", "Email '" + email + "' đã được sử dụng bởi một tài khoản khác trong hệ thống!");
                req.setAttribute("user", current);
                req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
                return;
            }
        }

        // Xử lý upload avatar lên Cloudinary bằng Multipart
        String finalAvatarUrl = current.getAvatar();
        try {
            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String submittedName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                try (InputStream is = part.getInputStream()) {
                    byte[] bytes = is.readAllBytes();
                    String uploadedUrl = CloudinaryUtil.uploadBytes(bytes, submittedName);
                    if (uploadedUrl != null && !uploadedUrl.isEmpty()) {
                        finalAvatarUrl = uploadedUrl;
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[ProfileServlet] Lỗi upload avatar: " + e.getMessage());
        }

        // Tạo đối tượng User tạm thời chứa toàn bộ thay đổi
        User pendingUser = new User();
        pendingUser.setUserName(current.getUserName());
        pendingUser.setFullName(fullname);
        pendingUser.setPhone(phone);
        pendingUser.setEmail(email);
        pendingUser.setAvatar(finalAvatarUrl);

        // Reset biến đếm gửi lại OTP cho phiên mới
        session.removeAttribute("profile_otp_resend_count");
        session.removeAttribute("profile_last_resend_time");

        // Xác định email sẽ nhận mã OTP:
        // Nếu người dùng đổi sang email mới -> gửi mã OTP đến email mới để xác nhận
        // Nếu người dùng không đổi email -> gửi mã OTP đến email hiện tại của tài khoản
        String targetOtpEmail = isEmailChanged ? email : current.getEmail();

        // Lưu thông tin chờ xác nhận vào Session
        session.setAttribute("pending_update_user", pendingUser);
        session.setAttribute("pending_target_email", targetOtpEmail);

        // GỬI MÃ OTP ĐẾN EMAIL (GMAIL MỚI NẾU ĐỔI EMAIL)
        userService.sendProfileOtp(current.getUserName(), targetOtpEmail);

        // Chuyển hướng người dùng sang trang nhập mã OTP
        resp.sendRedirect(req.getContextPath() + "/profile/verify-otp");
    }
}
