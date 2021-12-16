package com.lce.tpms.web.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lce.tpms.exception.LoginException;
import com.lce.tpms.service.PhoneService;
import com.lce.tpms.service.UserService;
import com.lce.tpms.vo.User;
import com.lce.tpms.vo.UserDto;
import com.lce.tpms.web.annotation.LoginUser;
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
		return "home";
	}
	
	@GetMapping("/error")
	public String errorPage() {
		return "common/400error";
	}

	@GetMapping("/user/list")
	public String home(Model model,@RequestParam(name = "maker", required = false) String maker, @RequestParam(name = "name", required = false) String name,  @RequestParam(name = "page", required = false, defaultValue = "1" ) int pageNo) {
		HashMap<String, Object> option = new HashMap<String, Object>();
		if(maker == null || maker.equals("")) {
			option.put("maker", null);			
		}else {
			option.put("maker", maker);
		}
		if(name == null || name.equals("")) {
			option.put("name", null);			
		}else {
			option.put("name", name.trim());
		}
		option.put("page", pageNo);
		// 기기전체의 목록 담기
		HashMap<String, Object> result = phoneService.getAllPhonesContainsRentalByPageAndOption(option);
		model.addAttribute("phones", result.get("phones"));
		model.addAttribute("pagination", result.get("pagination"));
		model.addAttribute("maker", maker);
		model.addAttribute("name", name);
		// 제조사정보
		List<String> makers = phoneService.getPhoneMakers();
		model.addAttribute("makers", makers);
		return "user/list";
	}
	
	@GetMapping("/register")
	public String registerForm() {
		return "register";
	}
	
	
	@PostMapping("/register")
	public String register(UserDto user, RedirectAttributes rat) {
		User newUser = userService.registerUser(user);
		SessionUtils.addAttribute("LOGINED_USER", newUser);
		rat.addFlashAttribute("status", "register");
		return "redirect:/user/main";
	}
	
	/**
	 * 로그인 수행
	 * @return 메인페이지
	 */
	@PostMapping("/login")
	public String login(String code, String password) {
		User user = userService.login(code, password);
		
		// 로그인 전 페이지가 있으면 되돌아가기
		String returnURI = (String)SessionUtils.getAttribute("returnURI");
		String returnParam = (String)SessionUtils.getAttribute("returnParam");
		if(returnURI != null && returnParam != null) {		// 둘다 존재하는 경우
			return "redirect:" + returnURI + "?" + returnParam;
		}else if(returnURI != null && returnParam == null){
			return "redirect:" + returnURI;
		}
		
		if(user.getAdmin().equals("Y")) {
			return "redirect:/admin/main";
		}else {
			return "redirect:/user/main";
		}
	}
	
	@GetMapping("/user/main")
	public String userMain(@LoginUser User user, Model model) {
		// 최근문의내역, 예약정보들을 받아온다
		HashMap<String, Object> userInfo = userService.getUserMainInfo(user.getCode());
		model.addAttribute("inquiries", userInfo.get("inquiries"));
		model.addAttribute("rental", userInfo.get("rental"));
		model.addAttribute("waitRental", userInfo.get("waitRental"));
		model.addAttribute("reserve", userInfo.get("reserve"));
		model.addAttribute("reservePhone", userInfo.get("reservePhone"));
		return "user/main";
	}
	
	/**
	 * 로그아웃 실행
	 * @return
	 */
	@GetMapping("/logout")
	public String logout(RedirectAttributes rat) {
		SessionUtils.destorySession();
		rat.addFlashAttribute("status", "logout");
		return "redirect:/home";
	}
	
	@GetMapping(value = {"/home", "/login", ""})
	public String home() {
		// 로그인 되어있다면 로그아웃 시키기
		User user = (User)SessionUtils.getAttribute("LOGINED_USER");
		if(user != null) {
			SessionUtils.destorySession();
		}
		return "home";
	}
	
}
