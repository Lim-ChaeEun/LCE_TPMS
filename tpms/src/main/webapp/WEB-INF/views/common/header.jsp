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
		<c:choose>
			<c:when test="${not empty LOGINED_USER and LOGINED_USER.admin eq 'Y'}">
				<a class="navbar-brand" href="/tpms/admin/main">
					<img src="/tpms/resources/static/images/tpms_logo1.png" class="mx-3" alt="error" width="230" height="70" >
				</a>
			</c:when>
			<c:otherwise>
				<a class="navbar-brand" href="/tpms/user/main">
					<img src="/tpms/resources/static/images/tpms_logo1.png" class="mx-3" alt="error" width="230" height="70" >
				</a>
			</c:otherwise>
		</c:choose>
	</h1>
	<p class="header">Test Phone Management System</p>
	<!-- 네비바 -->
	<nav id="nav">
		<ul>
			<c:if test="${not empty LOGINED_USER }">
				<c:choose>
					<c:when test="${LOGINED_USER.admin eq 'N'}">
						<li class="${menu eq 'main' ? 'current' : '' }"><a href="/tpms/user/list">대여</a></li>
						<li class="${menu eq 'inquiry' ? 'current' : '' }"><a href="/tpms/user/inquiry">문의</a></li>
						<li class="${menu eq 'my' ? 'current' : '' }">
							<a href="">${LOGINED_USER.name} 님</a>
							<ul>
								<li><a href="/tpms/user/history/rental">내 대여이력 확인</a></li>
								<li><a href="/tpms/user/history/inquiry">내 문의내역 확인</a></li>
								<li><a href="/tpms/logout">로그아웃</a></li>
							</ul>
						</li>
					</c:when>
					<c:otherwise>
						<li class="${menu eq 'approval' ? 'current' : '' }"><a href="/tpms/admin/main">승인관리</a></li>
						<li class="${menu eq 'phone' ? 'current' : '' }"><a href="/tpms/admin/phone">기기관리</a></li>
						<li class="${menu eq 'user' ? 'current' : '' }"><a href="/tpms/admin/user">회원관리</a></li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
	</nav>
</section>