# LẬP TRÌNH WEB (WEBPR330479)
## BÁO CÁO BÀI TẬP 03 (19/11/2026)
### CẤU HÌNH SITEMESH DECORATOR 3 & FORM VALIDATION (BOOTSTRAP 5)

> ## 🎯 THƯ MỤC BÀI TẬP CẦN CHẤM: `BT3_Sitemesh_Validation`
* **Trường:** Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE)
* **Khoa:** Công Nghệ Thông Tin
* **Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung
* **Sinh viên thực hiện:** Nguyễn Thanh Tâm
* **Mã số sinh viên (MSSV):** 24133052
* **Kho lưu trữ GitHub:** [https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb](https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb)
* **Tài liệu hướng dẫn chạy chi tiết:** 👉 **[Xem file HUONG_DAN_CHAY_WEB.md](HUONG_DAN_CHAY_WEB.md)**

---

### 🔑 DANH SÁCH TÀI KHOẢN KIỂM THỬ (DÀNH CHO GIẢNG VIÊN CHẤM BÀI):

| STT | Tên tài khoản (Username) | Mật khẩu | Chuẩn mã hóa lưu CSDL | Trạng thái kích hoạt | Quyền hạn (Role) | Chức năng kiểm thử |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| **1** | **`syber096`** | **`123`** hoặc **`thanhtam123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Quản trị)** | Kiểm thử Đăng nhập, SiteMesh Decorator, CRUD Category & Video |
| **2** | **`thanhtam`** | **`123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **User (Người dùng)** | Kiểm thử Video cá nhân, Phân trang 6 video/trang |
| **3** | **`admin`** | **`123`** | **BCrypt Hash** (`$2a$...`) | **Đã kích hoạt (`status = 1`)** | **Admin (Dự phòng)** | Đăng nhập quản trị hệ thống |

> 💡 **Trợ giúp kiểm thử nhanh:**  
> Tại trang Đăng nhập (`/login`), hệ thống đã tích hợp sẵn các nút **"Điền nhanh tài khoản"** (`syber096`, `thanhtam`, `admin`). Giảng viên chỉ cần bấm 1 click là form tự động điền đầy đủ để test ngay lập tức mà không cần gõ thủ công.

---

### 🚀 NỘI DUNG THỰC HIỆN BÀI TẬP 03:

#### 1. Phần 1: Cấu hình SiteMesh Decorator 3 với Template Bootstrap 5
* **Công nghệ tích hợp:** SiteMesh 3.3.0 tương thích Jakarta EE 10 / Tomcat 10.1 (`org.sitemesh:sitemesh:3.3.0`).
* **Decorator Template (`decorators/web.jsp`):**
  * Sử dụng chuẩn 3 thẻ SiteMesh: `<sitemesh:write property='title'/>`, `<sitemesh:write property='head'/>`, `<sitemesh:write property='body'/>`.
  * Giao diện thiết kế trên nền **Bootstrap 5.3.3 + Bootstrap Icons 1.11.3**.
  * **Thanh Header / Navbar thông minh:**
    * *Chưa đăng nhập:* Chỉ hiển thị mục **Trang Chủ** và 2 nút **Đăng Nhập / Đăng Ký**. Toàn bộ menu quản trị được ẩn tự động.
    * *Đã đăng nhập:* Tự động mở khóa và hiển thị các menu: **Video Của Tôi**, **Quản Lý Videos**, **Quản Lý Danh Mục**, cùng Avatar người dùng và nút **Đăng Xuất**.
  * **Chân trang (Footer):** Gọn gàng, tinh tế, chứa thông tin sinh viên MSSV 24133052 và đồ án Lập Trình Web HCMUTE.
  * **Cấu hình Filter:** `MySiteMeshFilter.java` kế thừa `ConfigurableSiteMeshFilter`, exclude các đường dẫn stream nhị phân: `/media*`, `/image*`, `/static/*`, `/assets/*`.

