package com.lce.tpms.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Rental {
	
	private String code;
	private String userCode;
	private String phoneCode;
	private Date startDate;
	private Date endDate;
	private Date giveDate;
	private String status;

}
