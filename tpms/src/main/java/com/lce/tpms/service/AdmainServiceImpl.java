package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.InquiryDao;
import com.lce.tpms.dao.RentalDao;

@Service
@Transactional
public class AdmainServiceImpl implements AdminService{
	
	@Autowired
	public InquiryDao inquiryDao;
	@Autowired
	public RentalDao rentalDao;

	@Override
	public List<HashMap<String, Object>> getNoRespondInquiries() {
		return inquiryDao.getNoRespondInquiries();
	}
	
	@Override
	public List<HashMap<String, Object>> getWaitRentals() {
		return rentalDao.getWaitRentals();
	}
	
	@Override
	public List<HashMap<String, Object>> getOverdueRentals() {
		return rentalDao.getOverdueRentals();
	}
}
