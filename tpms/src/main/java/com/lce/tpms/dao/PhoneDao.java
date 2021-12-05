package com.lce.tpms.dao;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Phone;

public interface PhoneDao {
	
	List<Phone> getAllPhones();
	
	List<HashMap<String, Object>> getAllPhonesContainsRental();
	
	List<HashMap<String, Object>> getPhonesContainsRentalforOption(HashMap<String, String> option);

}
