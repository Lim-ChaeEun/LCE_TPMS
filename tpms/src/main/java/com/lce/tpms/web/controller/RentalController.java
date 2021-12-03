package com.lce.tpms.web.controller;

import java.text.ParseException;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lce.tpms.service.RentalService;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.DateUtils;
import com.lce.tpms.web.util.SessionUtils;

// 예약과 관련된 
@Controller
@RequestMapping("/rental")
public class RentalController {
	
	@Autowired
	private RentalService rentalService;
	
	@PostMapping("/apply")
	public String applyRental(String phoneCode, String startDate, String endDate) throws ParseException {
		// 대여신청 
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		Rental rental = new Rental();
		rental.setPhoneCode(phoneCode);
		rental.setStartDate(DateUtils.stringToDate(startDate));
		rental.setEndDate(DateUtils.stringToDate(endDate));
		rental.setUserCode(user.getCode());
		rentalService.applyRental(rental);
		return "redirect:/main";
	}
	

}
