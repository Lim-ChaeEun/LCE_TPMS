<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 대여신청</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
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
						<div class="col-12 ">
							<header class="major">
										<h2>대여 신청</h2>
							</header>
							<div class="row">
								<div class="col-12 col-12-medium col-12-small">
									<section class="box rental-info">
										<header class="inquiryHead">
												<h4 class="inquiryHead"><span class="danger">※ 필독 ※</span>  기기대여 신청 시 유의사항 </h4>
												<p class='inquiyHead'>대여가능한 최대 일수는 7일 입니다.</p>
												<p class='inquiyHead'>대여신청은 대여일로부터 3일 이전부터 가능합니다.</p>
											</header>
										<table id="rental-table" data-phone-code="${phone.code }">
											<tr>
												<th>대여일시<span class="important">✔</span></th>
												<td colspan="5"><input type="date" name="startDate"> ~ <input type="date" name="endDate"></td>
											</tr>
											<tr>
												<th>기기</th>
												<td>${phone.modelName } </td>
												<th>운영체제 (버전) </th>
												<td>${phone.os }  ${phone.version }</td>
												<th>디스플레이</th>
												<td>${phone.display } 인치 </td>
											</tr>
											<tr>
												<th>제조사 </th>
												<td>${phone.maker }</td>
												<th>맥주소 </th>
												<td>${phone.macAddress }</td>
												<th>메모리</th>
												<td> ${phone.memory } GB</td>
											</tr>
										</table>
										<header>
											<h3>대여자 정보</h3>
										</header>
										<table>
											<tr>
												<th>사번</th>
												<td>${user.code }</td>
												<th>소속</th>
												<td>${user.team }</td>
												<th>휴대폰</th>
												<td>${user.phone }</td>
											</tr>
											<tr>
												<th>이름</th>
												<td>${user.name }</td>
												<th>직급</th>
												<td>${user.position }</td>
												<th>이메일</th>
												<td>${user.email }</td>
											</tr>
										</table>
										<footer>
											<ul class="actions">
												<li><a href="../user/list" class="button alt">취소</a></li>
												<li><a  class="button apply">신청 </a></li>
											</ul>
										</footer>
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
<script type="text/javascript">
$(function(){
	
	// 알림메시지 띄우고 해당 부분 포커스해주는 함수 
	function alertAndFocus(value, message) {
		alert(message);
		value.focus();
	}
	
	// post 방식으로 신청데이터 전송 
	function sendRentalInfo(path, params, method){
		method = method || "post";
		// form 객체생성 
		let form = $('<form></form>');
		// 속성 삽입하기 
		form.attr("method", method);
		form.attr("action", path);
		for(let key in params){
			form.append($('<input/>', {type: 'hidden', name: key, value:params[key]}));
		}
		form.appendTo('table');
		
		form.submit();
	}
	
	$('footer .apply').on('click', function(){
		// 입력값 유효성 확인
		let sDate = $("#rental-table input[name=startDate]");
		let eDate = $('#rental-table input[name=endDate]');
		let startDate = new Date(sDate.val());
		let endDate = new Date(eDate.val());
		
		if(sDate.val() == ''){
			alertAndFocus(sDate, '시작일을 입력하세요! ');
			return;
		} else if(eDate.val() == ''){
			alertAndFocus(eDate, '종료일을 입력하세요! ');
			return;
		} else if(startDate >= endDate){
			alertAndFocus(sDate, '시작일은 종료일보다 앞서야 합니다! ');
			return;
		}else if(endDate - startDate > 518400000){
			alertAndFocus(eDate, '대여할 수 있는 최대기간은 일주일입니다!');
			return;
		}else if(new Date() > startDate){
			alertAndFocus(sDate, '대여시작일은 오늘 이후여야 합니다! ');
			return;
		}else if(startDate - new Date() > 345600000){
			alertAndFocus(sDate, '대여신청은 대여시작일 기준 3일 이전부터 가능합니다.');
			return;
		}
		const phoneCode = $('#rental-table').data('phone-code');
		// 검사완료 후 신청하기 
		sendRentalInfo("apply", {phoneCode:phoneCode, startDate:sDate.val(), endDate:eDate.val()}, 'post');
	})

})
</script>
</body>
</html>