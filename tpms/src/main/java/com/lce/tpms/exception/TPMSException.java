package com.lce.tpms.exception;

// 사용자 정의 예외 클래스
public class TPMSException extends RuntimeException{

	/**
	 * 모든 Class는 UID를 가진다. Class의 내용이 변경되면 UID값 역시 바뀌게 된다.
	 * 직렬화하여 통신하고 UID값으로 통신이 정상인지 확인을 하는데 그 값이 바뀌면 다른 Class로 인식하게 됨
	 * 이를 방지하기 위해 고유값으로 미리 명시해 주는 부분이 serialVersionUID
	 * 한마디로 serialVersionUID는 값을 저장할 때 클래스 버전이 맞는지 확인하기 위한 용도입니다.
	 */
	private static final long serialVersionUID = 1729265064625909075L;

	private String title;
	
	public TPMSException(String title, String message) {
		super(message);
		this.title = title;
	}
	
	public String getTitle() {
		return title;
	}
	
}
