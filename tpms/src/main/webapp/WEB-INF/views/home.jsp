<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<section id="header" class="home">
			<!-- TPMS 로고 넣기 -->
			<h1 class="home">
				<a class="navbar-brand" href="/tpms/home">
					<img src="/tpms/resources/static/images/tpms_logo1.png" class="mx-3" alt="error" width="300" height="90" >
				</a>
			</h1>
			<p class="header">Test Phone Management System</p>
		</section>
		<!-- 메인 바디 -->
		<section id="main" class="home">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<section>
							<div class="row">
								<div id="nmp" class="col-4 col-12-small"></div>
								<div id="nmp" class="col-4 col-12-small">
									<section class="box login" id="login-area">
										<header>
											<c:if test="${param.error eq 'deny' }">
												<div class="row text-center">
													<div class="col-12">
														<div class="alert alert-danger">
															<strong>본 서비스는 로그인 후 사용가능합니다.</strong>
														</div>
													</div>					
												</div>
											</c:if>
											<c:if test="${param.error eq 'admin' }">
												<div class="row text-center">
													<div class="col-12">
														<div class="alert alert-danger">
															<strong>본 서비스는 관리자 인증 후 사용가능합니다.</strong>
														</div>
													</div>					
												</div>
											</c:if>
											<c:if test="${not empty error}">
												<div class="row text-center">
													<div class="col-12">
														<div class="alert alert-danger">
															<strong>[ ${error.title } ]</strong>  ${error.message }
														</div>
													</div>					
												</div>
											</c:if>
										</header>
										<form method="post" action="login" id="login-form">
											<div class="row">
												<div class="col-12">
													<div class="row">
														<div class="col-12 input">
															<input type="text" class="form-control bg-light" name="code" placeholder="사번">
														</div>
													</div>
													<div class="row">
														<div class="col-12 input">
															<input type="password" class="form-control bg-light" name="password" placeholder="비밀번호">
														</div>
													</div>
												</div>
											</div>
										</form>	
										<div class="row">
											<div class="col-12 footer">
												<a class="button login"><span>로그인</span></a>
												<a href="register" class="button alt"><span>회원가입</span></a>
												<p>비회원 대여가능 기기 조회 ><a href="user/list" class="distance">기기페이지</a></p>
											</div>
										</div>
									</section>
								</div>
								<div class="col-4 col-12-small"></div>
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
	$('#login-area .login').on('click', function(){
		confirmUser();
	});
	
	$('#login-form :text, :password').on('keydown', function(e){
		if(e.keyCode == 13) {
			confirmUser();
		}
	});
	
	function confirmUser(){
		const idValue = $('#login-form :text').val();
		const pwdValue = $('#login-form :password').val();
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