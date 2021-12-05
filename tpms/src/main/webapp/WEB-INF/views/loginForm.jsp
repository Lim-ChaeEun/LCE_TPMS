<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS || 로그인</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<!-- 헤더 -->
		<c:set var="menu" value="my"/>
		<%@ include file="common/header.jsp" %>
			<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">
						<div class="col-12">
							<section>
								<div class="row">
									<div class="col-2 col-12-small"></div>
									<div class="col-8 col-12-small">
										<section class="box">
											<header>
												<c:if test="${param.error eq 'deny' }">
													<div class="row text-center">
														<div class="col-9">
															<div class="alert alert-danger">
																<strong>본 서비스는 로그인 후 사용가능합니다.</strong>
															</div>
														</div>					
													</div>
												</c:if>
												<c:if test="${not empty error}">
													<div class="row text-center">
														<div class="col-9">
															<div class="alert alert-danger">
																<strong>[ ${error.title } ]</strong>  ${error.message }
															</div>
														</div>					
													</div>
												</c:if>
											</header>
											<form method="post" action="login" id="login-form">
												<div class="row">
													<div class="col-9">
														<div class="row">
															<div class="col-12">
																<input type="text" class="form-control bg-light" name="code" placeholder="사번">
															</div>
														</div>
														<div class="row">
															<div class="col-12">
																<input type="password" class="form-control bg-light" name="password" placeholder="비밀번호">
															</div>
														</div>
													</div>
													<div class="col-3">
														<a class="button large"><span>로그인</span></a>
													</div>
												</div>
											</form>	
										</section>
									</div>
									<div class="col-2 col-12-small"></div>
								</div>
							</section>

						</div>
					</div>
				</div>
			</section>
		<!-- 푸터 -->
		<%@ include file="common/footer.jsp" %>
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
	$('#login-form .button').on('click', function(){
		confirmUser();
	});
	
	$('#login-form :text, :password').on('keydown', function(e){
		if(e.keyCode == 13) {
			confirmUser();
		}
	});
	
	function confirmUser(){
		let idValue = $('#login-form :text').val();
		let pwdValue = $('#login-form :password').val();
		if(!idValue){
			alert('사번을 입력하세요.');
			$('#login-form :text').focus();
			return;
		}
		if(!pwdValue){
			alert('비밀번호를 입력하세요.');
			$('#login-form :password').focus();
			return;
		}
		$('#login-form').submit();
	}
});
</script>
</body>
</html>