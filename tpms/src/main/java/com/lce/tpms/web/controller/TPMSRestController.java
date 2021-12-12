package com.lce.tpms.web.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@RestController
@RequestMapping("/rest")
public class TPMSRestController {
	
	@Autowired
	private UserService userService;

	@GetMapping("/islogin")
	public User isLogined() {
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		return user;
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
