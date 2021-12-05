package com.lce.tpms.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Inquiry {
	
	private String code;
	private String userCode;
	private String title;
	private String content;
	private String respond;
	private String status;
	private Date respondDate;
	private Date createdDate;
	
}
