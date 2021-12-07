package com.lce.tpms.dao;

import com.lce.tpms.vo.Reservation;

public interface ReservationDao {
	
	void insertReservation(Reservation reservation);
	
	Reservation getUserReserve(String userCode);
	
	Reservation getPhoneReserve(String userCode);

	Reservation getReservationByCode(String userCode);
	
}
