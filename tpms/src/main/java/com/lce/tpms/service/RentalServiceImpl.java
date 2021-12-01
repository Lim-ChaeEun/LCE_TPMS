package com.lce.tpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.RentalDao;
import com.lce.tpms.vo.Rental;

@Service
@Transactional
public class RentalServiceImpl implements RentalService {
	
	@Autowired
	private RentalDao rentalDao;

	/**
	 * 현재진행중인 대여 목
	 */
	@Override	
	public List<Rental> getCurrentRentalList() {
		List<Rental> rentals = rentalDao.getCurrentRentalList();
		return rentals;
	}
	
}
