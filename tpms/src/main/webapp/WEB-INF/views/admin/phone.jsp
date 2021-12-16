<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS | 기기관리</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<c:set var="menu" value="phone"/>
		<!-- 헤더 -->
		<%@ include file="../common/header.jsp" %>
		<!-- 메인 바디 -->
		<section id="main">
			<div class="container">
				<div class="row">
					<div class="col-12 rentalHisLine">
						<header class="major">
							<h2>기기관리</h2>
						</header>
						<div class="row">
							<div class="col-12 col-12-medium col-12-small">
								<section class="box">
									<div class="row">
										<div class="col-12">
											<div id="addPhone">
												<a href="#insert" rel="modal:open" class="button alt" id="insert-phone">기기추가</a>
											</div>
										</div>
									</div>
									<c:choose>
										<c:when test="${empty phones }">
											<p>등록된 기기가 존재하지 않습니다.</p>
										</c:when>
										<c:otherwise>
											<div class="table-box">
											<table class="admin table--min" id="phone-list">
												<thead>
												<colgroup>
														<col width="3%"/>
														<col width="7%"/>
														<col width="14%"/>
														<col width="11%"/>
														<col width="19%"/>
														<col width="13%"/>
														<col width="10%"/>
														<col width="15%"/>
														<col width="8%"/>
													</colgroup>
												<tr class="head">
													<th scope="col"></th>
													<th scope="col">코드</th>
													<th scope="col">기기명</th>
													<th scope="col">대여현황</th>
													<th scope="col">대여자</th>
													<th scope="col" colspan="3" >대여정보</th>
													<th scope="col" class="center">상세</th>
												</tr>
												</thead>
												<tbody>
													<c:forEach var="phone" items="${phones }" varStatus="loop">
														<tr id="${phone.CODE }">
															<td class="center">${loop.count + ((pagination.pageNo-1)*10)}</td>
															<td>${phone.CODE }</td>
															<td>${phone.NAME }</td>
															<c:choose>
																	<c:when test="${empty phone.STATUS or phone.STATUS eq 'FIN' or phone.STATUS eq 'REJ'}">
																		<td class="bold">대여가능</td>				
																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>					
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${phone.STATUS eq 'WAIT' }">
																				<td class='bold danger'>승인대기중</td>		
																				<td>${phone.USERNAME } / ${phone.USERTEAM }</td>
																				<td colspan="2">신청일 : <fmt:formatDate value="${phone.STARTDATE }" pattern="yy-MM-dd"/> ~ <fmt:formatDate value="${phone.ENDDATE }" pattern="yy-MM-dd"/></td>
																				<td class="strong" id="${phone.RENTALCODE }">
																					<button class="approve rental">승인</button>
																					<button class="alt rental">반려</button>
																				</td>					
																			</c:when>
																			<c:otherwise>
																				<td class='bold danger'>대여중</td>			
																				<td>${phone.USERNAME } / ${phone.USERTEAM }</td>
																				<td>반납 : <fmt:formatDate value="${phone.ENDDATE }" pattern="yy-MM-dd"/></td>
																				<td>잔여일 : ${phone.REMAINDAY }</td>
																				<td class="strong" id="${phone.RENTALCODE }">
																					<button class="return">반납</button>
																					<button class="alt alarm">알림</button>
																				</td>					
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															<td class="strong">
																<button class="makeBtn small">상세</button>
															</td>
														</tr>
														<tr class="hide" style="display:none "  id="${phone.CODE }">
															<td colspan="1"></td>
															<td colspan="2">제조사 : ${phone.MAKER } </td>
															<td colspan="3">운영체제 : ${phone.OS }  ${phone.VERSION }</td>
															<td colspan="3">디스플레이 : ${phone.DISPLAY } 인치</td>
														</tr>
														<tr class="hide" style="display:none "  id="${phone.CODE }">
															<td colspan="1"></td>
															<td colspan="2">메모리 : ${phone.MEMORY } GB</td>
															<td colspan="3">비밀번호 : ${phone.PASSWORD }</td>
															<td colspan="3">맥주소 : ${phone.MACADDRESS }</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										</c:otherwise>
									</c:choose>
									<!-- 페이징 -->
									<c:if test="${pagination.totalRows gt 0 }">
										<!-- url 설정하기  -->
										<c:set var="url" value="phone?page=" />
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
								</section>
									<!-- 등록 모달 -->
								<div id="insert" class="modal">
									<h3>기기 등록하기</h3>
									<p class="middle"><strong class="important">*</strong> 표시는 필수입력값입니다.</p>
									<table>
										<colgroup>
											<col width="40%"/>
											<col width="60%"/>
										</colgroup>
					            		<tr>
					            			<th>기기명<strong class="important">*</strong></th>
						                	<td><input class="long" id="phoneName" type="text" placeholder="ex) 아이폰13"></td>
					                	</tr>
					            		<tr>
					            			<th>제조사<strong class="important">*</strong></th>
						                	<td><input class="long" id="phoneMaker" type="text" placeholder="ex) 애플 / 삼성"></td>
					                	</tr>
					            		<tr>
					            			<th>운영체제<strong class="important">*</strong></th>
						                	<td><input class="long" id="phoneOS" type="text" placeholder="ex) IOS / Android"></td>
					                	</tr>
					            		<tr>
					            			<th>버전<strong class="important">*</strong></th>
						                	<td><input class="long" id="phoneVersion" type="text"></td>
					                	</tr>
					            		<tr>
					            			<th>맥주소</th>
						                	<td><input class="long" id="phoneMac" type="text"></td>
					                	</tr>
					            		<tr>
					            			<th>디스플레이</th>
						                	<td><input class="normal" id="phoneDisplay" type="text"> 인치</td>
					                	</tr>
					            		<tr>
					            			<th>메모리</th>
						                	<td><input class="normal" id="phoneMemory" type="text"> GB</td>
					                	</tr>
					            		<tr>
					            			<th>비밀번호</th>
						                	<td><input class="long" id="phonePwd" type="text"></td>
					                	</tr>
						            </table>
									<footer>
										<button class="alt">기기등록</button>
									</footer>
								</div>
							</div> 
						</div>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script>
