package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lce.tpms.dao.PhoneDao;
import com.lce.tpms.vo.Pagination;
import com.lce.tpms.vo.Phone;

@Service
@Transactional
public class PhoneServiceImpl implements PhoneService{
	
	private static final int ROWS_PER_PAGE = 10;
	private static final int PAGE_PER_PAGE_BLOCK = 5;

	@Autowired
	private PhoneDao phoneDao;
	
	/**
	 * 모든 기기정보 반환하는 메소드 
	 */
	@Override
	public List<Phone> getAllPhons() {
		return phoneDao.getAllPhones();
	}
	
	@Override
	public List<String> getPhoneMakers() {
		return phoneDao.getPhoneMakers();
	}
	
	/**
	 * 기기정보 + 대여정보 함께 반환하는 메소드 
	 */
	@Override
	public HashMap<String, Object> getAllPhonesContainsRentalByPageAndOption(HashMap<String, Object> option) {
		int pageNo = (Integer)option.get("page");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("beginIndex", (pageNo-1)*ROWS_PER_PAGE + 1);
		param.put("endIndex", pageNo*ROWS_PER_PAGE);
		if(option.get("maker") != null) {
			String maker = (String)option.get("maker");
			param.put("maker", maker);
		}
		if(option.get("name") != null) {
			String name = (String)option.get("name");
			param.put("name", name);			
		}
		List<HashMap<String, Object>> phones = phoneDao.getAllPhonesContainsRentalByPageAndOption(param);
		// 페이징 처리
		// 총 행의 갯수
		int totalRows = phoneDao.getPhonesCntByOption(param);
		// 총 페이지 수
		int totalPages = (int)Math.ceil((double)totalRows/ROWS_PER_PAGE);
		// 총 페이지 블럭 수
		int totalBlocks = (int)Math.ceil((double)totalPages/PAGE_PER_PAGE_BLOCK);
		// 요청한 페이지 번호가 속하는 블럭
		int currentBlock = (int)Math.ceil((double)pageNo/PAGE_PER_PAGE_BLOCK);
		// 현재 블럭의 시작과 끝
		int beginPage = (currentBlock-1)*PAGE_PER_PAGE_BLOCK + 1;
		int endPage = (currentBlock)*PAGE_PER_PAGE_BLOCK;
		// 만약 현재 블럭이 마지막 블럭이면 
		if(currentBlock == totalBlocks) {
			endPage = totalPages;
		}
		// 페이지네이션 객체 생성
		Pagination pagination = new Pagination(pageNo, totalRows, totalPages, totalBlocks, currentBlock, beginPage, endPage);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("phones", phones);
		result.put("pagination", pagination);
		return result;
	}
	
	@Override
	public Phone getPhoneByCode(String phoneCode) {
		return phoneDao.getPhoneByCode(phoneCode);
	}
}
