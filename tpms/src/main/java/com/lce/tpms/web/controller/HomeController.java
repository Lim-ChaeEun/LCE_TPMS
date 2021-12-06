package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lce.tpms.exception.LoginException;
import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.UserService;
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
	public String home(Model model, @RequestParam(name = "page", required = false, defaultValue = "1" ) int pageNo) {
		HashMap<String, Object> option = new HashMap<String, Object>();
		option.put("page", pageNo);
		// 기기전체의 목록 담기
		HashMap<String, Object> result = phoneService.getAllPhonesContainsRentalByPageAndOption(option);
		model.addAttribute("phones", result.get("phones"));
		model.addAttribute("pagination", result.get("pagination"));
		return "main";
	}
	
	@GetMapping("/register")
	public String registerForm() {
		return "register";
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
	public String logout(RedirectAttributes rat) {
		SessionUtils.destorySession();
		rat.addFlashAttribute("status", "logout");
		return "redirect:/main";
	}
	
}
