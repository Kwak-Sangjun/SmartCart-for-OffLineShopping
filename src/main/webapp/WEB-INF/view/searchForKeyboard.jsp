<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
div#main {
		position: absolute;
		left: 193px;
		top: 98px;
	}
	
div#table{
	position:absolute;
	left:230px;
	top:130px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="main">		
		<img src="img/index/middle2.png" width=790px height=490px>							
	</div>	

	<div id="table">	
			<form action="?pageChange=search" method="post">
				<input type="text" name="search"/>
				<input type="submit" value="검색"/>
				<table border="1" align="center" width="500">
					<tr>
						<td>제품명</td>
						<td>카테고리</td>
						<td>가격</td>
						<td>위치보기</td>
					</tr>
	
					<c:forEach var="product" items="${list}">						
						<tr>
							<td>${product.pName}</td>
							<td>${product.pCategory}</td>
							<td>${product.pPrice}</td>
							<td>
								<form action="?pageChange=where" method="post">
									<input type="hidden" name="pCategory" value="${product.pCategory}"/>
									<input type="submit" value="위치보기"/>						         
								</form>
							</td>
						</tr>		
		 			</c:forEach>	
		 			
				</table>
			</form>
	</div>		
</body>
</html>