package com.lce.tpms.dao;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Phone;

public interface PhoneDao {
	
	List<Phone> getAllPhones();
	
	List<HashMap<String, Object>> getAllPhonesContainsRentalByPageAndOption(HashMap<String, Object> option);
	
	int getPhonesCnt();
	
	int getPhonesCntByOption(HashMap<String, Object> option);
	
	Phone getPhoneByCode(String phoneCode);

	List<String> getPhoneMakers();
}
