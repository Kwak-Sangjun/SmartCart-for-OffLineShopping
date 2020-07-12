<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.BasketProduct" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table, th, td {border-spacing: 1px; text-align: center; line-height: 1.5; margin: 20px 10px;}
    th, td { padding: 10px; border-bottom: 1px solid #DF3A01; }
    th {border-top:1px solid #DF3A01; width: auto; padding: 10px; font-weight: bold; vertical-align: top; background: #D8D8D8;}
    td {width: auto; padding: 10px; vertical-align: top; border-bottom: 1px solid #ccc;}
</style>
</head>
<body>


<table>
	  <thead>
      <tr>
            <th>상품명</th>
            <th>제조사</th>
            <th>수량</th>
            <th>금액</th>           
      </tr>
      </thead>
	<tbody>
	<c:forEach var="list" items="${bill}" varStatus="status">
	 	<tr>
	 		<td>${list.product.pName}</td><td>${list.product.pManufacturer}</td><td>${list.amount}</td><td>${list.amount*list.product.pPrice}</td>
	 	</tr>
	 </c:forEach>
	 </tbody>
</table>


</body>
</html>