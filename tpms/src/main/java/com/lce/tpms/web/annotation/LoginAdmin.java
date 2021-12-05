package com.lce.tpms.web.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.PARAMETER)
public @interface LoginAdmin {
	
	/*
	 * @Retention(RetentionPolicy.RUNTIME)
	 * -> 어노테이션 유지정책
	 * -> RUNTIME이므로 런타임 시에 해당 어노테이션의 정보를 얻을 수 있습니다.
	 * 
	 * @Target(ElementType.PARAMETER) : 이 어노테이션이 생성되는 위치
	 * -> ElementType.PARAMETER로 지정했으므로 메소드의 파라미터로 선언된 객체에서만 사용가능
	 */

}
