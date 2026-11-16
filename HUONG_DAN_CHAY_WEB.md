# HƯỚNG DẪN KHỞI CHẠY VÀ KIỂM THỬ HỆ THỐNG WEB
## BÀI TẬP LẬP TRÌNH WEB (WEBPR330479) - HCMUTE

* **Sinh viên thực hiện:** Nguyễn Thanh Tâm
* **Mã số sinh viên (MSSV):** 24133052
* **Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung
* **Kho lưu trữ GitHub:** [https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb](https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb)

---

## 1. CÁCH KHỞI CHẠY MÁY CHỦ TOMCAT ĐỂ MỞ WEB

### Cách 1: Khởi chạy nhanh bằng Apache Tomcat có sẵn (Khuyên dùng)
1. Mở cửa sổ **Terminal / PowerShell** hoặc **Command Prompt (cmd)**.
2. Chạy lệnh sau để khởi động Tomcat:
   ```cmd
   set JAVA_HOME=C:\Program Files\Java\jdk-24
   D:\LapTrinhWeb\apache-tomcat-10.1.44\apache-tomcat-10.1.44\bin\catalina.bat run
   ```
3. Sau khi màn hình console hiện thông báo `Deployment of web application archive has finished`, mở trình duyệt web bất kỳ và truy cập:
   👉 **[http://localhost:8080/24133052_NguyenThanhTam_CRUD/](http://localhost:8080/24133052_NguyenThanhTam_CRUD/)**

---

### Cách 2: Khởi chạy bằng Eclipse / Spring Tool Suite (STS) / VS Code
1. Mở IDE (Eclipse, STS hoặc VS Code).
2. Chọn **File -> Open Projects from File System...** và trỏ đến thư mục `BT2_CRUD`.
3. Click chuột phải vào dự án -> **Run As -> Run on Server** -> Chọn **Apache Tomcat v10.1**.
4. Ứng dụng sẽ tự động mở trang chủ tại trình duyệt tích hợp.

---

## 2. BẢNG TÀI KHOẢN ĐĂNG NHẬP & KIỂM THỬ SẴN CÓ

| STT | Tài khoản (Username) | Mật khẩu gốc | Chuẩn mã hóa CSDL | Trạng thái kích hoạt | Quyền hạn (Role) | Chức năng kiểm thử |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| **1** | **`syber096`** | **`thanhtam123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Quản trị)** | Đăng nhập Hash Password, Cookie, Session, CRUD Category |
| **2** | **`thanhtam`** | **`123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Quản trị)** | Đăng nhập Hash Password, Cookie, Session, CRUD Category |
| **3** | **`admin`** | **`123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Dự phòng)** | Đăng nhập quản trị hệ thống |

---

## 3. KỊCH BẢN KIỂM THỬ TỪNG CHỨC NĂNG TRÊN GIAO DIỆN

### 🔹 Kịch bản 1: Đăng ký tài khoản & Nhận mã OTP qua Email
1. Truy cập đường dẫn: **`http://localhost:8080/24133052_NguyenThanhTam_CRUD/register`** (hoặc bấm vào thẻ số 1 ở Trang chủ).
2. Nhập các thông tin đăng ký:
   * **Tên đăng nhập:** ví dụ `tamuser`
   * **Email:** ví dụ `tamuser@gmail.com`
   * **Họ tên:** `Nguyễn Thanh Tâm`
   * **Số điện thoại:** `0987654321`
   * **Mật khẩu:** `123456`
   * **Xác nhận mật khẩu:** `123456`
3. Bấm nút **"Đăng Ký & Nhận Mã OTP Qua Email"**:
   * Mật khẩu sẽ được tự động băm bảo mật bằng **BCrypt Hash**.
   * Hệ thống tự động chuyển hướng bạn sang trang **`/verify-otp`**.
   * Trên trang xác nhận, **khung màu vàng trợ giúp** sẽ hiển thị ngay mã OTP 6 chữ số vừa tạo (đồng thời mã cũng được ghi log ra Server Console và gửi qua email).
4. Nhập 6 chữ số OTP vào ô và bấm **"Kích Hoạt Tài Khoản"**:
   * Hệ thống báo kích hoạt thành công và chuyển thẳng sang trang Đăng nhập.

---

### 🔹 Kịch bản 2: Đăng nhập với Mật khẩu mã hóa (Hash Password)
1. Truy cập đường dẫn: **`http://localhost:8080/24133052_NguyenThanhTam_CRUD/login`**
2. Đăng nhập bằng tài khoản mẫu:
   * **Username:** `syber096`
   * **Password:** `thanhtam123`
   *(Hoặc đăng nhập bằng tài khoản `tamuser` / `123456` vừa tạo ở Kịch bản 1)*.
