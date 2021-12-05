package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.Reservation;

public interface RentalService {

	List<Rental> getCurrentRentalList();
	
	void applyRental(Rental rental);
	
	HashMap<String, Object> getRentalByUserAndStatus(String status);
	
	List<HashMap<String, Object>> getFinRentalsByUser(String userCode);
	
	void insertReservation(Reservation reservation);
	
}
