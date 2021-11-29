package com.lce.tpms.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.User;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;

	@GetMapping("/main")
	public String home(Model model) {
		List<User> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "main";
	}
}
