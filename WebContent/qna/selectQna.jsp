<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="gd.emp.*"%>
<%@ page import="java.util.*"%>
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
		<title>select Q&A</title>
		<style>
		th {
			text-align: center;
		}
		#button {
			height: 70px;
			width: 100px;
		}
		
		#custom-margin {
			margin-left: 25%;
			margin-right: 25%;
		}
		.contentFont {
			font-size:14px;
		}
		</style>
	</head>
	<body>
	<%
		// 인코딩을 맞춤 
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		//비밀번호가 공백인지 틀렸는지
		String msg = request.getParameter("ck");
		System.out.println(msg+" <-- msg");
		String msg2 = request.getParameter("ck2");
		System.out.println(msg+" <-- msg");
		
		//이전페이지에서 넘긴 정보를 받음(수정이나 삭제에 다녀올 때)
		int	currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String selectMenu = request.getParameter("selectMenu");
		String searchWord = request.getParameter("searchWord");
		System.out.println(currentPage + " <-- currentPage");
		System.out.println(selectMenu + " <-- selectMenu");
		System.out.println(searchWord + " <-- searchWord");
		int rowPerPage= Integer.parseInt(request.getParameter("rowPerPage"));
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		//System.out.println(qnaNo+" <-- qnaNo");

		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try{
			conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
			//System.out.println(conn+" <-- conn");
			stmt1 = conn.prepareStatement(
					"select qna_no, qna_title, qna_content, qna_user, qna_date from employees_qna where qna_no=?");
			stmt1.setInt(1, qnaNo);
			//System.out.println(stmt1+" <-- stmt1");
			rs1 = stmt1.executeQuery();
			//System.out.println(rs1+" <-- rs1");
			QnA qna = new QnA();
			if (rs1.next()) {
				qna.qnaNo = rs1.getInt("qna_no");
				qna.qnaTitle = rs1.getString("qna_title");
				qna.qnaContent = rs1.getString("qna_content");
				qna.qnaUser = rs1.getString("qna_user");
				qna.qnaDate = rs1.getString("qna_date");
			}
			
			System.out.println(request.getRequestURI() + request.getQueryString());
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
				<div class="container pt-3" style="margin-top:30px">
					<div style="float:left; margin:20px 0px;">
						<h3>게시글</h3>
					</div>
					<table class="table">
						<tr>
							<th class="table-secondary" style="font-size: 13px; width: 15%"><strong>게시글 번호</strong></th>
							<td class="contentFont"><%=qna.qnaNo%></td>
						</tr>
						<tr>
							<th class="table-secondary" style="font-size: 13px;"><strong>제 목</strong></th>
							<td class="contentFont"><%=qna.qnaTitle%></td>
						</tr>
						<tr>
							<th class="table-secondary" style="font-size: 13px; height: 100px"><strong>내 용</strong></th>
							<td class="contentFont"><%=qna.qnaContent%></td>
						</tr>
						<tr>
							<th class="table-secondary" style="font-size: 13px;"><strong>작성자</strong></th>
							<td class="contentFont"><%=qna.qnaUser%></td>
						</tr>
						<tr>
							<th class="table-secondary" style="font-size: 13px;"><strong>작성일</strong></th>
							<td class="contentFont"><%=qna.qnaDate.substring(0, 10)%></td>
						</tr>
					</table>
					<!-- 링크 목록 -->
					<div class="row">
						<div class="col-10">
							<a class="btn btn-secondary btn-sm"
								href="<%=request.getContextPath()%>/qna/UpdateQnaForm.jsp?qnaNo=<%=qna.qnaNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">수정</a>
							<a class="btn btn-secondary btn-sm"
								href="<%=request.getContextPath()%>/qna/DeleteQnaForm.jsp?qnaNo=<%=qna.qnaNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">삭제</a>
						</div>
						<div class="col-2">
							<a style="float: right" class="btn btn-secondary btn-sm"
								href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">목록</a>
						</div>
					</div>
					<hr>
					<!-- 댓글 입력 -->
					<form method="post" action="<%=request.getContextPath()%>/qna/insertCommentAction.jsp?currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">
						<input type="hidden" name="qnaNo" value="<%=qna.qnaNo%>">
						<div class="form-group">
							<label for="comment"><small>댓 글</small></label>
							<textarea class="form-control" rows="2" id="comment" name="comment"></textarea>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-sm-5">
									<label for="commentUser"><small>작성자명</small></label> <input
										type="text" class="form-control" id="commentUser"
										name="commentUser">
								</div>
								<div class="col-sm-5">
									<label for="pwd"><small>비밀번호</small></label> <input
										type="password" class="form-control" id="commentPw"
										name="commentPw">
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="sendUrl" value="<%=request.getRequestURI()%>?qnaNo=<%=qna.qnaNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">
									<button id="button" class="btn btn-secondary btn-sm" type="submit" class="btn btn-primary">
										등록
									</button>
								</div>
							</div>
						</div>
					</form>
					<!-- 댓글목록 -->
					<%
						// select comment_no, comment from qna_comment where qna_no=
						// limit ?,?
						stmt2 = conn.prepareStatement(
								"select comment_no, qna_no, comment, comment_date, comment_user from employees_comment where qna_no=? order by comment_no desc");
						stmt2.setInt(1, qnaNo);
						rs2 = stmt2.executeQuery();
						ArrayList<Comment> list = new ArrayList<Comment>();
		
						while (rs2.next()) {
							Comment c = new Comment();
							c.commentNo = rs2.getInt("comment_no");
							c.qnaNo = rs2.getInt("qna_no");
							c.comment = rs2.getString("comment");
							c.commentDate = rs2.getString("comment_date");
							c.commentUser = rs2.getString("comment_user");
							list.add(c);
						}
						System.out.println(list.size() + " <-- list.size");
					%>
					<br>
		
					<!-- 댓글 삭제 창 -->
					<table class="table" style="100%;">
						<tr>
							<th style="width:460px;">댓 글</th>
							<th style="width:130px;">작성자</th>
							<th style="width:90px;">작성일</th>
							<th style="width:60px;">&nbsp;</th>
						</tr>
					</table>
					<%
						int idCnt = 0;
						for (Comment c : list) {
					%>
					<form method="post" action="<%=request.getContextPath()%>/qna/DeleteCommentAction.jsp?commentNo=<%=c.commentNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">
						<table class="table" style="100%;">
							<tr>
								<td style="width:460px;"><small><%=c.comment%></small></td>
								<td style="width:130px; text-align: center;"><small><%=c.commentUser%></small></td>
								<td style="width:90px; text-align: center;"><small><%=c.commentDate%></small></td>
								<td style="width:60px;">
									<button type="button" style="width : 100%;" class="btn btn-light btn-sm" data-toggle="collapse" data-target="#collapse<%=idCnt %>">
										X
									</button>
								</td>
							</tr>
							<tr >
								<td colspan="4" style="border-top : none; height : 5px;">
									<div id="collapse<%=idCnt%>" class="collapse" style="height : 30px;">
										<input type="password" placeholder="비밀번호를 입력해주세요." name="delPw" style="width:180px;height:30px;font-size:13px;">
										<button type="submit" class="btn btn-dark btn-sm" style="height:30px; font-size: 0.8rem; vertical-align: bottom;">
											삭제
										</button>
										<div id="collapse<%=idCnt%>"class="collapse" style="margin: 5px 0px;">
										<% 
											if(request.getParameter("ck")!=null && c.commentNo==Integer.parseInt(request.getParameter("commentNo"))){
										%>
											<strong>비밀번호를 입력해주세요.</strong>	
										<%	
											}
										%>
										<% 
											if(request.getParameter("ck2")!=null && c.commentNo==Integer.parseInt(request.getParameter("commentNo"))){
										%>
											<strong>비밀번호가 틀렸습니다.</strong>	
										<%	
											}
										%>
										</div>
									</div>
								</td>
							</tr>
						</table>
						<input type="hidden" name="sendUrl2" value="<%=request.getRequestURI()%>?qnaNo=<%=qna.qnaNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>&commentNo=<%=c.commentNo%>">
					</form>
					<%
							idCnt+=1;
						}
					%>
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