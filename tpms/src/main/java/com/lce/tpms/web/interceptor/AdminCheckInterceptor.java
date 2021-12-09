package com.lce.tpms.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.MethodParameter;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.lce.tpms.vo.User;
import com.lce.tpms.web.annotation.LoginAdmin;
import com.lce.tpms.web.util.SessionUtils;


public class AdminCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		MethodParameter[] methodParameters = handlerMethod.getMethodParameters();
		
		// 매개변수에서 @LoginAdmin 어노테이션 존재여부 확인하기
		boolean hasLoginAdminAnnotation = false;
		for(MethodParameter param : methodParameters) {
			if(param.getParameterAnnotation(LoginAdmin.class)!= null) {
				hasLoginAdminAnnotation = true;
				break;
			}
		}
		
		// @LoginAdmin 어노테이션 있을때만 확인 
		// @LoginAdmin 어노테이션 있지만 session에 저장되어있는 사용자가 없는경우 -> 에러 
		if (hasLoginAdminAnnotation && SessionUtils.getAttribute("LOGINED_USER") == null) {
			String returnUri = request.getRequestURI();
			String returnParam = request.getQueryString();
			String uri = returnUri.replace("/tpms", "");
			SessionUtils.addAttribute("returnURI", uri);
			SessionUtils.addAttribute("returnParam", returnParam);
			response.sendRedirect("/tpms/login?error=admin");
			return false;
		}else if(hasLoginAdminAnnotation && SessionUtils.getAttribute("LOGINED_USER") != null){
			// @LoginAdmin 어노테이션이 있고 세션에 사용자도 있는경우
			// 세션에 있는 사용자의 admin여부가 Y인지 확인한다
			boolean isAdmin = false;
			User user = (User)(SessionUtils.getAttribute("LOGINED_USER"));
			if("Y".equals(user.getAdmin())) {
				isAdmin = true; 
			}
			// 어드민이 y가 아닌경우는 로그인폼 재요청
			if(hasLoginAdminAnnotation && !isAdmin) {
				String returnUri = request.getRequestURI();
				String returnParam = request.getQueryString();
				String uri = returnUri.replace("/tpms", "");
				SessionUtils.addAttribute("returnURI", uri);
				SessionUtils.addAttribute("returnParam", returnParam);
				response.sendRedirect("/tpms/home?error=admin");
				return false;
			}
		}
		
		return true;
	}
}
