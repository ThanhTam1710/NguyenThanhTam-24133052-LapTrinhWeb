package com.myexample.dao;

import java.util.List;
import com.myexample.model.Video;

/**
 * Interface DAO cho bảng Videos
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public interface VideoDAO {
    List<Video> getAll();

    List<Video> getLatest10();

    List<Video> getByUserId(int userId, int page, int pageSize);

    int countByUserId(int userId);

    Video get(String videoId);

    void insert(Video video);

    void update(Video video);

    void delete(String videoId);

    void updateViews(String videoId);
}
