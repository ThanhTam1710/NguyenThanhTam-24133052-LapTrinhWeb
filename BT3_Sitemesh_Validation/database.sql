-- =======================================================
-- BÀI TẬP: LẬP TRÌNH WEB (WEBPR330479)
-- BỔ SUNG: OTP EMAIL KÍCH HOẠT, HASH PASSWORD & BẢNG VIDEOS (QUẦN ÁO THỜI TRANG)
-- SINH VIÊN: Nguyễn Thanh Tâm
-- MSSV: 24133052
-- =======================================================

CREATE DATABASE ShoppingServiceMVC;
GO
USE ShoppingServiceMVC;
GO

-- 1. Bảng Category (CRUD Danh mục Thời Trang)
IF OBJECT_ID('Category', 'U') IS NOT NULL DROP TABLE Category;
CREATE TABLE Category(
    [cate_id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [cate_name] [nvarchar](255) NOT NULL,
    [icons] [nvarchar](255) NULL
);
GO

-- Dữ liệu mẫu 10 Danh Mục Thời Trang Quần Áo, Phụ Kiện
INSERT INTO Category(cate_name, icons) VALUES (N'Quần Áo Nam', 'https://images.unsplash.com/photo-1490114538077-0a7f8cb49891?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Quần Áo Nữ', 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Giày Dép Thời Trang', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Áo Sơ Mi & Công Sở', 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Váy Đầm Dự Tiệc', 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Quần Jean & Denim', 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Áo Khoác & Outerwear', 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Trang Sức & Phụ Kiện', 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Túi Xách & Balo Nữ', 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=200');
INSERT INTO Category(cate_name, icons) VALUES (N'Đồng Hồ & Mắt Kính', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=200');
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
-- 1. Username: syber096 | Password gốc: thanhtam123 | Password hash: $2a$12$Nq9xMox2lH1X4QY8u0l/i.kUvL7s4S5kSj8N4.bB1YF0eI7TzUaWC
INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate, status, code, otp_expiry)
VALUES ('syber096@gmail.com', 'syber096', N'Nguyễn Thanh Tâm', '$2a$12$Nq9xMox2lH1X4QY8u0l/i.kUvL7s4S5kSj8N4.bB1YF0eI7TzUaWC', NULL, 1, '0987654321', GETDATE(), 1, NULL, NULL);

-- 2. Username: thanhtam | Password gốc: 123 | Password hash: $2a$12$vI8aWBnW3fID.ZQ4/zo1G.q1l5Q9/3g1U6i/u9x8r5q0E5k4w6G7a
INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate, status, code, otp_expiry)
VALUES ('thanhtam@gmail.com', 'thanhtam', N'Nguyễn Thanh Tâm', '$2a$12$vI8aWBnW3fID.ZQ4/zo1G.q1l5Q9/3g1U6i/u9x8r5q0E5k4w6G7a', NULL, 1, '0987654321', GETDATE(), 1, NULL, NULL);

-- 3. Username: admin | Password gốc: 123
INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate, status, code, otp_expiry)
VALUES ('admin@gmail.com', 'admin', N'Quản Trị Viên', '$2a$12$vI8aWBnW3fID.ZQ4/zo1G.q1l5Q9/3g1U6i/u9x8r5q0E5k4w6G7a', NULL, 1, '0901234567', GETDATE(), 1, NULL, NULL);
GO

-- 3. Bảng Videos (Mối quan hệ 1-n với bảng User: 1 User có nhiều Videos sản phẩm thời trang)
IF OBJECT_ID('Videos', 'U') IS NOT NULL DROP TABLE Videos;
CREATE TABLE Videos(
    [videoId] [nvarchar](50) PRIMARY KEY NOT NULL,      -- Mã định danh video
    [title] [nvarchar](255) NOT NULL,                   -- Tiêu đề video sản phẩm thời trang
    [poster] [nvarchar](255) NULL,                      -- Hình ảnh thumbnail / poster
    [url] [nvarchar](500) NULL,                         -- File video hoặc link xem video (YouTube / MP4)
    [views] [int] DEFAULT 0,                            -- Lượt xem video
    [description] [nvarchar](MAX) NULL,                 -- Mô tả nội dung video
    [active] [bit] DEFAULT 1,                           -- 1: Hoạt động, 0: Ẩn
    [createdDate] [datetime] DEFAULT GETDATE(),         -- Ngày đăng video
    [userId] [int] NULL FOREIGN KEY REFERENCES [User](id) ON DELETE CASCADE
);
GO

