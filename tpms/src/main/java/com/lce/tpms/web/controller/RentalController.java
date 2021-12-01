package com.lce.tpms.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lce.tpms.service.RentalService;

// 예약과 관련된 
@Controller
@RequestMapping("/rental")
public class RentalController {
	
	@Autowired
	private RentalService rentalService;
	
	@GetMapping("/apply")
	public String applyRental(String phoneCode) {
		// 대여신청 
		
		return "";
	}
	

}
