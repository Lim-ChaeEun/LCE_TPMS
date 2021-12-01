package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping("/phone/list")
	public String phoneList(Model model) {
		// 기기전체의 목록 담
		List<HashMap<String, Object>> phones = phoneService.getAllPhonesContainsRental();
		model.addAttribute("phones", phones);
		return "user/list";
	}
	

}
