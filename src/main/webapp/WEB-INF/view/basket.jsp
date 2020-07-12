<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="css/basket.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="init();">
   <div id="main">      
      <img src="img/index/middle2.png" width=790px height=490px>                     
   </div>
          <div id="backlist">
         <c:forEach begin="1" end="8">
          <ul class="board">
                 <li class="fl tc w70 list t_line lt_line"></li>
                 <li class="fl tc w500 list t_line lt_line"></li>
                 <li class="fl tc w120 list t_line lt_line"></li>
                 <li class="fl tc w100 list  lt_line"></li>
         </ul>
         </c:forEach>
         </div>

<div id="blist" >
<form name="form" method="get">
<div style="height:auto;">
<ul class="board">
        <li class="fl tc w70 title t_line">취소</li>
        <li class="fl tc w500 title t_line">상품명</li>
        <li class="fl tc w120 title t_line">수량</li>
        <li class="fl tc w100 title ">가격</li>
</ul>
</div>
<div id="plist" >
   <c:forEach var="prod" items="${basket}" varStatus="status">
     <ul class="board">
        <li class="fl tc w70 list t_line lt_line"><input type="checkbox" id="check_${status.count}" style='zoom:2.0;' value="취소"/></li>
        <li class="fl tc w500 list t_line lt_line">${prod.product.pName}</li>
        <li class="fl tc w120 list t_line lt_line">
        	<img src="img/button/minus2.png" style="transform: translate(-3px, 4px); height:30px; width:30px" id="btnd_${status.count}" />
        	<input type="text" id="amount_${status.count}" value="${prod.amount}" readonly size="1" style="transform:translate(0px, -5px); text-align: center;"/>
         	<img src="img/button/plus2.png" style="transform: translate(3px, 4px); height:30px; width:30px" id="btnu_${status.count}" /></li>
        <li class="fl tc w100 list  lt_line" id="price_${status.count}">${prod.amount*prod.product.pPrice}원</li> 
     </ul>
    </c:forEach>
</div>
<div id="totalLine" style="height:auto;">
   <ul class="board">
        <li class="fl tc w570 list t_line lt_line">총액</li>
        <li class="fl tc w220 list lt_line" id="total"></li>
    </ul>
</div>
<div id="btndiv">
	<img src="img/button/cancel2.png" style="height:60px; width:180px" onClick="cancel()" />
	<img src="img/button/payment.png" style="height:60px; width:180px" onClick="kakaopay()"/>
</div>

</form>
</div>
<script>
function cancel(){
	var ele = document.getElementById('plist');
	var eleCount = parseInt(ele.childElementCount);
	var c="";
	for(num=1;num<=eleCount;num++){
		if($('#check_'+num).is(":checked") == true){ 
			if(c==""){ c=num; }
			else{ c=c+","+num; }
		}
	   }
	
	if (confirm("이 상품을 취소하시겠습니까?")) {
    	location.href="?pageChange=cancel?numbers="+c;
    }

}

function kakaopay(){
	var totalPrice = parseInt($('#total').text());
	location.href='?pageChange=kakaopay?totalPrice='+totalPrice;
}


$(document).ready(function() {
   var ele = document.getElementById('plist');
   var eleCount = parseInt(ele.childElementCount);
   var total=0;
   for(num=1;num<=eleCount;num++){
      total= parseInt($('#price_'+num).text())+total;
   }
    $('#total').text(total+'원');
   });


$(function(){
   $('#plist').children().on('click',function(event){
      var name = event.target.getAttribute('id');
      var string = name.split('_');
      var id = string[0];
      var num = string[1];
      var amount = parseInt($('#amount_'+num).val());
      var priceM = parseInt($('#price_'+num).text());
      var total = parseInt($('#total').text());
      if(id=='cancle'){
         if (confirm("이 상품을 취소하시겠습니까?")) {
                // 확인 버튼 클릭 시 동작
                alert("동작을 시작합니다.");
                event.target.parentNode.parentNode.remove();
            } else {
                // 취소 버튼 클릭 시 동작
                alert("동작을 취소했습니다.");
            }
      }
      
      if(id=='btnu')
         { 
           var price = priceM/amount;
           $('#price_'+num).text((amount+1)*price+'원');
           $('#total').text((total+price)+'원');
           location.href="?pageChange=amount?num="+num+"&amount="+(amount+1);
         }
      if(id=='btnd' && amount>1)
         { 
           var price = priceM/amount;
           $('#price_'+num).text((amount-1)*price+'원');
           $('#total').text((total-price)+'원');
           location.href="?pageChange=amount?num="+num+"&amount="+(amount-1);
         }
   })
});

function init() {
	var totalPrice = parseInt($('#total').text());
	var sessionPrice = parseInt("<c:out value="${sessionScope.totalPrice}"/>");
	
	if(totalPrice!=sessionPrice){
		location.href="?pageChange=setTotalPrice?totalPrice="+totalPrice;
	}
	
}

</script>

</body>
</html>