-- Dữ liệu mẫu 12 Videos Thời Trang Quần Áo (phân bổ cho syber096 userId = 1 và thanhtam userId = 2)
INSERT INTO Videos(videoId, title, poster, url, views, description, active, createdDate, userId)
VALUES 
('VID01', N'BST Áo Thun Cotton & Sơ Mi Nam Nữ Basic Dạo Phố', 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=800', 'https://www.youtube.com/watch?v=9ch7GdhGUHQ', 1540, N'Áo thun 100% cotton thoáng mát và áo sơ mi dáng basic dễ phối đồ. Thiết kế tối giản trẻ trung dạo phố hoặc đi làm.', 1, DATEADD(hour, -11, GETDATE()), 1),
('VID02', N'Áo Khoác Bomber & Outerwear Unisex Cá Tính Thu Đông', 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800', 'https://www.youtube.com/watch?v=4DVKObRYpT8', 2750, N'Áo khoác bomber 2 lớp cản gió và giữ ấm nhẹ. Kiểu dáng Unisex streetwear năng động, phù hợp thời tiết se lạnh.', 1, DATEADD(hour, -10, GETDATE()), 1),
('VID03', N'Váy Đầm Hoa Dáng Xòe Đi Tiệc & Dạo Phố Thanh Lịch', 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=800', 'https://www.youtube.com/watch?v=wFG3ZqjxHjg', 2310, N'Mẫu váy hoa nhẹ nhàng chất voan lụa cao cấp tôn dáng eo thon. Thích hợp cho các buổi tiệc nhẹ và dã ngoại.', 1, DATEADD(hour, -9, GETDATE()), 1),
('VID04', N'Set Đồ Nỉ Thu Đông & Áo Hoodie Nữ Form Rộng Trẻ Trung', 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=800', 'https://www.youtube.com/watch?v=Crw_LkNzzVc', 3890, N'Hoodie nỉ bông dày dặn ấm áp form rộng unisex phong cách Hàn Quốc, tiện lợi đi học và dạo phố mùa đông.', 1, DATEADD(hour, -8, GETDATE()), 1),
('VID05', N'Quần Jean Nữ Cạp Cao Ống Suông Hack Dáng Năng Động', 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=800', 'https://www.youtube.com/watch?v=nB9EeUK1b5Q', 3120, N'Quần jean cạp cao ống suông tôn chân dài, chất denim co giãn nhẹ không bai xù. Dễ phối áo croptop cá tính.', 1, DATEADD(hour, -7, GETDATE()), 1),
('VID06', N'Bộ Sưu Tập Blazer May Đo & Quần Tây Quý Cô Công Sở', 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=800', 'https://www.youtube.com/watch?v=Yt2-Bv030Uo', 1980, N'Bộ suit blazer may đo chuẩn form thanh lịch và chuyên nghiệp dành cho các quý cô văn phòng hiện đại.', 1, DATEADD(hour, -6, GETDATE()), 1),
('VID07', N'Chân Váy Xếp Ly Cạp Cao Phong Cách Vintage Hàn Quốc', 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=800', 'https://www.youtube.com/watch?v=nmhPrLiPr40', 2260, N'Chân váy xếp ly cạp cao có lớp lót bảo hộ an toàn. Phối cùng gile len hoặc sơ mi tạo phong cách cực xinh.', 1, DATEADD(hour, -5, GETDATE()), 1),
('VID08', N'Bộ Sưu Tập Vòng Cổ Bạc 925 & Lắc Tay Nữ Đính Đá Sang Chảnh', 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800', 'https://www.youtube.com/watch?v=rsIDG50k3Iw', 3200, N'Trang sức bạc cao cấp 925 đính đá nhân tạo lấp lánh, thiết kế mảnh mai thanh lịch giúp tôn vinh vẻ đẹp phái nữ.', 1, DATEADD(hour, -4, GETDATE()), 1),
('VID09', N'Phụ Kiện Trang Sức Vintage & Khuyên Tai Nữ Cao Cấp', 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=800', 'https://www.youtube.com/watch?v=KMR5YUUdsvE', 2150, N'Các mẫu khuyên tai đính ngọc trai nhân tạo và kim loại mạ vàng sang trọng, tạo điểm nhấn thu hút cho khuôn mặt.', 1, DATEADD(hour, -3, GETDATE()), 1),
('VID10', N'Nhẫn & Mặt Dây Chuyền Thời Trang Bạc Nữ Tinh Tế', 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800', 'https://www.youtube.com/watch?v=YBKN4lRIltA', 2890, N'Set nhẫn và mặt dây chuyền phong cách tối giản thanh lịch, chất liệu không gỉ, bền màu theo thời gian.', 1, DATEADD(hour, -2, GETDATE()), 1),
('VID11', N'Bộ Sưu Tập Giày Sneaker Thể Thao Nam Nữ Độn Đế Siêu Êm', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800', 'https://www.youtube.com/watch?v=GWNyvuSs7GU', 4180, N'Mẫu giày thể thao sneaker đế đệm êm chân, bám đường tốt, phối màu trẻ trung dễ đi học, đi chơi, tập gym.', 1, DATEADD(hour, -1, GETDATE()), 2),
('VID12', N'Giày Cao Gót Mũi Nhọn 7cm Quyến Rũ Thanh Lịch Đi Tiệc', 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=800', 'https://www.youtube.com/watch?v=mIieHM6KhJk', 2840, N'Giày cao gót nữ mũi nhọn 7 phân da lộn cao cấp, đệm lót gót êm ái giúp bước đi tự tin, quyến rũ trong mọi sự kiện.', 1, GETDATE(), 2);
GO
