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
						<header class="major">
							<h2>승인 / 연체 / 문의</h2>
						</header>
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
											<table class="admin" id="rental-table">
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
													<th class="center" scope="col">순번</th>
													<th scope="col">기기명</th>
													<th scope="col">제조사</th>
													<th scope="col">대여기간</th>
													<th scope="col">신청자</th>
													<th scope="col">승인</th>
												</tr>
												</thead>
												<tbody>
													<c:forEach var="rental" items="${rentals }" varStatus="loop">
														<tr id="${rental.CODE }">
															<td class="center">${loop.count }</td>
															<td>${rental.PHONENAME }</td>
															<td>${rental.PHONEMAKER }</td>
															<td><fmt:formatDate value="${rental.STARTDATE }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${rental.ENDDATE }" pattern="yyyy-MM-dd"/></td>
															<td>${rental.USERNAME } / ${rental.USERTEAM } (${rental.USERPOSITION })</td>
															<td>
																<button class="approve">승인</button>
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
										<h3>연체 현황</h3>
									</header>
									<c:choose>
										<c:when test="${empty rentals }">
											<p>현재 연체된 목록이 없습니다.</p>
										</c:when>
										<c:otherwise>
											<table class="admin" id="overDue-table">
												<thead>
												<colgroup>
													<col width="5%"/>
													<col width="8%"/>
													<col width="20%"/>
													<col width="25%"/>
													<col width="20%"/>
													<col width="12%"/>
													<col width="10%"/>
												</colgroup>
												<tr class="head" >
													<th scope="col"><input type="checkbox" name="chk" value="checkAll"></th>
													<th class="center" scope="col">순번</th>
													<th scope="col">기기 / 제조사</th>
													<th scope="col">사용자</th>
													<th scope="col">반납 예정일</th>
													<th class="center" scope="col">연체일</th>
													<th class="center" scope="col"></th>
												</tr>
												</thead>
												<tbody>
													<c:forEach var="over" items="${overdues }" varStatus="loop">
														<tr id="${over.CODE }">
															<td><input type="checkbox" name="chk" value="${over.CODE }"></td>
															<td class="center">${loop.count }</td>
															<td>${over.PHONENAME } / ${over.PHONEMAKER }</td>
															<td>${over.USERNAME } / ${over.USERTEAM } (${over.USERPOSITION })</td>
															<td><fmt:formatDate value="${over.ENDDATE }" pattern="yyyy-MM-dd"/></td>
															<td class="center strong">${over.OVERDAY }</td>
															<td class="center"><button class="alt">알림</button></td>
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
														<tr id="${inquiry.CODE }">
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
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/emailjs-com@2.4.1/dist/email.min.js"></script>
<script>
$(function(){
	
	let status = "<c:out value='${status}' />";
	if(status == 'approve'){
		alert("대여신청을 승인했습니다.");
	}else if(status == 'reject'){
		alert("대여신청을 반려했습니다.");		
	}
	
	// 체크박스 관련설정
	$('#overDue-table').on('click', 'input:checkbox', function(){
		if($(this).val() == 'checkAll'){
			let status = $('input:checkbox[name=chk]').prop('checked');
			$('input:checkbox[name=chk]').prop('checked', status);
		}
	})
	
	// 기기대여 신청 승인 . 반려 
	$('#rental-table tbody td').on('click', 'button', function(){
		// 승인인 경우
		let rentalCode = $(this).closest('tr').attr('id');
		let status = 'approve';
		console.log(rentalCode);
		if($(this).hasClass('approve')){
			//  이메일 작성
			console.log('승인')
		} else{
			status = 'reject';
			// 이메일 작성  
			console.log('반려 ');
		}
		location.href = "rental?code="+rentalCode+"&status="+status;
		
	})
	
	// 연체알림 이메일 
	$('#overDue-table tbody td').on('click', '.alt', function(){
		sendOverEmail();
	})
	
	// 이메일 보내기 
	function sendEmail(name, message, email){
		emailjs.init('user_S0kArdgcTNuCZifqLMLpt');
		let templateParams = {
				name : name,
				message : message,
				email: email
		}
		emailjs.send('service_c2kyuum', 'template_fapyng4',templateParams).then(function(response){
			console.log('success', response.status, response.text);
		}, function(error){
			console.log('success', error);
		})
	}
	
})
</script>
</body>
</html>