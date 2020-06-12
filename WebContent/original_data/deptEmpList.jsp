<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.emp.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
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
		<title>deptEmp List</title>
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
		
		String searchWord ="";
		if(request.getParameter("searchWord")!=null){
			searchWord = request.getParameter("searchWord");
		}
		System.out.println(searchWord+" <-- serachWord");
		//페이지
		int currentPage = 1; // 처음페이지는 1페이지여서 1로지정
		if(request.getParameter("currentPage")!=null){ // 응답받을 페이지가 없다면
			// System.out.println(request.getParameter("currentPage")+"<----- param currentPage");
			currentPage = Integer.parseInt(request.getParameter("currentPage")); // 현재페이지는
			//System.out.println("if");
		} // 페이지를 응답받겠다
		//System.out.println(currentPage+ "<-- currentPage");
		int rowPerPage = 10; // 페이지당 출력할 데이터갯수
		if(request.getParameter("rowPerPage")!=null){ // rowPerPage를 응답 받으면
			rowPerPage=Integer.parseInt(request.getParameter("rowPerPage")); // 응답받은 rowPerPage를 rowPerPage로 지정
		}
		int beginLow = (currentPage-1)*10; // 데이터를 몇번째부터 출력할건지
		//데이터베이스 연결
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:mariadb://localhost:3306/yoonseon12", "root", "java1234");
		//System.out.println(conn+" <-- conn");
		
		PreparedStatement stmt = conn.prepareStatement(
				"select * from employees_dept_emp limit ?,?");
		stmt.setInt(1,beginLow);
		stmt.setInt(2,rowPerPage);
		//System.out.println(stmt+" <-- stmt");
		ResultSet rs = stmt.executeQuery();
		//System.out.println(rs+" <-- rs");
		ArrayList<DeptEmp> list = new ArrayList<DeptEmp>(); //동적배열
		while(rs.next()){
			DeptEmp a = new DeptEmp();
			a.empNo=rs.getInt("emp_no");
			a.deptNo=rs.getString("dept_no");
			a.fromDate=rs.getString("from_date");
			a.toDate=rs.getString("to_date");
			list.add(a);
		}
		//테이블 전체행의 수
		int lastPage = 0; //마지막페이지를 저장할 변수를 선언하고 초기화
		int totalRow = 0; // 데이터의 총갯수를 저장할 변수로 선언하고 초기화
		PreparedStatement stmt2 = conn.prepareStatement("select count(*) from employees_dept_emp");
		ResultSet rs2 = stmt2.executeQuery();
		//System.out.println(rs2+" <-- rs2");
		if(rs2.next()){
			totalRow = rs2.getInt("count(*)");
		}
		//System.out.println(totalRow+" <-- totalRow");
		lastPage= totalRow / rowPerPage; // 마지막페이지 = 데이터총개수/페이지당 출력할 데이터갯수
		if(totalRow%rowPerPage!=0){ // 데이터총개수/페이지당 출력할 데이터갯수의 나머지가 0이아니면
			lastPage+=1; // 초과하는 데이터를 표시하기위해 마지팍페이지+1
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
						<h2>부서별 직원의 근무기간</h2>
					</div>
					<div class="row">
						<div class="col-sm-10">
							<span><strong><%=totalRow%></strong>개의 데이터</span>
						</div>
						<div class="col-sm-2"">
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
								<th>emp_no</th>
								<th>dept_no</th>
								<th>from_date</th>
								<th>to_date</th>
							</tr>
						</thead>
						<tbody>	
						<%
							for(DeptEmp a : list){
						%>
							<tr>
								<td><%=a.empNo%></td>
								<td><%=a.deptNo%></td>
								<td><%=a.fromDate%></td>
								<td><%=a.toDate%></td>
							</tr>	
						<%
							} 
						%>
						</tbody>
					</table>
					<div style="text-align: center;">
						<a class="btn btn-secondary btn-sm" href="<<%=request.getRequestURI()%>?currentPage=1&rowPerPage=<%=rowPerPage%>"><<</a>
					<%
						if(currentPage>1){
					%>
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
					<%		
						} else{
					%>
							<a class="btn btn-secondary btn-sm" role="button" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>">이전</a>
					<%
						}
					%>
					<span>
						-<%=currentPage%>-
					</span>
					<%
						if(currentPage<lastPage){
					%>
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
					<%		
						} else{
					%>
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>">다음</a>
					<%
						}
					%>
						<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">>></a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>