# LẬP TRÌNH WEB (WEBPR330479)
## BÀI TẬP: LOGIN COOKIE & SESSION + CRUD CATEGORY

* **Trường:** Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE)
* **Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung
* **Sinh viên thực hiện:** Nguyễn Thành Tâm
* **Mã số sinh viên (MSSV):** 24133052

---

### Cấu trúc thư mục bài nộp:
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
└── BT2_CRUD/
    ├── pom.xml
    ├── database.sql
    └── src/
        └── main/
            ├── java/com/myexample/
            │   ├── connection/DBConnection.java
            │   ├── model/ (Category.java, User.java)
            │   ├── dao/ (CategoryDAO.java, UserDAO.java, impl/...)
            │   ├── service/ (CategoryService.java, UserService.java, impl/...)
            │   ├── controller/ (CategoryListController, CategoryAddController, CategoryEditController, CategoryDeleteController, DownloadImageController, ...)
            │   └── util/Constant.java
            └── webapp/
                ├── WEB-INF/web.xml
                └── view/
                    ├── index.jsp
                    ├── list-category.jsp
                    ├── add-category.jsp
                    ├── edit-category.jsp
                    ├── login.jsp
                    ├── error.jsp
                    ├── login-cookie.jsp
                    └── login-session.jsp
```

---

### Hướng dẫn chạy và kiểm thử:
1. **Cơ sở dữ liệu:** Chạy file `BT2_CRUD/database.sql` trên SQL Server để tạo database `ShoppingServiceMVC`.
2. **Triển khai:** Mở project trong Eclipse / STS / VS Code và Run on Apache Tomcat (Tomcat 10.1+ / Jakarta EE).
3. **Tài khoản đăng nhập mẫu:**
   * Username: `thanhtam` (hoặc `tamnt`, `admin`)
   * Password: `123`
4. **Các URL chức năng chính:**
   * Quản lý danh mục (CRUD): `/admin/category/list`
   * Đăng nhập Cookie (30s): `/login-cookie`
   * Đăng nhập Session: `/login-session`
   * Đăng nhập 3 tầng: `/login`
