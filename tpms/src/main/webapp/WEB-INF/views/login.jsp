<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
</style>
<title>TPMS || 로그인</title>

</head>
<body>
<div class="container-fluid my-3 mt-0 p-0">
	<header>
		<%@ include file="common/header.jsp" %>
	</header>
	<main>
		<div class="row">
			<div class="card offset-3 mt-5" style="width: 50rem;">
				<div class="card-body">
					<c:if test="${not empty error}">
						<div class="row text-center">
							<div class="col">
								<div class="alert alert-danger">
									<strong>[ ${error.title } ]</strong>  ${error.message }
								</div>
							</div>					
						</div>
					</c:if>
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
								<button class="btn btn-danger w-100 h-100">로그인</button>
							</div>
						</div>
					</form>	
			  	</div>
			</div>
		</div> 
	</main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

</script>
</body>
</html>