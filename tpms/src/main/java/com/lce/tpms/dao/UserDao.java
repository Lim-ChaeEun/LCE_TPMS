package com.lce.tpms.dao;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.User;
import com.lce.tpms.vo.UserDto;

public interface UserDao {

	List<User> getAllUser();
	
	User getUserByCode(String code);
	
	void insertUser(UserDto user);
	
	void updateUserStatus(HashMap<String, String> option);
	
	void updateUserAdmin(HashMap<String, String> option);
	
}
