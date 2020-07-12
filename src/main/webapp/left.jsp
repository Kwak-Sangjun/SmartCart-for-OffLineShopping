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
		<div style="position: relative; top: 110px; left: 20px;">
			<a href="?pageChange=event">
				<img src="img/index/11.png" width=130px height=50px>
			</a>
		</div>
	</div>
	<div style="position: absolute;">
		<div style="position: relative; top: 165px; left: 20px;">
			<a href="?pageChange=scanBarcode">
				<img src="img/index/22.png" width=130px height=50px>
			</a>
		</div>
	</div>
	<div style="position: absolute;">
		<div style="position: relative; top: 218px; left: 15px;">
			<a href="?pageChange=searchProduct">
				<img src="img/index/33.png" width=138px height=50px> 
			</a>
		</div>
	</div>
	<div style="position: absolute;">
		<div style="position: relative; top: 275px; left: 20px;">
			<a href="?pageChange=viewMap">
				<img src="img/index/44.png" width=130px height=50px>
			</a>
		</div>
	</div>

	<img src="img/index/left2.png" width=180px height=490px>
</body>
</html>