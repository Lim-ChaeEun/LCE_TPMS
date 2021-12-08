<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 관리자</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<c:set var="menu" value="approval"/>
		<!-- 헤더 -->
		<%@ include file="../common/header.jsp" %>
		<!-- 메인 바디 -->
		<section id="main">
			<div class="container">
				<div class="row">
					<div class="col-12 rentalHisLine">
							<div class="row">
								<div class="col-12 col-12-medium col-12-small">
									<section class="box">
										<header>
											<h3>승인대기 목록</h3>
										</header>
										<c:choose>
											<c:when test="${empty rentals }">
												<p>대기중인 대여신청이 없습니다.</p>
											</c:when>
											<c:otherwise>
												<table class="admin">
													<thead>
													<colgroup>
														<col width="8%"/>
														<col width="20%"/>
														<col width="12%"/>
														<col width="20%"/>
														<col width="25%"/>
														<col width="15%"/>
													</colgroup>
													<tr class="head">
														<th scope="col">순번</th>
														<th scope="col">기기명</th>
														<th scope="col">제조사</th>
														<th scope="col">대여기간</th>
														<th scope="col">신청자</th>
														<th scope="col">승인</th>
													</tr>
													</thead>
													<tbody>
														<c:forEach var="rental" items="${rentals }" varStatus="loop">
															<tr>
																<td>${loop.count }</td>
																<td>${rental.PHONENAME }</td>
																<td>${rental.PHONEMAKER }</td>
																<td><fmt:formatDate value="${rental.STARTDATE }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${rental.ENDDATE }" pattern="yyyy-MM-dd"/></td>
																<td>${rental.USERNAME } / ${rental.USERTEAM } (${rental.USERPOSITION })</td>
																<td>
																	<button>승인</button>
																	<button class="alt">반려</button>
																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</c:otherwise>
										</c:choose>
									</section>
								</div>
								<div class="col-12 col-12-medium col-12-small">
									<section class="box">
										<header>
											<h3>미답변 문의 목록</h3>
										</header>
										<c:choose>
											<c:when test="${empty inquiries }">
												<p>답변하지 않은 문의가 없습니다.</p>
											</c:when>
											<c:otherwise>
												<table class="admin">
													<thead>
													<colgroup>
														<col width="8%"/>
														<col width="20%"/>
														<col width="52%"/>
														<col width="10%"/>
														<col width="10%"/>
													</colgroup>
													<tr class="head">
														<th scope="col">순번</th>
														<th scope="col">문의제목</th>
														<th scope="col">문의내용</th>
														<th scope="col">등록일</th>
														<th scope="col">답변</th>
													</tr>
													</thead>
													<tbody>
														<c:forEach var="inquiry" items="${inquiries }" varStatus="loop">
															<tr>
																<td>${loop.count }</td>
																<td>${inquiry.TITLE }</td>
																<td>${inquiry.CONTENT }</td>
																<td><fmt:formatDate value="${inquiry.CREATEDDATE }" pattern="yyyy-MM-dd"/></td>
																<td><button class="alt">답변</button></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
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

</script>
</body>
</html>