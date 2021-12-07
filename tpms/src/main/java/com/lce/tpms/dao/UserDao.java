package com.lce.tpms.dao;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.User;

public interface UserDao {

	List<User> getAllUser();
	
	User getUserByCode(String code);
	
	void insertUser(User user);
	
	void updateUserStatus(HashMap<String, String> option);
	
	List<String> getAllDepartments();

	List<String> getAllTeamsByDept(String dept);
}
