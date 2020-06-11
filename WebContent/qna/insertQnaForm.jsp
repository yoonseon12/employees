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
		<title>글 쓰기</title>
		<style>
			#custom-margin{
				margin-left: 25%;
				margin-right: 25%;
			}
		</style>
	</head>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String msg ="";
		if(request.getParameter("ck") != null){
			msg = "입력하지 않은 창이 있습니다.";
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
			<div class="container pt-3">
				<br>
				<h3>게시글 작성</h3>
				<form method="post" action="<%=request.getContextPath()%>/qna/insertQnaAction.jsp">
				
					<!-- Q&A제목 -->
					<div class="form-group">
						<label for="qnaTitle">
							제목 :
						</label>
						<input type="text" class="form-control" name="qnaTitle" id="qnaTitle">
					</div>
					
					<!-- Q&A 내용 -->
					<div class="form-group"> 
						<label for="qnaContent">
							내용 : 
						</label>
						<textarea class="form-control" rows="5" name="qnaContent" id="qnaContent"></textarea>
					</div>
					
					<!-- 글쓴이 -->
					<div class="form-group"> 
						<label for="qnaUser">
							글쓴이 : 
						</label>
						<input type="text" class="form-control" name="qnaUser" id="qnaUser">
					</div>
					
					<!-- 비밀번호 -->
					<div class="form-group"> 
						<label for="qnaPw">
							비밀번호 :  
						</label>
						<input type="password" class="form-control" name="qnaPw" id="qnaPw">
					</div>
					<div>
						<strong><%=msg%></strong>
					</div>
					<br>
					<div class="row">
						<div class="col-10">
							<button class="btn btn-secondary btn-sm" type="submit">저장하기</button>
							<a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/qna/insertQnaForm.jsp">초기화</a>
						</div>
						<div class="col-2">
							<a style="float:right;"class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/qna/qnaList.jsp">목록</a>
						</div>
					</div>
				</form>
			</div>
		</div>	
	</body>
</html>