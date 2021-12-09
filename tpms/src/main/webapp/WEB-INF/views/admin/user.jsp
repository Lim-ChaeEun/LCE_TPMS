<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 회원관리</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<c:set var="menu" value="user"/>	
		<!-- 헤더 -->
		<%@ include file="../common/header.jsp" %>
		<!-- 메인 바디 -->
		<section id="main">
			<div class="container">
				<div class="row">
					<div class="col-12 rentalHisLine">
						<header class="major">
							<h2>회원목록</h2>
						</header>
						<div class="row">
							<div class="col-12 col-12-medium col-12-small">
								<section class="box">
									<c:choose>
										<c:when test="${empty users }">
											<p>사용자가 존재하지 않습니다.</p>
										</c:when>
										<c:otherwise>
											<table class="admin">
												<thead>
												<colgroup>
													<col width="10%"/>
													<col width="10%"/>
													<col width="25%"/>
													<col width="15%"/>
													<col width="15%"/>
													<col width="15%"/>
													<col width="10%"/>
												</colgroup>
												<tr class="head">
													<th scope="col">사번</th>
													<th scope="col">이름</th>
													<th scope="col">소속</th>
													<th scope="col">이메일</th>
													<th scope="col">휴대폰</th>
													<th scope="col">대여가능여부</th>
													<th scope="col">관리자</th>
												</tr>
												</thead>
												<tbody>
													<c:forEach var="user" items="${users }">
														<tr>
															<td>${user.code }</td>
															<td>${user.name }</td>
															<td>${user.team } / ${user.position }</td>
															<td>${user.email }</td>
															<td>${user.phone }</td>
															<c:choose>
																<c:when test="${user.status eq 'X'}">
																	<td class="strong danger">불가</td>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${user.status eq 'N'}">
																			<td class="strong">대여중</td>
																		</c:when>
																		<c:otherwise>
																			<td class="strong">가능</td>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
															<c:choose>
																<c:when test="${user.admin eq 'N'}">
																	<td><button class="alt">부여</button></td>
																</c:when>
																<c:otherwise>
																	<td><button class="alt">취소</button></td>
																</c:otherwise>
															</c:choose>
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