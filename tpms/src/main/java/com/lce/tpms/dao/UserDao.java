package com.lce.tpms.dao;

import java.util.List;

import com.lce.tpms.vo.User;

public interface UserDao {

	List<User> getAllUser();
	
	User getUserByCode(String code);
}
