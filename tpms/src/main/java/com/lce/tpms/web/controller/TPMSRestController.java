package com.lce.tpms.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lce.tpms.service.EmailService;
import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.RentalService;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.Phone;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@RestController
@RequestMapping("/rest")
public class TPMSRestController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private RentalService rentalService;
	@Autowired
	private PhoneService phoneService;
	@Autowired
	private EmailService emailService;

	@GetMapping("/islogin")
	public User isLogined() {
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		return user;
	}
	
	@GetMapping("/notify/overDue")
	public void notifyOverDue(String rentalCode) {
		Rental rental = rentalService.getRentalByCode(rentalCode);
		Phone phone = phoneService.getPhoneByCode(rental.getPhoneCode());
		User user = userService.getUserByCode(rental.getUserCode());
		emailService.sendOverDueEmail(user, phone, rental);
	}
	
	@GetMapping("/isAbleUser")
	public boolean isAbleUser(String userCode) {
		User user = userService.getUserByCode(userCode);
		if(user != null) {
			return false;
		}
		return true;
	}
	
	@GetMapping("/ableReserve")
	public boolean isAbleToReserve() {
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		boolean result = userService.isAbleToReserve(user.getCode());
		return result;
	}
}
