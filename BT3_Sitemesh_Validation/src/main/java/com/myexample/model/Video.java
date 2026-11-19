package com.myexample.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Model Video
 * Mối quan hệ 1-n: 1 User có nhiều Videos
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public class Video implements Serializable {
    private static final long serialVersionUID = 1L;

    private String videoId;         // Mã định danh video
    private String title;           // Tiêu đề video
    private String poster;          // Tên file ảnh thumbnail hoặc URL ảnh trực tuyến
    private String url;             // Đường dẫn video (tên file mp4 đã upload hoặc link YouTube/video)
    private int views;              // Lượt xem
    private String description;     // Mô tả video
    private boolean active;         // Trạng thái hoạt động (true: hiển thị, false: ẩn)
    private Timestamp createdDate;  // Ngày giờ đăng video
    private int userId;             // Khóa ngoại liên kết tới User (id)
    private String userFullName;    // Họ tên người đăng (để tiện hiển thị)
    private String username;        // Username người đăng

    public Video() {
        this.active = true;
        this.views = 0;
        this.createdDate = new Timestamp(System.currentTimeMillis());
    }

    public Video(String videoId, String title, String poster, String url, int views, String description, boolean active, Timestamp createdDate, int userId) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.url = url;
        this.views = views;
        this.description = description;
        this.active = active;
        this.createdDate = createdDate != null ? createdDate : new Timestamp(System.currentTimeMillis());
        this.userId = userId;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Tự động trích xuất link embed YouTube từ link shorts, watch hoặc youtu.be
     */
    public String getEmbedUrl() {
        if (url == null || url.trim().isEmpty()) {
            return null;
        }
        String u = url.trim();
        if (u.contains("youtube.com/watch?v=")) {
            int idx = u.indexOf("watch?v=");
            String id = u.substring(idx + 8);
            int amp = id.indexOf("&");
            if (amp != -1) id = id.substring(0, amp);
            return "https://www.youtube.com/embed/" + id;
        } else if (u.contains("youtube.com/shorts/")) {
            int idx = u.indexOf("shorts/");
            String id = u.substring(idx + 7);
            int q = id.indexOf("?");
            if (q != -1) id = id.substring(0, q);
            return "https://www.youtube.com/embed/" + id;
        } else if (u.contains("youtu.be/")) {
            int idx = u.indexOf("youtu.be/");
            String id = u.substring(idx + 9);
            int q = id.indexOf("?");
            if (q != -1) id = id.substring(0, q);
            return "https://www.youtube.com/embed/" + id;
        } else if (u.contains("youtube.com/embed/")) {
            return u;
        }
        return null;
    }

    public boolean isYouTube() {
        return getEmbedUrl() != null;
    }

    public String getPosterUrl() {
        if (poster == null || poster.trim().isEmpty()) {
            return "https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=600";
        }
        if (poster.startsWith("http://") || poster.startsWith("https://")) {
            return poster;
        }
        return "/24133052_NguyenThanhTam_CRUD/media?fname=" + poster;
    }

    @Override
    public String toString() {
        return "Video [videoId=" + videoId + ", title=" + title + ", views=" + views + ", userId=" + userId + "]";
    }
}
