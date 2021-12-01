<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<title>TPMS || 기기 리스트</title>
</head>
<body>
<div class="container-fluid my-3 mt-0 p-0">
	<header>
		<%@ include file="../common/header.jsp" %>
	</header>
	<main>
		<div class="row p-5">
			<h1>기기 목록 </h1>
			<table class="table table-hover text-center mt-2">
				<thead>
					<colgroup>
						<col width="10%"/>
						<col width="*%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="8%"/>
						<col width="10%"/>
						<col width="15%"/>
					</colgroup>
					<tr class="table-secondary">
						<th scope="col">순번 </th>
						<th scope="col">모델명 </th>
						<th scope="col">제조사 </th>
						<th scope="col">운영체제 </th>
						<th scope="col">버전 </th>
						<th scope="col">메모리 </th>
						<th scope="col">디스플레이 </th>
						<th scope="col">대여  </th>
						<th scope="col"></th>
					</tr>
				</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty phones } }">
						<tr>
							<td colspan="8">대여가능한 기기가 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="phone" items="${phones}" varStatus="loop">
							<tr id="${phone.CODE}">
								<td>${loop.count }</td>
								<td>${phone.NAME }</td>
								<td>${phone.MAKER }</td>
								<td>${phone.OS }</td>
								<td>${phone.VERSION }</td>
								<td>${phone.MEMORY } GB </td>
								<td>${phone.DISPLAY } 인치 </td>
								<c:choose>
									<c:when test="${phone.GIVE eq 'N' }">
										<td><button class="btn-sm btn-outline-secondary" disabled>대여중 </button> </td>
										<td><fmt:formatDate value="${phone.ENDDATE }" pattern="yy-MM-dd"/> 반납예정  </td>
									</c:when>
									<c:otherwise>
										<td><a class="btn btn-sm btn-outline-danger" href="#">대여신청 </a></td>									
										<td></td>									
									</c:otherwise>
								</c:choose>
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
<!-- 
<script src="/resources/static/js/user_list.js"></script>
 -->
<script>
$(function(){
	// s
	
}
);
</script>
</body>
</html>