package com.lce.tpms.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lce.tpms.exception.LoginException;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.SessionUtils;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	
	@ExceptionHandler(LoginException.class)
	public String handlerLoginException(LoginException ex, Model model) {
		ex.printStackTrace();
		model.addAttribute("error", ex);
		return "login";
	}

	@GetMapping("/main")
	public String home(Model model) {
		List<User> users = userService.getAllUser();
		model.addAttribute("users", users);
		return "main";
	}
	
	/**
	 * 로그인 폼 보여줌
	 * @return
	 */
	@GetMapping("/login")
	public String loginForm() {
		return "login";
	}
	
	/**
	 * 로그인 수행
	 * @return 메인페이지
	 */
	@PostMapping("/login")
	public String login(String code, String password) {
		userService.login(code, password);
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
