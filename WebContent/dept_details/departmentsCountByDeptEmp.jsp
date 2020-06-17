<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "gd.emp.*" %>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deptManager List</title>
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
				margin-left: 20%; 
				margin-right: 20%;
			}
		</style>
	</head>
	<body>
	<%
		request.setCharacterEncoding("utf-8"); // 인코딩 맞추기
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		String query = "SELECT d2.dept_no, d1.dept_name, d2.cnt FROM employees_departments d1 INNER JOIN (SELECT dept_no, COUNT(*) cnt FROM employees_dept_emp WHERE to_date = '9999-01-01' GROUP BY dept_no) d2 ON d1.dept_no = d2.dept_no ORDER BY d2.dept_no";
		PreparedStatement stmt = conn.prepareStatement(query);
		ResultSet rs= stmt.executeQuery();
		//System.out.println(stmt1+" <-- stmt1");
		//System.out.println(rs1+" <-- rs");
		ArrayList<DepartmentsCountByDeptEmp> list= new ArrayList<DepartmentsCountByDeptEmp>();// 동적배열 list
		while(rs.next()){
			DepartmentsCountByDeptEmp b = new DepartmentsCountByDeptEmp();
			b.deptNo = rs.getString("d2.dept_no");
			b.deptName = rs.getString("d1.dept_name");
			b.count = rs.getInt("d2.cnt");
			list.add(b); //b를 list에 추가
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
			<div style="margin-bottom: 100px">
				<div class="container pt-3">
					<div style="margin-top:30px; margin-bottom:30px; text-align: center;">
						<h2>부서별 사원수</h2>
					</div>
					<table class="table" style="text-align: center; margin-top:5px;">
						<thead>
							<tr class="table-secondary">
								<th>부서 번호</th>
								<th>부서 이름</th>
								<th>사원 수</th>
							</tr>
						</thead>
						<tbody>
						<%
							for(DepartmentsCountByDeptEmp b : list){
						%>
							<tr>
								<td><%=b.deptNo%></td>
								<td><%=b.deptName%></td>
								<td><%=b.count%></td>
							</tr>	
						<%
							}
						%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</body>
</html>