package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.PhoneDao;
import com.lce.tpms.vo.Phone;

@Service
@Transactional
public class PhoneServiceImpl implements PhoneService{

	@Autowired
	private PhoneDao phoneDao;
	
	/**
	 * 모든 기기정보 반환하는 메소드 
	 */
	@Override
	public List<Phone> getAllPhons() {
		return phoneDao.getAllPhones();
	}
	
	/**
	 * 기기정보 + 대여정보 함께 반환하는 메소드 
	 */
	@Override
	public List<HashMap<String, Object>> getAllPhonesContainsRental() {
		return phoneDao.getAllPhonesContainsRental();
	}
	
}
