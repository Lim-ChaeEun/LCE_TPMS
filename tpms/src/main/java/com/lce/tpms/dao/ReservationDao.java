package com.lce.tpms.dao;

import com.lce.tpms.vo.Reservation;

public interface ReservationDao {
	
	void insertReservation(Reservation reservation);
	
	String userAlreadyReserveBefore(String userCode);
	
	String phoneAlreadyReserveBefore(String userCode);

	String getReservationByCode(String userCode);
	
}
