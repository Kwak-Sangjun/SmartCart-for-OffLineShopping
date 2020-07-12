<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String pageChange;
	%>
	
	<div style="position: absolute;">
		<div style="position: relative; top: 28px; left: 710px;">
			<a href="?pageChange=calculator"> 
				<img src="img/button/cal.png" width=47px height=37px>		
			</a>
		</div>
	</div>
	
	<div style="position: absolute;">
		<div style="position: relative; top: 28px; left: 770px;">
			<a href="?pageChange=basket"> 
				<img src="img/button/basket.png" width=47px height=37px>
			</a>
		</div>
	</div>

	<div style="position: absolute;">
		<div style="position: relative; top: 28px; left: 830px;">
			<a href="index.jsp"> 
				<img src="img/button/home.png" width=47px height=37px>		
			</a>
		</div>
	</div>

	<img src="img/index/top.png" width=970px height=80px>
</body>
</html>