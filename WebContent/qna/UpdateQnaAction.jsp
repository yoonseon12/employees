<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	System.out.println("");
	// url 값을 받아오기위한 변수 받음
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	System.out.println(currentPage+" <-- currentPage");
	String selectMenu = request.getParameter("selectMenu");
	System.out.println(selectMenu+" <-- selectMenu");
	String searchWord = request.getParameter("searchWord");
	System.out.println(searchWord+" <-- searchWord");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.println(rowPerPage+" <-- rowPerPage");
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo+" <-- qnaNo");
	String qnaTitle = request.getParameter("qnaTitle");
	System.out.println(qnaTitle+" <-- qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	System.out.println(qnaContent+" <-- qnaContent");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	try{
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		System.out.println(conn+" <-- conn");
		stmt = conn.prepareStatement("Update employees_qna set qna_title=?, qna_content=? where qna_no=?");
		stmt.setString(1, qnaTitle);
		stmt.setString(2, qnaContent);
		stmt.setInt(3, qnaNo);
		System.out.println(stmt+" <-- stmt");
		rs = stmt.executeQuery();
		System.out.println(rs+" <-- rs");
		response.sendRedirect(request.getContextPath()+"/qna/selectQna.jsp?qnaNo="+qnaNo+"&currentPage="+currentPage+"&selectMenu="+selectMenu+"&searchWord="+searchWord+"&rowPerPage="+rowPerPage);
	} finally{
		rs.close();
		stmt.close();
		conn.close();
	}
%>