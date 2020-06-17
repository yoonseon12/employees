<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//url 값을 받아오기위한 변수 받음
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	System.out.println(currentPage+" <-- currentPage");
	String selectMenu = request.getParameter("selectMenu");
	System.out.println(selectMenu+" <-- selectMenu");
	String searchWord = request.getParameter("searchWord");
	System.out.println(currentPage+" <-- searchWord");
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.println(rowPerPage+" <-- rowPerPage");
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	//마리아 db설정
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/yoonseon12", "yoonseon12", "java1004");
	
	String delPw = ""; // 입력한 비밀번호를 받을 변수를 선언하고 초기화
	if(request.getParameter("delPw")!=""){ // 입력한 비밀번호가 있다면
		delPw = request.getParameter("delPw");
	}else{ // 입력한 비밀번호가 없다면
		response.sendRedirect(request.getParameter("sendUrl2")+"&ck=fail&commentNo="+commentNo); // ck값을 받고 돌아감
		return;
	}
	System.out.println(delPw+" <-- delPw");
	PreparedStatement stmt1 = conn.prepareStatement("SELECT comment_pw FROM employees_comment WHERE comment_no=?");
	stmt1.setInt(1,commentNo);
	ResultSet rs1= stmt1.executeQuery();
	String realPw = ""; // 데이터베이스에 있는 비밀번호를 담을 변수를 선언 후 초기화
	while(rs1.next()) {
		System.out.println(rs1.getString(1)+" <--PW"); // 진짜 비밀번호
		realPw = rs1.getString(1);
	}
	if(delPw.equals(realPw)){ 
		PreparedStatement stmt2 = conn.prepareStatement("delete from employees_comment where comment_no=?");
		stmt2.setInt(1,commentNo);
		stmt2.executeQuery();
	}else{
		response.sendRedirect(request.getParameter("sendUrl2")+"&ck2=false&commentNo="+commentNo);
		return;
	}
	
	
	response.sendRedirect(request.getParameter("sendUrl2"));  // hidden으로 넘긴 현재페이지의 값을 불러와서 출력 */
%>