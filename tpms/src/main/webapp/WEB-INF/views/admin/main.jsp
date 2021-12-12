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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
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
															<td data-user-email="${rental.USEREMAIL }"><span>${rental.USERNAME }</span> / ${rental.USERTEAM } (${rental.USERPOSITION })</td>
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
										<c:when test="${empty overdues}">
											<p>현재 연체된 목록이 없습니다.</p>
										</c:when>
										<c:otherwise>
											<table class="admin" id="overDue-table">
												<thead>
												<colgroup>
													<col width="10%"/>
													<col width="20%"/>
													<col width="25%"/>
													<col width="15%"/>
													<col width="15%"/>
													<col width="15%"/>
												</colgroup>
												<tr class="head" >
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
															<td class="center">${loop.count }</td>
															<td><span>${over.PHONENAME }</span> / ${over.PHONEMAKER }</td>
															<td data-user-email="${over.USEREMAIL }"><span>${over.USERNAME }</span> / ${over.USERTEAM } (${over.USERPOSITION })</td>
															<td><fmt:formatDate value="${over.ENDDATE }" pattern="yyyy-MM-dd"/></td>
															<td class="center strong">${over.OVERDAY }</td>
															<td>
																<button class="return">반납</button>
																<button class="alt">알림</button>
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
											<table class="admin" id="inquiry-table">
												<thead>
												<colgroup>
													<col width="8%"/>
													<col width="52%"/>
													<col width="20%"/>
													<col width="10%"/>
													<col width="10%"/>
												</colgroup>
												<tr class="head">
													<th class="center" scope="col">순번</th>
													<th scope="col">문의제목</th>
													<th scope="col">문의자</th>
													<th scope="col">등록일</th>
													<th scope="col">답변</th>
												</tr>
												</thead>
												<tbody>
													<c:forEach var="inquiry" items="${inquiries }" varStatus="loop">
														<tr id="${inquiry.CODE }">
															<td class="center">${loop.count }</td>
															<td data-inquiry-content="${inquiry.CONTENT }">${inquiry.TITLE }</td>
															<td>${inquiry.USERNAME } / ${inquiry.USERTEAM }</td>
															<td><fmt:formatDate value="${inquiry.CREATEDDATE }" pattern="yyyy-MM-dd"/></td>
															<td><a href="#respond" rel="modal:open" class="button small alt">답변</a></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</c:otherwise>
									</c:choose>
									<!-- 모달 -->
									<div id="respond" class="modal">
									  <h3>문의 답변하기</h3>
									  <table>
										  <colgroup>
											<col width="100%"/>
										</colgroup>
									  	<tr>
									  		<th>문의자</th>
									  	</tr>
									  	<tr>
									  		<td id="user-name"></td>
									  	</tr>
									  	<tr>
									  		<th>제목</th>
									  	</tr>
									  	<tr>
									  		<td id="inquiry-title"></td>
									  	</tr>
									  	<tr>
									  		<th>내용</th>
									  	</tr>
									  	<tr>
									  		<td id="inquiry-content"></td>
									  	</tr>
									  </table>
									  <textarea cols="55" rows="6" id="inquiry-respond"></textarea>
									  <footer>
										  <button class="alt">답변완료</button>
									  </footer>
									</div>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>

