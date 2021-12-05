package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Phone;

public interface PhoneService {

	List<Phone> getAllPhons();
	
	List<HashMap<String, Object>> getAllPhonesContainsRental();
	
	List<HashMap<String, Object>> getPhonesContainsRentalforOption(HashMap<String, String> option);
}
