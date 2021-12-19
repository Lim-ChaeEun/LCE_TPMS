<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 기기리스트</title>
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
						<div class="col-12">
							<!-- 기기리스트 -->
							<section>
								<header class="major">
									<h2>기기 리스트</h2>
								</header>
								<div class="row">
									<div class="col-12">
										<div id="search-option">
											<c:choose>
												<c:when test="${name ne null }">
													<input type="text"  value="${name }">
												</c:when>
												<c:otherwise>
													<input type="text"  placeholder=" ex) 아이폰">
												</c:otherwise>
											</c:choose>
											<button class="searchBtn alt">검색</button>
											<button class="searchBtn reset">초기화</button>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-12">
										<div class="table-box">
											<table class="table table--min" >
												<thead>
													<colgroup>
														<col width="7%"/>
														<col width="11%"/>
														<col width="30%"/>
														<col width="15%"/>
														<col width="13%"/>
														<col width="13%"/>
														<col width="11%"/>
													</colgroup>
													<tr>
														<th scope="col">순번 </th>
														<th scope="col" class="selectbox">
															<label for="select">제조사</label>
															<select name="maker" class="select">
																<option value=""  ${maker eq "null" ? 'selected' : '' }> 제조사 </option>
																<c:forEach var="mk" items="${makers }">
																	<option value="${mk }"  ${maker eq mk ? 'selected' : '' }>${mk }</option>
																</c:forEach>
															</select>
														</th>
														<th scope="col">모델명 </th>
														<th scope="col">운영체제 / 버전 </th>
														<th scope="col">상태 </th>
														<th scope="col">반납일</th>
														<th scope="col">대여 /예약 </th>
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
																<tr id="${phone.CODE}" class="back">
																	<td class="center">${loop.count + ((pagination.pageNo-1)*10)}</td>
																	<td>${phone.MAKER }</td>
																	<td><strong>${phone.NAME }</strong></td>
																	<td class="center"><strong>${phone.OS }  ${phone.VERSION }</strong></td>
																	<c:choose>
																		<c:when test="${empty phone.STATUS or phone.STATUS eq 'FIN' or phone.STATUS eq 'REJ'}">
																			<td class="bold center">신청가능</td>									
																			<td class="center"></td>									
																			<td class="center"><button class="btn apply makeBtn">신청</button></td>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${phone.STATUS eq 'WAIT' }">
																					<td class='bold danger center'>승인대기중</td>
																					<td class="center"></td>									
																					<td class="center"></td>									
																				</c:when>
																				<c:otherwise>
																					<td class='bold danger center'>대여중</td>
																					<td class='bold center'><fmt:formatDate value="${phone.ENDDATE }" pattern="MM/d"/> 예정</td>
																					<td class="center"><button class="btn reserve">예약 </button></td>									
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
										</div>
										<!-- 페이징 -->
										<c:if test="${pagination.totalRows gt 0 }">
											<!-- url 설정하기  -->
											<c:choose>
												<c:when test="${maker ne null or name ne null }">
													<c:set var="url" value="list?maker=${maker }&name=${name }&page=" />
												</c:when>
												<c:otherwise>
													<c:set var="url" value="list?page=" />
												</c:otherwise>
											</c:choose>
											<div class="page">
												<ul class="pagination modala">
													<c:choose>
														<c:when test="${pagination.pageNo le 1 }">
															<li><a class="first">이전</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="${url }${pagination.pageNo - 1 }" class="first">이전</a></li>
														</c:otherwise>
													</c:choose>
													<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
														<li><a href="${url }${num }" class="${pagination.pageNo eq num ? 'active' : ''} num">${num }</a></li>
													</c:forEach>
													<c:choose>
														<c:when test="${pagination.pageNo ge pagination.totalPages }">
															<li><a class="last">다음</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="${url }${pagination.pageNo + 1 }" class="last">다음</a></li>
														</c:otherwise>
													</c:choose>
												</ul>
											</div>
										</c:if>
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
<script type="text/javascript">
$(function(){
	let status = "<c:out value='${status}' />";
	if(status == 'rentalFin'){
		alert("대여신청이 완료되었습니다. \n승인이 완료되면 등록하신 이메일로 알림이 전송됩니다. ");
	}else if(status == 'reserveFin'){
		alert("예약신청이 완료되었습니다. \n해당 대여자가 반납할 시 등록하신 이메일로 알림이 전송됩니다. ");		
	}
	
	changeLabel();
	
	function changeLabel(){
		let label = $('.selectbox label');
		let selectName = $('.selectbox select').val();
		if(selectName){
			label.text(selectName);
		}		
	}

	$('.selectbox select').change(function(){
		changeLabel();
		searchOption();
    });
	
	// 대여신청을 클릭한 경우
	// 1. 로그인이 되어있는지 확인 -> 되어있지 않다면 알림창띄우고 로그인 페이지이동여부 결정 
	// 로그인 되어있으면 대여신청 팝업 띄우고 신청받기
	$('#phone-list').on('click', '.apply' , function(){
		let phoneCode = $(this).closest('tr').attr('id');
		if(!loginConfirm()){
			return false;	
		}
		location.href = "../rental/apply?phone=" + phoneCode;	
		
	});
	
	function searchOption(){
		let selectOption = $('.selectbox .select').val();
		let nameOption = $('#search-option > input').val();
		location.href = "/tpms/user/list?maker="+selectOption+"&name="+nameOption;		
	}
	
	$('#search-option').on('keydown', 'input' , function(e){
		if(e.keyCode == 13) {
			searchOption();
		}
	});
	
	$('#search-option').on('click', '.alt' ,function(){
		searchOption();
	});
	
	$('#search-option').on('click', '.reset' ,function(){
		location.href = "/tpms/user/list";	
	});
	
	// 예약선택 시 
	$('#phone-list').on('click', '.reserve' , function(){
		if(confirm('예약신청하시겠습니까?')){
			
			let phoneCode = $(this).closest('tr').attr('id');
			// 로그인 여부 , 예약가능 여부 확
			if(!loginConfirm()){
				return false;
			}
			if(!reserveConfirm()){
				return false;
			}
			location.href = "../rental/reservation?phone=" + phoneCode;	
		}
	});	
	
	
	// 로그인과 상태확인하는 함수 
	function loginConfirm(){
			let isable = true;
			$.ajax({
				url: '../rest/islogin',
				type: "GET",
				async: false
			}).done(function(user){
				if(user == ''){
					// 로그인 되어있지 않은 경우 
					isable = false;
					let confirmValue = confirm("예약은 로그인 후에만 가능합니다. \n로그인 페이지로 이동하시겠습니까?");
					if(confirmValue){
						location.href = "/tpms/home"; 
					}
				} else{
					if(user.status == 'N'){
						// 예약가능한 상태인지 확인하기
						isable = false;
						alert('이미 대여중이거나, 대여신청을 하셨습니다.');
					}else if(user.status == 'X'){
						isable = false;
						alert('*지난 대여에서 연체가 발생하셨습니다. \n*반납일로부터 7일 이후에 대여가 가능합니다. \n즉시 대여신청을 원하신다면 문의게시판을 이용해주세요.');
					}
				}
			});
			return isable;
	}
	
	// 이미 예약했는지 확인하는 함수 
	function reserveConfirm(){
		let isAble = true;
		$.ajax({
			type:"GET",
			url:"../rest/ableReserve",
			async: false
		}).done(function(result){
			if(!result){
				isAble = false;
				alert("이미 예약하신 기기가 존재합니다. \n다른 기기를 예약하시려면 기존예약을 취소해주세요. ");
			}
		})
		return isAble;
	}

})
</script>
</body>
</html>