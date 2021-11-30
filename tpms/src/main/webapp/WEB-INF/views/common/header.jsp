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
<header class="my-3 mt-0">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
	    	<a class="navbar-brand" href="/tpms/main">
	    		<img src="/tpms/resources/images/tpms_logo1.png" class="mx-3" alt="error" width="130" height="40" >
	    	</a>
		    <div class="collapse navbar-collapse mx-3" >
			  	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
			  		<li class="nav-item mx-3" >
			       		<a class="nav-link active fs-5 fw-bold"  href="#">기기대여</a>
			        </li>
			        <li class="nav-item mx-3">
			          	<a class="nav-link fs-5 fw-bold" href="#">문의</a>
			        </li>
			  	</ul>	
			  	<c:choose>
			  		<c:when test="${empty LOGINED_USER }">
			  			<div class="text-end">
				          	<a class="btn btn-outline-danger fw-bold" href="/tpms/login">로그인</a>
				   		</div>
			  		</c:when>
			  		<c:otherwise>
						<div class="collapse navbar-collapse justify-content-end" id="navbarNavDarkDropdown">
					      <ul class="navbar-nav">
					        <li class="nav-item dropdown">
					          <a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					          	<strong>${LOGINED_USER.name}</strong> 님 안녕하세요!
					          </a>
					          <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarDarkDropdownMenuLink">
					            <li><a class="dropdown-item" href="#">내 기록관리</a></li>
					            <li><a class="dropdown-item" href="/tpms/logout">로그아웃</a></li>
					          </ul>
					        </li>
					      </ul>
					    </div>
			  		</c:otherwise>
			  	</c:choose>
		    </div>
	  </div>
	</nav>
</header>