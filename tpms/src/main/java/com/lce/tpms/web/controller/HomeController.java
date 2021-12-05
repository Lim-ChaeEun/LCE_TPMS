package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.lce.tpms.exception.LoginException;
import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private PhoneService phoneService;
	
	@ExceptionHandler(LoginException.class)
	public String handlerLoginException(LoginException ex, Model model) {
		ex.printStackTrace();
		model.addAttribute("error", ex);
		return "loginForm";
	}

	@GetMapping("/main")
	public String home(Model model) {
		// 기기전체의 목록 담기
		List<HashMap<String, Object>> phones = phoneService.getAllPhonesContainsRental();
		model.addAttribute("phones", phones);
		return "main";
	}
	
	/**
	 * 로그인 폼 보여줌
	 * @return
	 */
	@GetMapping("/login")
	public String loginForm() {
		return "loginForm";
	}
	
	/**
	 * 로그인 수행
	 * @return 메인페이지
	 */
	@PostMapping("/login")
	public String login(String code, String password) {
		userService.login(code, password);
		
		// 로그인 전 페이지가 있으면 되돌아가기
		String returnURI = (String)SessionUtils.getAttribute("returnURI");
		String returnParam = (String)SessionUtils.getAttribute("returnParam");
		if(returnURI != null && returnParam != null) {		// 둘다 존재하는 경우
			return "redirect:" + returnURI + "?" + returnParam;
		}else if(returnURI != null && returnParam == null){
			return "redirect:" + returnURI;
		}
		
		return "redirect:/main";
	}
	
	/**
	 * 로그아웃 실행
	 * @return
	 */
	@GetMapping("/logout")
	public String logout() {
		SessionUtils.destorySession();
		return "redirect:/main";
	}
	
}
