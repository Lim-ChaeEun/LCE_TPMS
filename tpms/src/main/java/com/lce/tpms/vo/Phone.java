package com.lce.tpms.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Phone {
	
	private String code;
	private String modelName;
	private String maker;
	private String os;
	private String  version;
	private String macAddress;
	private String password;
	private int memory;
	private double display;

}
