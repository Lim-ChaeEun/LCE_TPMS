 package com.lce.tpms.dao;

import java.util.HashMap;
import java.util.List;

import com.lce.tpms.vo.Inquiry;

public interface InquiryDao {
	
	void insertInquiry(Inquiry inquiry);
	
	List<Inquiry> getInquiriesByUser(String userCode);
	
	List<Inquiry> getUserRecentInquiry(String userCode);

	List<HashMap<String, Object>> getNoRespondInquiries();
	
	void updateInquiry(HashMap<String, String> param);
	
}
