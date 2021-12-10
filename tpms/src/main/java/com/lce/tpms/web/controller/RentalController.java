package com.lce.tpms.web.controller;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.RentalService;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.Reservation;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.annotation.LoginUser;
import com.lce.tpms.web.util.DateUtils;

// 예약과 관련된 
@Controller
@RequestMapping("/rental")
public class RentalController {
	
	@Autowired
	private RentalService rentalService;
	
	@Autowired
	private PhoneService phoneService;

	@PostMapping("/apply")
	public String applyRental(String phoneCode, String startDate, String endDate, RedirectAttributes rat, @LoginUser User user) throws ParseException {
		// 대여신청 
		Rental rental = new Rental();
		rental.setPhoneCode(phoneCode);
		rental.setStartDate(DateUtils.stringToDate(startDate));
		rental.setEndDate(DateUtils.stringToDate(endDate));
		rental.setUserCode(user.getCode());
		rentalService.applyRental(rental, user.getCode());
		rat.addFlashAttribute("status", "rentalFin");
		return "redirect:/user/list";
	}
	
	@GetMapping("/apply")
	public String applyPage(@LoginUser User user, @RequestParam(name = "phone") String phoneCode , Model model) {
		model.addAttribute("user", user);
		model.addAttribute("phone", phoneService.getPhoneByCode(phoneCode));
		return "user/rental"; 
	}
	
	@GetMapping("/reservation")
	public String reserveRental(@LoginUser User user, String phone, RedirectAttributes rat) {
		Reservation reserve = new  Reservation();
		reserve.setUserCode(user.getCode());
		reserve.setPhoneCode(phone);
		rentalService.insertReservation(reserve);
		rat.addFlashAttribute("status", "reserveFin");
		return "redirect:/user/list";
	}

}
