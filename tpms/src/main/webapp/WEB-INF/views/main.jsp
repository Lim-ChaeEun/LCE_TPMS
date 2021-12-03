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
		<!-- 헤더 시작 -->
			<section id="header">
				<!-- TPMS 로고 넣기 -->
				<h1>
					<a class="navbar-brand" href="/tpms/main">
    					<img src="/tpms/resources/static/images/tpms_logo1.png" class="mx-3" alt="error" width="200" height="60" >
    				</a>
    			</h1>
				<!-- 네비바 -->
				<nav id="nav">
					<ul>
						<li class="current"><a href="/tpms/main">대여</a></li>
						<li><a href="#">문의</a></li>
						<li>
							<c:choose>
						  		<c:when test="${empty LOGINED_USER }">
									<a href="/tpms/login">로그인</a>
						  		</c:when>
						  		<c:otherwise>
									<a>${LOGINED_USER.name} 님</a>
									<ul>
										<li><a href="#">내 대여이력 확인</a></li>
										<li><a href="/tpms/logout">로그아웃</a></li>
									</ul>
						  		</c:otherwise>
						  	</c:choose>
						</li>
					</ul>
				</nav>
			</section>
		<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">
						<div class="col-12">
							<!-- 기기리스트 -->
								<section>
									<header class="major">
										<h2>기기 리스트</h2>
									</header>
									<div class="row">
										<div class="col-6">
										</div>
										<div class="col-6">
											<label>제조사 </label>
											<select name="maker" class="select">
												<option>삼성 </option>
												<option>샤오미</option>
												<option>애플 </option>
												<option>엘지</option>
											</select>
											<label>모델명</label>  
											<input type="text" placeholder="Username" >
											<button class="btn">검색</button>
										</div>
									</div>
									<div class="row">
										<div class="col-12">
											<table class="table table-hover text-center mt-2">
												<thead>
													<colgroup>
														<col width="10%"/>
														<col width="*%"/>
														<col width="10%"/>
														<col width="15%"/>
														<col width="10%"/>
														<col width="10%"/>
														<col width="10%"/>
														<col width="12%"/>
														<col width="6%"/>
													</colgroup>
													<tr>
														<th scope="col">순번 </th>
														<th scope="col">모델명 </th>
														<th scope="col">제조사 </th>
														<th scope="col">운영체제 / 버전 </th>
														<th scope="col">메모리 </th>
														<th scope="col">디스플레이 </th>
														<th scope="col">대여  </th>
														<th scope="col">예상 반납일</th>
														<th scope="col"></th>
													</tr>
												</thead>
												<tbody id="phone-list">
													<c:choose>
														<c:when test="${empty phones }">
															<tr>
																<td colspan="8">대여가능한 기기가 존재하지 않습니다.</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach var="phone" items="${phones}" varStatus="loop">
																<tr id="${phone.CODE}">
																	<td>${loop.count }</td>
																	<td><strong>${phone.NAME }</strong></td>
																	<td>${phone.MAKER }</td>
																	<td>${phone.OS }  ${phone.VERSION }</td>
																	<td>${phone.MEMORY } GB </td>
																	<td>${phone.DISPLAY } 인치 </td>
																	<c:choose>
																		<c:when test="${empty phone.STATUS}">
																			<td><button class="btn apply"><span>신청</span></button></td>
																			<td></td>									
																			<td></td>									
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${phone.STATUS eq 'WAIT' }">
																					<td class='bold'>승인대기중</td>
																					<td></td>									
																					<td></td>									
																				</c:when>
																				<c:otherwise>
																					<td class='bold'>대여중</td>
																					<td class='bold'><fmt:formatDate value="${phone.ENDDATE }" pattern="MM월 dd일"/> 예정</td>
																					<td><button class="btn reserve">예약 </button></td>									
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose>
																</tr>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
										</div>
									<!-- 모달연습 버튼  -->
									<div id="modal" class="modal-overlay">
								        <div class="modal-window">
								            <div class="title">
								                <h3>기기대여 신청</h3>
								            </div>
								            <div class="close-area">X</div>
								            <div class="content">
								                <form action="rental/apply" method="post" class="offset-2" id="rental-form">
											        	<input type="hidden" id="phone-code" name="phoneCode" value="" />
									  					<div class="col-md-10">
									    					<label class="form-label">시작일자</label>
									    					<input type="date" class="form-control" id="rental-start" name="startDate">
									  					</div>
									  					<div class="col-md-10">
									    					<label class="form-label">종료일자</label>
									    					<input type="date" class="form-control" id="rental-end" name="endDate">
									  					</div>
												</form>
												<div class="footer mt-3">
											        <button type="button" class="btn cancel" id="btn-cancel">취소</button>
											        <button type="button" class="btn apply">신청</button>
											     </div>
								            </div>
								        </div>
								    </div>
									</div>
								</section>
						</div>
					</div>
				</div>
			</section>
		<!-- 푸터 -->
			<section id="footer">
				<div class="container">
					<div class="row">
						<div class="col-6">
							<div id="copyright">
								<ul class="links">
									<li>TestPhone Management System</li><li>Made by: ChaeEun Lim</li>
								</ul>
							</div>
						</div>
						<div class="col-6">
							<div id="copyright">
								<ul class="links">
									<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</section>

	</div>

	<!-- Scripts -->
		<script src="/tpms/resources/static/assets/js/jquery.min.js"></script>
		<script src="/tpms/resources/static/assets/js/jquery.dropotron.min.js"></script>
		<script src="/tpms/resources/static/assets/js/browser.min.js"></script>
		<script src="/tpms/resources/static/assets/js/breakpoints.min.js"></script>
		<script src="/tpms/resources/static/assets/js/util.js"></script>
		<script src="/tpms/resources/static/assets/js/main.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		
<script src="/tpms/resources/static/js/main.js"></script>
</body>
</html>