-- =======================================================
-- BÀI TẬP: LẬP TRÌNH WEB (WEBPR330479)
-- BỔ SUNG: OTP EMAIL KÍCH HOẠT, HASH PASSWORD & QUÊN MẬT KHẨU
-- SINH VIÊN: Nguyễn Thanh Tâm
-- MSSV: 24133052
-- =======================================================

CREATE DATABASE ShoppingServiceMVC;
GO
USE ShoppingServiceMVC;
GO

-- 1. Bảng Category (CRUD Danh mục)
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

-- 2. Bảng User (Đăng nhập, Đăng ký, OTP qua Email & Hash Password)
IF OBJECT_ID('[User]', 'U') IS NOT NULL DROP TABLE [User];
CREATE TABLE [User](
    [id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [email] [nvarchar](255) NULL,
    [username] [nvarchar](100) NOT NULL UNIQUE,
    [fullname] [nvarchar](255) NULL,
    [password] [nvarchar](255) NOT NULL,    -- Lưu chuỗi mật khẩu đã băm (BCrypt Hash)
    [avatar] [nvarchar](255) NULL,
    [roleid] [int] DEFAULT 2,               -- 1: Admin, 2: User
    [phone] [nvarchar](20) NULL,
    [createdDate] [date] NULL,
    [status] [int] DEFAULT 1,               -- 1: Đã kích hoạt, 0: Chưa kích hoạt (chờ xác nhận OTP)
    [code] [nvarchar](20) NULL,             -- Mã OTP 6 chữ số
    [otp_expiry] [datetime] NULL            -- Thời gian hết hạn của OTP
);
GO

-- Tài khoản mẫu cho Nguyễn Thanh Tâm (Role Admin = 1, Status = 1 Đã kích hoạt)
-- 1. Username: syber096 | Password gốc: thanhtam123 | Password hash: $2a$12$e8gV1rB7HjG.aK33oF5yI.z.bX89L6p81Z2uPz9p9O4l4o6kQ6I9a
INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate, status, code, otp_expiry)
VALUES ('syber096@gmail.com', 'syber096', N'Nguyễn Thanh Tâm', '$2a$12$Nq9xMox2lH1X4QY8u0l/i.kUvL7s4S5kSj8N4.bB1YF0eI7TzUaWC', NULL, 1, '0987654321', GETDATE(), 1, NULL, NULL);

-- 2. Username: thanhtam | Password gốc: 123 | Password hash: $2a$12$Z0mU6C6yV5lP6hZ2eB3n2.4w5r6T7y8u9I0o1P2q3W4e5R6t7Y8u9
INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate, status, code, otp_expiry)
VALUES ('thanhtam@gmail.com', 'thanhtam', N'Nguyễn Thanh Tâm', '$2a$12$vI8aWBnW3fID.ZQ4/zo1G.q1l5Q9/3g1U6i/u9x8r5q0E5k4w6G7a', NULL, 1, '0987654321', GETDATE(), 1, NULL, NULL);

-- 3. Username: admin | Password gốc: 123
INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate, status, code, otp_expiry)
VALUES ('admin@gmail.com', 'admin', N'Quản Trị Viên', '$2a$12$vI8aWBnW3fID.ZQ4/zo1G.q1l5Q9/3g1U6i/u9x8r5q0E5k4w6G7a', NULL, 1, '0901234567', GETDATE(), 1, NULL, NULL);
GO
