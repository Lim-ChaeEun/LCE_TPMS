package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.InquiryDao;
import com.lce.tpms.dao.RentalDao;
import com.lce.tpms.dao.ReservationDao;
import com.lce.tpms.dao.UserDao;
import com.lce.tpms.vo.Rental;
import com.lce.tpms.vo.Reservation;
import com.lce.tpms.vo.User;

@Service
@Transactional
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private InquiryDao inquiryDao;
	@Autowired
	private RentalDao rentalDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ReservationDao reservDao;
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Override
	public void updateRental(HashMap<String, String> option) {
		// 대여상태 변경  && 사용자 상태 변경 (반려일 경우 )
		HashMap<String, String> rentalParam = new HashMap<String, String>();
		HashMap<String, String> userParam = new HashMap<String, String>();
		String status = option.get("status");
		String rentalCode = option.get("rentalCode");
		Rental rental = rentalDao.getRentalByCode(rentalCode);
		// 대여상태 변경
		rentalParam.put("rentalCode", rentalCode);
		if("approve".equals(status)) {
			// 승인 
			rentalParam.put("status", "ING");
			rentalDao.updateRental(rentalParam);
		}else if("reject".equals(status)) {
			rentalParam.put("status", "REJ");
			userParam.put("status", "Y");
			userParam.put("userCode", rental.getUserCode());
			rentalDao.updateRental(rentalParam);
			userDao.updateUserStatus(userParam);
		}
		
	}
	
	@Override
	public void returnRental(HashMap<String, String> option) {
		String status = option.get("status");
		String rentalCode = option.get("rentalCode");
		Rental rental = rentalDao.getRentalByCode(rentalCode);
		// 이 기기를 예약한 사람 있는지 확인
		Reservation reserv = reservDao.getPhoneReserve(rental.getPhoneCode());
		if(reserv != null) {
			User user = userDao.getUserByCode(reserv.getUserCode());
			// 예약한 사람에게 이메일 보내기;
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				helper.setFrom("TPMS");
				helper.setTo(user.getEmail());
				helper.setSubject(user.getName()+"님 예약하신 기기의 반납이 완료되었습니다.");
				helper.setText("지금 TPMS사이트에서 대여신청이 가능합니다.");
				
				mailSender.send(message);
			} catch(Exception e){
				System.out.println(e);
			}
			reservDao.deleteReservation(reserv.getCode());
		}
		// 대여상태, 
		// 반납, 사용자 상태 번경, 연체처리, 예약한사람있으면 이메일보내기
		HashMap<String, String> rentalParam = new HashMap<String, String>();
		rentalParam.put("rentalCode", rentalCode);
		rentalParam.put("status", "FIN");
		HashMap<String, String> userParam = new HashMap<String, String>();
		userParam.put("userCode", rental.getUserCode());
		if("delay".equals(status)) {
			userParam.put("status", "Y");
		}else if("return".equals(status)) {
			userParam.put("status", "N");
		}
		rentalDao.updateRental(rentalParam);
		userDao.updateUserStatus(userParam);
		
	}

	@Override
	public void respondInquiry(HashMap<String, String> param) {
		inquiryDao.updateInquiry(param);
	}
	
	@Override
	public List<HashMap<String, Object>> getNoRespondInquiries() {
		return inquiryDao.getNoRespondInquiries();
	}
	
	@Override
	public List<HashMap<String, Object>> getWaitRentals() {
		return rentalDao.getWaitRentals();
	}
	
	@Override
	public List<HashMap<String, Object>> getOverdueRentals() {
		return rentalDao.getOverdueRentals();
	}
}
