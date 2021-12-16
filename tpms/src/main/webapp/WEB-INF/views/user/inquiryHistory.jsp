<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 내 문의내역</title>
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
									<h2>나의 문의내역</h2>
								</header>
								<div class="row">
									<div class="col-12">
										<div class="table-box">
											<table class="table table--min" id="inquiry-table">
												<thead>
													<colgroup>
														<col width="10%"/>
														<col width="30%"/>
														<col width="15%"/>
														<col width="15%"/>
														<col width="15%"/>
														<col width="15%"/>
													</colgroup>
													<tr>
														<th scope="col">순번 </th>
														<th scope="col">문의제목 </th>
														<th scope="col">문의자 </th>
														<th scope="col">답변상태 </th>
														<th scope="col">문의일자 </th>
														<th scope="col"> </th>
													</tr>
												</thead>
												<tbody id="inquiry-list">
													<c:choose>
														<c:when test="${empty inquiries}">
															<tr>
																<td colspan="6"><p class="bold center">문의내역이 존재하지 않습니다.</p></td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach var="inquiry" items="${inquiries }" varStatus="loop">
																<tr id="${inquiry.code }">
																	<td>${loop.count }</td>
																	<td><p class="bold">${inquiry.title }</p></td>
																	<td>${user.name }</td>
																	<c:choose>
																		<c:when test="${inquiry.status eq 'N' }">
																			<td class="bold">미완료</td>
																		</c:when>
																		<c:otherwise>	
																			<td class="bold"><p class="danger">답변완료</p></td>
																		</c:otherwise>
																	</c:choose>
																	<td><p class="bold"><fmt:formatDate value="${inquiry.createdDate}" pattern="yyyy-MM-dd"/></p></td>
																	<td><button id="show">보기</button></td>
																</tr>
																<tr class="hide" style="display:none "  id="${inquiry.code }">
																	<td colspan="1" class="bold"><p>문의내용</p></td>
																	<td colspan="5">${inquiry.content }</td>
																</tr>
																<tr class="hide" style="display:none "  id="${inquiry.code }">
																	<c:choose>
																		<c:when test="${inquiry.status eq 'N' }">
																			<td colspan="6" class="center"><p class="bold">작성된 답변이 없습니다.</p></td>
																		</c:when>
																		<c:otherwise>
																			<td colspan="1" class="bold"><p class="danger">문의답변</p></td>
																			<td colspan="4">${inquiry.respond }</td>
																			<td colspan="1" class="bold"><p><fmt:formatDate value="${inquiry.respondDate}" pattern="yyyy-MM-dd"/></p></td>
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
$(function(){
	$('#inquiry-table tbody').on('click', 'button', function(){
		let inquiryCode = $(this).closest('tr').attr('id');
		let inquiryContent = $(this).closest('tr').next('tr:eq(0)');
		let inquiryRespond = inquiryContent.next('tr');
		
		if(inquiryContent.css('display') == 'none'){
			$('.hide').css('display', 'none');
			if($('#'+inquiryCode+'.hide')){
				$('#'+inquiryCode+'.hide').css('display', '');
			}
		} else{
			if($('#'+inquiryCode+'.hide')){
				$('#'+inquiryCode+'.hide').css('display', 'none');
			}			
		}
	})
})
</script>
</body>
</html>