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
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://localhost:3306/employees", "root", "java1234");
	System.out.println(conn+" <-- conn"); //연결 디버깅
	PreparedStatement stmt = conn.prepareStatement("UPDATE departments SET dept_name=? WHERE dept_no=?");
	stmt.setString(1, deptName);
	stmt.setString(2, deptNo);
	System.out.println(stmt+" <-- stmt");
	stmt.executeUpdate();
	
	response.sendRedirect(request.getContextPath()+"/dept_details/departmentsList.jsp");
%>