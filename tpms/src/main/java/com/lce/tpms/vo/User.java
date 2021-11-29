package com.lce.tpms.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class User {

	private String code;
	private String password;
	private String name;
	private String email;
	private String phone;
	private String team;
	private String position;
	private String admin;
	
}