#### 2. Phần 2: Validation 2 lớp (Client-side Bootstrap 5 & Server-side Servlet) cho tất cả các Form
* **Form Đăng Nhập (`login.jsp` + `LoginServlet.java`):**
  * *Client:* Kích hoạt Bootstrap Validation `.needs-validation`, kiểm tra `required`, độ dài tối thiểu 3 ký tự, hiển thị `.invalid-feedback` viền đỏ trực quan.
  * *Server:* Chặn null/rỗng, kiểm tra tài khoản tồn tại trong DB, so khớp hash BCrypt, kiểm tra trạng thái kích hoạt OTP.
* **Form Đăng Ký (`register.jsp` + `RegisterServlet.java`):**
  * *Client:* Regex username `^[a-zA-Z0-9_]{3,30}$`, kiểm tra định dạng email `type="email"`, regex SĐT 10 số `0[0-9]{9}`, kiểm tra khớp mật khẩu real-time, checkbox điều khoản.
  * *Server:* Chặn trùng username/email, kiểm tra mật khẩu khớp, băm BCrypt an toàn.
* **Form Quên Mật Khẩu & OTP (`forgot-password.jsp`, `verify-otp.jsp`, `reset-password.jsp`):**
  * *Client:* Pattern mã OTP đủ 6 chữ số `^[0-9]{6}$`, kiểm tra mật khẩu mới `minlength="6"`.
  * *Server:* Xác thực OTP đúng và còn hiệu lực 5 phút; hash mật khẩu mới trước khi cập nhật.
* **Form Thêm Mới - Insert (`add-category.jsp`, `video-add.jsp`):**
  * *Client:* Tên danh mục `required minlength="2" maxlength="100"`; Tiêu đề video `required minlength="3"`, URL video `type="url"`.
  * *Server:* `CategoryAddController` và `VideoAddController` kiểm tra độ dài tên, chặn trùng mã video, xử lý upload an toàn.
* **Form Chỉnh Sửa - Edit (`edit-category.jsp`, `video-edit.jsp`):**
  * *Client:* Validation bắt buộc tên/tiêu đề; hiển thị ảnh/video hiện tại trực quan.
  * *Server:* `CategoryEditController` và `VideoEditController` validate dữ liệu, tự động giữ ảnh/video cũ nếu không tải file mới.
* **Bộ lọc bảo mật phân quyền (`AuthFilter.java`):**
  * Chặn triệt để người dùng chưa đăng nhập khi truy cập `/admin/*` và `/video`, tự động chuyển hướng về `/login?error=auth_required` kèm thông báo cảnh báo.

---

### 🌐 DANH SÁCH ĐƯỜNG DẪN KIỂM THỬ BÀI TẬP 03 (CONTEXT PATH: `/24133052_NguyenThanhTam_BT3`):

| Chức năng | Đường dẫn kiểm thử (URL) | Mô tả tính năng |
|---|---|---|
| **Trang chủ** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/home` | Banner giới thiệu, 10 video mới nhất, SiteMesh Navbar |
| **Đăng nhập** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/login` | Form đăng nhập có Bootstrap validation, nút điền nhanh tài khoản |
| **Đăng ký** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/register` | Form đăng ký có validation regex, kiểm tra khớp mật khẩu |
| **Quên mật khẩu** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/forgot-password` | Gửi mã OTP khôi phục qua email |
| **Kênh Video (/video)** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/video` | Phân trang đúng 6 video/trang theo đề bài (yêu cầu đăng nhập) |
| **Chi tiết Video** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/video/detail?id=VID01` | Phát video YouTube / MP4 và danh sách gợi ý |
| **Quản lý Videos (CRUD)** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/admin/video/list` | Danh sách video hệ thống (yêu cầu đăng nhập) |
| **Thêm Video Mới (Insert)** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/admin/video/add` | Form thêm video có validation |
| **Sửa Video (Edit)** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/admin/video/edit?id=VID01` | Form sửa video có validation |
| **Quản lý Danh mục (CRUD)** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/admin/category/list` | Danh sách danh mục sản phẩm |
| **Thêm Danh mục (Insert)** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/admin/category/add` | Form thêm danh mục có validation |
| **Sửa Danh mục (Edit)** | `http://localhost:8080/24133052_NguyenThanhTam_BT3/admin/category/edit?id=1` | Form sửa danh mục có validation |

