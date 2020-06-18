<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gd.emp.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
	<head>
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
		<meta charset="UTF-8">
		<title>departmentList</title>
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
		Connection conn = null;
		List<DeptAverageSalary> list = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
			String query = "SELECT d.dept_no, d.dept_name, AVG(s.salary) 'avgSalary' ";
			query += "FROM employees_departments d ";
			query += "INNER JOIN employees_dept_emp de ";
			query += "INNER JOIN employees_salaries s ";
			query += "ON d.dept_no = de.dept_no AND de.emp_no = s.emp_no ";
			query += "GROUP BY d.dept_name ";
			query += "ORDER BY d.dept_no";
			stmt = conn.prepareStatement(query);
			rs = stmt.executeQuery();
			list = new ArrayList<DeptAverageSalary>();
			while (rs.next()) {
				DeptAverageSalary d = new DeptAverageSalary();
				d.deptNo = rs.getString("d.dept_no");
				d.deptName = rs.getString("d.dept_name");
				d.avgSalary = rs.getDouble("avgSalary");
				list.add(d);
			}
		// System.out.println(list.size())
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
		<div style="margin-bottom:100px;">
			<div id="custom-margin">
				<div class="container pt-3">
					<div style="margin-top:30px; margin-bottom:30px; text-align: center;">
						<h2>부서별 평균연봉</h2>
					</div>
					<table class="table" style="margin-top : 5px; text-align: center;">
						<thead>
							<tr class="table-secondary">
								<th>부서 번호</th>
								<th>부서 이름</th>
								<th>평균 급여</th>
							</tr>
						</thead>
						<tbody>
						<%
							for (DeptAverageSalary d : list) {
						%>
							<tr>
								<td><%=d.deptNo%></td>
								<td><%=d.deptName%></td>
								<td><%=d.avgSalary%></td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
				</div>
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