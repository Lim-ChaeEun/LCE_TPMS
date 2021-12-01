package com.lce.tpms.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@RestController
@RequestMapping("/user/rest")
public class UserRestController {

	@GetMapping("/islogin")
	public User isLogined() {
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		return user;
	}
	
}
