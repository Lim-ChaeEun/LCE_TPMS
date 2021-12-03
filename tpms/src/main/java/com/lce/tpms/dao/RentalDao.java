package com.lce.tpms.dao;

import java.util.List;

import com.lce.tpms.vo.Rental;

public interface RentalDao {

	List<Rental> getCurrentRentalList();
	
	void insertRental(Rental rental);
}
