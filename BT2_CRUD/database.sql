-- =======================================================
-- BÀI TẬP: LẬP TRÌNH WEB (WEBPR330479)
-- SINH VIÊN: Nguyễn Thanh Tâm
-- MSSV: 24133052
-- =======================================================

CREATE DATABASE ShoppingServiceMVC;
GO
USE ShoppingServiceMVC;
GO

-- 1. Bảng Category (CRUD Danh mục - PDF 1)
IF OBJECT_ID('Category', 'U') IS NOT NULL DROP TABLE Category;
CREATE TABLE Category(
    [cate_id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [cate_name] [nvarchar](255) NOT NULL,
    [icons] [nvarchar](255) NULL
);
GO

-- Dữ liệu mẫu Category
INSERT INTO Category(cate_name, icons) VALUES (N'Quần Áo Nam', NULL);
INSERT INTO Category(cate_name, icons) VALUES (N'Quần Áo Nữ', NULL);
INSERT INTO Category(cate_name, icons) VALUES (N'Giày Dép', NULL);
GO

-- 2. Bảng User (Đăng nhập / Đăng ký - PDF 2)
IF OBJECT_ID('[User]', 'U') IS NOT NULL DROP TABLE [User];
CREATE TABLE [User](
    [id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [email] [nvarchar](255) NULL,
    [username] [nvarchar](100) NOT NULL UNIQUE,
    [fullname] [nvarchar](255) NULL,
    [password] [nvarchar](100) NOT NULL,
    [avatar] [nvarchar](255) NULL,
    [roleid] [int] NULL,
    [phone] [nvarchar](20) NULL,
    [createdDate] [date] NULL
);
GO

-- Tài khoản mẫu cho Nguyễn Thanh Tâm (admin: roleid = 1)
INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate)
VALUES ('syber096@gmail.com', 'syber096', N'Nguyễn Thanh Tâm', 'thanhtam123', NULL, 1, '0987654321', GETDATE());

INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate)
VALUES ('thanhtam@gmail.com', 'thanhtam', N'Nguyễn Thanh Tâm', '123', NULL, 1, '0987654321', GETDATE());

INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate)
VALUES ('admin@gmail.com', 'admin', N'Quản Trị Viên', '123', NULL, 1, '0901234567', GETDATE());
GO
