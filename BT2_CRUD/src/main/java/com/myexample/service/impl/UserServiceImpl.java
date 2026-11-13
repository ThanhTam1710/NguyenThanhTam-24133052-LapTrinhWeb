package com.myexample.service.impl;

import com.myexample.dao.UserDAO;
import com.myexample.dao.impl.UserDAOImpl;
import com.myexample.model.User;
import com.myexample.service.UserService;

import java.sql.Date;

public class UserServiceImpl implements UserService {
    private final UserDAO userDao = new UserDAOImpl();

    @Override
    public boolean login(String username, String password) {
        return userDao.checkLogin(username, password) != null;
    }

    @Override
    public User checkLogin(String username, String password) {
        return userDao.checkLogin(username, password);
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username)) {
            return false;
        }
        Date date = new Date(System.currentTimeMillis());
        User newUser = new User(email, username, fullname, password, null, 5, phone, date);
        userDao.insert(newUser);
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }
}
