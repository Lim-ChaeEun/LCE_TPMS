package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.InquiryDao;
import com.lce.tpms.dao.RentalDao;
import com.lce.tpms.dao.UserDao;
import com.lce.tpms.vo.Rental;

@Service
@Transactional
public class AdmainServiceImpl implements AdminService{
	
	@Autowired
	public InquiryDao inquiryDao;
	@Autowired
	public RentalDao rentalDao;
	@Autowired
	public UserDao userDao;
	
	@Override
	public void decideRental(HashMap<String, String> option) {
		// 대여상태 변경  && 사용자 상태 변경 (반려일 경우 )
		HashMap<String, String> param = new HashMap<String, String>();
		String rentalCode = option.get("rentalCode");
		Rental rental = rentalDao.getRentalByCode(rentalCode);
		param.put("rentalCode", rentalCode);

		if("approve".equals(option.get("status"))) {
			// 승인 
			param.put("status", "ING");
			rentalDao.updateRental(param);
		}else {
			// 반려 
			param.put("status", "REJ");
			rentalDao.updateRental(param);
			param.clear();
			param.put("userCode", rental.getUserCode());
			param.put("status", "Y");
			userDao.updateUserStatus(param);
		}
		
	}

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
