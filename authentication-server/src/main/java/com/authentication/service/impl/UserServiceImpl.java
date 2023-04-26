package com.authentication.service.impl;

import com.authentication.service.UserService;
import com.authentication.model.entity.User;
import com.authentication.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username).get();
    }

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public Boolean notExistEmail(String email) {
        List<User> userList = userRepository.findAll();
        for (User user : userList) {
            if (user.getEmail().equals(email)) {
                return false;
            }
        }
        return true;
    }

    @Override
    public void changePassword(User user, String password) {
        user.setPassword(new BCryptPasswordEncoder(10).encode(password));
        userRepository.save(user);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email).get();
    }

    @Override
    public boolean notExistUsername(String username) {
        List<User> userList = userRepository.findAll();
        for (User user : userList) {
            if (user.getUsername().equals(username)) {
                return false;
            }
        }
        return true;
    }
}
