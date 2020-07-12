<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-spacing: 1px;
}
</style>
</head>
<body>
	<%
		String select = request.getParameter("pageChange");

		if (select == null) {
			select = "middle.jsp";
		}
	%>

	<table width=970px height=570px bgcolor="#ffdc46">

		<tr height=80px>
			<td colspan=2><jsp:include page="top.jsp" flush="false" /></td>
		</tr>

		<tr>
			<td width=180px height=490px>
				<jsp:include page="left.jsp" flush="false" />
			</td>
			<td width=790px height=490px>
				<jsp:include page="<%=select%>"	flush="false" />
			</td>
		</tr>

	</table>
</body>
</html>