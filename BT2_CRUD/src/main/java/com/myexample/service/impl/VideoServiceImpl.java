package com.myexample.service.impl;

import java.util.List;
import com.myexample.dao.VideoDAO;
import com.myexample.dao.impl.VideoDAOImpl;
import com.myexample.model.Video;
import com.myexample.service.VideoService;

/**
 * Triển khai VideoService
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public class VideoServiceImpl implements VideoService {

    private final VideoDAO videoDAO = new VideoDAOImpl();

    @Override
    public List<Video> getAll() {
        return videoDAO.getAll();
    }

    @Override
    public List<Video> getLatest10() {
        return videoDAO.getLatest10();
    }

    @Override
    public List<Video> getByUserId(int userId, int page, int pageSize) {
        return videoDAO.getByUserId(userId, page, pageSize);
    }

    @Override
    public int countByUserId(int userId) {
        return videoDAO.countByUserId(userId);
    }

    @Override
    public Video get(String videoId) {
        return videoDAO.get(videoId);
    }

    @Override
    public void insert(Video video) {
        videoDAO.insert(video);
    }

    @Override
    public void update(Video video) {
        videoDAO.update(video);
    }

    @Override
    public void delete(String videoId) {
        videoDAO.delete(videoId);
    }

    @Override
    public void updateViews(String videoId) {
        videoDAO.updateViews(videoId);
    }
}
