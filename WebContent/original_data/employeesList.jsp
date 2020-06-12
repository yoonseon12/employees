<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.Employees"%>
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
		<title>employees List</title>
		<style>
			#custom-margin{
				margin-left: 20px; margin-right: 20px;
			}
		</style>
	</head>
	<body>
	<%
		request.setCharacterEncoding("utf-8"); // 인코딩 맞추기

		//1. 페이지
		int currentPage = 1; // 현재페이지값을 저장하기위해 변수를 만듦 (첫번째의 현재페이지는 1이니까 1이라고 저장)
		if (request.getParameter("currentPage") != null) {
			// 만약 응답받을 페이지의 값이 null이 아니라면 -> 응답받을 페이지의 값이 있다면 
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			//응답받을 페이지 = 응답을 받아 페이지를받음  //문자형인 currentPage의 값을 정수형으로 받아라
		}
		//System.out.println(currentPage+" <-- currentPage");
		int rowPerPage = 10; // 한 페이지에 데이터를 몇개씩 볼것인가
		if(request.getParameter("rowPerPage")!=null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		int beginRow = (currentPage - 1) * rowPerPage; // 행을 어디서부터 출력할 것인가?
		//첫번째페이지 0*10=0부터  두번째 페이지 1*10=10부터 세번째페이지 2*10*20부터
		//System.out.println(rowPerPage);
		//System.out.println(beginRow);
		//2.0 database 설정
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:mariadb://localhost:3306/yoonseon12", "root", "java1234");
		//2. 현재 페이지의 departments 테이블 행들
		//System.out.println(conn+" <-- conn");
		PreparedStatement stmt1 = null;
		stmt1 = conn.prepareStatement("select * from employees_employees order by emp_no asc limit ?,?");
		stmt1.setInt(1, beginRow);
		stmt1.setInt(2, rowPerPage);
		System.out.println(stmt1+"<-- stmt1");
		ResultSet rs1 = stmt1.executeQuery();
		//System.out.println(stmt1+" <-- stmt1");
		ArrayList<Employees> list = new ArrayList<Employees>();
		while (rs1.next()) {
			Employees d = new Employees(); // 클래스 새로운 배열을 선언(?) -선언할 데이터는 아래에 있는 값들
			// d.(클래스에 있는값)=rs.get(형태)("테이블 열 이름");
			d.empNo = rs1.getInt("emp_no");
			d.birthDate = rs1.getString("birth_date");
			d.firstName = rs1.getString("first_name");
			d.lastName = rs1.getString("last_name");
			d.gender = rs1.getString("gender");
			d.hireDate = rs1.getString("hire_date");
			list.add(d); // 변수 d의 값을 list에 더한다 // rs1안의 데이터 -> list
		}
		//3. departments 테이블 전체행의 수
		int lastPage = 0; // 마지막페이지 변수를 선언하고 초기화
		int totalRow = 0; // 데이터의 총갯수 변수를 선언하고 초기화
		PreparedStatement stmt2 = null;
		stmt2 = conn.prepareStatement("select count(*) from employees_employees"); // 데이터의 갯수를 출력하는 쿼리문
		System.out.println(stmt2+" <- stmt2");
		ResultSet rs2 = stmt2.executeQuery();
		if (rs2.next()) {
			totalRow = rs2.getInt("count(*)"); // 카운터의 값을 받아옴
		}
		lastPage = totalRow / rowPerPage; // 마지막페이지 = 데이터 총갯수/한페이지에 볼 데이터 갯수
		if (totalRow % rowPerPage != 0) { // 만약 (데이터 총갯수/한페이지에 볼 데이터 갯수)계산한 값이 나머지가 없다면
			lastPage += 1; // 마지막페이지를 1늘림
		}
		//System.out.println(totalRow+" <-- totalRow");
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
			<div style="margin-bottom: 100px;">
				<div class="container pt-3">
					<div style="margin-top:30px; margin-bottom:30px; text-align: center;">
						<h2>직원 리스트</h2>
					</div>
					<div class="row">
						<div class="col-sm-10">
							<span>전체직원 :<strong> <%=totalRow%>명</strong></span>
						</div>
						<div class="col-sm-2">
							<div class="dropdown">
								<button type="button" class="dropdown-toggle" data-toggle="dropdown" style="float: right;">
								<%=rowPerPage%>개씩
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href='<%=request.getRequestURI()%>?rowPerPage=5'>5개씩</a>
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
								<th>birth_date</th>
								<th>first_name</th>
								<th>last_name</th>
								<th>gender</th>
								<th>hire_date</th>
							</tr>
						</thead>
						<tbody>
						<%
							for (Employees d : list) {
						%>
							<tr>
								<td><%=d.empNo%></td>
								<td><%=d.birthDate%></td>
								<td><%=d.firstName%></td>
								<td><%=d.lastName%></td>
								<td><%=d.gender%></td>
								<td><%=d.hireDate%></td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
					
					<!-- 페이지 -->
					<div style="text-align: center; margin-top: 35px;">
						<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=1&rowPerPage=<%=rowPerPage%>"><<</a>
					<%
						if(currentPage > 1) {
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
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>">다음</a>
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
		</div>s	
	</body>
</html>