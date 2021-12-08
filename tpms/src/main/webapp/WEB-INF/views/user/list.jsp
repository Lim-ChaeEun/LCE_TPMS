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
		<c:set var="menu" value="main"/>
		<%@ include file="../common/header.jsp" %>
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
										<div class="col-6" id="search-option">
											<label>제조사 </label>
											<select name="maker" class="select">
												<option value=""  ${maker eq "null" ? 'selected' : '' }> 선택안함 </option>
												<c:forEach var="mk" items="${makers }">
													<option value="${mk }"  ${maker eq mk ? 'selected' : '' }>${mk }</option>
												</c:forEach>
											</select>
											<label>모델명</label>
											<c:choose>
												<c:when test="${name ne null }">
													<input type="text"  value="${name }">
												</c:when>
												<c:otherwise>
													<input type="text"  placeholder=" ex) 아이폰" >
												</c:otherwise>
											</c:choose>
											<button class="searchBtn">검색</button>
										</div>
									</div>
									<div class="row">
										<div class="col-12">
											<table class="table">
												<thead>
													<colgroup>
														<col width="8%"/>
														<col width="15%"/>
														<col width="9%"/>
														<col width="14%"/>
														<col width="10%"/>
														<col width="10%"/>
														<col width="12%"/>
														<col width="12%"/>
														<col width="10%"/>
													</colgroup>
													<tr>
														<th scope="col">순번 </th>
														<th scope="col">모델명 </th>
														<th scope="col">제조사 </th>
														<th scope="col">운영체제 / 버전 </th>
														<th scope="col">메모리 </th>
														<th scope="col">화면 </th>
														<th scope="col">상태 </th>
														<th scope="col">반납일</th>
														<th scope="col">대여 /예약 </th>
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
																	<td>${loop.count + ((pagination.pageNo-1)*10)}</td>
																	<td><strong>${phone.NAME }</strong></td>
																	<td>${phone.MAKER }</td>
																	<td>${phone.OS }  ${phone.VERSION }</td>
																	<td>${phone.MEMORY } GB </td>
																	<td>${phone.DISPLAY } 인치 </td>
																	<c:choose>
																		<c:when test="${empty phone.STATUS or phone.STATUS eq 'FIN'}">
																			<td class="bold">신청가능</td>									
																			<td></td>									
																			<td><button class="btn apply"><span>신청</span></button></td>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${phone.STATUS eq 'WAIT' }">
																					<td class='bold danger'>승인대기중</td>
																					<td></td>									
																					<td></td>									
																				</c:when>
																				<c:otherwise>
																					<td class='bold danger'>대여중</td>
																					<td class='bold'><fmt:formatDate value="${phone.ENDDATE }" pattern="MM/d"/> 예정</td>
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
											<!-- 페이징 -->
											<c:if test="${pagination.totalRows gt 0 }">
												<!-- url 설정하기  -->
												<c:choose>
													<c:when test="${maker ne null or name ne null }">
														<c:set var="url" value="list?maker=${maker }&name=${name }&page=" />
													</c:when>
													<c:otherwise>
														<c:set var="url" value="list?page=" />
													</c:otherwise>
												</c:choose>
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
<script type="text/javascript">
$(function(){
	let status = "<c:out value='${status}' />";
	if(status == 'rentalFin'){
		alert("대여신청이 완료되었습니다. \n승인이 완료되면 이메일로 알림이 전송됩니다. ");
	}
})
</script>
<script src="/tpms/resources/static/js/list.js"></script>
</body>
</html>