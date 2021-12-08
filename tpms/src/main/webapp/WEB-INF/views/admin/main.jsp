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
		<%@ include file="../common/header.jsp" %>
		<!-- Banner -->
			<section id="banner">
				<header>
					<h2>원하는 기기를 찾아보세요.</h2>
					<input type="text" placeholder="기기명 검색" id="phone-search">
				</header>
			</section>
			<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">
						<div class="col-12 rentalHisLine">
							관리자메인 
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
	
	$('#phone-search').on('keydown', function(e){
		if(e.keyCode == 13) {
			let name = $('#phone-search').val();
			console.log(name)
			location.href = "/tpms/user/list?name="+name;		
		}
	});
})
</script>
</body>
</html>