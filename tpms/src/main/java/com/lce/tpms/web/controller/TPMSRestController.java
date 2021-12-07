package com.lce.tpms.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@RestController
@RequestMapping("/rest")
public class TPMSRestController {
	
	@Autowired
	PhoneService phoneService;
	@Autowired
	UserService userService;

	@GetMapping("/islogin")
	public User isLogined() {
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		return user;
	}
	
	@GetMapping("/ableReserve")
	public boolean isAbleToReserve() {
		System.out.println("실행 ");
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		boolean result = userService.isAbleToReserve(user.getCode());
		return result;
	}
	
	@GetMapping("/getTeams")
	public List<String> getTeamsByDept(String dept){
		return userService.getAllTeamsByDept(dept);
	}
	
}
