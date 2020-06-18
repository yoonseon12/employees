<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="gd.emp.QnA" %>
<%@ page import="java.util.Calendar"%>
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
		<title>Q&A</title>
		<style>
			thead{
				text-align: center;
			}
			#custom-margin{
				margin-left : 20%;
				margin-right : 20%;
			}
			.center{
				text-align: center;
			}
		</style>
	</head>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		//선택한 selectMenu값 받기 
		String selectMenu = request.getParameter("selectMenu");
		System.out.println(selectMenu+" <-- selectMenu");
		//검색창에 입력한 값 받기
		String searchWord ="";
		if(request.getParameter("searchWord") != null){
			searchWord = request.getParameter("searchWord");
		}
		System.out.println(searchWord+" <-- serachWord");
		
		//페이지
		int currentPage = 1;
		if(request.getParameter("currentPage")!=null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		//System.out.println(currentPage+" <- currentPage");
		int rowPerPage = 10; // 한페이지당 출력 할 데이터 개수
		// rowPerPage의 개수를 선택했다면
		if(request.getParameter("rowPerPage")!=null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		} 
		
		int beginRow = (currentPage-1)*rowPerPage; // 몇행부터 출력할것인가
		//System.out.println(beginRow+" <- beginRow"); 
		
		//마리아db
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try{
			conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
			
			//검색어 유무에 따른 동적쿼리
			if(searchWord.equals("")){
				stmt1 = conn.prepareStatement("select qna_no, qna_title, qna_user, qna_date from employees_qna order by qna_no desc limit ?, ?");
				stmt1.setInt(1,beginRow);
				stmt1.setInt(2,rowPerPage);
			} else if(selectMenu.equals("title")){
				stmt1 = conn.prepareStatement(
						"select qna_no, qna_title, qna_user, qna_date from employees_qna where qna_title like ? order by qna_no desc limit ?,?");
				stmt1.setString(1,"%"+searchWord+"%");
				stmt1.setInt(2,beginRow);
				stmt1.setInt(3,rowPerPage);
			} else if(selectMenu.equals("user")){
				stmt1 = conn.prepareStatement(
						"select qna_no, qna_title, qna_user, qna_date from employees_qna where qna_user like ? order by qna_no desc limit ?,?");
				stmt1.setString(1,"%"+searchWord+"%");
				stmt1.setInt(2,beginRow);
				stmt1.setInt(3,rowPerPage);
			} else if(selectMenu.equals("content")){
				stmt1 = conn.prepareStatement(
						"select qna_no, qna_title, qna_user, qna_date from employees_qna where qna_content like ? order by qna_no desc limit ?,?");
				stmt1.setString(1,"%"+searchWord+"%");
				stmt1.setInt(2,beginRow);
				stmt1.setInt(3,rowPerPage);
			} else if(selectMenu.equals("titleContent")){
				stmt1 = conn.prepareStatement(
						"select qna_no, qna_title, qna_user, qna_date from qna where employees_qna_content like ? or qna_title like ? order by qna_no desc limit ?,?");
				stmt1.setString(1,"%"+searchWord+"%");
				stmt1.setString(2,"%"+searchWord+"%");
				stmt1.setInt(3,beginRow);
				stmt1.setInt(4,rowPerPage);
			}
			//System.out.println(stmt1+" <- stmt1");
			rs1 = stmt1.executeQuery();
			ArrayList<QnA> list =new ArrayList<QnA>(); //동적배열
			while(rs1.next()){
				QnA qna = new QnA();
				qna.qnaNo = rs1.getInt("qna_no");
				qna.qnaTitle = rs1.getString("qna_title");
				qna.qnaUser = rs1.getString("qna_user");
				qna.qnaDate = rs1.getString("qna_date");
				list.add(qna);
			}
			//System.out.println(list.size()+" <- list.size"); //list의 size 값
			
			//마지막페이지
			int lastPage=0; // 마지막페이지
			int totalRow=0; // 데이터의 총갯수
			if(searchWord.equals("")){ // 동적쿼리
				stmt2 = conn.prepareStatement("select count(*) from employees_qna");
			}else if(selectMenu.equals("title")){
				stmt2 = conn.prepareStatement("select count(*) from employees_qna where qna_title like ?");
				stmt2.setString(1,"%"+searchWord+"%");
			}else if(selectMenu.equals("user")){
				stmt2 = conn.prepareStatement("select count(*) from employees_qna where qna_user like ?");
				stmt2.setString(1,"%"+searchWord+"%");
			}else if(selectMenu.equals("content")){
				stmt2 = conn.prepareStatement("select count(*) from employees_qna where qna_content like ?");
				stmt2.setString(1,"%"+searchWord+"%");
			}else if(selectMenu.equals("titleContent")){
				stmt2 = conn.prepareStatement("select count(*) from employees_qna where qna_user like ? or qna_content like ?");
				stmt2.setString(1,"%"+searchWord+"%");
				stmt2.setString(2,"%"+searchWord+"%");
			}
			//System.out.println(stmt2+" <- stmt2");
			rs2 = stmt2.executeQuery();
			if(rs2.next()){
				totalRow=rs2.getInt("count(*)");
			}
			//System.out.println(totalRow+" <- totalRow");
			lastPage=totalRow/rowPerPage;
			if(totalRow%rowPerPage!=0){ // 데이터의 총개수 / 한페이지에 출력할 페이지 수 가 0이 아니라면
				lastPage+=1; // 마지막페이지를 1 늘림
			}
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
		<div id="custom-margin">
			<div style="margin-bottom: 100px">
				<div class="container pt-3">
					<div style="margin-top:30px; margin-bottom:30px; text-align: center;">
						<h2>문의사항</h2>
					</div>
					
					<!-- 테이블 위에 행 (몇개의 페이지랑 몇개씩 페이지 출력할건지 있는 부분) -->
					<div class="row">
						<div class="col-sm-12">
							<h4>전체글보기</h4>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-10">
							<div>
								<span style="vertical-align : sub;"><strong><%=totalRow%></strong> 개의 글</span>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="dropdown" style="width: 80px; float: right;">
								<button type="button" class="dropdown-toggle" data-toggle="dropdown" style="width : 100%;">
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
					<table class="table" style="margin-top : 5px;">
						<thead>
							<tr class="table-secondary">
								<th>번 호</th>
								<th>제 목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
						<%
							for(QnA q : list){
								//System.out.println(q.qnaDate.substring(0,10)+" <- qnaDate.substring"); //list의 size 값
								//substring(?,?) 몇번부터 몇번까지 글자 자름
								
								String qnaDateSub = q.qnaDate.substring(0,10);
								
								Calendar today = Calendar.getInstance();
								int year = today.get(Calendar.YEAR);
								//System.out.println(year+" <- year");
								int month = today.get(Calendar.MONTH)+1;
								//System.out.println(month+" <- month");
								int day = today.get(Calendar.DATE);
								//System.out.println(day+" <- day");
								String month2 = ""+ month;
								if(month < 10){
									month2="0"+month;
								}
								String day2= ""+day;
								if(day < 10){
									day2="0"+day;
								}
								String strToday = year+"-"+month2+"-"+day2;
								//System.out.println(strToday+" <- strToday");
						%>
							<tr>
								<td class="center"><%=q.qnaNo%></td>
									<td>
										<a href="<%=request.getContextPath()%>/qna/selectQna.jsp?qnaNo=<%=q.qnaNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>"><%=q.qnaTitle%></a>
									</td>
								<td class="center"><%=q.qnaUser%></td>
								<td class="center"><%=strToday%></td>
							</tr>
						<%
							}
						%>
						</tbody>
					</table>
					
					<!-- 글쓰기 버튼 -->
					<div>
						<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/qna/insertQnaForm.jsp">글 쓰기</a>
					</div>
					
					<!-- 페이지 -->
					<div style="text-align: center;">
						<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=1&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>"><<</a>
					<% 
						//검색을하면 searchWord 값에 맞춰서 페이징. 검색을 안하면 searchWord가 공백이기 때문에 searchWord값이 공백들어가서 일반 페이징.
						if(currentPage>1){
					%>		
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage-1%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">이전</a>
							
					<%	
						} else{
					%>		
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">이전</a>
					<% 	
						}
					%>
						<span>
							-<%=currentPage%>-
						</span>
					<%	
						//검색하면 searchWord 값에 맞춰서 페이징하고 검색을 안하면 searchWord가 공백이기 때문에 searchWord값이 공백들어가서 일반 페이징.
						if(currentPage<lastPage){
					%>
							<a class="btn btn-secondary btn-sm" href='<%=request.getRequestURI()%>?currentPage=<%=currentPage+1%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>'>다음</a>
											
					<%
						} else{
					%>		
							<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=lastPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">다음</a>
					<%
						}
					%>
						<a class="btn btn-secondary btn-sm" href="<%=request.getRequestURI()%>?currentPage=<%=lastPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">>></a>
					</div>
					<div style="margin:20px; text-align: center;">
						<form method="post" action="<%=request.getRequestURI()%>">
							<select name="selectMenu">
								<option value="title">제목</option>
								<option value="user">작성자</option>
								<option value="content">내용</option>
								<option value="titleContent">제목+내용</option>
							</select>
							<input type = "text" name="searchWord">
							<button type="submit">
								<img src="<%=request.getContextPath()%>/imgs/search.jpg">
							</button>
						</form>
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