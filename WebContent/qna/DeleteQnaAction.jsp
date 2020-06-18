<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo);
	String qnaPw = request.getParameter("qnaPw");
	System.out.println(qnaPw);
	//url값 받아올 변수
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	System.out.println(currentPage+" <-- currentPage");
	String selectMenu = request.getParameter("selectMenu");
	System.out.println(selectMenu+" <-- selectMenu");
	String searchWord = request.getParameter("searchWord");
	System.out.println(currentPage+" <-- currentPage");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.println(rowPerPage+" <-- rowPerPage");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	try{
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		System.out.println(conn+" <-- conn");
		stmt = conn.prepareStatement("delete from employees_qna where qna_no=? and qna_pw=?");
		stmt.setInt(1, qnaNo);
		stmt.setString(2, qnaPw);
		System.out.println(stmt+" <-- stmt");
		int row = stmt.executeUpdate(); // 1(결과물이 있음) or 0(결과물이 없음)
		System.out.println(row+" <-- row"); // 1 or 0
		if(row==0){ // 비밀번호 틀림
			response.sendRedirect(request.getContextPath()+"/qna/DeleteQnaForm.jsp?qnaNo="+qnaNo+"&currentPage="+currentPage+"&selectMenu="+selectMenu+"&searchWord="+searchWord+"&rowPerPage="+rowPerPage); // 재요청(끝나면 qnaList로 이동한다.)
		} else{ // 비밀번호 맞음
			response.sendRedirect(request.getContextPath()+"/qna/qnaList.jsp?currentPage="+currentPage+"&selectMenu="+selectMenu+"&searchWord="+searchWord+"&rowPerPage="+rowPerPage); // 재요청(끝나면 qnaList로 이동한다.)
		}
	} finally{
		stmt.close();
		conn.close();
	}
%>
