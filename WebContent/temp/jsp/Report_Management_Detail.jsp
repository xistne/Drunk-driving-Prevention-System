<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("euc-kr"); %>
<%
String s_name = (String)session.getAttribute("__name");
String s_uno = (String)session.getAttribute("__uno");
%>
신고메시지 일부
추가사항들

보고서 내용
<P>

		<%
		 	String rno = request.getParameter("_rno");
		
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_C","root","1234");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select * from report where rno="+rno+"");
				

				
				while(rs.next()){

					out.println(rs.getString("rno")+"</a>");
					out.println((rs.getString("rdate")).substring(0,10)+"</a>");
					out.println((rs.getString("rme")).substring(0,12)+"</a>");
					out.println((rs.getString("rdate")).substring(11,16)+"</a><p>");
					out.println(rs.getString("rme")+"</a>");
					
				}
			//	out.println("<a href = 'User_List_UI.jsp?_id="+id+"&_name="+name+"'>" + "회원 정보 수정" + "</a>");
				

				
			}catch(Exception e){
				
				e.printStackTrace();
			}
			
		
		%>
<P>
<a href="Board_Information_Insert.jsp?_rno=<%= rno %>" align ="right">보고서 작성</a>  <p>
<a href="Board_Information_Update.jsp" align ="right">보고서 수정</a>  <p>

</body>
</html>