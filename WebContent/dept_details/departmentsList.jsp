
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
		
		String searchWord="";
		if(request.getParameter("searchWord")!=null){
			searchWord = request.getParameter("searchWord");
		}
		System.out.println(searchWord+" <-- searchWord");
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
		String tlqkf = null;
		System.out.println(tlqkf);
		//2.0 database
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null; // 변수안에 값을 넣기전에일단 초기화 시킴
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		//System.out.println(conn+" <-- conn");
		//2. 현재페이지의 departments 테이블 행들
		ArrayList<Departments> list = new ArrayList<Departments>();//현재 페이지의 department에 행을 저장하려고 만듬
		PreparedStatement stmt1 = null;
		// 동적 쿼리
		if(searchWord.equals("")){ // searchWord의 값이 공백이라면 -> 검색을 하지 않았다면 
			stmt1 = conn.prepareStatement("select * from employees_departments order by dept_no asc limit ?,?");
			stmt1.setInt(1, beginRow); // 처음부터
			stmt1.setInt(2, rowPerPage); // ??까지
		}else{ // searchWord의 값이 공백이아니라면 -> 검색을 했다면
			stmt1 = conn.prepareStatement("select * from employees_departments where dept_name like ? order by dept_no asc limit ?,?");
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setInt(2, beginRow);
			stmt1.setInt(3, rowPerPage);
		}
		//System.out.println(stmt1+" <-- stmt1");
		ResultSet rs1 = null;
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
		PreparedStatement stmt2 = null;
		if(searchWord.equals("")){
			stmt2 = conn.prepareStatement("select count(*) from employees_departments");
		}else{
			stmt2 = conn.prepareStatement("select count(*) from employees_departments where dept_name like ?");
			stmt2.setString(1, "%"+searchWord+"%");
		}
		//System.out.println(stmt2+" <--stmt2");
		ResultSet rs2 = null;
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
									<th>수정</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
							<%
								for (Departments d : list) {
							%>
								<tr>
									<td><%=d.deptNo%></td>
									<td><%=d.deptName%></td>
									<td>
										<a href="<%=request.getContextPath()%>/dept_details/updateDepartmentsForm.jsp?deptNo=<%=d.deptNo%>" class="btn btn-secondary btn-sm" role="button">수정</a>
									</td>
									<td>
										<form method="post" action="<%=request.getContextPath()%>/dept_details/deleteDepartmentsAction.jsp?deptNo=<%=d.deptNo%>">
											<input type="hidden" name="sendUrl" value='<%=request.getRequestURI() + "?" + request.getQueryString()%>'>
											<button class="btn btn-secondary btn-sm" type="submit">삭제</button>
										</form>
									</td>
								</tr>
							<%
								}
							%>
							</tbody>
						</table>
						
						<!-- 부서 추가 버튼 -->
						<div>
							<a href="<%=request.getContextPath()%>/dept_details/insertDepartmentsForm.jsp" class="btn btn-secondary btn-sm">부서 추가</a>
						</div>
					
						<!-- 페이지 -->
						<div style="text-align: center;">
							<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/dept_details/departmentsList.jsp?currentPage=1&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>"><<</a>
						<%
							if(currentPage > 1){
						%>
								<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/dept_details/departmentsList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">이전</a>
						<%
							} else{
						%>
							<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/dept_details/departmentsList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">이전</a>
						<%
							}
						%>
							<span>
								-<%=currentPage%>-
							</span>
						<%
							if(currentPage < lastPage){
						%>
								<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/dept_details/departmentsList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">다음</a>
						<%
							} else{
						%>
								<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/dept_details/departmentsList.jsp?currentPage=<%=currentPage%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">다음</a>
						<%
							}
						%>
							<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/dept_details/departmentsList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">>></a>
						</div>
						<div style="margin:30px; text-align: center;">
							<form method="post" action="<%=request.getContextPath()%>/dept_details/departmentsList.jsp">
								<input type="text" name="searchWord" placeholder="부서 이름 검색">
								<button type="submit">
									<i class="fa fa-search"></i>
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>