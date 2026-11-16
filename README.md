# LẬP TRÌNH WEB (WEBPR330479)
## BÁO CÁO BÀI TẬP 02 (12/11/2026 - 16/11/2026)
### BỔ SUNG: KÍCH HOẠT OTP QUA EMAIL, HASH PASSWORD & QUÊN MẬT KHẨU

> ## 🎯 THƯ MỤC BÀI TẬP CẦN CHẤM: `BT2_CRUD`
> 👉 **Kính gửi Thầy:** Toàn bộ yêu cầu bài tập 02 (Kích hoạt OTP Email, Mật khẩu băm BCrypt, Đăng xuất, Quên mật khẩu OTP qua mail, Web Bán Hàng CRUD Danh mục) được thực hiện hoàn chỉnh trong thư mục: **`BT2_CRUD/`**.
> * **Khi mở trên Eclipse / STS / VS Code:** Thầy chỉ cần chọn mở duy nhất thư mục **`BT2_CRUD`** (hoặc file `BT2_CRUD/pom.xml`) -> **Run on Server (Tomcat 10.1)**.
> * *Lưu ý:* Thư mục `BT1_Login_Cookie_Session` và `BT_JPA_CRUD_Category` là các bài tập cũ trước đó lưu kèm theo trong repository.

* **Trường:** Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE)
* **Khoa:** Công Nghệ Thông Tin
* **Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung
* **Sinh viên thực hiện:** Nguyễn Thanh Tâm
* **Mã số sinh viên (MSSV):** 24133052
* **Kho lưu trữ GitHub:** [https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb](https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb)
* **Tài liệu hướng dẫn chạy chi tiết:** 👉 **[Xem file HUONG_DAN_CHAY_WEB.md](HUONG_DAN_CHAY_WEB.md)**

---

### 🔑 DANH SÁCH TÀI KHOẢN KIỂM THỬ (DÀNH CHO GIẢNG VIÊN CHẤM BÀI):

| STT | Tên tài khoản (Username) | Mật khẩu gốc | Chuẩn mã hóa lưu CSDL | Trạng thái kích hoạt | Quyền hạn (Role) | Chức năng kiểm thử |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| **1** | **`syber096`** | **`thanhtam123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Quản trị)** | Đăng nhập Hash Password, Cookie, Session, CRUD Category |
| **2** | **`thanhtam`** | **`123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Quản trị)** | Đăng nhập Hash Password, Cookie, Session, CRUD Category |
| **3** | **`admin`** | **`123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Dự phòng)** | Đăng nhập quản trị hệ thống |

> 💡 **Kiểm thử Đăng ký tài khoản mới & Nhận OTP:**  
> Hệ thống đã cấu hình SMTP Gmail thật. Khi đăng ký hoặc quên mật khẩu, giảng viên chỉ cần nhập **email thật** của mình, mã OTP 6 số sẽ được gửi trực tiếp đến hộp thư (kiểm tra cả thư mục Spam). Ngoài ra, mã OTP cũng được **hiển thị trực tiếp trên giao diện** (khung "Hỗ trợ chấm bài") để test nhanh mà không cần mở email.  
> 📖 **Hướng dẫn kiểm thử chi tiết từng bước:** xem file **[HUONG_DAN_CHAY_WEB.md](HUONG_DAN_CHAY_WEB.md)** → Mục 5.

---

### 🚀 NỘI DUNG VÀ HƯỚNG DẪN CÁC TÍNH NĂNG MỚI BỔ SUNG:

#### 1. Kích hoạt tài khoản bằng mã OTP được gửi qua email khi đăng ký tài khoản
* **Đường dẫn (URL):** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/register`
* **Quy trình hoạt động:**
  1. Người dùng điền thông tin: Tên đăng nhập, Email, Họ tên, Số điện thoại, Mật khẩu, Xác nhận mật khẩu.
  2. Hệ thống kiểm tra trùng lặp tài khoản / email. Mật khẩu được mã hóa an toàn bằng thuật toán **BCrypt** (`PasswordUtil.hashPassword`).
  3. Hệ thống sinh mã OTP ngẫu nhiên 6 chữ số với thời hạn 5 phút, lưu tài khoản ở trạng thái chưa kích hoạt (`status = 0`, `code = OTP`).
  4. Hệ thống gửi email chứa mã OTP đến địa chỉ email đăng ký qua giao thức **Jakarta Mail (SMTP Gmail)** và chuyển hướng sang trang `/verify-otp`.
  5. Người dùng nhập mã OTP 6 chữ số. Khi khớp và còn hạn, tài khoản được kích hoạt (`status = 1`), người dùng có thể đăng nhập bình thường.
  6. Có chức năng **"Gửi lại mã OTP"** (`/verify-otp?action=resend`) nếu mã cũ hết hạn.

#### 2. Đăng nhập với mật khẩu được mã hóa (Hash Password) & Đăng xuất
* **Đường dẫn (URL):** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/login`
* **Quy trình hoạt động:**
  1. Người dùng nhập tên đăng nhập (hoặc email) và mật khẩu.
  2. Hệ thống so khớp mật khẩu bằng hàm bảo mật `PasswordUtil.checkPassword(plainPassword, hashedPassword)` (sử dụng `BCrypt.checkpw`), đảm bảo mật khẩu không bao giờ được lưu hay so sánh dưới dạng văn bản thuần.
  3. **Kiểm tra trạng thái kích hoạt:** Nếu tài khoản tồn tại nhưng chưa được xác nhận OTP (`status == 0`), hệ thống sẽ từ chối đăng nhập và tự động điều hướng sang trang nhập OTP kích hoạt.
  4. Hỗ trợ tùy chọn **"Ghi nhớ đăng nhập"** lưu Cookie trong 7 ngày.
* **Đăng xuất (Logout):**
  * **Đường dẫn (URL):** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/logout`
  * Hủy bỏ `HttpSession`, xóa sạch Cookie lưu đăng nhập trên trình duyệt và chuyển hướng về trang đăng nhập kèm thông báo.

