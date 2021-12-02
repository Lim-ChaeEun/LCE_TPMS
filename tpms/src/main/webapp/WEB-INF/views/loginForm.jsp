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
						<li><a href="/tpms/main">대여</a></li>
						<li><a href="#">문의</a></li>
						<li class="current">
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
							<section>
								<div class="row">
									<div class="col-2 col-12-small"></div>
									<div class="col-8 col-12-small">
										<section class="box">
											<header>
												<c:if test="${not empty error}">
													<div class="row text-center">
														<div class="col">
															<div class="alert alert-danger">
																<strong>[ ${error.title } ]</strong>  ${error.message }
															</div>
														</div>					
													</div>
												</c:if>
											</header>
											<form method="post" action="login">
												<div class="row">
													<div class="col-9">
														<div class="row mb-2">
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
														<button class="btn large">로그인</button>
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

</body>
</html>