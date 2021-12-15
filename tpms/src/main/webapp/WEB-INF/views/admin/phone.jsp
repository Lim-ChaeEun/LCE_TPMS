<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 기기관리</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<c:set var="menu" value="phone"/>
		<!-- 헤더 -->
		<%@ include file="../common/header.jsp" %>
		<!-- 메인 바디 -->
		<section id="main">
			<div class="container">
				<div class="row">
					<div class="col-12 rentalHisLine">
						<header class="major">
							<h2>기기관리</h2>
						</header>
						<div class="row">
							<div class="col-12 col-12-medium col-12-small">
								<section class="box">
									<c:choose>
										<c:when test="${empty phones }">
											<p>등록된 기기가 존재하지 않습니다.</p>
										</c:when>
										<c:otherwise>
											<table class="admin" id="phone-list">
												<thead>
												<colgroup>
														<col width="3%"/>
														<col width="8%"/>
														<col width="15%"/>
														<col width="12%"/>
														<col width="20%"/>
														<col width="14%"/>
														<col width="10%"/>
														<col width="23%"/>
														<col width="10%"/>
													</colgroup>
												<tr class="head">
													<th scope="col"></th>
													<th scope="col">코드</th>
													<th scope="col">기기명</th>
													<th scope="col">대여현황</th>
													<th scope="col">대여자</th>
													<th scope="col" colspan="3" >대여정보</th>
													<th scope="col" class="center">상세</th>
												</tr>
												</thead>
												<tbody>
													<c:forEach var="phone" items="${phones }" varStatus="loop">
														<tr id="${phone.CODE }">
															<td class="center">${loop.count + ((pagination.pageNo-1)*10)}</td>
															<td>${phone.CODE }</td>
															<td>${phone.NAME }</td>
															<c:choose>
																	<c:when test="${empty phone.STATUS or phone.STATUS eq 'FIN' or phone.STATUS eq 'REJ'}">
																		<td class="bold">대여가능</td>				
																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>					
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${phone.STATUS eq 'WAIT' }">
																				<td class='bold danger'>승인대기중</td>		
																				<td>${phone.USERNAME } / ${phone.USERTEAM }</td>
																				<td colspan="2">신청일 : <fmt:formatDate value="${phone.STARTDATE }" pattern="yy-MM-dd"/> ~ <fmt:formatDate value="${phone.ENDDATE }" pattern="yy-MM-dd"/></td>
																				<td class="strong">
																					<button class="alt small">승인</button>
																					<button class="small">반려</button>
																				</td>					
																			</c:when>
																			<c:otherwise>
																				<td class='bold danger'>대여중</td>			
																				<td>${phone.USERNAME } / ${phone.USERTEAM }</td>
																				<td>반납 : <fmt:formatDate value="${phone.ENDDATE }" pattern="yy-MM-dd"/></td>
																				<td>잔여일 : ${phone.REMAINDAY }</td>
																				<td class="strong">
																					<button class="small">반납</button>
																					<button class="alt small">알림</button>
																				</td>					
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															<td class="strong">
																<button class="makeBtn small">상세</button>
															</td>
														</tr>
														<tr class="hide" style="display:none "  id="${phone.CODE }">
															<td colspan="1"></td>
															<td colspan="2">제조사 : ${phone.MAKER } </td>
															<td colspan="3">운영체제 : ${phone.OS }  ${phone.VERSION }</td>
															<td colspan="3">디스플레이 : ${phone.DISPLAY } 인치</td>
														</tr>
														<tr class="hide" style="display:none "  id="${phone.CODE }">
															<td colspan="1"></td>
															<td colspan="2">메모리 : ${phone.MEMORY } GB</td>
															<td colspan="3">비밀번호 : ${phone.PASSWORD }</td>
															<td colspan="3">맥주소 : ${phone.MACADDRESS }</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</c:otherwise>
									</c:choose>
									<!-- 페이징 -->
									<c:if test="${pagination.totalRows gt 0 }">
										<!-- url 설정하기  -->
										<c:set var="url" value="phone?page=" />
										<div class="page">
											<ul class="pagination modal">
												<c:choose>
													<c:when test="${pagination.pageNo le 1 }">
														<li><a class="first">이전</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="${url }${pagination.pageNo - 1 }" class="first">이전</a></li>
													</c:otherwise>
												</c:choose>
												<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
													<li><a href="${url }${num }" class="${pagination.pageNo eq num ? 'active' : ''} num">${num }</a></li>
												</c:forEach>
												<c:choose>
													<c:when test="${pagination.pageNo ge pagination.totalPages }">
														<li><a class="last">다음</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="${url }${pagination.pageNo + 1 }" class="last">다음</a></li>
													</c:otherwise>
												</c:choose>
											</ul>
										</div>
									</c:if>
								</section>
							</div> 
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- 푸터 -->
		<%@ include file="../common/footer.jsp" %>
	</div>

<!-- Scripts -->
<script src="/tpms/resources/static/assets/js/jquery.min.js"></script>
<script src="/tpms/resources/static/assets/js/jquery.dropotron.min.js"></script>
<script src="/tpms/resources/static/assets/js/browser.min.js"></script>
<script src="/tpms/resources/static/assets/js/breakpoints.min.js"></script>
<script src="/tpms/resources/static/assets/js/util.js"></script>
<script src="/tpms/resources/static/assets/js/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function(){

	$('#phone-list td').on('click', '.makeBtn', function(){
		let phoneCode = $(this).closest('tr').attr('id');
		let phoneContent = $(this).closest('tr').next('tr:eq(0)');
		
		if(phoneContent.css('display') == 'none'){
			$('.hide').css('display', 'none');
			if($('#'+phoneCode+'.hide')){
				$('#'+phoneCode+'.hide').css('display', '');
			}
		} else{
			if($('#'+phoneCode+'.hide')){
				$('#'+phoneCode+'.hide').css('display', 'none');
			}			
		}
	})

})
</script>
</body>
</html>