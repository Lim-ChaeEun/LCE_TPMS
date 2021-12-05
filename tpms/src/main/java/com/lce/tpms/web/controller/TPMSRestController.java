package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lce.tpms.service.PhoneService;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@RestController
@RequestMapping("/rest")
public class TPMSRestController {
	
	@Autowired
	PhoneService phoneService;

	@GetMapping("/islogin")
	public User isLogined() {
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		return user;
	}
	
	@GetMapping("/search")
	public List<HashMap<String, Object>> getPhoneListBySerachOption(String maker, String name){
		HashMap<String, String> option = new HashMap<String, String>();
		if(maker.equals("")) {
			option.put("maker", null);			
		}else {
			option.put("maker", maker);
		}
		if(name.equals("")) {
			option.put("name", null);			
		}else {
			option.put("name", name);
		}
		List<HashMap<String, Object>> phones = phoneService.getPhonesContainsRentalforOption(option);
		return phones;
	}

	
}
