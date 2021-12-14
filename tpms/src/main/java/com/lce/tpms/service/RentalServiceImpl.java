package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.RentalDao;
import com.lce.tpms.dao.ReservationDao;
import com.lce.tpms.dao.UserDao;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.Reservation;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@Service
@Transactional
public class RentalServiceImpl implements RentalService {
	
	@Autowired
	private RentalDao rentalDao;
	
	@Autowired
	private ReservationDao reservationDao;
	
	@Autowired
	private UserDao userDao;
	
	@Override
	public void cancelRental(String rentalCode, String userCode) {
		rentalDao.deleteRental(rentalCode);
		HashMap<String, String> option = new HashMap<String, String>();
		option.put("userCode", userCode);
		option.put("status", "Y");
		userDao.updateUserStatus(option);
	}
	
	@Override
	public void applyRental(Rental rental, String userCode) {
		rentalDao.insertRental(rental);
		// 대여신청한 사용자의 상태를 n으로 변경
		HashMap<String, String> option = new HashMap<String, String>();
		option.put("userCode", userCode);
		option.put("status", "N");
		userDao.updateUserStatus(option);
		User  user = userDao.getUserByCode(userCode);
		SessionUtils.removeAttribute("LOGINED_USER");
		SessionUtils.addAttribute("LOGINED_USER", user);
	}
	
	
	@Override
	public List<HashMap<String, Object>> getFinRentalsByUser(String userCode) {
		return rentalDao.getFinRentalsByUser(userCode);
	}
	
	@Override
	public HashMap<String, Object> getRentalByUserAndStatus(String status) {
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		HashMap<String, String> option = new HashMap<String, String>();
		option.put("userCode", user.getCode());
		option.put("status", status);
		return rentalDao.getRentalByUserAndStatus(option);
	}
	
	@Override
	public void insertReservation(Reservation reservation) {
		reservationDao.insertReservation(reservation);
		HashMap<String, String> option = new HashMap<String, String>();
		option.put("userCode", reservation.getUserCode());
		option.put("status", "N");
		userDao.updateUserStatus(option);
	}
	
	@Override
	public HashMap<String, Object> getPhoneNowRental(String phoneCode) {
		return rentalDao.getPhoneNowRental(phoneCode);
	}
	
	@Override
	public Rental getRentalByCode(String rentalCode) {
		return rentalDao.getRentalByCode(rentalCode);
	}
	
}
