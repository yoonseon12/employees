<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");//인코딩 맞추기
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo+" <-- qnaNo");
	String comment = request.getParameter("comment");
	System.out.println(comment+" <-- comment");
	String commentPw = request.getParameter("commentPw");
	System.out.println(commentPw+" <-- commentPw");
	String commentUser = request.getParameter("commentUser");
	System.out.println(commentUser+" <-- commentUser");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://localhost:3306/yoonseon12", "root", "java1234");
	System.out.println(conn+" <- conn");
	
	// commentNo
	PreparedStatement stmt1 = conn.prepareStatement(
			"select max(comment_no) from employees_comment");
	System.out.println(stmt1+" <- stmt1");
	ResultSet rs1 = stmt1.executeQuery();
	int commentNo =1; // 
	if(rs1.next()) {
		commentNo= rs1.getInt("max(comment_no)")+1 ;
	}
	
	// 입력
	PreparedStatement stmt2 = conn.prepareStatement(
			"insert into employees_comment(comment_no, qna_no, comment, comment_date, comment_pw, comment_user) values(?, ?, ?, now(), ?, ?)");
	stmt2.setInt(1, commentNo);
	stmt2.setInt(2, qnaNo);
	stmt2.setString(3, comment);
	stmt2.setString(4, commentPw); 
	stmt2.setString(5, commentUser);
	stmt2.executeUpdate();
	response.sendRedirect(request.getParameter("sendUrl"));
%>