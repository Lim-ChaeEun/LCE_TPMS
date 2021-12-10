package com.lce.tpms.dao;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Rental;

public interface RentalDao {
	
	void insertRental(Rental rental);
	
	List<HashMap<String, Object>> getFinRentalsByUser(String userCode);
	
	HashMap<String, Object> getRentalByUserAndStatus(HashMap<String, String> option);
	
	List<HashMap<String, Object>> getWaitRentals();

	List<HashMap<String, Object>> getOverdueRentals();
	
	void updateRental(HashMap<String, String> option);
	
	Rental getRentalByCode(String code);
	
}
