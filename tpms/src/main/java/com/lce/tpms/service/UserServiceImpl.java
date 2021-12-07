package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.InquiryDao;
import com.lce.tpms.dao.ReservationDao;
import com.lce.tpms.dao.UserDao;
import com.lce.tpms.exception.LoginException;
import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.Reservation;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@Service
@Transactional
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;
	@Autowired
	private InquiryDao inquiryDao;
	@Autowired
	private ReservationDao reservationDao;
	@Autowired
	private RentalService rentalService;
	
	@Override
	public List<User> getAllUser() {
		return userDao.getAllUser();
	}
	
	@Override
	public List<Inquiry> getInquiriesByUser(String userCode) {
		return inquiryDao.getInquiriesByUser(userCode);
	}
	
	@Override
	public User login(String code, String password) {
		User user = userDao.getUserByCode(code);
		// 만약 반환되는 user가 없다면
		if(user == null) {
			throw new LoginException("사번 / 비밀번호 오류", "사번 혹은 비밀번호가 유효하지 않습니다.");
		}
		// 암호화 이전
		if(!password.equals(user.getPassword())) {
			throw new LoginException("사번 / 비밀번호 오류", "사번 혹은 비밀번호가 유효하지 않습니다.");
		}
		SessionUtils.addAttribute("LOGINED_USER", user);
		return user;
	}
	
	@Override
	public void registerInquiry(Inquiry inquiry) {
		inquiryDao.insertInquiry(inquiry);
	}
	
	@Override
	public boolean isAbleToReserve(String userCode) {
		Reservation reserve = reservationDao.getUserReserve(userCode);
		if(reserve != null) {
			return false;
		}
		return true;
	}
	
	@Override
	public List<String> getAllDepartments() {
		return userDao.getAllDepartments();
	}
	
	@Override
	public HashMap<String, Object> getUserMainInfo(String userCode) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		// 사용자의 최근 문의 3개까지 조회해서 담기
		List<Inquiry> inquiries = inquiryDao.getInquiriesByUser(userCode);
		// 대여, 예약내역 조회해서 담기
		HashMap<String, Object> rental = rentalService.getRentalByUserAndStatus("ING");
		if(rental == null) {
			rental = rentalService.getRentalByUserAndStatus("WAIT");
		}
		Reservation reserve = reservationDao.getUserReserve(userCode);
		userInfo.put("inquiries", inquiries);
		userInfo.put("rental", rental);
		userInfo.put("reserve", reserve);
		return userInfo;
	}
	
	@Override
	public List<String> getAllTeamsByDept(String dept) {
		return userDao.getAllTeamsByDept(dept);
	}
}
