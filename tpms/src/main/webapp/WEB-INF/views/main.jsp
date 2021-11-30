<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<title>샘플 애플리케이션</title>
</head>
<body>
<div class="container-fluid my-3 mt-0 p-0">
	<header>
		<%@ include file="common/header.jsp" %>
	</header>
	<main>
		<div class="p-5">
		<h1>메인화면</h1>
		<table class="table text-center">
			<thead>
					<colgroup>
						<col width="15%"/>
						<col width="15%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
						<col width="15%"/>
					</colgroup>
					<tr>
						<th scope="col">사번</th>
						<th scope="col">이름</th>
						<th scope="col">이메일</th>
						<th scope="col">휴대폰</th>
						<th scope="col">팀</th>
						<th scope="col">직책</th>
					</tr>
			</thead>
			<tbody>
					<c:choose>
						<c:when test="${empty users }">
							<tr>
								<td colspan="4">검색결과가 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="user" items="${users }">
								<tr>
									<td>${user.code }</td>
									<td>${user.name }</td>
									<td>${user.email }</td>
									<td>${user.phone }</td>
									<td>${user.team }</td>
									<td>${user.position }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
			</tbody>
		</table>
		</div>
	</main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
</script>
</body>
</html>