#### 3. Quên mật khẩu gửi mã xác nhận OTP qua email
* **Đường dẫn (URL):** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/forgot-password`
* **Quy trình hoạt động:**
  1. Người dùng nhập Email hoặc Tên đăng nhập cần khôi phục mật khẩu.
  2. Hệ thống kiểm tra sự tồn tại trong CSDL. Nếu hợp lệ, hệ thống tạo mã OTP mới (hiệu lực 5 phút) và gửi email hướng dẫn đặt lại mật khẩu.
  3. Chuyển hướng sang trang `/reset-password`. Người dùng nhập mã OTP nhận được, mật khẩu mới và xác nhận mật khẩu.
  4. Hệ thống xác thực mã OTP, băm mật khẩu mới bằng **BCrypt** và cập nhật vào CSDL. Người dùng đăng nhập ngay bằng mật khẩu mới.

---

### 📂 CẤU TRÚC BÀI NỘP TRÊN GITHUB REPOSITORY:

```text
NguyenThanhTam-24133052-LapTrinhWeb/
├── BT1_Login_Cookie_Session/               # Bài tập 1: Cookie & Session
│   ├── HelloCookieServlet.java
│   ├── LoginCookieServlet.java
│   ├── LoginSessionServlet.java
│   ├── ProfileServlet.java
│   └── LogoutServlet.java
│
├── BT2_CRUD/                               # Bài tập 2: Mô hình 3 tầng MVC + Tính năng OTP & Hash Password
│   ├── pom.xml                             # Thư viện: Jakarta Servlet 6.0, Jakarta Mail 2.1.3, jBCrypt 0.4, MSSQL
│   ├── database.sql                        # Script CSDL SQL Server cập nhật trường status, code, otp_expiry, hash pass
│   └── src/main/
│       ├── java/com/myexample/
│       │   ├── connection/DBConnection.java
│       │   ├── model/                      # User.java (status, code, otpExpiry), Category.java
│       │   ├── util/                       # PasswordUtil.java (BCrypt & SHA-256), EmailUtil.java (SMTP + Logging)
│       │   ├── dao/                        # UserDAO.java, CategoryDAO.java, impl/UserDAOImpl.java
│       │   ├── service/                    # UserService.java, impl/UserServiceImpl.java (registerWithOtp, resetPassword)
│       │   └── controller/                 # LoginServlet, LogoutServlet, RegisterServlet, VerifyOtpServlet, ForgotPasswordServlet, ResetPasswordServlet...
│       └── webapp/
│           ├── WEB-INF/web.xml
│           └── view/
│               ├── index.jsp               # Bảng điều khiển trung tâm liên kết toàn bộ chức năng
│               ├── login.jsp               # Giao diện đăng nhập hỗ trợ mã hóa và tài khoản mẫu
│               ├── register.jsp            # Giao diện đăng ký tài khoản mới
│               ├── verify-otp.jsp          # Giao diện nhập mã OTP kích hoạt tài khoản
│               ├── forgot-password.jsp     # Giao diện yêu cầu OTP quên mật khẩu
│               ├── reset-password.jsp      # Giao diện nhập OTP và thiết lập mật khẩu mới
│               └── list-category.jsp       # Giao diện CRUD danh mục
│
└── BT_JPA_CRUD_Category/                   # Bài tập JPA 3.0 & Hibernate ORM 6.4 theo chuẩn UTEx LMS
    ├── pom.xml                             # Hibernate 6.4.4.Final, Jakarta Persistence 3.1, MSSQL JDBC
    └── src/main/
        ├── resources/META-INF/persistence.xml # Cấu hình persistence-unit jpa-hibernate-mysql
        └── java/vn/iotstar/
            ├── entity/                     # Category.java, Video.java, User.java (Entity JPA)
            ├── util/                       # PasswordUtil.java, EmailUtil.java
            ├── config/                     # JpaConfig.java (Singleton EntityManagerFactory), Test.java
            ├── dao/ & service/             # CategoryDao, CategoryServiceImpl
            └── controller/                 # CategoryController, DownloadImageController, HomeController
```

---

### 🌐 DANH SÁCH ĐƯỜNG DẪN KIỂM THỬ TRỰC TIẾP:
1. **Trang chủ tổng hợp:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/`
2. **Đăng ký tài khoản (Gửi OTP Email):** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/register`
3. **Xác nhận mã OTP:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/verify-otp`
4. **Đăng nhập mật khẩu Hash:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/login`
5. **Đăng xuất:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/logout`
6. **Quên mật khẩu (Gửi OTP Email):** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/forgot-password`
7. **Đặt lại mật khẩu mới:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/reset-password`
8. **Quản lý danh mục CRUD:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/admin/category/list`
9. **Dự án JPA 3.0 Category:** `http://localhost:8080/24133052_NguyenThanhTam_JPA/admin/categories`
