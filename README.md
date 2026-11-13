# LẬP TRÌNH WEB (WEBPR330479)
## BÁO CÁO BÀI TẬP LẬP TRÌNH WEB & JPA 3.0

* **Trường:** Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE)
* **Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung
* **Sinh viên thực hiện:** Nguyễn Thanh Tâm
* **Mã số sinh viên (MSSV):** 24133052
* **Kho lưu trữ GitHub:** [NguyenThanhTam-24133052-LapTrinhWeb](https://github.com/ThanhTam1710/NguyenThanhTam-24133052-LapTrinhWeb)

---

### Cấu trúc bài nộp trên Repository:
```text
NguyenThanhTam-24133052-LapTrinhWeb/
├── BT1_Login_Cookie_Session/
│   ├── HelloCookieServlet.java
│   ├── LoginCookieServlet.java
│   ├── login-cookie.jsp
│   ├── LoginSessionServlet.java
│   ├── ProfileServlet.java
│   ├── LogoutServlet.java
│   ├── login-session.jsp
│   └── LoginServlet.java
│
├── BT2_CRUD/
│   ├── pom.xml
│   ├── database.sql
│   └── src/main/
│       ├── java/com/myexample/
│       │   ├── connection/DBConnection.java
│       │   ├── model/ (Category.java, User.java)
│       │   ├── dao/ (CategoryDAO.java, UserDAO.java, impl/...)
│       │   ├── service/ (CategoryService.java, UserService.java, impl/...)
│       │   ├── controller/ (CategoryListController, CategoryAddController, CategoryEditController, CategoryDeleteController, DownloadImageController, ...)
│       │   └── util/Constant.java
│       └── webapp/
│           ├── WEB-INF/web.xml
│           └── view/ (list-category.jsp, add-category.jsp, edit-category.jsp, login.jsp, ...)
│
└── BT_JPA_CRUD_Category/ (Bài tập JPA 3.0 & Jakarta Servlet 6.0 theo LMS UTEx)
    ├── pom.xml (Hibernate ORM 6.4.4.Final, MSSQL JDBC, Jakarta EE 10)
    └── src/
        └── main/
            ├── resources/META-INF/
            │   └── persistence.xml (Cấu hình Persistence Unit jpa-hibernate-mysql, kết nối database webst2)
            ├── java/vn/iotstar/
            │   ├── entity/ (Category.java, Video.java - Ánh xạ Quan hệ One-to-Many, NamedQuery)
            │   ├── config/ (JpaConfig.java - Singleton EntityManagerFactory, Test.java)
            │   ├── dao/ (ICategoryDao.java, CategoryDao.java, impl/CategoryDao.java)
            │   ├── service/ (ICategoryService.java, impl/CategoryServiceImpl.java)
            │   ├── controller/ (CategoryController.java, DownloadImageController.java, HomeController.java)
            │   └── util/ (Constant.java - Quản trị đường dẫn upload hình ảnh)
            └── webapp/
                ├── WEB-INF/web.xml
                ├── index.jsp
                └── views/admin/
                    ├── category-list.jsp (Hiển thị danh sách, tìm kiếm, phân trang, hình ảnh)
                    ├── category-add.jsp (Thêm mới danh mục, tải ảnh đại diện)
                    └── category-edit.jsp (Cập nhật thông tin danh mục, đổi ảnh preview)
```

---

### 🔑 Danh sách tài khoản đăng nhập & kiểm thử (Dành cho Giảng viên):

| STT | Tên tài khoản (Username) | Mật khẩu (Password) | Quyền hạn (Role) | Chức năng kiểm thử |
| :---: | :--- | :--- | :---: | :--- |
| **1** | **`syber096`** | **`thanhtam123`** | **Admin (Quản trị viên)** | Đăng nhập hệ thống 3 tầng (`/login`), Đăng nhập Cookie (`/login-cookie`), Đăng nhập Session (`/login-session`), Quản trị danh mục |
| **2** | **`thanhtam`** | **`123`** | **Admin (Quản trị viên)** | Đăng nhập hệ thống 3 tầng (`/login`), Đăng nhập Cookie (`/login-cookie`), Đăng nhập Session (`/login-session`), Quản trị danh mục |
| **3** | **`admin`** | **`123`** | **Admin (Dự phòng)** | Tài khoản quản trị dự phòng |

---

### Hướng dẫn kiểm thử các bài tập:

#### 1. Bài tập 1 & 2: Cookie, Session & CRUD Category (JDBC)
- **Database:** Chạy script `BT2_CRUD/database.sql` trên SQL Server (đã tạo sẵn các tài khoản trên).
- **Tài khoản đăng nhập:** Sử dụng tài khoản `syber096` / `thanhtam123` hoặc `thanhtam` / `123`.
- **URL chức năng:**
  - Danh sách danh mục: `http://localhost:8080/24133052_NguyenThanhTam_LoginCookieSession_CRUD/admin/category/list`
  - Đăng nhập Cookie (tự nhớ 30s): `/login-cookie`
  - Đăng nhập Session: `/login-session`
  - Đăng nhập 3 tầng: `/login`

#### 2. Bài tập JPA 3.0: CRUD Category bằng JPA (Hibernate)
- **Công nghệ áp dụng:** JPA 3.0, Hibernate ORM 6.4+, Jakarta Servlet 6.0, JSTL 3.0, Java 17+.
- **Database:** SQL Server cơ sở dữ liệu `webst2` (cấu hình trong `META-INF/persistence.xml`). Hệ thống tích hợp cơ chế fallback danh sách thông minh, sẵn sàng hiển thị và thao tác CRUD mượt mà ngay cả khi database offline.
- **URL chức năng chính:**
  - Danh sách & Tìm kiếm: `http://localhost:8080/24133052_NguyenThanhTam_JPA/admin/categories`
  - Thêm mới danh mục: `http://localhost:8080/24133052_NguyenThanhTam_JPA/admin/category/add`
  - Sửa danh mục: `http://localhost:8080/24133052_NguyenThanhTam_JPA/admin/category/edit?id=1`
  - Xóa danh mục: `http://localhost:8080/24133052_NguyenThanhTam_JPA/admin/category/delete?id=...`
  - Xem/tải ảnh upload: `http://localhost:8080/24133052_NguyenThanhTam_JPA/image?fname=...`
