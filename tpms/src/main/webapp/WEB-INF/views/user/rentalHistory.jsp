<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 내 대여이력</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<!-- 헤더 -->
		<c:set var="menu" value="my"/>
		<%@ include file="../common/header.jsp" %>
			<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">	
						<div class="col-12">
							<section>
								<header class="major">
									<h2>나의 대여이력</h2>
								</header>
								<div class="row">
									<div class="col-12">
									<div class="table-box">
										<table class="table table--min" id="rental-table">
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
																<td class="center">${loop.count}</td>
																<td class="center"><p class="bold">${rental.NAME }</p></td>
																<td class="center">${rental.MAKER }</td>
																<td class="center">${rental.OS } ${rental.VERSION }</td>
																<td class="center"><p class="bold"><fmt:formatDate value="${rental.STARTDATE }" pattern="yy/MM/d"/> ~ <fmt:formatDate value="${rental.ENDDATE }" pattern="yy/MM/d"/></p></td>
																<c:choose>
																	<c:when test="${rental.STATUS eq 'REJ' }">
																		<td class="center"><p class="strong danger">반려됨</p></td>																
																	</c:when>
																	<c:otherwise>
																		<td class="center"><p class="bold"><fmt:formatDate value="${rental.GIVEDATE }" pattern="yy/MM/d"/></p></td>																
																	</c:otherwise>
																</c:choose>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
										</div>
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