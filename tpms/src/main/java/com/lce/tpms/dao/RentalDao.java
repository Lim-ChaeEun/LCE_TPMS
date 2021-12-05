package com.lce.tpms.dao;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Rental;

public interface RentalDao {

	List<Rental> getCurrentRentalList();
	
	void insertRental(Rental rental);
	
	List<HashMap<String, Object>> getFinRentalsByUser(String userCode);
	
	HashMap<String, Object> getRentalByUserAndStatus(HashMap<String, String> option);
}
