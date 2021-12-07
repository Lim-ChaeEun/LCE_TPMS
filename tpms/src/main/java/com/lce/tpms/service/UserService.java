package com.lce.tpms.service;

import java.util.List;

import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.User;

public interface UserService {
	
	/**
	 * 모든 회원정보를 리턴하는 메소드
	 * @return 회원 리스트
	 */
	List<User> getAllUser();
	
	void login(String id, String password);

	void registerInquiry(Inquiry inquiry);
	
	List<Inquiry> getInquiriesByUser(String userCode);
	
	boolean isAbleToReserve(String userCode);
	
	List<String> getAllDepartments();

	List<String> getAllTeamsByDept(String dept);
}
