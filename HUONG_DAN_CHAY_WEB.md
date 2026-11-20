# HƯỚNG DẪN KHỞI CHẠY VÀ KIỂM THỬ HỆ THỐNG WEB
## BÀI TẬP LẬP TRÌNH WEB (WEBPR330479) - HCMUTE

> ## 🎯 THƯ MỤC CẦN CHẤM BÀI MỚI NHẤT: `BT3_Sitemesh_Validation`
> 👉 Toàn bộ source code Bài tập 03 (SiteMesh Decorator 3, Template Bootstrap 5, Form Validation đầy đủ 2 lớp Client/Server, Bảo mật AuthFilter) nằm trong thư mục: **`BT3_Sitemesh_Validation/`**.

* **Sinh viên thực hiện:** Nguyễn Thanh Tâm
* **Mã số sinh viên (MSSV):** 24133052
* **Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung
* **Kho lưu trữ GitHub:** [https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb](https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb)

---

## 1. CÁCH KHỞI CHẠY MÁY CHỦ TOMCAT ĐỂ MỞ WEB (BÀI TẬP 03)

### Cách 1: Khởi chạy nhanh bằng Apache Tomcat có sẵn (Khuyên dùng)
1. Mở cửa sổ **Terminal / PowerShell** hoặc **Command Prompt (cmd)**.
2. Chạy lệnh sau để khởi động Tomcat:
   ```cmd
   set "JAVA_HOME=C:\Program Files\Java\jdk-24"
   D:\LapTrinhWeb\apache-tomcat-10.1.44\apache-tomcat-10.1.44\bin\catalina.bat run
   ```
