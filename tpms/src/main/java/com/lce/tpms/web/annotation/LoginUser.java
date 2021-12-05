package com.lce.tpms.web.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.PARAMETER)
public @interface LoginUser {
	/*
	 로그인이 되어있는지 사전에 체크해주려고 만든 커스텀 어노테이션
	 @Retention : 어노테이션이 실제 적용되고 유지되는 범위
	 @Retention의 속성으로 RetentionPolicy -> source, class, runtime 가 올 수 있음
	 	RetentionPolicy.SOURCE : 소스 코드(.java)까지 남아있는다.
		RetentionPolicy.CLASS : 클래스 파일(.class)까지 남아있는다.
		RetentionPolicy.RUNTIME : 런타임까지 남아있는다.(=사실상 안 사라진다.)
	
	@Target : 자바컴파일러가 어노테이션이 어디 적용될 지 결정
		ElementType.TYPE : 타입 선언
		ElementType.CONSTRUCTOR : 생성자 선언
		ElementType.FIELD : 멤버 변수 선언
		ElementType.METHOD : 메서드 선언
		ElementType.PARAMETER : 파라미터 선언
		...

	나는 로그인어노테이션이 런타임까지 남아있어야 하고 파라미터에 선언할것이므로
	@Retention(RetentionPolicy.RUNTIME)
	@Target(ElementType.PARAMETER)
	로 작성
	
	 */
}
