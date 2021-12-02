package com.lce.tpms.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.RentalService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private PhoneService phoneService;
	@Autowired
	private RentalService rentalService;
	

}
