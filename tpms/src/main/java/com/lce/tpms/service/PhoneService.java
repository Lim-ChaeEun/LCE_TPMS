package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Phone;

public interface PhoneService {

	List<Phone> getAllPhons();
	
	HashMap<String, Object> getAllPhonesContainsRentalByPageAndOption(HashMap<String, Object> option);
	
	Phone getPhoneByCode(String phoneCode);
	
	List<String> getPhoneMakers();
}
