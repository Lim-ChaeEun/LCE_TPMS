package com.lce.tpms.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Rental {
	
	private String code;
	private String userCode;
	private String phoneCode;
	private Date startDate;
	private Date endDate;
	private Date giveDate;
	private String give;

}
