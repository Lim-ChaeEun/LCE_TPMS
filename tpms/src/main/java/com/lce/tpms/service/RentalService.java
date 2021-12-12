package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.Reservation;

public interface RentalService {
	
	void applyRental(Rental rental, String userCode);
	
	HashMap<String, Object> getRentalByUserAndStatus(String status);
	
	List<HashMap<String, Object>> getFinRentalsByUser(String userCode);
	
	void insertReservation(Reservation reservation);
	
	HashMap<String, Object> getPhoneNowRental(String phoneCode);
	
	void cancelRental(String rentalCode, String userCode);
}
