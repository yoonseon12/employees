<%@page import="gd.emp.Departments"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>부서 수정</title>
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
			#custom-margin{
				margin-left: 25%;
				margin-right: 25%;
				margin-top: 40px;
			}
		</style>
	</head>
	<body>
		<%
			request.setCharacterEncoding("UTF-8");
		
			String deptNo = request.getParameter("deptNo");
			System.out.println(deptNo+" <- deptNo");
			
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			Departments d = null;
			try{
				conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
				System.out.println(conn+" <-- conn"); //연결 디버깅
				stmt = conn.prepareStatement("SELECT dept_no, dept_name FROM employees_departments WHERE dept_no=?");
				stmt.setString(1, deptNo);
				System.out.println(stmt+" <- stmt");
				rs= stmt.executeQuery();
				if(rs.next()){
					d = new Departments();
					d.deptNo = rs.getString("dept_no");
					d.deptName = rs.getString("dept_name");
				}
		%>
		<!-- 베너 -->
		<div>
			<jsp:include page="/inc/banner.jsp" ></jsp:include> <!-- jsc:include = 모듈을 가져온다 -->
		</div>
		<!-- 메인 메뉴 -->
		<div>
			<jsp:include page="/inc/mainmenu.jsp" ></jsp:include><!-- jsc:include = 모듈을 가져온다 -->
		</div>
		<!-- 내용 -->
		<div id="custom-margin">
			<div style="margin-bottom:30px;">
				<h3>부서 수정</h3>
			</div>
			<div>
				<form method="post" action="<%=request.getContextPath()%>/dept_details/updateDepartmentsAction.jsp">
					<div style="margin-bottom: 20px;">
						<div style="margin-bottom: 20px;">
							<div>
								<span>부서번호</span>
							</div>
							<div>
								<input style="background: white;" type="text" class="form-control" name="deptNo" value="<%=d.deptNo%>" readonly="readonly">
							</div>
						</div>
						<div>
							<div>
								<span>부서 이름</span>
							</div>
							<div>
								<input type="text" class="form-control" name="deptName" value="<%=d.deptName%>">
							</div>
						</div>
					</div>
					<div class="text-center">
		 				<button class="btn btn-secondary btn-sm" type="submit">수정하기</button>
					</div>
				</form>
			</div>
		</div>
		<%
			} finally{
				rs.close();
				stmt.close();
				conn.close();
			}
		%>
	</body>
</html>