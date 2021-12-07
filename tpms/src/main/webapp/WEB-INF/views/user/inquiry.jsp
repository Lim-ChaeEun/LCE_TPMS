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
		<c:set var="menu" value="inquiry"/>
		<%@ include file="../common/userHeader.jsp" %>
			<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">	
						<div class="col-12">
							<section>
								<header class="major">
									<h2>1:1 문의</h2>
								</header>
								<div class="row">
									<div class="col-12 col-12-small">
										<section class="box">
											<header class="inquiryHead">
												<h4 class="inquiryHead">기기구매 신청, 대여 및 예약문의가 가능합니다.</h4>
												<p class='inquiyHead'>1:1 문의글 답변 운영시간 9:00 ~ 18:00</p>
           										<p class='inquiyHead'>접수 후 48시간 안에 답변 드리겠습니다.</p>
											</header>
											<form method="post" action="inquiry/register" id="inquiry-form">
												<div class="row">
													<div class="col-12">
														<div class="row">
															<div class="col-12">
																<label>문의 제목</label>
																<input type="text" class="form-control bg-light" name="title">
															</div>
														</div>
														<div class="row">
															<div class="col-12">
																<label>문의 내용</label>
																<textarea rows="30" cols="100" name="content"></textarea>
															</div>
														</div>
													</div>
												</div>
											</form>	
											<footer>
												<ul class="actions" id="inquiryBtn">
													<li><a class="button submit">등록</a></li>
													<li><a class="button alt">취소</a></li>
												</ul>
											</footer>
										</section>
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
	let status = "<c:out value='${status}' />";
	console.log(status);
	if(status == 'inquiryFin'){
		alert("문의글 등록이 완료되었습니다. \n작성하신 문의글은 '내 문의내역 확인'에서 확인이 가능합니다.");
	}
	
	$('#inquiryBtn').on('click', '.submit', function(){
		// 제목, 내용썼는지
		let title = $('#inquiry-form :text').val()
		let content = $('#inquiry-form textarea').val()
		if(title == ''){
			alert('문의제목을 입력하세요.');
			$('#inquiry-form :text').focus();
			return;
		}
		if(content == ''){
			alert("문의내용을 입력하세요.");
			$('#inquiry-form textarea').focus();
			return;
		}
		
		$.ajax({
			type:"GET",
			url:"../rest/islogin",
		})
		.done(function(user){
			if(!user){
				// 로그인 되어있지 않은 경우 
				let confirmValue = confirm("1:1문의등록은 로그인 후에만 가능합니다. \n로그인 페이지로 이동하시겠습니까?");
				if(confirmValue){
					// 로그인 된 후에 다시 전페이지로 돌아가는 부분 추가 구현하면 좋을듯
					location.href = "/tpms/login"; 
				}
			}else{
				let submitConfirm = confirm("문의사항을 등록하시겠습니까?");
				if(!submitConfirm){
					return;					
				}
				$('#inquiry-form').submit();
				
			}
		});
		
	});
	
	$('#inquiryBtn').on('click', '.alt', function(){
		location.href = "inquiry";
	});
});
</script>
</body>
</html>