package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.InquiryDao;
import com.lce.tpms.dao.PhoneDao;
import com.lce.tpms.dao.RentalDao;
import com.lce.tpms.dao.ReservationDao;
import com.lce.tpms.dao.UserDao;
import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.Phone;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.Reservation;
import com.lce.tpms.vo.User;

@Service
@Transactional
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private InquiryDao inquiryDao;
	@Autowired
	private RentalDao rentalDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private PhoneDao phoneDao;
	@Autowired
	private ReservationDao reservDao;
	@Autowired
	private EmailService emailService;
	
	@Override
	public void updateRental(HashMap<String, String> option) {
		// 대여상태 변경  && 사용자 상태 변경 (반려일 경우 )
		HashMap<String, String> rentalParam = new HashMap<String, String>();
		HashMap<String, String> userParam = new HashMap<String, String>();
		String status = option.get("status");
		String rentalCode = option.get("rentalCode");
		Rental rental = rentalDao.getRentalByCode(rentalCode);
		Phone phone = phoneDao.getPhoneByCode(rental.getPhoneCode());
		User user = userDao.getUserByCode(rental.getUserCode());
		// 대여상태 변경
		rentalParam.put("rentalCode", rentalCode);
		if("approve".equals(status)) {
			// 승인 
			rentalParam.put("status", "ING");
			rentalDao.updateRental(rentalParam);
			emailService.sendArroveEmail(user, phone);
		}else if("reject".equals(status)) {
			rentalParam.put("status", "REJ");
			userParam.put("status", "Y");
			userParam.put("userCode", rental.getUserCode());
			rentalDao.updateRental(rentalParam);
			userDao.updateUserStatus(userParam);
			emailService.sendRejectEmail(user, phone.getModelName());
		}
		
	}
	
	@Override
	public void returnRental(HashMap<String, String> option) {
		String status = option.get("status");
		String rentalCode = option.get("rentalCode");
		Rental rental = rentalDao.getRentalByCode(rentalCode);
		User rentalUser = userDao.getUserByCode(rental.getUserCode());
		// 이 기기를 예약한 사람 있는지 확인
		Reservation reserv = reservDao.getPhoneReserve(rental.getPhoneCode());
		if(reserv != null) {
			User reserveUser = userDao.getUserByCode(reserv.getUserCode());
			// 예약한 사람에게 이메일 보내기;
			emailService.sendReserveEmail(reserveUser);
			reservDao.deleteReservation(reserv.getCode());
		}
		// 대여상태, 
		HashMap<String, String> rentalParam = new HashMap<String, String>();
		rentalParam.put("rentalCode", rentalCode);
		rentalParam.put("status", "FIN");
		HashMap<String, String> userParam = new HashMap<String, String>();
		userParam.put("userCode", rental.getUserCode());
		if("delay".equals(status)) {
			userParam.put("status", "X");
		}else if("return".equals(status)) {
			userParam.put("status", "Y");
		}
		emailService.sendReturnEmail(rentalUser, status);
		rentalDao.updateRental(rentalParam);
		rentalDao.returnRental(rentalCode);
		userDao.updateUserStatus(userParam);
		
	}

	@Override
	public void respondInquiry(HashMap<String, String> param) {
		inquiryDao.updateInquiry(param);
		Inquiry inquiry = inquiryDao.getInquiryByCode(param.get("inquiryCode"));
		User user = userDao.getUserByCode(inquiry.getUserCode());
		emailService.sendInquiryEmail(user, inquiry);
	}
	
	@Override
	public List<HashMap<String, Object>> getNoRespondInquiries() {
		return inquiryDao.getNoRespondInquiries();
	}
	
	@Override
	public List<HashMap<String, Object>> getWaitRentals() {
		return rentalDao.getWaitRentals();
	}
	
	@Override
	public List<HashMap<String, Object>> getOverdueRentals() {
		return rentalDao.getOverdueRentals();
	}
}
