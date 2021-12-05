<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="string" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!doctype html>
<head>
<meta charset="utf-8">
</head>
<!-- 헤더 시작 -->
<section id="header">
	<!-- TPMS 로고 넣기 -->
	<h1>
		<a class="navbar-brand" href="/tpms/main">
			<img src="/tpms/resources/static/images/tpms_logo1.png" class="mx-3" alt="error" width="200" height="60" >
		</a>
	</h1>
	<!-- 네비바 -->
	<nav id="nav">
		<ul>
			<li class="${menu eq 'main' ? 'current' : '' }"><a href="/tpms/main">대여</a></li>
			<li class="${menu eq 'inquiry' ? 'current' : '' }"><a href="/tpms/user/inquiry">문의</a></li>
			<li class="${menu eq 'my' ? 'current' : '' }">
				<c:choose>
			  		<c:when test="${empty LOGINED_USER }">
						<a href="/tpms/login">로그인</a>
			  		</c:when>
			  		<c:otherwise>
						<a>${LOGINED_USER.name} 님</a>
						<ul>
							<li><a href="/tpms/user/history/rental">내 대여이력 확인</a></li>
							<li><a href="/tpms/user/history/inquiry">내 문의내역 확인</a></li>
							<li><a href="/tpms/logout">로그아웃</a></li>
						</ul>
			  		</c:otherwise>
			  	</c:choose>
			</li>
		</ul>
	</nav>
</section>