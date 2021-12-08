<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>TPMS || 회원가입</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/tpms/resources/static/assets/css/main.css" />
	<link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
</head>
<body class="homepage is-preload">
	<div id="page-wrapper">
		<!-- 헤더 -->
		<c:set var="menu" value="main"/>
		<%@ include file="common/header.jsp" %>
		<!-- 메인 바디 -->
			<section id="main">
				<div class="container">
					<div class="row">	
						<div class="col-12">
							<section>
								<header class="major">
									<h2>회원가입</h2>
								</header>
								<div class="row">
									<div class="col-1"></div>
									<div class="col-10 col-12-small">
										<section class="box">
										      <div class="container register">
										        <div>
										          <p><strong class="important">*</strong> 표시항목은 필수입력 값입니다.</p>
										          <div class="join_form">
										            <table>
										              <colgroup>
										                <col width="30%"/>
										                <col width="auto"/>
										              </colgroup>
										              <tbody>
										            		<tr>
										             		<th><span>아이디(사번)</span><strong class="important">*</strong></th>
										                  	<td><input type="text" placeholder="사번을 입력하세요."></td>
										                </tr>
										                <tr>
											           		<th><span>이름</span><strong class="important">*</strong></th>
											                	<td><input type="text" placeholder=""></td>
										                </tr>
										                <tr>
										                  	<th><span>비밀번호</span><strong class="important">*</strong></th>
										                 	<td><input type="password" placeholder="비밀번호를 입력해주세요."></td>
										                </tr>
										                <tr>
											               	<th><span>비밀번호 확인</span><strong class="important">*</strong></th>
											             	<td><input type="password" placeholder="비밀번호를 확인하세요"></td>
										                </tr>
										                <tr class="email">
										                  	<th><span>이메일</span><strong class="important">*</strong></th>
										                  	<td><input type="email"  class="email" placeholder="abc@bccard.com"></td>
										                </tr>
										                <tr>
										                  	<th><span>휴대폰 번호</span></th>
										                  	<td><input type="text" placeholder="ex) 010-1234-5678"></td>
										                </tr>
										                <tr>
										                		<th><span>소속 / 직급</span></th>
										                  	<td>
										                  		<select id="department" >	
										                  			<option selected>선택하세요 </option>
										                  			<c:forEach var="dept" items="${depts }">
										                  				<option>${dept}</option>
										                  			</c:forEach>
										                  			<option value="direct">직접입력  </option>
										                  		</select>
										               			<span class="distance"></span>
										               			<select id="team">
										               			</select>
										               			<input type="text" id="teamDirect" name="">
										               			<span class="distance">/</span>
										               			<select>
										                  			<option>인턴  </option>
										                  			<option>사원 </option>
										                  			<option>대리 </option>
										                  			<option>과장 </option>
										                  			<option>팀장 </option>
										               			</select>
										               		</td>
										                </tr>
										              </tbody>
										            </table>
										          </div>
										          <footer>
													<ul class="actions" id="registerBtn">
														<li><a class="button submit">회원가입</a></li>
														<li><a class="button alt">취소</a></li>
													</ul>
												</footer>
										        </div> 
										      </div>
										</section>
									</div>
									<div class="col-1"></div>
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
<script type="text/javascript">
$(function(){
	
	$("#teamDirect").hide();
	
	$('#department').on('change', function(){
		let dept = $('#department').val();
		if(dept == "direct"){
			$("#teamDirect").show();
		}else{
			$("#teamDirect").hide();			
			$.ajax({
				type:"GET",
				url:"rest/getTeams",
				data:{dept:dept},
				dataType:"json"
			}).done(function(teams){
				$opt = "";
				$.each
				$opt += "";
			})
		}
	})
	
	$('#registerBtn').on('click', function(){
		console.log("회원가입 시도 ");
	})
})
</script>
</body>
</html>