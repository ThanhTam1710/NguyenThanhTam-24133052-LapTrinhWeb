package com.myexample.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.myexample.connection.DBConnection;
import com.myexample.dao.VideoDAO;
import com.myexample.model.Video;

/**
 * Triển khai VideoDAO kết nối SQL Server và có In-Memory Fallback
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public class VideoDAOImpl extends DBConnection implements VideoDAO {

    // Danh sách Video mẫu thời trang lưu trữ trong bộ nhớ (hỗ trợ kiểm thử trực quan và CRUD mượt mà)
    private static final Map<String, Video> MEMORY_VIDEOS = Collections.synchronizedMap(new LinkedHashMap<>());

    static {
        long now = System.currentTimeMillis();

        // 1. Áo Thun & Sơ Mi Nam Nữ - ZARA Try-On Haul
        createSample("VID01", "BST Áo Thun Cotton & Sơ Mi Nam Nữ Basic Dạo Phố",
                "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=800",
                "https://www.youtube.com/watch?v=9ch7GdhGUHQ", 1540,
                "Áo thun 100% cotton thoáng mát và áo sơ mi dáng basic dễ phối đồ. Thiết kế tối giản trẻ trung dạo phố hoặc đi làm.",
                true, new Timestamp(now - 11000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 2. Áo Khoác Bomber & Outerwear Thu Đông
        createSample("VID02", "Áo Khoác Bomber & Outerwear Unisex Cá Tính Thu Đông",
                "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800",
                "https://www.youtube.com/watch?v=4DVKObRYpT8", 2750,
                "Áo khoác bomber 2 lớp cản gió và giữ ấm nhẹ. Kiểu dáng Unisex streetwear năng động, phù hợp thời tiết se lạnh.",
                true, new Timestamp(now - 10000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 3. Váy Đầm Dự Tiệc & Dạo Phố
        createSample("VID03", "Váy Đầm Hoa Dáng Xòe Đi Tiệc & Dạo Phố Thanh Lịch",
                "https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=800",
                "https://www.youtube.com/watch?v=wFG3ZqjxHjg", 2310,
                "Mẫu váy hoa nhẹ nhàng chất voan lụa cao cấp tôn dáng eo thon. Thích hợp cho các buổi tiệc nhẹ và dã ngoại.",
                true, new Timestamp(now - 9000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 4. Set Đồ Nỉ & Hoodie Form Rộng
        createSample("VID04", "Set Đồ Nỉ Thu Đông & Áo Hoodie Nữ Form Rộng Trẻ Trung",
                "https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=800",
                "https://www.youtube.com/watch?v=Crw_LkNzzVc", 3890,
                "Hoodie nỉ bông dày dặn ấm áp form rộng unisex phong cách Hàn Quốc, tiện lợi đi học và dạo phố mùa đông.",
                true, new Timestamp(now - 8000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 5. Quần Jean Cạp Cao Ống Rộng
        createSample("VID05", "Quần Jean Nữ Cạp Cao Ống Suông Hack Dáng Năng Động",
                "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=800",
                "https://www.youtube.com/watch?v=nB9EeUK1b5Q", 3120,
                "Quần jean cạp cao ống suông tôn chân dài, chất denim co giãn nhẹ không bai xù. Dễ phối áo croptop cá tính.",
                true, new Timestamp(now - 7000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 6. Set Blazer May Đo Công Sở
        createSample("VID06", "Bộ Sưu Tập Blazer May Đo & Quần Tây Quý Cô Công Sở",
                "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=800",
                "https://www.youtube.com/watch?v=Yt2-Bv030Uo", 1980,
                "Bộ suit blazer may đo chuẩn form thanh lịch và chuyên nghiệp dành cho các quý cô văn phòng hiện đại.",
                true, new Timestamp(now - 6000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 7. Chân Váy Xếp Ly Vintage
        createSample("VID07", "Chân Váy Xếp Ly Cạp Cao Phong Cách Vintage Hàn Quốc",
                "https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=800",
                "https://www.youtube.com/watch?v=nmhPrLiPr40", 2260,
                "Chân váy xếp ly cạp cao có lớp lót bảo hộ an toàn. Phối cùng gile len hoặc sơ mi tạo phong cách cực xinh.",
                true, new Timestamp(now - 5000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 8. Trang Sức Vòng Cổ Bạc 925
        createSample("VID08", "Bộ Sưu Tập Vòng Cổ Bạc 925 & Lắc Tay Nữ Đính Đá Sang Chảnh",
                "https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800",
                "https://www.youtube.com/watch?v=rsIDG50k3Iw", 3200,
                "Trang sức bạc cao cấp 925 đính đá nhân tạo lấp lánh, thiết kế mảnh mai thanh lịch giúp tôn vinh vẻ đẹp phái nữ.",
                true, new Timestamp(now - 4000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 9. Phụ Kiện Trang Sức & Khuyên Tai
        createSample("VID09", "Phụ Kiện Trang Sức Vintage & Khuyên Tai Nữ Cao Cấp",
                "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=800",
                "https://www.youtube.com/watch?v=KMR5YUUdsvE", 2150,
                "Các mẫu khuyên tai đính ngọc trai nhân tạo và kim loại mạ vàng sang trọng, tạo điểm nhấn thu hút cho khuôn mặt.",
                true, new Timestamp(now - 3000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 10. Nhẫn & Mặt Dây Chuyền Bạc
        createSample("VID10", "Nhẫn & Mặt Dây Chuyền Thời Trang Bạc Nữ Tinh Tế",
                "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800",
                "https://www.youtube.com/watch?v=YBKN4lRIltA", 2890,
                "Set nhẫn và mặt dây chuyền phong cách tối giản thanh lịch, chất liệu không gỉ, bền màu theo thời gian.",
                true, new Timestamp(now - 2000000), 1, "Nguyễn Thanh Tâm", "syber096");

        // 11. Giày Sneaker Thể Thao Nam Nữ
        createSample("VID11", "Bộ Sưu Tập Giày Sneaker Thể Thao Nam Nữ Độn Đế Siêu Êm",
                "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800",
                "https://www.youtube.com/watch?v=GWNyvuSs7GU", 4180,
                "Mẫu giày thể thao sneaker đế đệm êm chân, bám đường tốt, phối màu trẻ trung dễ đi học, đi chơi, tập gym.",
                true, new Timestamp(now - 1000000), 2, "Nguyễn Thanh Tâm", "thanhtam");

        // 12. Giày Cao Gót Nữ 7cm
        createSample("VID12", "Giày Cao Gót Mũi Nhọn 7cm Quyến Rũ Thanh Lịch Đi Tiệc",
                "https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=800",
                "https://www.youtube.com/watch?v=mIieHM6KhJk", 2840,
                "Giày cao gót nữ mũi nhọn 7 phân da lộn cao cấp, đệm lót gót êm ái giúp bước đi tự tin, quyến rũ trong mọi sự kiện.",
                true, new Timestamp(now), 2, "Nguyễn Thanh Tâm", "thanhtam");
    }

    private static void createSample(String id, String title, String poster, String url, int views, String desc, boolean active, Timestamp date, int userId, String fullname, String username) {
        Video v = new Video(id, title, poster, url, views, desc, active, date, userId);
        v.setUserFullName(fullname);
        v.setUsername(username);
        MEMORY_VIDEOS.put(id, v);
    }

    private Video mapVideo(ResultSet rs) throws Exception {
        Video v = new Video();
        v.setVideoId(rs.getString("videoId"));
        v.setTitle(rs.getString("title"));
        v.setPoster(rs.getString("poster"));
        v.setUrl(rs.getString("url"));
        v.setViews(rs.getInt("views"));
        v.setDescription(rs.getString("description"));
        v.setActive(rs.getBoolean("active"));
        v.setCreatedDate(rs.getTimestamp("createdDate"));
        v.setUserId(rs.getInt("userId"));
        try {
            v.setUserFullName(rs.getString("fullname"));
            v.setUsername(rs.getString("username"));
        } catch (Exception ignored) {}
        return v;
    }

    @Override
    public List<Video> getAll() {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT v.*, u.fullname, u.username FROM Videos v LEFT JOIN [User] u ON v.userId = u.id ORDER BY v.createdDate DESC";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapVideo(rs));
            }
            if (!list.isEmpty()) {
                return list;
            }
        } catch (Exception ignored) {
        }
        // Fallback in-memory
        List<Video> res;
        synchronized (MEMORY_VIDEOS) {
            res = new ArrayList<>(MEMORY_VIDEOS.values());
        }
        Collections.sort(res, (a, b) -> b.getCreatedDate().compareTo(a.getCreatedDate()));
        return res;
    }

    @Override
    public List<Video> getLatest10() {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT TOP 10 v.*, u.fullname, u.username FROM Videos v LEFT JOIN [User] u ON v.userId = u.id WHERE v.active = 1 ORDER BY v.createdDate DESC";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapVideo(rs));
            }
            if (!list.isEmpty()) {
                return list;
            }
        } catch (Exception ignored) {
        }
        // Fallback in-memory: 10 video mới nhất đang active
        List<Video> all;
        synchronized (MEMORY_VIDEOS) {
            all = new ArrayList<>(MEMORY_VIDEOS.values());
        }
        List<Video> res = new ArrayList<>();
        for (Video v : all) {
            if (v.isActive()) {
                res.add(v);
            }
        }
        Collections.sort(res, (a, b) -> b.getCreatedDate().compareTo(a.getCreatedDate()));
        if (res.size() > 10) {
            return new ArrayList<>(res.subList(0, 10));
        }
        return res;
    }

    @Override
    public List<Video> getByUserId(int userId, int page, int pageSize) {
        List<Video> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT v.*, u.fullname, u.username FROM Videos v LEFT JOIN [User] u ON v.userId = u.id " +
                     "WHERE v.userId = ? ORDER BY v.createdDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapVideo(rs));
                }
                if (!list.isEmpty()) {
                    return list;
                }
            }
        } catch (Exception ignored) {
        }
        // Fallback in-memory
        List<Video> userVideos = new ArrayList<>();
        synchronized (MEMORY_VIDEOS) {
            for (Video v : MEMORY_VIDEOS.values()) {
                if (v.getUserId() == userId) {
                    userVideos.add(v);
                }
            }
        }
        Collections.sort(userVideos, (a, b) -> b.getCreatedDate().compareTo(a.getCreatedDate()));
        int fromIndex = Math.min(offset, userVideos.size());
        int toIndex = Math.min(fromIndex + pageSize, userVideos.size());
        return new ArrayList<>(userVideos.subList(fromIndex, toIndex));
    }

    @Override
    public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM Videos WHERE userId = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int c = rs.getInt(1);
                    if (c > 0) return c;
                }
            }
        } catch (Exception ignored) {
        }
        // Fallback in-memory
        int count = 0;
        synchronized (MEMORY_VIDEOS) {
            for (Video v : MEMORY_VIDEOS.values()) {
                if (v.getUserId() == userId) {
                    count++;
                }
            }
        }
        return count;
    }

    @Override
    public Video get(String videoId) {
        if (videoId == null) return null;
        String sql = "SELECT v.*, u.fullname, u.username FROM Videos v LEFT JOIN [User] u ON v.userId = u.id WHERE v.videoId = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapVideo(rs);
                }
            }
        } catch (Exception ignored) {
        }
        return MEMORY_VIDEOS.get(videoId);
    }

    @Override
    public void insert(Video video) {
        if (video == null || video.getVideoId() == null) return;
        // Luôn lưu vào Memory để đảm bảo UI phản hồi ngay lập tức
        MEMORY_VIDEOS.put(video.getVideoId(), video);

        String sql = "INSERT INTO Videos(videoId, title, poster, url, views, description, active, createdDate, userId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, video.getVideoId());
            ps.setString(2, video.getTitle());
            ps.setString(3, video.getPoster());
            ps.setString(4, video.getUrl());
            ps.setInt(5, video.getViews());
            ps.setString(6, video.getDescription());
            ps.setBoolean(7, video.isActive());
            ps.setTimestamp(8, video.getCreatedDate() != null ? video.getCreatedDate() : new Timestamp(System.currentTimeMillis()));
            ps.setInt(9, video.getUserId());
            ps.executeUpdate();
        } catch (Exception ignored) {
        }
    }

    @Override
    public void update(Video video) {
        if (video == null || video.getVideoId() == null) return;
        // Luôn cập nhật trong Memory
        Video existing = MEMORY_VIDEOS.get(video.getVideoId());
        if (existing != null) {
            existing.setTitle(video.getTitle());
            if (video.getPoster() != null && !video.getPoster().trim().isEmpty()) {
                existing.setPoster(video.getPoster());
            }
            if (video.getUrl() != null && !video.getUrl().trim().isEmpty()) {
                existing.setUrl(video.getUrl());
            }
            existing.setDescription(video.getDescription());
            existing.setActive(video.isActive());
            MEMORY_VIDEOS.put(existing.getVideoId(), existing);
        } else {
            MEMORY_VIDEOS.put(video.getVideoId(), video);
        }

        String sql = "UPDATE Videos SET title = ?, poster = ?, url = ?, description = ?, active = ? WHERE videoId = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, video.getTitle());
            ps.setString(2, video.getPoster());
            ps.setString(3, video.getUrl());
            ps.setString(4, video.getDescription());
            ps.setBoolean(5, video.isActive());
            ps.setString(6, video.getVideoId());
            ps.executeUpdate();
        } catch (Exception ignored) {
        }
    }

    @Override
    public void delete(String videoId) {
        if (videoId == null) return;
        // Luôn xóa trong Memory
        MEMORY_VIDEOS.remove(videoId);

        String sql = "DELETE FROM Videos WHERE videoId = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            ps.executeUpdate();
        } catch (Exception ignored) {
        }
    }

    @Override
    public void updateViews(String videoId) {
        if (videoId == null) return;
        Video v = MEMORY_VIDEOS.get(videoId);
        if (v != null) {
            v.setViews(v.getViews() + 1);
        }

        String sql = "UPDATE Videos SET views = views + 1 WHERE videoId = ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, videoId);
            ps.executeUpdate();
        } catch (Exception ignored) {
        }
    }
}
