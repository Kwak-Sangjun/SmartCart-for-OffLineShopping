<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/calculator.css">
<style type="text/css">
</style>
</head>
<body>
<div id="main" style="background-color: white; width:770px; border:3.5px solid black;">
<div style="margin:30px;"> 
<h3><span style="background-color: #F2F5A9;">예산금액</span> : <input type="text" id="budget" value="${sessionScope.budget}원" size="15px;"style="font-size:12pt; font-weight:bold;"/></div>
<div style="margin:30px;"> 
<h3><span style="background-color: #D0F5A9;">현재총액</span> : <input type="text" id="totalPrice" value="${sessionScope.totalPrice}원" size="15px;"style="font-size:12pt; font-weight:bold;"/>
</div>
<div style="margin:30px;">
 <span style="font-size: 17px;">
   ▶ 예산이 <span style="font-weight:bold;">0원</span>이라면 불이 들어오지 않습니다.<br>
   ▶ <span style="color: green; font-weight:bold;">초록색</span> : 장바구니 총액이 예산의 80%미만입니다. <br>
   ▶ <span style="color: purple; font-weight:bold;">보라색</span> : 장바구니의 총액이 예산의 80% 이상입니다.<br>
   ▶ <span style="color: red; font-weight:bold;">빨간색</span> : 장바구니의 총액이 예산을 초과합니다.
</span>
</div>
<div class="wrap">
  <div class="input-box">
    <input id="numInput" type="text" placeholder="0">
  </div>
  <table>
    <tbody>
      <tr>
        <td colspan="3" class="col3"><button id="acBtn">AC</button></td>
      </tr>
      <tr>
        <td><button class="number">7</button></td>
        <td><button class="number">8</button></td>
        <td><button class="number">9</button></td>
      </tr>
      <tr>
        <td><button class="number">4</button></td>
        <td><button class="number">5</button></td>
        <td><button class="number">6</button></td>
      </tr>
      <tr>
        <td><button class="number">1</button></td>
        <td><button class="number">2</button></td>
        <td><button class="number">3</button></td>
      </tr>
      <tr>
        <td><button class="number">0</button></td>
        <td colspan="2" class="col2"><button class="enter" id="enter" onclick="enter()">입력</button></td>
      </tr>
    </tbody>
  </table>
</div>
</div>

<script src="js/calculator.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

function enter() {
   var enterNum =  parseInt($('#numInput').val());
   if(isNaN(enterNum)) { enterNum=0;}
   $('#budget').val(enterNum+'원');
   alert("예산 금액을 "+enterNum+"원으로 설정합니다.");
   location.href='?pageChange=setBudget?budget='+enterNum;
}


</script>
</body>
</html>