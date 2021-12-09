<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" type="image/png" href="/tpms/resources/static/images/head.png"/>
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>TPMS | 관리자</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="/tpms/resources/static/admin/css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body>
   <section id="header">
		<h1>
			<a class="navbar-brand" href="/tpms/admin/main">
				<img src="/tpms/resources/static/images/tpms_logo1.png" class="mx-3" alt="error" width="250" height="80" >
			</a>
		</h1>
	</section>
	<section>
        <div id="layoutSidenav">
            <%@ include file="../common/nav.jsp" %>
            <div id="layoutSidenav_content">
            <!--  메인 시작 -->
	        	<div class="container-fluid px-4">
	            	<h3 class="mt-4 mb-1">승인대기 목록</h3>
	                <ol class="breadcrumb mb-4">
	                	<li class="breadcrumb-item"><a href="index.html">승인</a></li>
	                    <li class="breadcrumb-item active">문의</li>
	                </ol>
	                         <table id="datatablesSimple">
	                             <thead>
	                                 <tr>
	                                     <th>순번 </th>
	                                     <th>기기명</th>
	                                     <th>제조사</th>
	                                     <th>대여기간</th>
	                                     <th>신청자</th>
	                                     <th>승인</th>
	                                 </tr>
	                             </thead>
	                             <tfoot>
	                                 <tr>
	                                     <th>순번 </th>
	                                     <th>기기명</th>
	                                     <th>제조사</th>
	                                     <th>대여기간</th>
	                                     <th>신청자</th>
	                                     <th>승인</th>
	                                 </tr>
	                             </tfoot>
	                             <tbody>
						            <c:forEach var="rental" items="${rentals }" varStatus="loop">
										<tr>
											<td>${loop.count }</td>
											<td>${rental.PHONENAME }</td>
											<td>${rental.PHONEMAKER }</td>
											<td><fmt:formatDate value="${rental.STARTDATE }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${rental.ENDDATE }" pattern="yyyy-MM-dd"/></td>
											<td>${rental.USERNAME } / ${rental.USERTEAM } (${rental.USERPOSITION })</td>
											<td>
												<button>승인</button>
												<button class="alt">반려</button>
											</td>
										</tr>
									</c:forEach>
	                             </tbody>
	                         </table>
	            </div>
                <!-- 종료  -->
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2021</div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
       </section>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
      <script src="/tpms/resources/static/admin/js/scripts.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
      <script src="/tpms/resources/static/admin/js/datatables-simple-demo.js"></script>
  </body>
</html>
