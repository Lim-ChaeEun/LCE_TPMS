package com.lce.tpms.service;

import java.text.ParseException;
import java.util.Date;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.vo.Inquiry;
import com.lce.tpms.vo.Phone;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.User;
import com.lce.tpms.web.util.DateUtils;

@Service
@Transactional
public class EmailServiceImpl implements EmailService{
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public void sendEmail(String email, String subject, String content) {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			message.setFrom(new InternetAddress("lim0315lim@gmail.com", "TPMS", "UTF-8"));
			helper.setTo(email);
			helper.setSubject(subject);
			helper.setText(content);
			
			mailSender.send(message);
			
		}catch (Exception e) {
			System.out.println(e);
		}
	}

	@Override
	public void sendReserveEmail(User user) {
		String subject = "[TPMS] " + user.getName() + " 님 예약하신 기기의 반납이 완료되었습니다.";
		String content = "지금 TPMS사이트에서 대여신청이 가능합니다. 감사합니다. ";
		sendEmail(user.getEmail(), subject, content);
	}
	
	@Override
	public void sendReturnEmail(User user, String status) {
		String subject = "";
		String content = "";
		if(status.equals("normal")) {
			subject = "[TPMS] "+ user.getName() +" 님 반납이 완료되었습니다.";
			content = "반납이 정상적으로 완료되었습니다. 감사합니다. ";
		}else if(status.equals("delay")) {
			String dateString = DateUtils.dateToDateString(new Date());
			subject = "[TPMS] "+ user.getName() +" 님 반납완료되었습니다. + 연체관련 알림";
			content = "해당 기기의 반납이 정상적으로 완료되었지만, 대여건에 대해 연체가 발생하였으므로 " + System.lineSeparator() + dateString +" 이후 7일 후부터 대여가 가능합니다. ";		
		}
	
		sendEmail(user.getEmail(), subject, content);
	}
	
	@Override
	public void sendArroveEmail(User user, Phone phone) {
		String subject = "[TPMS] " + user.getName() + " 님 대여요청이 승인되셨습니다.";
		String content = "요청하신 " +phone.getModelName()+ " 기기에 대한 대여요청이 승인되었습니다. " + System.lineSeparator()+ System.lineSeparator() + "[기기 상세정보]"
				+ System.lineSeparator() + "기기명 : " +phone.getModelName()
				+ System.lineSeparator() + "제조사 : " +phone.getMaker()
				+ System.lineSeparator() + "운영체제 : " + phone.getOs() +" / "+ phone.getVersion()
				+ System.lineSeparator() + "맥주소 : " + phone.getMacAddress()
				+ System.lineSeparator() + "비밀번호 : " + phone.getPassword()
				+ System.lineSeparator() + "메모리 / 디스플레이 : " + phone.getMemory() +"GB / " +phone.getDisplay() + "인치";
		sendEmail(user.getEmail(), subject, content);
	} 
	
	@Override
	public void sendRejectEmail(User user, String phoneName) {
		String subject = "[TPMS] " + user.getName() + " 님 대여요청이 반려되었습니다.";
		String content = "요청하신 " +phoneName+ " 기기에 대한 대여요청이 반려되었습니다. " + System.lineSeparator()+ System.lineSeparator() + "문의사항이 있으시면 TPMS사이트 문의 탭에서 문의바랍니다.";
		sendEmail(user.getEmail(), subject, content);
	}
	
	@Override
	public void sendInquiryEmail(User user, Inquiry inquiry) {
		String subject = "[TPMS] " + user.getName() + " 님 문의답변이 완료되었습니다.";
		String inquiryDate = DateUtils.dateToDateString(inquiry.getCreatedDate());
		String content = user.getName() + " 님, 지난 " + inquiryDate + "일 문의하신 사항에 대한 답변이 완료되었습니다."+ System.lineSeparator()
				+ System.lineSeparator() + "답변내용 : " + inquiry.getRespond()+ System.lineSeparator()
				+ System.lineSeparator() + "자세한 사항은 홈페이지에서 확인하세요.";
		sendEmail(user.getEmail(), subject, content);
	}
	
	@Override
	public void sendOverDueEmail(User user, Phone phone, Rental rental) {
		try {
			// 연체일 구하기 (날짜로만 구하기 )
			String todayString = DateUtils.dateToDateString(new Date());
			Date today = DateUtils.stringToDate(todayString);
			long overDay = ((today.getTime() - rental.getEndDate().getTime()) / (1000*24*60*60));
			String subject = "[TPMS] " + user.getName() + " 님 연체관련 안내드립니다.";
			String endDateString = DateUtils.dateToDateString(rental.getEndDate());
			String content = "안녕하세요 " + user.getName() + " 님, "
				+ System.lineSeparator() + "대여하신 " +phone.getModelName() + " 기기가 "
				+ System.lineSeparator() + "예상반납일 " + endDateString + "보다 " +overDay+ "일 연체되었습니다."
				+ System.lineSeparator() + "빠른시일내로 반납 부탁드립니다.";
			sendEmail(user.getEmail(), subject, content);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void sendReturnScheduleEmail(User user, Phone phone, Rental rental) {
		try {
			// 남은 일 구하기 (날짜로만 구하기 )
			String todayString = DateUtils.dateToDateString(new Date());
			Date today = DateUtils.stringToDate(todayString);
			long remainDay = ((rental.getEndDate().getTime() - today.getTime() ) / (1000*24*60*60));
			String subject = "[TPMS] " + user.getName() + " 님 대여기기 반납관련 안내드립니다.";
			String endDateString = DateUtils.dateToDateString(rental.getEndDate());
			String content = "안녕하세요 " + user.getName() + " 님, "
				+ System.lineSeparator() + "대여하신 " +phone.getModelName() + " 기기가 "
				+ System.lineSeparator() + "반납일 " + endDateString + "까지 " +remainDay+ "일 남았습니다."
				+ System.lineSeparator() + "기간 내 반납 부탁드립니다.";
			sendEmail(user.getEmail(), subject, content);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}
