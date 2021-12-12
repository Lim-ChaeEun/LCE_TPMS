package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.User;
import com.lce.tpms.vo.UserDto;

public interface UserService {
	
	/**
	 * 모든 회원정보를 리턴하는 메소드
	 * @return 회원 리스트
	 */
	List<User> getAllUser();
	
	User getUserByCode(String userCode);
	
	User login(String id, String password);

	void registerInquiry(Inquiry inquiry);
	
	List<Inquiry> getInquiriesByUser(String userCode);
	
	HashMap<String, Object> getUserMainInfo(String userCode);
	
	boolean isAbleToReserve(String userCode);

	User registerUser(UserDto user);
	
	void cancelReserve(String reserveCode, String userCode);
	
}
