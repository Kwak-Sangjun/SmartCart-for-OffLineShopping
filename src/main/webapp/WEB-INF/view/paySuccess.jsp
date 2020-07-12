<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

<form id="TheForm" method="post" action="bill" target="TheWindow"></form>


<div>
   <div style="position: absolute;">
      <div style="position: relative; top: 150px; left: 130px;"><img src="img/index/thanks.png"></img></div>
   </div>
   
   <div style="position: absolute;">
      <div style="position: relative; top: 300px; left: 500px;"><img src="img/button/bill.png" onclick="bill()"></img></div>
   </div>

   <img src="img/index/middle2.png" width=790px height=490px style="left: 190px; top: 93px;"></img>
</div>

<script type=text/javascript>

function bill() {
	  var f = document.getElementById('TheForm');
	  window.open('', 'TheWindow',"width=400,height=300,left=300px,top=100px");
	  f.submit();
	}
	
	
	
</script>
</body>
</html>