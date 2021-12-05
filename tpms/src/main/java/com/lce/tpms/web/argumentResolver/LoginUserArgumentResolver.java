package com.lce.tpms.web.argumentResolver;

import java.util.Objects;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.lce.tpms.web.annotation.LoginUser;
import com.lce.tpms.web.util.SessionUtils;

public class LoginUserArgumentResolver implements HandlerMethodArgumentResolver{

	/*
	 HandlerMethodArgumentResolver : 컨트롤러에 메소드에서 특정조건에 맞는 파라미터가 있으면 원하는 값을 바인딩해주는 인터페이스
	 */
	
	/**
	 * 파라미터가 resolver에 의해 수행될 수 있는 타입인지 t/f 리턴
	 * 여기서 true를 리턴하면 resolveArgument메소드가 수행됨
	 */
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return Objects.nonNull(parameter.getParameterAnnotation(LoginUser.class));
	}
	
	/**
	 * resolveArgument는 실제로 파라미터와 바인딩을 할 객체를 리턴합니다.
	 * 
	 */
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		return SessionUtils.getAttribute("LOGINED_USER");
	}
	
}
