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
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");
	System.out.println(conn+" <-- conn");
	PreparedStatement stmt1 = conn.prepareStatement("delete from qna where qna_no=? and qna_pw=?");
	stmt1.setInt(1, qnaNo);
	stmt1.setString(2, qnaPw);
	System.out.println(stmt1+" <-- stmt1");
	int row = stmt1.executeUpdate(); // 1(결과물이 있음) or 0(결과물이 없음)
	System.out.println(row+" <-- row"); // 1 or 0
	if(row==0){
		response.sendRedirect(request.getContextPath()+"/qna/DeleteQnaForm.jsp?qnaNo="+qnaNo+"&currentPage="+currentPage+"&selectMenu="+selectMenu+"&searchWord="+searchWord+"&rowPerPage="+rowPerPage); // 재요청(끝나면 qnaList로 이동한다.)
	} else{
		response.sendRedirect(request.getContextPath()+"/qna/qnaList.jsp?currentPage="+currentPage+"&selectMenu="+selectMenu+"&searchWord="+searchWord+"&rowPerPage="+rowPerPage); // 재요청(끝나면 qnaList로 이동한다.)
	}
%>