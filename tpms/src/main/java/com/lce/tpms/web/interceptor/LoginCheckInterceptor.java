package com.lce.tpms.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.MethodParameter;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.lce.tpms.web.annotation.LoginUser;
import com.lce.tpms.web.util.SessionUtils;

public class LoginCheckInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		MethodParameter[] methodParameters = handlerMethod.getMethodParameters();
		
		boolean hasLoginUserAnnotation = false;
		// 하나씩 보면서 로그인 어노테이션 있나 확인
		for (MethodParameter parameter : methodParameters) {
			if (parameter.getParameterAnnotation(LoginUser.class) != null) {
				hasLoginUserAnnotation = true;
				break;
			}
		}
		// 어노테이션이 있는데 로그인되어있지 않는 경우
		if (hasLoginUserAnnotation && SessionUtils.getAttribute("LOGINED_USER") == null) {
			// 이전에 접속해있던 정보 세션에 저장하고 이동하기
			String returnUri = request.getRequestURI();
			String returnParam = request.getQueryString();
			String uri = returnUri.replace("/tpms", "");
			SessionUtils.addAttribute("returnURI", uri);
			SessionUtils.addAttribute("returnParam", returnParam);
			response.sendRedirect("/tpms/login?error=deny");	
			return false;
		}
		return true;
	}
	
}