3. Sau khi màn hình console hiện thông báo `Deployment of web application archive has finished`, mở trình duyệt web bất kỳ và truy cập:
   👉 **[http://localhost:8080/24133052_NguyenThanhTam_BT3/login](http://localhost:8080/24133052_NguyenThanhTam_BT3/login)**

---

### Cách 2: Khởi chạy bằng Eclipse / Spring Tool Suite (STS) / VS Code
1. Mở IDE (Eclipse, STS hoặc VS Code).
2. Chọn **File -> Open Projects from File System...** và trỏ đến thư mục `BT3_Sitemesh_Validation`.
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

### 🔹 Kịch bản 6: Chỉnh sửa Hồ sơ cá nhân (Profile), Upload Cloudinary & Xác thực OTP (Phần 3)
1. **Truy cập:** Đăng nhập tài khoản `syber096` -> Bấm vào tên người dùng trên góc phải Navbar -> Chọn **"Hồ sơ cá nhân (Profile)"** (hoặc truy cập URL: `http://localhost:8080/24133052_NguyenThanhTam_BT3/profile`).
2. **Cập nhật thông tin thông thường (Họ tên, SĐT, Ảnh đại diện):**
   * Sửa Họ và tên, SĐT hoặc chọn file ảnh mới (JPG, PNG, WEBP).
   * File ảnh được tải trực tiếp lên đám mây **Cloudinary** bằng Multipart Servlet.
   * Nhấn **"Lưu Cập Nhật Hồ Sơ"** -> Hệ thống chuyển sang trang **`/profile/verify-otp`** và gửi mã OTP 6 số về email hiện tại của tài khoản.
   * Nhập 6 chữ số OTP -> Hồ sơ được cập nhật toàn bộ thành công.
3. **Đổi sang địa chỉ Email mới (Yêu cầu Mật khẩu & OTP Gmail mới):**
   * Nhập địa chỉ email mới tại ô **Địa chỉ Email**.
   * Ô **"Mật khẩu tài khoản"** sẽ tự động kích hoạt bắt buộc nhập.
   * Nhập mật khẩu hiện tại (ví dụ: `thanhtam123`) -> Bấm **"Lưu Cập Nhật Hồ Sơ"**.
   * Hệ thống kiểm tra mật khẩu chính xác và tự động gửi mã OTP 6 số đến **hộp thư Gmail mới**.
   * Tại trang xác nhận OTP, có nút **"Gửi lại mã OTP"** kèm **đồng hồ đếm ngược 30 giây** chống spam.
   * Nhập mã OTP từ Gmail mới -> Email và toàn bộ hồ sơ được cập nhật hoàn tất.

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

---

## 5. HƯỚNG DẪN KIỂM THỬ GỬI OTP THẬT QUA EMAIL (TỪNG BƯỚC)

Hệ thống đã được cấu hình sẵn tài khoản Gmail SMTP để gửi email thật. Khi đăng ký hoặc quên mật khẩu, mã OTP sẽ được gửi trực tiếp đến email mà người dùng nhập vào.

### ✅ Test 1: Đăng ký tài khoản mới & nhận OTP qua email thật

| Bước | Thao tác | Kết quả mong đợi |
| :---: | :--- | :--- |
| 1 | Mở trình duyệt, truy cập: `http://localhost:8080/24133052_NguyenThanhTam_CRUD/register` | Hiển thị trang Đăng ký tài khoản |
| 2 | Nhập thông tin: **Username:** `testmail01`, **Email:** *(nhập email thật của bạn, ví dụ: `yourname@gmail.com`)*, **Họ tên:** `Nguoi Dung Test`, **SĐT:** `0901234567`, **Mật khẩu:** `123456`, **Xác nhận:** `123456` | Các ô được điền đầy đủ |
| 3 | Nhấn nút **"Đăng Ký & Nhận Mã OTP Qua Email"** | Chuyển sang trang Xác thực OTP. Hệ thống gửi email chứa mã OTP 6 số đến email vừa nhập |
| 4 | Mở hộp thư email (kiểm tra cả **Hộp thư đến** và **thư mục Spam**). Tìm email từ **"HCMUTE Web System"** | Email chứa mã OTP 6 chữ số, có giao diện HTML đẹp với logo HCMUTE |
| 5 | Copy mã OTP từ email, quay lại trang web, dán vào ô nhập OTP | Ô OTP hiển thị 6 chữ số |
| 6 | Nhấn **"Kích Hoạt Tài Khoản"** | Thông báo kích hoạt thành công, chuyển sang trang Đăng nhập |
| 7 | Đăng nhập bằng `testmail01` / `123456` | Đăng nhập thành công, vào Trang chủ |

### ✅ Test 2: Quên mật khẩu & nhận OTP đặt lại mật khẩu qua email thật

| Bước | Thao tác | Kết quả mong đợi |
| :---: | :--- | :--- |
| 1 | Truy cập: `http://localhost:8080/24133052_NguyenThanhTam_CRUD/forgot-password` | Hiển thị trang Quên mật khẩu |
| 2 | Nhập email hoặc username đã đăng ký (ví dụ: `testmail01` hoặc email thật) | Ô nhập được điền |
| 3 | Nhấn **"Gửi Mã Xác Nhận OTP Qua Email"** | Chuyển sang trang Đặt lại mật khẩu. Email OTP mới được gửi đến hộp thư |
| 4 | Mở hộp thư email, lấy mã OTP mới | Email mới chứa mã OTP 6 số cho đặt lại mật khẩu |
| 5 | Nhập mã OTP, nhập mật khẩu mới (ví dụ: `newpass789`), xác nhận mật khẩu | Các ô được điền đầy đủ |
| 6 | Nhấn **"Xác Nhận & Cập Nhật Mật Khẩu"** | Thông báo đổi mật khẩu thành công |
| 7 | Đăng nhập bằng `testmail01` / `newpass789` | Đăng nhập thành công với mật khẩu mới |

### ✅ Test 3: Đăng nhập Hash Password & Đăng xuất

| Bước | Thao tác | Kết quả mong đợi |
| :---: | :--- | :--- |
| 1 | Truy cập: `http://localhost:8080/24133052_NguyenThanhTam_CRUD/login` | Hiển thị trang Đăng nhập |
| 2 | Nhập `syber096` / `thanhtam123` (hoặc nhấn chip điền nhanh) | Ô username và password được điền |
| 3 | Nhấn **"Đăng Nhập"** | Đăng nhập thành công, vào Trang chủ với lời chào cá nhân |
| 4 | Nhấn nút **"Đăng Xuất"** trên thanh trên cùng | Phiên bị hủy, chuyển về trang Đăng nhập với thông báo đã đăng xuất |
| 5 | Thử truy cập lại trang chủ bằng URL trực tiếp | Không vào được, phải đăng nhập lại |

---

> 🎯 **Lưu ý đặc biệt cho môi trường chấm bài:**  
> - Hệ thống gửi OTP **thật qua email** (SMTP Gmail). Giảng viên chỉ cần nhập email thật khi đăng ký/quên mật khẩu là sẽ nhận được mã OTP trong hộp thư.
> - Ngoài ra, mã OTP cũng được **hiển thị trực tiếp trên giao diện** (khung "Hỗ trợ chấm bài") để giảng viên test nhanh mà không cần mở email.
> - Hệ thống có cơ chế **In-Memory Fallback**: Nếu máy chấm bài chưa bật SQL Server hoặc chưa có Internet, hệ thống **vẫn hoạt động 100%** với dữ liệu mẫu trong RAM.
