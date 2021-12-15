package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@PostMapping("/phone/insert")
	public String insertPhone(Phone phone, RedirectAttributes rat) {
		phoneService.insertPhone(phone);
		rat.addFlashAttribute("status", "insert");
		return "redirect:/admin/phone";
	}

	@GetMapping("/rental")
	public String decideRental(@LoginAdmin User user, @RequestParam String code, @RequestParam String status, @RequestParam String url, RedirectAttributes rat) {
		HashMap<String, String> option = new  HashMap<String, String>();
		option.put("rentalCode", code);
		option.put("status", status);
		adminService.updateRental(option);
		rat.addFlashAttribute("status", status);
		return "redirect:"+url;
	}
	
	@GetMapping("/user")
	public String userManagement(@LoginAdmin User user, Model model) {
		List<User> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "admin/user";
	}
	
	@GetMapping("/rental/return")
	public String returnRental(@LoginAdmin User user, @RequestParam String code, @RequestParam String status, @RequestParam String url, RedirectAttributes rat) {
		HashMap<String, String> option = new  HashMap<String, String>();
		option.put("rentalCode", code);
		option.put("status", status);
		adminService.returnRental(option);
		rat.addFlashAttribute("status", "return");
		return "redirect:"+url;
	}
	
	@GetMapping("/user/status")
	public String updateUserStatus(@RequestParam(name = "code") String userCode, @RequestParam String status) {
		HashMap<String, String> option = new HashMap<String, String>();
		option.put("userCode", userCode);
		option.put("status", status);
		userService.updateUserStatus(option);
		return "redirect:/admin/user";
	}

	@GetMapping("/user/admin")
	public String updateUserAdmin(@RequestParam(name = "code") String userCode, @RequestParam String status) {
		HashMap<String, String> option = new HashMap<String, String>();
		option.put("userCode", userCode);
		option.put("admin", status);
		userService.updateUserAdmin(option);
		return "redirect:/admin/user";
	}
	
	@GetMapping("/phone")
	public String home(Model model, @RequestParam(name = "page", required = false, defaultValue = "1" ) int pageNo) {
		HashMap<String, Object> option = new HashMap<String, Object>();
		option.put("page", pageNo);
		// 기기전체의 목록 담기
		HashMap<String, Object> result = phoneService.getAllPhonesContainsRentalByPageAndOption(option);
		model.addAttribute("phones", result.get("phones"));
		model.addAttribute("pagination", result.get("pagination"));
		return "admin/phone";
	}
	
	
	@GetMapping("/inquiry")
	public String phoneManagement(@LoginAdmin User user, @RequestParam String code, @RequestParam String respond, RedirectAttributes rat) {
		HashMap<String, String> option = new  HashMap<String, String>();
		option.put("respond", respond);
		option.put("inquiryCode", code);
		adminService.respondInquiry(option);
		rat.addFlashAttribute("status", "inquiry");
		return "redirect:/admin/main";
	}
	
}
