<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "gd.emp.DeptManager" %>
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
		
		String searchWord ="";
		if(request.getParameter("searchWord")!=null){
			searchWord = request.getParameter("searchWord");
		}
		System.out.println(searchWord+" <-- searchWord");
		//1.페이지
		int currentPage = 1; // 현재 페이지를 1로설정(초기값이 1페이지니까)
		if(request.getParameter("currentPage")!=null){
			//System.out.println(request.getParameter("currentPage")+"<----- param currentPage");
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
			//System.out.println("if");
		}
		//System.out.println(currentPage+" <- correntPage");
		int rowPerPage = 10; // 한페이지에 몇개의 데이터를 가져올지
		if(request.getParameter("rowPerPage")!=null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		int beginRow=(currentPage -1)*10; // 행을 어디서부터 출력할 것인가?
		
		//2.0 db설정
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		//2. 현재페이지의departments테이블 행들
		PreparedStatement stmt1 = conn.prepareStatement(
				"select * from employees_dept_manager order by dept_no asc limit ?,?");
		stmt1.setInt(1, beginRow); // 한페이지에 몇개씩?
		stmt1.setInt(2, rowPerPage); // 행을 어디서부터 출력할 것인가?
		ResultSet rs1= stmt1.executeQuery();
		//System.out.println(stmt1+" <-- stmt1");
		//System.out.println(rs1+" <-- rs");
		ArrayList<DeptManager> list= new ArrayList<DeptManager>();// 동적배열 list
		while(rs1.next()){
			DeptManager b = new DeptManager();
			b.deptNo = rs1.getString("dept_no");
			b.empNo = rs1.getInt("emp_no");
			b.fromDate = rs1.getString("from_date");
			b.toDate = rs1.getString("to_date");
			list.add(b); //b를 list에 추가
		}
		// 창넘기기
		int lastPage = 0; // 마지막페이지 변수를 선언 후 초기화
		int totalRow = 0; // 데이터의 총 개수 변수를 선언 후 초기화
		PreparedStatement stmt2 = conn.prepareStatement("select count(*) from employees_dept_manager");
		//System.out.println(stmt2+" <- stmt2");
		ResultSet rs2 = stmt2.executeQuery();
		if(rs2.next()){ //만약 다음페이지 값이 있다면
			totalRow = rs2.getInt("count(*)"); // 데이터 총갯수
		}
		//System.out.println(totalRow+" <-- totalRow");
		lastPage = totalRow / rowPerPage;
		if(totalRow%rowPerPage!=0){ // 다음행에 출력할 데이터가 있다면
			lastPage+=1; //마지막 페이지 하나 추가
		}
		//System.out.println(lastPage+" <-- lastPage");
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
						<h2>매니저 리스트</h2>
					</div>
					<div class="row">
						<div class="col-sm-10">
							<span>매니저  : <strong><%=totalRow%>명</strong></span>
						</div>
						<div class="col-sm-2">
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
					<table class="table" style="text-align: center; margin-top:5px;">
						<thead>
							<tr class="table-secondary">
								<th>dept_no</th>
								<th>emp_no</th>
								<th>from_date</th>
								<th>to_date</th>
							</tr>
						</thead>
						<tbody>
						<%
							for(DeptManager b : list){
						%>
							<tr>
								<td><%=b.deptNo%></td>
								<td><%=b.empNo%></td>
								<td><%=b.fromDate%></td>
								<td><%=b.toDate%></td>
							</tr>	
						<%
							}
						%>
						</tbody>
					</table>
					<div style="text-align: center;">
						<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=1&rowPerPage=<%=rowPerPage%>"><<</a>
					<%
						if(currentPage>1){
					%>
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
					<%
						} else{
					%>
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>">이전</a>
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