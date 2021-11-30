package com.lce.tpms.web.util;


import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * HttpSession 객체 생상과 폐기, 속성값에 대한 CRUD 기능을 제공하는 클래스
 * @author lim03
 *
 */
public class SessionUtils {
	
	/*
	 * getSession(), getSession(true) -> HttpSession 존재하면 이를 반환하고 없을 시 세션 새로 생성하기
	 * getSession(false) -> HttpSession 존재하면 반환하고 존재하지 않으면 null을 반환
	 */
	
	/**
	 * 현재 서버로 요청보낸 사용자의 세션객체 반환하기
	 * @param create 
	 * @return 세션객체
	 */
	private static HttpSession getSession(boolean create) {
		ServletRequestAttributes attributes = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
		return attributes.getRequest().getSession(create);
	}
	
	/**
	 * 세션 객체에 속성을 추가하는 메소드
	 * @param name 속성명
	 * @param value 속성값, 속성객체
	 */
	public static void addAttribute(String name, Object value) {
		getSession(true).setAttribute(name, value);
	}
	
	/**
	 * 세션객체에 name이름으로 추가된 속성값 반환하기
	 * @param name
	 * @return
	 */
	public static Object getAttribute(String name) {
		return getSession(true).getAttribute(name);
	}
	
	/**
	 * 세션객체에서 지정된 이름의 속성을 삭제
	 * @param name 삭제하고 픈 속성명
	 */
	public static void removeAttribute(String name) {
		getSession(true).removeAttribute(name);
	}
	
	/**
	 * 세션객체 폐기
	 */
	public static void destorySession() {
		HttpSession session = getSession(false);
		if(session != null) {
			session.invalidate();
		}
	}
	
}
