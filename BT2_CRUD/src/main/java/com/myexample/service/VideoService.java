package com.myexample.service;

import java.util.List;
import com.myexample.model.Video;

/**
 * Service cho nghiệp vụ Videos
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public interface VideoService {
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