<script>
$(function(){
	
	const status = "<c:out value='${status}' />";
	if(status == 'approve'){
		alert("대여신청을 승인했습니다.");
	}else if(status == 'reject'){
		alert("대여신청을 반려했습니다.");		
	}else if(status == 'return'){
		alert("반납이 완료되었습니다.");
	}
	
	/*
	// 체크박스 관련설정
	$('#overDue-table').on('click', 'input:checkbox', function(){
		if($(this).val() == 'checkAll'){
			let status = $('input:checkbox[name=chk]').prop('checked');
			$('input:checkbox[name=chk]').prop('checked', status);
		}
	})
	*/
	
	// 기기대여 신청 승인 . 반려 
	$('#rental-table tbody td').on('click', 'button', function(){
		// 승인인 경우
		let rentalCode = $(this).closest('tr').attr('id');
		let status = 'approve';
		console.log(rentalCode);
		let name = $('#'+rentalCode).find('td').eq(4).find('span').text();
		let email = $('#'+rentalCode).find('td').eq(4).data('user-email');
		let phone = $('#'+rentalCode).find('td').eq(1).text();
		if($(this).hasClass('approve')){
			let confirmValue = confirm('해당 요청을 승인하시겠습니까.');
			if(!confirmValue){
				return false;
			}
			//  이메일 작성
			let title = "대여요청이 승인되었습니다.";
			let message = "요청하셨던" +phone+ " 대여요청이 승인되었습니다. \n\n관리팀으로 오셔서 수령해가시길 바랍니다.";
			sendEmail(name, title, message, email, rentalCode, status);
			
		} else{
			status = 'reject';
			let confirmValue = confirm('해당 요청을 반려하시겠습니까.');
			if(!confirmValue){
				return false;
			}
			// 이메일 작성  
			let title = "대여요청이 반려되었습니다.";
			let message = "요청하셨던" +phone+ " 대여요청이 반려되었습니다. \n\n관련문의는 홈페이지 문의탭을 이용해주세요.";
			sendEmail(name, title, message, email, rentalCode, status);
		}
		
	})
	
	// 반납처리 하기
	$('#overDue-table tbody td').on('click', '.return', function(){
		let confirmValue = confirm('해당 기기를 반납처리하시겠습니까?');
		if(!confirmValue){
			return false;
		}
		let rentalCode = $(this).closest('tr').attr('id');
		location.href = "rental/return?code="+rentalCode+"&status=delay";
	})
	
	// 연체알림 이메일 
	$('#overDue-table tbody td').on('click', '.alt', function(){
		let rentalCode = $(this).closest('tr').attr('id');
		let selectTD = $('#'+rentalCode).find('td');
		let name = selectTD.eq(2).find('span').text();
		let email = selectTD.eq(2).data('user-email');
		let phoneName = selectTD.eq(1).find('span').text();
		let endDate = selectTD.eq(3).text();
		let overDay = selectTD.eq(4).text();
		// 이메일 전송
		sendOverEmail(name, phoneName, endDate, overDay, email);
	})
	
	// 모달관련
	$('#inquiry-table tr td').on('click', '.alt', function(){
		let inquiryCode = $(this).closest('tr').attr('id');
		$('#respond table #user-name').text($('#'+inquiryCode).find('td').eq(2).text());
		$('#respond table #inquiry-title').text($('#'+inquiryCode).find('td').eq(1).text());
		$('#respond table #inquiry-content').text($('#'+inquiryCode).find('td').eq(1).data('inquiry-content'));
		$('#respond #inquiry-respond').val('');
		$('#respond footer button').attr('id', inquiryCode);
	})
	
	$('#respond footer').on('click', '.alt', function(){
		let inquiryCode = $(this).attr('id');
		let respond = $('#respond #inquiry-respond').val();
		location.href = "inquiry?code="+inquiryCode+"&respond="+respond;
	})
	
	function sendOverEmail(name, phoneName, endDate, overDay, email){
		emailjs.init('user_S0kArdgcTNuCZifqLMLpt');
		let templateParams = {
				name : name,
				phoneName : phoneName,
				endDate : endDate,
				overDay : overDay,
				email : email
		}
		emailjs.send('service_c2kyuum', 'template_fapyng4',templateParams).then(function(response){
			console.log('success', response.status, response.text);
			alert('연체알림을 전송하였습니다.');
		}, function(error){
			console.log('error', error);
		})
		
	}
	
	// 이메일 보내기 
	function sendEmail(name, title, message, email, rentalCode, status){
		emailjs.init('user_S0kArdgcTNuCZifqLMLpt');
		let templateParams = {
				name : name,
				title : title, 
				message : message,
				email: email
		}
		emailjs.send('service_c2kyuum', 'template_l9q572c',templateParams).then(function(response){
			location.href = "rental?code="+rentalCode+"&status="+status;
		}, function(error){
			console.log('error', error);
		})
	}
	
})
</script>
</body>
</html>