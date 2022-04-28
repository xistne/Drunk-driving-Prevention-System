<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("euc-kr"); %>

<% String s_uno = (String)session.getAttribute("__uno"); %>

<%
	String name = request.getParameter("_name");
	String pw = request.getParameter("_pw");
	String police = "";
	String[] station = request.getParameterValues("_station");
	
	if(station != null) {
		for (int i = 0; i < station.length; i++) {
			police = station[i];
		}
	}
	
	if(name == null) name = "";
	if(pw == null) pw = "";
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_C", "root", "1234");
		Statement stmt = conn.createStatement();
		stmt.executeUpdate("update users set uname = '" + name + "', upw = '" + pw + "', police = '" + police + "'"
						+ " where uno = " + s_uno);
		
		stmt.close();
		conn.close();
		
		out.println("<h1>개인 정보 수정 확인</h1>");
		out.println("NAME : " + name + "<p>");
		out.println("PW : " + pw + "<p>");
		out.println("POLICE : " + police + "<p>");
		out.println("개인 정보 수정이 완료 되었습니다.<p>");
	}catch(Exception e) {
		response.sendRedirect("pages-error-404.html");
		e.printStackTrace();
	}
%>
<a href = "Report_Message.jsp">메인으로 돌아가기</a>
</body>
</html>