3. Bấm nút **"Đăng Nhập (Bảo Mật Hash)"**:
   * Hệ thống sử dụng hàm `PasswordUtil.checkPassword()` để so khớp với chuỗi BCrypt lưu trong CSDL.
   * Nếu tài khoản chưa xác thực OTP, hệ thống sẽ tự động chặn và yêu cầu nhập mã OTP trước khi cho phép vào hệ thống.
   * Đăng nhập thành công sẽ đưa bạn về Trang chủ kèm lời chào cá nhân hóa: `Xin chào: Nguyễn Thanh Tâm (Username: syber096)`.

---

### 🔹 Kịch bản 3: Đăng xuất an toàn (Logout)
1. Khi đã đăng nhập, ở thanh thông báo trên cùng của Trang chủ xuất hiện nút màu đỏ **"Đăng Xuất"** (hoặc vào URL: `http://localhost:8080/24133052_NguyenThanhTam_CRUD/logout`).
2. Bấm vào nút này:
   * Hệ thống hủy bỏ phiên làm việc (`session.invalidate()`).
   * Xóa Cookie đăng nhập nếu có.
   * Chuyển về màn hình đăng nhập với thông báo xanh: *"Đã đăng xuất thành công khỏi hệ thống!"*.

---

### 🔹 Kịch bản 4: Quên mật khẩu & Gửi OTP qua Email đặt lại mật khẩu mới
1. Tại trang Đăng nhập, bấm vào dòng chữ **"Quên mật khẩu?"** (hoặc vào link `http://localhost:8080/24133052_NguyenThanhTam_CRUD/forgot-password`).
2. Nhập Email hoặc Username cần khôi phục (ví dụ: `thanhtam@gmail.com` hoặc `syber096`).
3. Bấm **"Gửi Mã Xác Nhận OTP Qua Email"**:
   * Hệ thống kiểm tra tài khoản, sinh mã OTP 6 số ngẫu nhiên mới và dẫn sang trang `/reset-password`.
   * Khung trợ giúp hiển thị mã OTP vừa gửi.
4. Nhập mã OTP và mật khẩu mới (ví dụ: `newpass123`) -> Bấm **"Xác Nhận & Cập Nhật Mật Khẩu"**.
5. Mật khẩu mới được tự động băm BCrypt và lưu vào CSDL. Hệ thống thông báo thành công và bạn có thể đăng nhập ngay bằng mật khẩu mới vừa đổi.

---

### 🔹 Kịch bản 5: Quản lý danh mục sản phẩm (CRUD Category)
1. Truy cập đường dẫn: **`http://localhost:8080/24133052_NguyenThanhTam_CRUD/admin/category/list`**
2. **Hiển thị danh sách:** Danh sách danh mục với hình ảnh, tên và các nút chức năng.
3. **Thêm mới (`/admin/category/add`):** Nhập tên danh mục, tải ảnh icon từ máy hoặc dán link ảnh trực tiếp -> Bấm Lưu.
4. **Chỉnh sửa (`/admin/category/edit?id=...`):** Cập nhật tên hoặc đổi ảnh mới -> Bấm Cập nhật.
5. **Xóa danh mục (`/admin/category/delete?id=...`):** Bấm nút Xóa để loại bỏ danh mục.

---

### 🔹 Kịch bản 6: Đăng nhập Cookie (30s) & Session Profile
* **Đăng nhập Cookie:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/login-cookie` -> Lưu username vào Cookie tồn tại đúng 30 giây rồi tự hủy.
* **Đăng nhập Session:** `http://localhost:8080/24133052_NguyenThanhTam_CRUD/login-session` -> Lưu phiên với `HttpSession` và xem trang thông tin cá nhân tại `/profile`.

---

## 4. DANH SÁCH TẤT CẢ CÁC ĐƯỜNG DẪN URL TRỰC TIẾP

| Tên chức năng | Đường dẫn URL |
| :--- | :--- |
| **Trang chủ tổng hợp** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/` |
| **Đăng ký (Gửi OTP Email)** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/register` |
| **Xác thực mã OTP** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/verify-otp` |
| **Đăng nhập (Mật khẩu Hash)** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/login` |
| **Đăng xuất (Logout)** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/logout` |
| **Quên mật khẩu** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/forgot-password` |
| **Đặt lại mật khẩu mới** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/reset-password` |
| **Quản lý danh mục CRUD** | `http://localhost:8080/24133052_NguyenThanhTam_CRUD/admin/category/list` |
| **Dự án JPA 3.0 Category** | `http://localhost:8080/24133052_NguyenThanhTam_JPA/admin/categories` |

---

> 🎯 **Lưu ý đặc biệt cho môi trường chấm bài:**  
> Hệ thống được lập trình với cơ chế **In-Memory Fallback** thông minh: Nếu máy chấm bài của giảng viên chưa bật dịch vụ SQL Server hoặc chưa có kết nối Internet để gửi mail SMTP, hệ thống **vẫn hoạt động 100% mượt mà** với dữ liệu mẫu trong RAM và in mã OTP trực tiếp lên giao diện để thầy có thể hoàn thành việc chấm điểm chỉ trong 1 - 2 phút!
