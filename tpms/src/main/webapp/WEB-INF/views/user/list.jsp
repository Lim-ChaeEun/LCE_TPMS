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
						<col width="8%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
					</colgroup>
					<tr>
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
			<tbody id="phone-list">
				<c:choose>
					<c:when test="${empty phones }">
						<tr>
							<td colspan="8">대여가능한 기기가 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="phone" items="${phones}" varStatus="loop">
							<tr id="${phone.CODE}">
								<td>${loop.count }</td>
								<td class="fw-bold">${phone.NAME }</td>
								<td>${phone.MAKER }</td>
								<td>${phone.OS }</td>
								<td>${phone.VERSION }</td>
								<td>${phone.MEMORY } GB </td>
								<td>${phone.DISPLAY } 인치 </td>
								<c:choose>
									<c:when test="${empty phone.STATUS}">
										<td><button class="btn btn-outline-danger btn-sm">대여신청 </button></td>
										<td></td>									
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${phone.STATUS eq 'WAIT' }">
												<td><strong class="text-success">승인대기중</strong></td>
												<td></td>									
											</c:when>
											<c:otherwise>
												<td><strong class="text-danger">대여중</strong></td>
												<td class="fw-bold"><fmt:formatDate value="${phone.ENDDATE }" pattern="MM/dd"/> 반납예정</td>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<!-- 대여 모달창 -->
		<div class="modal fade" id="rental-Modal" tabindex="-1" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title text-center" id="model-head">기기대여신청</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form action="../../rental/apply" method="post" class="offset-2" id="rental-form">
		        	<input type="hidden" id="phone-code" name="phoneCode" value="" />
  					<div class="col-md-10">
    					<label class="form-label">시작일자</label>
    					<input type="date" class="form-control" id="rental-start" name="startDate">
  					</div>
  					<div class="col-md-10 mt-3">
    					<label class="form-label">종료일자</label>
    					<input type="date" class="form-control" id="rental-end" name="endDate">
  					</div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-outline-danger">신청</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 대여 모달창 -->
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
	
	// 대여신청 모달
	var rentalModal = new bootstrap.Modal(document.getElementById("rental-Modal"), {
		keyboard: false
	})
	
	// 대여신청을 클릭한 경우
	// 1. 로그인이 되어있는지 확인 -> 되어있지 않다면 알림창띄우고 로그인 페이지이동여부 결정 
	// 로그인 되어있으면 대여신청 팝업 띄우고 신청받기
	$('#phone-list').on('click', '.btn-outline-danger' , function(){
		let phoneCode = $(this).closest('tr').attr('id');
		// 로그인 여부 확인
		$.ajax({
			type:"GET",
			url:"../rest/islogin",
		})
		.done(function(user){
			if(!user){
				// 로그인 되어있지 않은 경우 
				console.log("로그인 안됨")
				let confirmValue = confirm("대여신청은 로그인 후에만 가능합니다. \n로그인 페이지로 이동하시겠습니까?");
				if(confirmValue){
					// 로그인 된 후에 다시 전페이지로 돌아가는 부분 추가 구현하면 좋을듯
					location.href = "/tpms/login"; 
				}
			}else{
				// 기기코드 설정하고 값 비우고 띄우기
				$('#rental-form').find('#phone-code').val(phoneCode);
				$('#rental-form').find('#rental-start').val('')
				$('#rental-form').find('#rental-end').val('')
				rentalModal.show();
			}
		});
	});
	
	// 대여모달 신청누르면 -> 유효성검사 후 제출
	$('#rental-Modal').on('click', '.btn-outline-danger', function(){
		// 값 유효성 확인
		// 1.시작일이 종료일보다 앞이 맞는지
		let startDateString = $('#rental-form').find('#rental-start').val();
		let endDateString = $('#rental-form').find('#rental-end').val();
		let startDate = new Date(startDateString);
		let endDate = new Date(endDateString);
		
		if(startDateString == ''){
			alert("시작일을 입력하세요");
			$('#rental-form').find('#rental-start').focus();
			return;
		} else if(endDateString == ''){
			alert("종료일를 입력하세요");
			$('#rental-form').find('#rental-end').focus();			
			return;
		} else if(startDateString > endDateString){
			alert("시작일은 종료일보다 앞이여야 합니다.");
			$('#rental-form').find('#rental-start').focus();
			return;
		} else if(startDateString == endDateString){
			alert("시작일과 종료일은 같을 수 없습니다.");
			$('#rental-form').find('#rental-start').focus();
			return;
		} else if(endDate - startDate > 518400000){
			alert("대여할 수 있는 최대기간은 일주일입니다.");
			$('#rental-form').find('#rental-end').focus();	
			return;
		} else if(new Date() > startDate){
			alert("대여시작일은 오늘보다 뒤여야합니다.");
			$('#rental-form').find('#rental-start').focus();	
			return;
		} else if(startDate - new Date() > 345600000){
			alert("대여신청은 대여일로부터 3일 이전부터 가능합니다.");
			$('#rental-form').find('#rental-start').focus();	
			return;
		}
		
		// 유효성 검사 완료하면 폼 제출
		$('#rental-form').submit();
	})
	
}
);
</script>
</body>
</html>