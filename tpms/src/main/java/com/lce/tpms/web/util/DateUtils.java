package com.lce.tpms.web.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

// 날짜와 문자열간의 변경 지원하는 메소드 
public class DateUtils {
	
	// 일반 날짜데이터 
	private static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	// 자바스크립트 날짜 데이터 
	private static SimpleDateFormat DATE_TIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
	// sql 날짜데이터 
	private static SimpleDateFormat SQL_TIME_FORMAT = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

	public static Date stringToDate(String dateString) throws ParseException {
		return DATE_FORMAT.parse(dateString);
	}
	
	public static Date stringToDateTime(String dateTimeString) throws ParseException {
		return DATE_TIME_FORMAT.parse(dateTimeString);
	}
	
	public static Date stringToSQLDate(String sqlDateString) throws ParseException {
		return SQL_TIME_FORMAT.parse(sqlDateString);
	}
	
	public static String dateToDateString(Date date) {
		return DATE_FORMAT.format(date);
	}
	
	public static String dateToDateTimeString(Date dateTime) {
		return DATE_TIME_FORMAT.format(dateTime);
	}
	
	public static String dateToSqlDateString(Date sqlDate) {
		return SQL_TIME_FORMAT.format(sqlDate);
	}
}
