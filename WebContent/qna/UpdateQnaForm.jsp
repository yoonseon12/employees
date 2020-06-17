<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수정</title>
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
	</head>
	<style>
		#custom-margin{
			margin-left: 25%;
			margin-right: 25%;
		}
	</style>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		// 전 페이지 url 값을 받아오기위한 변수를 받는다
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		System.out.println(qnaNo+" <-- qnaNo");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.println(currentPage+" <-- currentPage");
		String selectMenu = request.getParameter("selectMenu");
		System.out.println(selectMenu+" <-- selectMenu");
		String searchWord = request.getParameter("searchWord");
		System.out.println(currentPage+" <-- currentPage");
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.println(rowPerPage+" <-- rowPerPage");
		
		//Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		//System.out.println(conn+" <-- conn");
		PreparedStatement stmt1 = conn.prepareStatement("select qna_no, qna_title, qna_content, qna_user, qna_date from employees_qna where qna_no=?");
		stmt1.setInt(1, qnaNo);
		//System.out.println(stmt1+" <-- stmt1");
		ResultSet rs1 = stmt1.executeQuery();
		if(rs1.next()){
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
		<form method="post" action="<%=request.getContextPath()%>/qna/UpdateQnaAction.jsp?qnaNo=<%=qnaNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">
			<div id="custom-margin">
				<div class="container-fluid">
					<div style="margin-top:40px;">
						<h2>게시글 수정</h2>
					</div>
					<table style="margin-top:35px; "class="table">
						<tr>
							<td class="table-secondary" style="text-align: center; font-size: 13px; width: 15%">
								<strong>게시글 번호</strong>
							</td>
							<td style="font-size: 13px">
								<%=request.getParameter("qnaNo")%>
							</td>
						</tr>
						<tr>
							<td class="table-secondary" style="text-align: center; vertical-align: middle; font-size: 13px; width: 15%;">
								<strong>제목</strong>
							</td>
							<td>
								<textarea style="font-size: 13px;" class="form-control" rows="1" name="qnaTitle"><%=rs1.getString("qna_title")%></textarea>
							</td>
						</tr>
						<tr>
							<td class="table-secondary" style="text-align: center; vertical-align: middle; font-size: 13px; width: 15%;">
								<strong>내용</strong>
							</td>
							<td>
								<textarea style="font-size: 13px;" class="form-control" rows="2" name="qnaContent"><%=rs1.getString("qna_content")%></textarea>
							</td>
						</tr>
						<tr>
							<td class="table-secondary" style="text-align: center; font-size: 13px; width: 15%;">
								<strong>글쓴이</strong>
							</td>
							<td style="font-size: 13px;">
								<%=rs1.getString("qna_user")%>
							</td>
						</tr>
					</table>
					<button class="btn btn-secondary btn-sm" type="submit">수정</button>
			<%		
				}
			%>
				</div>
			</div>
		</form>
	</body>
</html>