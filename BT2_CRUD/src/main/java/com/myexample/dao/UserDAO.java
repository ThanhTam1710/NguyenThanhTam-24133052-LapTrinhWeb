package com.myexample.dao;

import com.myexample.model.User;

public interface UserDAO {
    User get(String username);
    void insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    User checkLogin(String username, String password);
}
