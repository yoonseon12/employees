<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Index</title>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<!-- Popper JS -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
		<!-- icon -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
		<style>
			.main{
				margin: 30px auto ;
				padding : 20px;
				width: 900px;
				border : 1px solid #343A40;
			}
			p{
				font-weight: bold;
			}
		</style>	  	
	</head>
	<body>
		<!-- 베너 -->
		<div>
			<jsp:include page="/inc/banner.jsp" ></jsp:include>
		</div>
		<!-- 메인 메뉴 -->
		<div>
			<jsp:include page="/inc/mainmenu.jsp" ></jsp:include>
		</div>
		<!-- 내용 -->
		<div class="container-fluid">
			<div class="main">
				<!-- 프로젝트 소개 -->
				<div class="text-center" style="margin-bottom:20px;">
					<span style="font-size:20px;"><strong>프로젝트 소개</strong></span>
				</div>
				<div class="text-center"style="margin-bottom:50px;">
					<p>MYSQL에서 제공하는 employees샘플 데이터베이스를 이용해 JSP를 사용하여 model1방식으로 구현하였습니다.</p>
					<p>제공된 기존 데이터들중 필요한 정보들을 확인할 수 있도록 JOIN하여  리스트를 구성하였습니다.</p>
				</div>
				<!-- 개발 프로그램 -->
				<div class="text-center" style="margin-bottom:20px;">
					<span style="font-size:20px;"><strong>개발 환경</strong></span>
				</div>
				<div>
					<div class="row" style="margin-bottom: 40px;">
						<div class="col-sm-6 text-center">
							<img width='150' height='150' src="<%=request.getContextPath()%>/imgs/java.jpg">
							<div>
								<span>JAVA 1.80_241</span>
							</div>
						</div>
						<div class="col-sm-6 text-center">
							<img width='150' height='150' src="<%=request.getContextPath()%>/imgs/eclipse.jpg">
							<div>
								<span>ECLIPSE 4.14.0</span>
							</div>
						</div>	
					</div>
					<div class="row">
						<div class="col-sm-6 text-center">
							<img width='150' height='150' src="<%=request.getContextPath()%>/imgs/mariadb.jpg">
							<div>
								<span>MARIA DB 10.4</span>
							</div>
						</div>
						<div class="col-sm-6 text-center">
							<img width='150' height='150' src="<%=request.getContextPath()%>/imgs/tomcat.jpg">
							<div>
								<span>APACHE-TOMCAT 9.0.30</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
	</body>
</html>