---

### 📂 CẤU TRÚC BÀI NỘP TRÊN GITHUB REPOSITORY:

```text
NguyenThanhTam-24133052-LapTrinhWeb/
├── BT3_Sitemesh_Validation/                # ⭐ BÀI TẬP 03 (MỚI NHẤT): SiteMesh 3 & Form Validation
│   ├── pom.xml                             # Cấu hình SiteMesh 3.3.0, Jakarta Servlet 6.0, jBCrypt, MSSQL
│   ├── database.sql                        # Script CSDL đầy đủ bảng Users, Category, Video
│   └── src/main/
│       ├── java/com/myexample/
│       │   ├── connection/DBConnection.java
│       │   ├── filter/
│       │   │   ├── MySiteMeshFilter.java   # Cấu hình SiteMesh 3 Decorator filter
│       │   │   └── AuthFilter.java         # Bảo mật chặn chưa đăng nhập truy cập /admin/* và /video
│       │   ├── controller/                 # Login, Register, ForgotPassword, VideoAdd/Edit, CategoryAdd/Edit...
│       │   ├── model/                      # User.java, Category.java, Video.java
│       │   ├── dao/ & service/             # Xử lý CSDL theo mô hình MVC 3 tầng
│       │   └── util/                       # PasswordUtil (BCrypt), EmailUtil (SMTP OTP), Constant
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml                 # Khai báo SiteMesh Filter
│           │   └── sitemesh.xml            # Mapping decorator /* -> /decorators/web.jsp
│           ├── decorators/
│           │   └── web.jsp                 # Template Bootstrap 5 dùng chung toàn hệ thống
│           └── view/                       # Các JSP con chỉ chứa body nội dung (SiteMesh tự trang trí)
│               ├── login.jsp, register.jsp, forgot-password.jsp, verify-otp.jsp, reset-password.jsp
│               ├── add-category.jsp, edit-category.jsp, list-category.jsp
│               ├── video-add.jsp, video-edit.jsp, video-list.jsp, video-user.jsp, video-detail.jsp
│               └── index.jsp               # Trang chủ
│
├── BT2_CRUD/                               # Bài tập 02: CRUD Category & Video, OTP Email, Hash Password
├── BT1_Login_Cookie_Session/               # Bài tập 01: Quản lý Cookie & Session
└── BT_JPA_CRUD_Category/                   # Bài tập JPA 3.0 & Hibernate ORM
```

---

## 🛠️ HƯỚNG DẪN KHỞI CHẠY BÀI TẬP 03 NHANH:

### Cách 1: Khởi chạy bằng Apache Tomcat độc lập
1. Mở cửa sổ **Terminal / CMD**.
2. Chạy lệnh:
   ```cmd
   set "JAVA_HOME=C:\Program Files\Java\jdk-24"
   D:\LapTrinhWeb\apache-tomcat-10.1.44\apache-tomcat-10.1.44\bin\catalina.bat run
   ```
3. Mở trình duyệt web truy cập:
   👉 **`http://localhost:8080/24133052_NguyenThanhTam_BT3/login`**

### Cách 2: Khởi chạy bằng Eclipse / Spring Tool Suite (STS) / VS Code
1. Mở IDE -> Import project từ thư mục `BT3_Sitemesh_Validation`.
2. Click chuột phải project -> **Run As -> Run on Server** (Apache Tomcat v10.1).
