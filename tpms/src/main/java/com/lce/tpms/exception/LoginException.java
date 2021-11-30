package com.lce.tpms.exception;

public class LoginException extends TPMSException{

	private static final long serialVersionUID = 4974093465412897951L;

	public LoginException(String title, String message) {
		super(title, message);
	}
	
}
