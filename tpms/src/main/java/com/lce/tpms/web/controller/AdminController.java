package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lce.tpms.service.AdminService;
import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.Phone;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.annotation.LoginAdmin;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	@Autowired
	UserService userService;
	@Autowired
	PhoneService phoneService;
	
	@GetMapping("/main")
	public String adminMain(@LoginAdmin User user, Model model) {
		List<HashMap<String, Object>> rentals = adminService.getWaitRentals();
		List<HashMap<String, Object>> overdues = adminService.getOverdueRentals();
		List<HashMap<String, Object>> inquiries = adminService.getNoRespondInquiries();
		model.addAttribute("rentals", rentals);
		model.addAttribute("inquiries", inquiries);
		model.addAttribute("overdues", overdues);
		return "admin/main";
	}

	@GetMapping("/user")
	public String userManagement(@LoginAdmin User user, Model model) {
		List<User> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "admin/user";
	}
	
	@GetMapping("/phone")
	public String phoneManagement(@LoginAdmin User user, Model model) {
		List<Phone> phones = phoneService.getAllPhones();
		model.addAttribute("phones", phones);
		return "admin/phone";
	}
	
}
