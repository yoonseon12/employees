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
				margin: 50px auto ;
				padding : 30px 20px;
				width: 1000px;
				border : 1px solid #343A40;
			}
			p{
				font-weight: bold;
			}
			img{
				margin : 0px 15px;
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
					<div class="row text-center" style="margin-bottom: 40px;">
						<div class="col-sm-2">
							<div>
								<h4>Language</h4>
							</div>
							<div>
								<div>
									JAVA <small>v.1.8</small>
								</div>
							</div>
						</div>
						<div class="col-sm-2">
							<div>
								<h4>Front Skill</h4>
							</div>
							<div>
								<div>
									HTML5
								</div>
								<div>
									CSS
								</div>
								<div>
									BootStrap <small>B4</small>
								</div>
							</div>
						</div>
						<div class="col-sm-2">
							<div>
								<h4>Back Skill</h4>
							</div>
							<div>
								JSP
							</div>
						</div>
						<div class="col-sm-2">
							<div>
								<h4>DB</h4>
							</div>
							<div>
								MariaDB <small>v.10.4</small>
							</div>
						</div>
						<div class="col-sm-2">
							<div>
								<h4>Tool</h4>
							</div>
							<div>
								<div>
									Eclipse<small> v.4.14</small>
								</div>
								<div>
									HeidiSQL
								</div>
							</div>
						</div>
						<div class="col-sm-2">
							<div>
								<h4>Web Server</h4>
							</div>
							<div>
								Tomcat<small> v.9</small>
							</div>
						</div>
					</div>
					<br>
					<br>
					<div class="text-center">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/java.jpg">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/html5.jpg">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/bootstrap.jpg">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/jsp.jpg">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/mariadb.jpg">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/eclipse.jpg">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/heidisql.jpg">
						<img width='80' height='80' src="<%=request.getContextPath()%>/imgs/tomcat.jpg">
					</div>
				</div>
			</div>
		</div>	
	</body>
</html>