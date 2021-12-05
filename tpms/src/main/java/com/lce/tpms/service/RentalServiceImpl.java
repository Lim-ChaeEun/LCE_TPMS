package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.RentalDao;
import com.lce.tpms.dao.ReservationDao;
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

	/**
	 * 현재진행중인 대여 목
	 */
	@Override	
	public List<Rental> getCurrentRentalList() {
		List<Rental> rentals = rentalDao.getCurrentRentalList();
		return rentals;
	}
	
	@Override
	public void applyRental(Rental rental) {
		rentalDao.insertRental(rental);
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
	}
	
}
