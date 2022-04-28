<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- 개인정보수정시 비번 한 번 더 입력 / 변경 비밀번호 확인 기능도 추가 -->
<h1>개인정보수정</h1>
<%
	String s_name = (String)session.getAttribute("__name");
	String s_uno = (String)session.getAttribute("__uno");
	
	String id = "";
	String pw = "";
%>

<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_C", "root", "1234");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from users where uno =" + s_uno);
		
		while(rs.next()) {
			id = rs.getString("uid");
			pw = rs.getString("upw");
		}
		
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e) {
		response.sendRedirect("Error.jsp");
		e.printStackTrace();
	}
%>

<form action="User_Update_Query.jsp" method = "post">
	ID : <input type = "text" name = "_id" value = <%=id%>><p>
	PW : <input type = "password" name = "_pw" value = <%=pw%>><p>
	<input type = "submit" value = "수정"><p>
</form>
</body>
</html>