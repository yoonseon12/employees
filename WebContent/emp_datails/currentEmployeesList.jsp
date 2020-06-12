<%@page import="gd.util.LoggableStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet"
			href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		<!-- jQuery library -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<!-- Popper JS -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
		<!-- icon -->
		<link rel="stylesheet"
			href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
			integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
			crossorigin="anonymous">
		<meta charset="UTF-8">
		<title>현재 사원 조회</title>
		<style>
		#custom-margin{
			margin-left: 20%; 
			margin-right: 20%;
		}
		.custom-table{
			font-size: 13px;
			margin-top: 5px;
			vertical-align: middle;
		}
		.custom-table th{
			text-align: center;
			vertical-align: middle;
		}
		.custom-table td{
			vertical-align: middle;
		}
		</style>
	</head>
	<body>
		<%
		request.setCharacterEncoding("UTF-8");
		
		String selectMenu = request.getParameter("selectMenu");
		System.out.println(selectMenu+" <-- selectMenu");
		
		String searchWord ="";
		if(request.getParameter("searchWord")!=null){
			searchWord=request.getParameter("searchWord");
		}
		System.out.println(searchWord+" <-- searchWord");
		
		//페이지 값 받기
		int currentPage=1;
		if(request.getParameter("currentPage")!=null){
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage=10; // 한페이지에 출력할 데이터 갯수
		if(request.getParameter("rowPerPage")!=null){
			rowPerPage=Integer.parseInt(request.getParameter("rowPerPage"));
		}
		int beginRow = (currentPage-1)*rowPerPage; // 데이터를 몇번째 부터 출력?
				
		//마리아디비 설정
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/yoonseon12", "root", "java1234");
		//System.out.println(conn+" <--conn");
		PreparedStatement stmt1 = null;
		if(searchWord.equals("")){
			String query="";
			query += "SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, birth_date, gender, hire_date ";
			query += "FROM employees_employees "; 
			query += "WHERE emp_no IN(SELECT emp_no FROM employees_dept_emp "; 
			query += "WHERE to_date = '9999-01-01') ";
			query += "ORDER BY emp_no limit ?,?;";
			stmt1 = conn.prepareStatement(query);
			stmt1.setInt(1,beginRow);
			stmt1.setInt(2,rowPerPage);
		} else if(selectMenu.equals("firstName")){
			String query="";
			query += "SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, birth_date, gender, hire_date ";
			query += "FROM employees_employees "; 
			query += "WHERE emp_no IN(SELECT emp_no FROM employees_dept_emp "; 
			query += "WHERE to_date = '9999-01-01') ";
			query += "AND first_name LIKE ? ";
			query += "ORDER BY emp_no limit ?,?;";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1,"%"+searchWord+"%");
			stmt1.setInt(2, beginRow);
			stmt1.setInt(3, rowPerPage);
		} else if(selectMenu.equals("lastName")){
			String query="";
			query += "SELECT emp_no, CONCAT(first_name, ' ', last_name) AS name, birth_date, gender, hire_date ";
			query += "FROM employees_employees "; 
			query += "WHERE emp_no IN(SELECT emp_no FROM employees_dept_emp "; 
			query += "WHERE to_date = '9999-01-01') ";
			query += "AND last_name LIKE ? ";
			query += "ORDER BY emp_no limit ?,?;";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1,"%"+searchWord+"%");
			stmt1.setInt(2, beginRow);
			stmt1.setInt(3, rowPerPage);
		}
		//System.out.println(stmt1+" <-- stmt1");
		ResultSet rs1 = stmt1.executeQuery();
		// String 타입만 가질 수 있는 ArrayList를 만든다.
		ArrayList<CurrentEmployees> list = new ArrayList<CurrentEmployees>();
		while(rs1.next()){
			CurrentEmployees a = new CurrentEmployees();
			a.empNo = rs1.getInt("emp_no");
			a.name = rs1.getString("name");
			a.birthDate = rs1.getString("birth_date");
			a.gender = rs1.getString("gender");
			a.hireDate = rs1.getString("hire_date");
			list.add(a);
		}
		//System.out.println(list.size()+" <-- list.size");
		
		// 마지막페이지 값 설정
		int lastPage=0;
		int totalRow = 0;
		PreparedStatement stmt2 = null;
		if(searchWord.equals("")){
			String query2="";
			query2 += "SELECT COUNT(*) ";
			query2 += "FROM employees_employees "; 
			query2 += "WHERE emp_no IN(SELECT emp_no FROM employees_dept_emp "; 
			query2 += "WHERE to_date = '9999-01-01')";
			stmt2 = conn.prepareStatement(query2);
		}else if(selectMenu.equals("firstName")){
			String query2="";
			query2 += "SELECT COUNT(*) ";
			query2 += "FROM employees_employees "; 
			query2 += "WHERE emp_no IN(SELECT emp_no FROM employees_dept_emp "; 
			query2 += "WHERE to_date = '9999-01-01') ";
			query2 += "AND first_name LIKE ?";
			stmt2 = conn.prepareStatement(query2);
			stmt2.setString(1,"%"+searchWord+"%");
		}else if(selectMenu.equals("lastName")){
			String query2="";
			query2 += "SELECT COUNT(*) ";
			query2 += "FROM employees_employees "; 
			query2 += "WHERE emp_no IN(SELECT emp_no FROM employees_dept_emp "; 
			query2 += "WHERE to_date = '9999-01-01') ";
			query2 += "AND last_name LIKE ?";
			stmt2 = conn.prepareStatement(query2);
			stmt2.setString(1,"%"+searchWord+"%");
		}
		ResultSet rs2 = stmt2.executeQuery();
		if(rs2.next()){
			totalRow = rs2.getInt("count(*)");
		}
		//System.out.println(totalRow+" <-- totalRow");
		lastPage = totalRow/rowPerPage;
		if(totalRow%rowPerPage != 0){
			lastPage+=1;
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
			<div style="margin-bottom:100px;">
				<div class="container pt-3">
					<div style="margin-top:30px; margin-bottom:30px; text-align: center;">
						<h2>현재 사원 목록</h2>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="dropdown">
								<button type="button" class="dropdown-toggle" data-toggle="dropdown" style="float: right;">
									<%=rowPerPage%>개씩
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="<%=request.getRequestURI()%>?rowPerPage=5">5개씩</a>
									<a class="dropdown-item" href="<%=request.getRequestURI()%>?rowPerPage=10">10개씩</a>
									<a class="dropdown-item" href="<%=request.getRequestURI()%>?rowPerPage=15">15개씩</a>
								</div>
							</div>
						</div>
					</div>
					<table class="table" style="text-align: center; margin-top: 5px;">
						<thead>
							<tr class="table-secondary">
								<th>사원 번호</th>
								<th>이름</th>
								<th>생일</th>
								<th>성별</th>
								<th>입사일</th>
							</tr>
						</thead>
						<tbody>
						<%
							for(CurrentEmployees a : list){
						%>	
							<tr>
								<td><%=a.empNo%></td>
								<td><%=a.name%></td>
								<td><%=a.birthDate%></td>
								<td><%=a.gender%></td>
								<td><%=a.hireDate%></td>
							</tr>
						<%	
							}
						%>
						</tbody>
					</table>
					<div style="margin:20px; text-align: center;">
						<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=1&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>&selectMenu=<%=selectMenu%>"><<</a>
						<%
							if(currentPage>1){
						%>
								<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>&selectMenu=<%=selectMenu%>">이전</a>
						<%
							} else{
						%>
								<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>&selectMenu=<%=selectMenu%>">이전</a>
						<%
							}
						%>
						<span>-<%=currentPage%>-</span>
						<%
							if(currentPage<lastPage){
						%>
								<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>&selectMenu=<%=selectMenu%>">다음</a>
						<%
							} else{
						%>
								<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>&selectMenu=<%=selectMenu%>">다음</a>
						<%
							}
						%>
						<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>&selectMenu=<%=selectMenu%>">>></a>
					</div>
					<!-- 검색 -->
					<div style="margin:20px; text-align: center;">
						<form method="post" action="<%=request.getRequestURI()%>">
							<select name="selectMenu">
								<option value="lastName">성(이름)</option>
								<option value="firstName">이름</option>
							</select>
							<input type="text" name="searchWord" placeholder="사원 이름 검색">
							<button type="submit">
								<i class="fa fa-search"></i>
							</button>
						</form>
					</div>
				</div>
			</div>	
		</div>	
	</body>
</html>