<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<title>게시글 삭제</title>
		<style>
			#custom-margin{
				margin-left : 25%;
				margin-right : 25%;
			}
		</style>
	</head>
	<body>
	<%
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		System.out.println(qnaNo);
		
		//url값 받아올 변수
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.println(currentPage+" <-- currentPage");
		String selectMenu = request.getParameter("selectMenu");
		System.out.println(selectMenu+" <-- selectMenu");
		String searchWord = request.getParameter("searchWord");
		System.out.println(currentPage+" <-- currentPage");
		int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.println(rowPerPage+" <-- rowPerPage");
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
			<div class="container pt-3" style="margin-top:30px;">
				<div style="margin-top:30px; margin-bottom:30px;">
					<h3>게시글 삭제</h3>
				</div>
				<form method="post" action="<%=request.getContextPath()%>/qna/DeleteQnaAction.jsp?qnaNo=<%=qnaNo%>&currentPage=<%=currentPage%>&selectMenu=<%=selectMenu%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">
					<div class="input-group mb-3">
						<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
						<input type="password" class="form-control" name="qnaPw" id="qnaPw"  placeholder="비밀번호를 입력해주세요">	
						<div class="input-group-append">
							<button class="btn btn-secondary btn-sm" type="submit">삭제</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>