$(function(){
	
	const returnURL = "/admin/phone";
	
	const status = "<c:out value='${status}' />";
	if(status == 'insert'){
		alert("기기등록이 완료되었습니다.");
	}else if(status == 'approve'){
		alert("대여신청을 승인했습니다.");
	}else if(status == 'reject'){
		alert("대여신청을 반려했습니다.");		
	}else if(status == 'return'){
		alert("반납이 완료되었습니다.");
	}
	
	// 기기대여 신청 승인 . 반려 
	$('#phone-list tbody td').on('click', '.rental', function(){
		// 승인인 경우
		const rentalCode = $(this).closest('td').attr('id');
		let status = 'approve';
		if($(this).hasClass('approve')){
			const confirmValue = confirm('해당 요청을 승인하시겠습니까.');
			if(!confirmValue){
				return false;
			}
		} else{
			status = 'reject';
			const confirmValue = confirm('해당 요청을 반려하시겠습니까.');
			if(!confirmValue){
				return false;
			}
		}
		location.href = "rental?code="+rentalCode+"&status="+status+"&url="+returnURL;
	})
	
	// 반납처리 하기
	$('#phone-list tbody td').on('click', '.return', function(){
		const confirmValue = confirm('해당 기기를 반납처리하시겠습니까?');
		if(!confirmValue){
			return false;
		}
		const rentalCode = $(this).closest('td').attr('id');
		location.href = "rental/return?code="+rentalCode+"&status=delay&url="+returnURL;
	})
	
	// 연체알림 이메일 
	$('#phone-list tbody td').on('click', '.alarm', function(){
		const rentalCode = $(this).closest('td').attr('id');
		$.ajax({
			type:"get",
			url:"../rest/notify/overDue?rentalCode="+rentalCode,
			success: function(){
				alert('알림전송이 완료되었습니다.');
			},
			error:function(){
				alert('알림전송에 실패했습니다.');
			}
		});

	})
	

	$('#phone-list td').on('click', '.makeBtn', function(){
		const phoneCode = $(this).closest('tr').attr('id');
		const phoneContent = $(this).closest('tr').next('tr:eq(0)');
		
		if(phoneContent.css('display') == 'none'){
			$('.hide').css('display', 'none');
			if($('#'+phoneCode+'.hide')){
				$('#'+phoneCode+'.hide').css('display', '');
			}
		} else{
			if($('#'+phoneCode+'.hide')){
				$('#'+phoneCode+'.hide').css('display', 'none');
			}			
		}
	})
	
	function alertAndFocus(element, message){
		alert(message);
		element.focus();
	}
	
	function makeFormAndSendPost(path, params){
		// form 객체생성
		let form = $('<form></form>');
		// 속성 삽입
		form.attr("method", "post");
		form.attr("action", path);
		for(let key in params){
			form.append($('<input/>', {type:'hidden', name: key, value:params[key]}));
		}
		form.appendTo('table');
		
		form.submit();
	}
	
	// 모달관련
	$('#insert-phone').on('click', function(){
		$('#insert input').val('');
	})
	
	$('#insert footer').on('click', '.alt', function(){
		const name = $('#insert table #phoneName');
		const maker = $('#insert table #phoneMaker');
		const os = $('#insert table #phoneOS');
		const version = $('#insert table #phoneVersion');
		if(name.val() == ''){
			alertAndFocus(name, '기기명은 필수 입력값입니다!');
			return;
		}else if(maker.val() == ''){
			alertAndFocus(maker, '제조사는 필수 입력값입니다!');
			return;			
		}else if(os.val() == ''){
			alertAndFocus(os, '운영체제는 필수 입력값입니다!');
			return;			
		}else if(version.val() == ''){
			alertAndFocus(version, '버전은 필수 입력값입니다!');
			return;
		}
		const mac = $('#insert table #phoneMac');
		const display = $('#insert table #phoneDisplay');
		const memory = $('#insert table #phoneMemory');
		const pwd = $('#insert table #phonePwd');
		
		if(confirm('해당 정보로 기기를 등록하시겠습니까?')){
			makeFormAndSendPost('phone/insert', {modelName:name.val(), maker:maker.val(), os:os.val(), version:version.val(), macAddress:mac.val(), display:display.val(), memory:memory.val(), password:pwd.val()})
		}
	})


})
</script>
</body>
</html>