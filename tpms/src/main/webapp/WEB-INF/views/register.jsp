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
									<div class="col-2"></div>
									<div class="col-8 col-12-small">
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
										                  	<td><input id="user-id" type="text" placeholder="사번을 입력하세요."></td>
										                </tr>
										                <tr>
											           		<th><span>이름</span><strong class="important">*</strong></th>
											                <td><input id="user-name" type="text" placeholder="ex) 김비씨"></td>
										                </tr>
										                <tr>
										                  	<th><span>비밀번호</span><strong class="important">*</strong></th>
										                 	<td><input id="user-password" type="password" placeholder="비밀번호를 입력해주세요."></td>
										                </tr>
										                <tr>
											               	<th><span>비밀번호 확인</span><strong class="important">*</strong></th>
											             	<td><input id="user-passwordConfirm" type="password" placeholder="비밀번호를 확인하세요"></td>
										                </tr>
										                <tr class="email">
										                  	<th><span>이메일</span><strong class="important">*</strong></th>
										                  	<td><input id="user-email" type="email"  class="email" placeholder="ex) abc@bccard.com"></td>
										                </tr>
										                <tr>
										                  	<th><span>휴대폰 번호</span></th>
										                  	<td><input id="user-phone" type="text" placeholder="ex) 010-1234-5678"></td>
										                </tr>
										                <tr>
										                	<th><span>소속 / 직급</span></th>
										                  	<td>
										               			<input class="small" type="text" id="user-team" name="team" placeholder="ex) 페이북 개발팀">
										               			<span class="distance">/</span>
										               			<select name="position" id="position">
										                  			<option selected disabled>선택하세요</option>
										                  			<option value="인턴">인턴  </option>
										                  			<option value="사원">사원 </option>
										                  			<option value="대리">대리 </option>
										                  			<option value="과장">과장 </option>
										                  			<option value="팀장">팀장 </option>
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
										<div class="col-2"></div>
									</div>
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
	
	function alertAndFocus(element, message){
		alert(message);
		element.focus();
	}
	
	function confirmAndFocus(element, message){
		if(!confirm(message)){
			element.focus();
		}
		return confirmValue;
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
	
	$('#registerBtn').on('click', '.alt', function(){
		if(confirm('회원가입을 취소하시겠습니까?')){
			location.href = "/tpms/home";
		}
		return;
	})
	
	$('#registerBtn').on('click', '.submit' ,function(){
		const table = $('.join_form table tbody');
		let code = table.find('#user-id');
		let name = table.find('#user-name');
		let password = table.find('#user-password');
		let passwordConfirm = table.find('#user-passwordConfirm');
		let email = table.find('#user-email');
		let phone = table.find('#user-phone');
		let team = table.find('#user-team');
		let position = table.find('#position');
		
		// 유효성 검사
		if(code.val() == ''){
			alertAndFocus(code, '아이디(사번)는 필수 입력값입니다!');
			return;
		}else if(code.val().length != 8){
			alertAndFocus(code, '아이디(사번)은 숫자 8자리 입니다.');
			return;			
		}else if(name.val() == ''){
			alertAndFocus(name, '이름은 필수 입력값입니다!');
			return;			
		}else if(password.val() == ''){
			alertAndFocus(password, '비밀번호는 필수 입력값입니다!');
			return;
		}else if(passwordConfirm.val() == ''){
			alertAndFocus(passwordConfirm, '비밀번호를 확인해주세요!');
			return;
		}else if(passwordConfirm.val() != password.val()){
			alertAndFocus(passwordConfirm, '비밀번호가 일치하지 않습니다!');
			return;
		}else if(email.val() == ''){
			alertAndFocus(email, '이메일은 필수 입력값입니다!');
			return;
		}
		if(phone.val() == ''){
			if(!confirmAndFocus(phone, '휴대폰 정보를 입력하지 않으시겠습니까?')){
				return;
			}
		}else if(team.val() == ''){
			if(!confirmAndFocus(team, '소속 팀 정보를 입력하지 않으시겠습니까?')){
				return;
			}
		}
		if(position.val() == null){
			if(!confirmAndFocus(position, '직급 정보를 입력하지 않으시겠습니까?')){
				return;
			}
		}
		
		if(!confirm('회원가입 하시겠습니까?')){
			return;
		}
		
		let ableUser = true;
			
		$.ajax({
			type:"get",
			url:"rest/isAbleUser",
			dataTye:"json",
			data:{userCode: code.val()},
			async: false
		}).done(function(result){
			ableUser = result;
		})
		if(ableUser){
			makeFormAndSendPost('register', {code:code.val(), name:name.val(), password:password.val(), email:email.val(), phone:phone.val(), team:team.val(), position:position.val()})
		}else{
			alert("이미 가입된 사용자입니다.");
			code.focus();
		}
		
	})
})
</script>
</body>
</html>