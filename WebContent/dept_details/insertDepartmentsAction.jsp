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
	Connection conn = null;
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	try{
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
		stmt1 = conn.prepareStatement(
				"select dept_no from employees_departments order by dept_no desc limit 0,1");
		//select max(dept_no) from departments
		rs = stmt1.executeQuery();
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
		stmt2 = conn.prepareStatement(
				"insert into employees_departments (dept_no, dept_name) values(?,?)");
		stmt2.setString(1,nextDeptNo2);
		stmt2.setString(2,deptName);
		stmt2.executeUpdate();
		response.sendRedirect(request.getContextPath()+"/dept_details/departmentsList.jsp");
		
	}finally{
		rs.close();
		stmt2.close();
		stmt1.close();
		conn.close();
	}
%>