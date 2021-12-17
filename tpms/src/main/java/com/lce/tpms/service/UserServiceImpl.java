package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.InquiryDao;
import com.lce.tpms.dao.ReservationDao;
import com.lce.tpms.dao.UserDao;
import com.lce.tpms.exception.LoginException;
import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.User;
import com.lce.tpms.vo.UserDto;
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
	public User getUserByCode(String userCode) {
		return userDao.getUserByCode(userCode);
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
		String secretPwd = DigestUtils.sha256Hex(password);
		if(!secretPwd.equals(user.getPassword())) {
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
	public void cancelReserve(String reserveCode, String userCode) {
		reservationDao.deleteReservation(reserveCode);
		HashMap<String, String> option = new HashMap<String, String>();
		option.put("userCode", userCode);
		option.put("status", "Y");
		userDao.updateUserStatus(option);
	}
	
	@Override
	public boolean isAbleToReserve(String userCode) {
		HashMap<String, Object> reserve = reservationDao.getUserReserve(userCode);
		if(reserve != null) {
			return false;
		}
		return true;
	}
	
	@Override
	public User registerUser(UserDto user) {
		String secretPwd = DigestUtils.sha256Hex(user.getPassword());
		user.setPassword(secretPwd);
		userDao.insertUser(user);
		User newUser = userDao.getUserByCode(user.getCode());
		return newUser;
	}
	
	@Override
	public void updateUserAdmin(HashMap<String, String> option) {
		userDao.updateUserAdmin(option);
		
	}
	
	@Override
	public HashMap<String, Object> getUserMainInfo(String userCode) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		// 사용자의 최근 문의 3개까지 조회해서 담기
		List<Inquiry> inquiries = inquiryDao.getUserRecentInquiry(userCode);
		// 대여, 예약내역 조회해서 담기
		HashMap<String, Object> rental = rentalService.getRentalByUserAndStatus("ING");
		userInfo.put("rental", rental);
		if(rental == null) {
			HashMap<String, Object> waitRental = rentalService.getRentalByUserAndStatus("WAIT");
			userInfo.put("waitRental", waitRental);
		}
		HashMap<String, Object> reserve = reservationDao.getUserReserve(userCode);
		if(reserve != null) {
			String phoneCode = (String)reserve.get("PHONECODE");
			HashMap<String, Object> reservePhone = rentalService.getPhoneNowRental(phoneCode);
			userInfo.put("reservePhone", reservePhone);
		}
		userInfo.put("inquiries", inquiries);
		userInfo.put("reserve", reserve);
		return userInfo;
	}
	
	@Override
	public void updateUserStatus(HashMap<String, String> option) {
		userDao.updateUserStatus(option);
	}
}
