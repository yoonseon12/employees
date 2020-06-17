<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String deptNo = request.getParameter("deptNo");
	System.out.println(deptNo);
	String deptName = request.getParameter("deptName");
	System.out.println(deptName);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
	System.out.println(conn+" <-- conn"); //연결 디버깅
	PreparedStatement stmt = conn.prepareStatement("UPDATE employees_departments SET dept_name=? WHERE dept_no=?");
	stmt.setString(1, deptName);
	stmt.setString(2, deptNo);
	System.out.println(stmt+" <-- stmt");
	stmt.executeUpdate();
	
	response.sendRedirect(request.getContextPath()+"/dept_details/departmentsList.jsp");
%>