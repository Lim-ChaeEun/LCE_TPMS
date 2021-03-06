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

import com.lce.tpms.service.RentalService;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.annotation.LoginUser;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private RentalService rentalService;
	
	@GetMapping("/inquiry")
	public String inqueryPage(@LoginUser User user) {
		return "user/inquiry";
	}
	
	@GetMapping("/history/rental")
	public String userRentalHistory(@LoginUser User user, Model model) {
		List<HashMap<String, Object>> rentalHis = rentalService.getFinRentalsByUser(user.getCode());
		model.addAttribute("rentals", rentalHis);
		return "user/rentalHistory";
	}
	
	@GetMapping("/history/inquiry")
	public String userInquiryHistory(@LoginUser User user, Model model) {
		List<Inquiry> inquiries = userService.getInquiriesByUser(user.getCode());
		model.addAttribute("user", user);
		model.addAttribute("inquiries", inquiries);
		return "user/inquiryHistory";
	}
	
	@GetMapping("/cancelRental")
	public String cancelRental(@LoginUser User user, @RequestParam(name="code") String rentalCode,  RedirectAttributes rat) {
		rentalService.cancelRental(rentalCode, user.getCode());
		rat.addFlashAttribute("status", "cancelRental");
		return "redirect:/user/main";
	}
	
	@GetMapping("/cancelReserve")
	public String cancelReserve(@LoginUser User user, @RequestParam(name="code") String reserveCode, RedirectAttributes rat) {
		userService.cancelReserve(reserveCode, user.getCode());
		rat.addFlashAttribute("status", "cancelReserve");
		return "redirect:/user/main";
	}
	
	
	@PostMapping("/inquiry/register")
	private String inqueryRegister(@LoginUser User user, String title, String content, RedirectAttributes rat) {
		Inquiry inquiry = new Inquiry();
		inquiry.setTitle(title);
		inquiry.setContent(content);
		inquiry.setUserCode(user.getCode());
		userService.registerInquiry(inquiry);
		rat.addFlashAttribute("status", "inquiryFin");
		return "redirect:/user/inquiry";
	}

}
