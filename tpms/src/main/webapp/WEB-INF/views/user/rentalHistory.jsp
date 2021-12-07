<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<!-- 헤더 -->
		<c:set var="menu" value="my"/>
		<%@ include file="../common/userHeader.jsp" %>
			<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">
						<div class="col-12 rentalHisLine">
							<div class="row">
								<div class="col-6 col-6-medium col-12-small">
									<section class="box rentalHis">
										<header>
											<h3>대여신청한 기기</h3>
										</header>
										<c:choose>
											<c:when test="${empty waitRental}">
												<p>현재 승인대기중인 기기가 존재하지 않습니다.</p>
													<footer>
														<ul class="actions">
															<li><a href="#" class="button alt">문의하러가기</a></li>
														</ul>
													</footer>
											</c:when>
											<c:otherwise>
												<p>기기: ${waitRental.NAME }</p>
												<p>제조사: ${waitRental.MAKER }</p>
												<p>운영체제: ${waitRental.OS }</p>
											</c:otherwise>
										</c:choose>
									</section>
								</div>
								<div class="col-6 col-6-medium col-12-small">
									<section class="box rentalHis">
										<header>
											<h3>대여중인 기기</h3>
										</header>
										<c:choose>
											<c:when test="${empty nowRental}">
												<p>현재 대여중인 기기가 존재하지 않습니다.</p>
												<footer>
													<ul class="actions">
														<li><a href="#" class="button alt">대여하러가기</a></li>
													</ul>
												</footer>
											</c:when>
											<c:otherwise>
												<p><strong>기기:  </strong> ${nowRental.NAME } (${nowRental.MAKER })</p>
												<p><strong>운영체제: </strong> ${nowRental.OS } ${nowRental.VERSION }</p>
											</c:otherwise>
										</c:choose>
									</section>
								</div>
							</div>						
						</div>
					</div>
					<div class="row">	
						<div class="col-12">
							<section>
								<header class="major">
									<h2>나의 대여이력</h2>
								</header>
								<div class="row">
									<div class="col-12">
										<table class="table" id="rental-table">
											<thead>
												<colgroup>
													<col width="10%"/>
													<col width="20%"/>
													<col width="12%"/>
													<col width="20%"/>
													<col width="25%"/>
													<col width="13%"/>
												</colgroup>
												<tr>
													<th scope="col">순번 </th>
													<th scope="col">대여기기 </th>
													<th scope="col">제조사 </th>
													<th scope="col">운영체제 / 버전 </th>
													<th scope="col">대여일자</th>
													<th scope="col">반납일 </th>
												</tr>
											</thead>
											<tbody id="phone-list">
												<c:choose>
													<c:when test="${empty rentals}">
														<tr>
															<td colspan="6"><p class="bold center">대여내역이 존재하지 않습니다.</p></td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="rental" items="${rentals }" varStatus="loop">
															<tr>
																<td>${loop.count}</td>
																<td><p class="bold">${rental.NAME }</p></td>
																<td>${rental.MAKER }</td>
																<td>${rental.OS } ${rental.VERSION }</td>
																<td><p class="bold"><fmt:formatDate value="${rental.STARTDATE }" pattern="yy-MM-d"/> ~ <fmt:formatDate value="${rental.ENDDATE }" pattern="yy-MM-d"/></p></td>
																<td><p class="bold"><fmt:formatDate value="${rental.GIVEDATE }" pattern="yy-MM-d"/></p></td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
									</div>
								</div>
							</section>
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

</script>
</body>
</html>