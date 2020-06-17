<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String deptNo = request.getParameter("deptNo");
	System.out.println(deptNo);
	String sendUrl = request.getParameter("sendUrl");
	System.out.println(sendUrl+" <-- sendUrl");
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
	System.out.println(conn+" <-- conn"); //연결 디버깅
	PreparedStatement stmt = conn.prepareStatement("delete from employees_departments where dept_no=?");
	stmt.setString(1, deptNo);
	System.out.println(stmt+" <-- stmt");
	stmt.executeUpdate();
	
	response.sendRedirect(sendUrl); // 지우고 다시 페이지를 보여주겠다, 재요청해라
%>