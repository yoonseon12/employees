<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="gd.emp.Titles" %>
<%@ page import="java.util.ArrayList" %>
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
		<title>title List</title>
		<style>
			#custom-margin{
				margin-left: 22%; 
				margin-right: 22%;
			}
		</style>
	</head>
	<body>
	<%
		//페이지
		int currentPage=1; // 첫번째페이지 변수를 1로지정(모든페이지의 기본값은 1)
		if(request.getParameter("currentPage")!=null){ // 응답받은 현재페이지의 값이 있다면
		currentPage=Integer.parseInt(request.getParameter("currentPage")); 
			// 요청받은 현재페이지의값을 정수형으로 변환
		} 
		System.out.println(currentPage+" <- currentPage"); // currentPage 디버깅
		int rowPerPage=10; // 한 페이지에 몇개의 데이터를 출력할 것인가
		if(request.getParameter("rowPerPage")!=null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		int beginRow=(currentPage - 1) * 10; //한페이지에서 행을 어디부터 출력할 것인가
		//System.out.println(rowPerPage+" <- rowPerPage");
		//System.out.println(beginRow+" <- beginRow");
		//db연결
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		//System.out.println(conn+" <- conn");
		PreparedStatement stmt1 = conn.prepareStatement("select * from employees_titles order by emp_no asc limit ?,?"); // 쿼리작성
		stmt1.setInt(1,beginRow);
		stmt1.setInt(2,rowPerPage);
		//System.out.println(stmt1+" <- stmt1");
		ResultSet rs1 = stmt1.executeQuery(); // 쿼리를 실행시킨다
		ArrayList<Titles> list = new ArrayList<Titles>();
		while(rs1.next()){
			Titles c = new Titles();
			c.empNo = rs1.getInt("emp_no");
			c.title = rs1.getString("title");
			c.fromDate = rs1.getString("from_date");
			c.toDate = rs1.getString("to_date");
			list.add(c);
		}
		//System.out.println(list.size()+" <- list.size");
		//마지막페이지
		int lastPage=0; // 마지막페이지를 저장할 변수 선언 후 초기화
		int totalRow=0; // 데이터의 총개수를 저장할 변수 선언 후 초기화
		PreparedStatement stmt2 = conn.prepareStatement("select count(*) from employees_titles");
		ResultSet rs2= stmt2.executeQuery();
		if(rs2.next()){
			totalRow= rs2.getInt("count(*)");//데이터의 총개수는 쿼리를실행한 값(=count값)을 정수로 변환시킨 값
		}
		//System.out.println(totalRow);
		lastPage=totalRow/rowPerPage;
		if(totalRow%rowPerPage!=0){
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
			<div style="margin-bottom: 100px">
				<div class="container pt-3">
					<div style="margin-top:30px; margin-bottom:30px; text-align: center;">
						<h2>직책 리스트</h2>
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
								<th>title</th>
								<th>from_date</th>
								<th>to_date</th>
							</tr>
						</thead>
						<tbody>
						<%
							for(Titles c : list){
						%>
							<tr>
								<td><%=c.empNo%></td>
								<td><%=c.title%></td>
								<td><%=c.fromDate%></td>
								<td><%=c.toDate%></td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
					
					<!-- 페이지 -->
					<div style="margin:20px; text-align: center;">
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