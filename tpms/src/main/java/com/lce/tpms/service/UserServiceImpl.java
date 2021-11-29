package com.lce.tpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lce.tpms.dao.UserDao;
import com.lce.tpms.vo.User;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;
	
	@Override
	public List<User> getAllUser() {
		return userDao.getAllUser();
	}
	
}
