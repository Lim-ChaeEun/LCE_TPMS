package com.lce.tpms.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Pagination {

	private int pageNo;				// 현재 페이지 번호
	private int totalRows;			// 조회된 총 행의 개수
	private int totalPages;			// 총 페이지 수
	private int totalPageBlocks;	// 총 페이지 블럭 수
	private int currentPageBlock;	// 현재 페이지에 해당하는 블럭
	private int beginPage;			// 시작 페이지 번호
	private int endPage;			// 끝 페이지 번호

}
