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
										                  <td><input type="text" placeholder="비밀번호를 입력해주세요."></td>
										                </tr>
										                <tr>
										                  <th><span>비밀번호 확인</span><strong class="important">*</strong></th>
										                  <td><input type="text" placeholder="비밀번호를 확인하세요"></td>
										                </tr>
										                <tr class="email">
										                  <th><span>이메일</span><strong class="important">*</strong></th>
										                  <td>
										                    <input type="text"  class="email" placeholder=""><span class="distance">@</span>
										                    <select>
										                    		<option>naver.com</option>
										                    		<option>gmail.com</option>
										                    		<option>daum.net</option>
										                    		<option>bccard.com</option>
										                    </select>
										                  </td>
										                </tr>
										                <tr>
										                  <th><span>휴대폰 번호</span></th>
										                  <td><input type="text" placeholder="ex) 010-1234-5678"></td>
										                </tr>
										                <tr>
										                  <th><span>소속 / 직급</span></th>
										                  <td><input type="text" placeholder="ex) 010-1234-5678"></td>
										                </tr>
										              </tbody>
										            </table>
										          </div>
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
		
<script src="/tpms/resources/static/js/main.js"></script>
</body>
</html>