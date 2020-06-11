<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	// 열 : dept_no dept_name
	// dept_name
	//String deptName =request.getParameter("deptName");
	// dept_no ?
	// dept_no를 구하는 알고리즘
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");
	PreparedStatement stmt = conn.prepareStatement(
			"select dept_no from departments order by dept_no desc limit 0,1");
	//select max(dept_no) from departments
	ResultSet rs = stmt.executeQuery();
	String deptNo = "";
	if(rs.next()){
		deptNo=rs.getString("dept_no");
		// deptNo = rs.getString("max(dept_no)")
	}
	System.out.println(deptNo);
	
	String deptNo2 = deptNo.substring(1); // deptNo를 몇번째부터 자르겠냐
	System.out.println(deptNo2);
	
	int deptNo3 = Integer.parseInt(deptNo2);
	System.out.println(deptNo3);
	
	int nextDeptNo = deptNo3+1;
	System.out.println(nextDeptNo);
	
	String nextDeptNo2 = "";
	
	if(nextDeptNo/100 >0){
		nextDeptNo2 = "d00"+nextDeptNo;
	}else if(nextDeptNo/10>0){
		nextDeptNo2 = "d0"+nextDeptNo;
	}else{
		nextDeptNo2 = "dm  "+nextDeptNo;
	}
	
	//dept_name
	String deptName = request.getParameter("deptName");
	PreparedStatement stmt1 = conn.prepareStatement(
			"insert into departments (dept_no, dept_name) values(?,?)");
	stmt1.setString(1,nextDeptNo2);
	stmt1.setString(2,deptName);
	stmt1.executeUpdate();
	response.sendRedirect(request.getContextPath()+"/dept_details/departmentsList.jsp");
%>