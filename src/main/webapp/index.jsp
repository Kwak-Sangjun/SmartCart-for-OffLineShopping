<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		if(session.getAttribute("totalPrice")==null){
			session.setAttribute("totalPrice", 0);
		}
		if(session.getAttribute("budget")==null){
			session.setAttribute("budget", 0);
		}
	
	%>

	<jsp:include page="menu.jsp" />

</body>
</html>