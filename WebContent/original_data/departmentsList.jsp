
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="gd.emp.Departments"%>
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
		
		//1. 페이지
		int currentPage = 1; // 현재 페이지값의 값을 저장하려고 변수 만듬
		if (request.getParameter("currentPage") != null) {
			// 만약 응답받을 페이지의 값이 없다면
			currentPage = Integer.parseInt(request.getParameter("currentPage")); //현재페이지 출력
		} // 응답받을페이지(현재페이지) = 페이지 받음
		//System.out.println(currentPage+" <-- currentPage");
		int rowPerPage = 5; // 한창에 몇개씩 볼것인가
		if(request.getParameter("rowPerPage")!=null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		int beginRow = (currentPage - 1) * rowPerPage; // 행을 어디서부터 출력하냐
		//2.0 database
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ArrayList<Departments> list = null;
		try{		
			conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
			//System.out.println(conn+" <-- conn");
			//2. 현재페이지의 departments 테이블 행들
			list = new ArrayList<Departments>();//현재 페이지의 department에 행을 저장하려고 만듬
			stmt1 = conn.prepareStatement("select * from employees_departments order by dept_no asc limit ?,?");
			stmt1.setInt(1, beginRow); // 처음부터
			stmt1.setInt(2, rowPerPage); // ??까지
			//System.out.println(stmt1+" <-- stmt1");
			rs1 = stmt1.executeQuery(); // -> rs1안의 데이터 -> list
			while (rs1.next()) {
				Departments d = new Departments();
				d.deptNo = rs1.getString("dept_no");
				d.deptName = rs1.getString("dept_name");
				list.add(d);
			}
			// System.out.println(list.size());
	
			// 3. departments 테이블 전체행의 수
			int lastPage = 0;
			int totalRow = 0;
			stmt2 = conn.prepareStatement("select count(*) from employees_departments");
			//System.out.println(stmt2+" <--stmt2");
			rs2 = stmt2.executeQuery();
			if (rs2.next()) {
				totalRow = rs2.getInt("count(*)");
			}
			lastPage = totalRow / rowPerPage;
			if (totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
			//System.out.println(lastPage+" <-- lastPage");
			//System.out.println(totalRow+" <-- totalRow");
			if(totalRow==0){ //만약 데이터 총개수가 0 이라면(데이터를 검색했는데 값이 없다면)
				lastPage=currentPage; // 마지막페이지를 현재페이지로 줘서 마지막페이지가0인 오류를 없앰
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
		<div style="margin-bottom:100px;">
			<div id="custom-margin">
				<div class="container pt-3">
					<div style="margin-top:30px; margin-bottom:30px; text-align: center;">
						<h2>부서 조회</h2>
					</div>
					<!-- 테이블 위에 행 (몇개의 페이지랑 몇개씩 페이지 출력할건지 있는 부분) -->
					<div>
						<div class="row">
							<div class="col-sm-10">
								<span style="vertical-align : sub;">부서개수 : <strong><%=totalRow%></strong></span>
							</div>
							<div class="col-sm-2">
								<div class="dropdown" style="float: right;">
									<button type="button" class="dropdown-toggle" data-toggle="dropdown">
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
						<table class="table" style="margin-top : 5px; text-align: center;">
							<thead>
								<tr class="table-secondary">
									<th>부서 번호</th>
									<th>부서 이름</th>
								</tr>
							</thead>
							<tbody>
							<%
								for (Departments d : list) {
							%>
								<tr>
									<td><%=d.deptNo%></td>
									<td><%=d.deptName%></td>
								</tr>
							<%
								}
							%>
							</tbody>
						</table>
						<!-- 페이지 -->
						<div style="text-align: center;">
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=1&rowPerPage=<%=rowPerPage%>"><<</a>
						<%
							if(currentPage > 1){
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
							if(currentPage < lastPage){
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
		</div>
		<%
		} finally{
			rs2.close();
			stmt2.close();
			rs1.close();
			stmt1.close();
			conn.close();
		}
		%>
	</body>
</html>