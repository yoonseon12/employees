<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8"); // 앞에서 넘겨지는 인코딩과 현재 인코딩을 맞추자
	//request 매개변수(입력 값 ip, title, content, user, pw) 설정
	String qnaIp = request.getRemoteAddr();
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaUser = request.getParameter("qnaUser");
	String qnaPw = request.getParameter("qnaPw");
	
	//매개값에 공백이 있으면 폼으로 되돌려 보낼건데 ck값과 함께 되돌려보낸다.
	if(qnaTitle.equals("") || qnaContent.equals("") || qnaUser.equals("") || qnaPw.equals("")) { // 하나라도 공백이 있다면
		response.sendRedirect(request.getContextPath()+"/qna/insertQnaForm.jsp?ck=fail");
		return; // 코드진행을 끝낸다.
	} 
	
	System.out.println(qnaIp+" <-- qnaIp");
	System.out.println(qnaTitle+" <-- qnaTitle");
	System.out.println(qnaContent+" <-- qnaContent");
	System.out.println(qnaUser+" <-- qnaUser");
	System.out.println(qnaPw+" <-- qnaPw");
	
	// qnaNo,
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");
	PreparedStatement stmt1 = conn.prepareStatement("select max(qna_no) from qna");
	System.out.println(stmt1+" <- stmt1");
	ResultSet rs1 = stmt1.executeQuery();
	System.out.println(rs1+" <- rs1");
	
	int qnaNo=1;
	// rs1 값이 있으면 qnaNo를 그 값의 +1
	// rs1 값이 없으면(else) qnaNo = 1
	if(rs1.next()){
		qnaNo=rs1.getInt("max(qna_no)") + 1 ;
	}
	System.out.println(qnaNo+" <- qnaNo");
	
	// qnaDate : sql문에서 now()함수를 사용
	/* 
		insert into qna(qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date) values(?, ?, ?, ?, ?, now());
	*/
	PreparedStatement stmt2 = conn.prepareStatement(
			"insert into qna(qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date, qna_ip) values(?, ?, ?, ?, ?, now(), ?)");
	stmt2.setInt(1,qnaNo);
	stmt2.setString(2,qnaTitle);
	stmt2.setString(3,qnaContent);
	stmt2.setString(4,qnaUser);
	stmt2.setString(5,qnaPw);
	stmt2.setString(6,qnaIp);
	stmt2.executeQuery();
	
	response.sendRedirect(request.getContextPath()+"/qna/qnaList.jsp");
%>