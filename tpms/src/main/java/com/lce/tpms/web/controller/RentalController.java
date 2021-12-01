package com.lce.tpms.web.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lce.tpms.service.RentalService;

// 예약과 관련된 
@Controller
@RequestMapping("/rental")
public class RentalController {
	
	@Autowired
	private RentalService rentalService;
	
	@PostMapping("/apply")
	public String applyRental(String phoneCode, String startDate, String endDate) {
		// 대여신청 
		System.out.println(phoneCode);
		System.out.println(startDate);
		System.out.println(endDate);
		return "redirect:/user/phone/list";
	}
	

}
