<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<!-- 헤더 -->
		<%@ include file="../common/header.jsp" %>
		<!-- Banner -->
			<section id="banner">
				<header>
					<h2>원하는 기기를 찾아보세요.</h2>
					<input type="text" placeholder="기기명 검색" id="phone-search">
				</header>
			</section>
			<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">
						<div class="col-12 rentalHisLine">
							<div class="row">
								<div class="col-6 col-6-medium col-12-small">
									<section class="box rentalHis">
										<c:choose>
											<c:when test="${empty rental and empty waitRental and empty reserve}">
												<header>
													<h3>대여 / 예약</h3>
												</header>
												<p>현재 대여/ 예약중인 기기가 존재하지 않습니다.</p>
												<footer>
													<ul class="actions">
														<li><a href="list" class="button">대여하러가기</a></li>
													</ul>
												</footer>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${empty reserve }">
														<c:choose>
															<c:when test="${empty rental }">
																<header>
																	<h3>대여신청 중인 기기</h3>
																</header>
																<div class="rentalnow">
																<table>
																	<tr>
																		<th>기기</th>
																		<td>${waitRental.NAME }</td>
																		<th>제조사</th>
																		<td>${waitRental.MAKER }</td>
																	</tr>
																	<tr>
																		<th>운영체제</th>
																		<td>${waitRental.OS } ${waitRental.VERSION }</td>
																	</tr>
																	<tr>
																		<th>대여기간</th>
																		<td><fmt:formatDate value="${waitRental.STARTDATE }" pattern="MM/d"/> ~ <fmt:formatDate value="${waitRental.ENDDATE }" pattern="MM/d"/></td>
																	</tr>
																</table>
																</div>
																<footer>
																	<ul class="actions">
																		<li><a class="button" id="cancelRental" data-rental-code="${waitRental.CODE }">신청취소</a></li>
																	</ul>
																</footer>
															</c:when>
															<c:otherwise>
																<header>
																	<h3>대여중인 기기</h3>
																</header>
																<div class="rentalnow">
																<table>
																	<tr>
																		<th>기기</th>
																		<td>${rental.NAME }</td>
																		<th>제조사</th>
																		<td>${rental.MAKER }</td>
																	</tr>
																	<tr>
																		<th>운영체제</th>
																		<td>${rental.OS } ${rental.VERSION }</td>
																	</tr>
																	<tr>
																		<th>대여기간</th>
																		<td><fmt:formatDate value="${rental.STARTDATE }" pattern="MM/d"/> ~ <fmt:formatDate value="${rental.ENDDATE }" pattern="MM/d"/></td>
																		<th>잔여일수</th>
																		<c:choose>
																			<c:when test="${rental.REMAINDAY lt 0 }">
																				<td class="strong danger">연체됨</td>
																			</c:when>
																			<c:otherwise>
																				<td class="strong">${rental.REMAINDAY lt 0 } 일</td>
																			</c:otherwise>
																		</c:choose>
																	</tr>
																</table>
																</div>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<header>
															<h3>예약중인 기기</h3>
														</header>
														<table>
															<tr>
																<th>기기</th>
																<td>${reserve.NAME }</td>
																<th>제조사</th>
																<td>${reserve.MAKER }</td>
															</tr>
															<tr>
																<th>운영체제</th>
																<td>${reserve.OS } ${reserve.VERSION }</td>
															</tr>
															<tr>
																<th>예상 반납일</th>
																<td><fmt:formatDate value="${reservePhone.ENDDATE}" pattern="yyyy/MM/d"/></td>
															</tr>
														</table>
														<footer>
															<ul class="actions">
																<li><a class="button" id="cancelReserve" data-reserve-code="${reserve.CODE }">예약취소</a></li>
															</ul>
														</footer>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</section>
								</div>
								<div class="col-6 col-6-medium col-12-small">
									<section class="box rentalHis">
										<header>
											<h3>나의 최근 문의내역</h3>
										</header>
										<c:choose>
											<c:when test="${empty inquiries}">
												<p>등록한 문의가 존재하지 않습니다.</p>
													<footer>
														<ul class="actions">
															<li><a href="/tpms/user/inquiry" class="button alt">문의하러가기</a></li>
														</ul>
													</footer>
											</c:when>
											<c:otherwise>
												<table>
													<thead>
													<colgroup>
														<col width="50%"/>
														<col width="25%"/>
														<col width="25%"/>
													</colgroup>
													<tr>
														<th scope="col">제목</th>
														<th scope="col">답변여부</th>
														<th scope="col">등록일</th>
													</tr>
													</thead>
													<tbody>
														<c:forEach var="inquiry" items="${inquiries}" varStatus="loop">
															<tr id="${inquiry.code}">
																<td><strong>${inquiry.title}</strong></td>
																<c:choose>
																	<c:when test="${inquiry.status eq 'N'}">
																		<td class="bold">미답변</td>
																	</c:when>
																	<c:otherwise>
																		<td class="danger bold">답변완료</td>
																	</c:otherwise>
																</c:choose>
																<td><fmt:formatDate value="${inquiry.createdDate }" pattern="yy-MM-dd"/></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
												<footer>
													<ul class="actions">
														<li><a href="history/inquiry" class="button alt">내 문의내역</a></li>
													</ul>
												</footer>
											</c:otherwise>
										</c:choose>
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
	
	$('footer li').on('click', '#cancelReserve', function(){
		let reserveCode = $(this).data('reserve-code');
		if(confirm('예약을 취소하시겠습니까?')){
			location.href = "cancelReserve?code="+reserveCode;
			return;
		}
	})
	
	$('footer li').on('click', '#cancelRental', function(){
		let rentalCode = $(this).data('rental-code');
		if(confirm('대여신청을 취소하시겠습니까?')){
			location.href = "cancelRental?code="+rentalCode;
			return;
		}
	})

	
	let status = "<c:out value='${status}' />";
	if(status == 'register'){
		alert("회원가입이 완료되었습니다. 축하합니다!");
	}else if(status == "cancelReserve"){
		alert("예약이 취소되었습니다!");
	}else if(status == "cancelRental"){
		alert("대여신청이 취소되었습니다!");
	}
	
	$('#phone-search').on('keydown', function(e){
		if(e.keyCode == 13) {
			let name = $('#phone-search').val();
			console.log(name)
			location.href = "/tpms/user/list?name="+name;		
		}
	});
})
</script>
</body>
</html>