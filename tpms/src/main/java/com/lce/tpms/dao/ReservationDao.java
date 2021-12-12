package com.lce.tpms.dao;

import java.util.HashMap;

import com.lce.tpms.vo.Reservation;

public interface ReservationDao {
	
	void insertReservation(Reservation reservation);
	
	HashMap<String, Object> getUserReserve(String userCode);
	
	Reservation getPhoneReserve(String phoneCode);

	Reservation getReservationByCode(String reserveCode);
	
	void deleteReservation(String reserveCode);
	
}
