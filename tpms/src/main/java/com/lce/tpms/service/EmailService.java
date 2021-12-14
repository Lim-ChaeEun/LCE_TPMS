package com.lce.tpms.service;

import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.Phone;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.User;

public interface EmailService {
	
	void sendEmail(String email, String subject, String content);

	void sendReserveEmail(User user);
	
	void sendReturnEmail(User user, String status);
	
	void sendArroveEmail(User user, Phone phone);
	
	void sendRejectEmail(User user, String phoneName);
	
	void sendOverDueEmail(User user, Phone phone, Rental rental);
	
	void sendReturnScheduleEmail(User user, Phone phone, Rental rental);
	
	void sendInquiryEmail(User user, Inquiry inquiry);
}
