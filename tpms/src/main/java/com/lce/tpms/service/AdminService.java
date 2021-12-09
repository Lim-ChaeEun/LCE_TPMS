package com.lce.tpms.service;

import java.util.HashMap;
import java.util.List;

public interface AdminService {
	
	List<HashMap<String, Object>> getNoRespondInquiries();

	List<HashMap<String, Object>> getWaitRentals();
	
	List<HashMap<String, Object>> getOverdueRentals();
}
