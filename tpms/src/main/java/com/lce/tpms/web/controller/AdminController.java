package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	private AdminService adminService;
	@Autowired
	private UserService userService;
	@Autowired
	private PhoneService phoneService;
	
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

	@GetMapping("/rental")
	public String decideRental(@LoginAdmin User user, @RequestParam String code, @RequestParam String status, RedirectAttributes rat) {
		HashMap<String, String> option = new  HashMap<String, String>();
		option.put("rentalCode", code);
		option.put("status", status);
		adminService.updateRental(option);
		rat.addFlashAttribute("status", status);
		return "redirect:/admin/main";
	}
	
	@GetMapping("/user")
	public String userManagement(@LoginAdmin User user, Model model) {
		List<User> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "admin/user";
	}
	
	@GetMapping("/rental/return")
	public String returnRental(@LoginAdmin User user, @RequestParam String code, @RequestParam String status, RedirectAttributes rat) {
		HashMap<String, String> option = new  HashMap<String, String>();
		option.put("rentalCode", code);
		option.put("status", status);
		System.out.println("반납처리");
		adminService.returnRental(option);
		rat.addFlashAttribute("status", status);
		return "redirect:/admin/main";
	}
	
	@GetMapping("/phone")
	public String phoneManagement(@LoginAdmin User user, Model model) {
		List<Phone> phones = phoneService.getAllPhones();
		model.addAttribute("phones", phones);
		return "admin/phone";
	}
	
	
	@GetMapping("/inquiry")
	public String phoneManagement(@LoginAdmin User user, @RequestParam String code, @RequestParam String respond) {
		HashMap<String, String> option = new  HashMap<String, String>();
		option.put("respond", respond);
		option.put("inquiryCode", code);
		adminService.respondInquiry(option);
		return "redirect:/admin/main";
	}
	
}
