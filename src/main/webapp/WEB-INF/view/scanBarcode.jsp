<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   div#main {
      position: absolute;
      left: 190px;
      top: 93px;
   }
 video { 
    position: absolute; 
    top:120px; 
    left:220px;
    object-fit:fill;
    width: 40%;
    height: 63%;
  }

  div#button{
     position: absolute;
     top: 380px;
     left: 650px;     
  }
  
  div#decoded {
    position: absolute;
    top:180px;
    left:650px;
  }
</style>
</head>
<body>
      <div id="main">      
         <img src="img/index/middle2.png" width=790px height=490px>                     
      </div>

      <div id="overlay" class="video-wrapper">
        <video autoplay muted style="pointer-events: none;"></video>
        <canvas id="overlay-canvas" width=0px height=0px></canvas>
        <canvas id="stream-canvas" width=640 height=480
                style="display:none;"></canvas>
      </div>
      
       <div data-role="content" id="decoded" style="font-size:20px;">
         <div id="text1" style="font-weight:bold; font-size:25px"><p>${product.pName}</p></div>
         <p>${product.pPrice}</p>
         <div id="text2" style="color:gray;"><p>${product.pManufacturer}</p></div>
        </div>
      
      <div id="button">
      <form action="?pageChange=addBasket" method="post" name="frm" id="frm">
      <table width="260px">
      <tr style="text-align-last: right">
         <td colspan=2 >
                        수량<input type=text name=amount value=1 style="transform:translate(0px, -5px); width:100px;height:20px;margin-right:10px;margin-left:10px;padding-right: 5px;"/>
           <img src="img/button/plus.png" width=30px height=30px onClick="up(document.frm.amount.value)" style="transform: translate(3px, 4px);"/>
           <img src="img/button/minus.png" width=30px height=30px onClick="down(document.frm.amount.value)" style="transform: translate(3px, 4px);"/>
         </td>           
       </tr> 
       
       <tr style="text-align-last: right">
          <td>총액:</td><td id="tPrice" align="right">${product.pPrice}원</td>
       </tr>
                
      <tr style="height: 65px; vertical-align: bottom;">
         <td width="130px">
            <input type="hidden" name="pNumber" value="${product.pNumber}"/>
            <input type="hidden" name="pName" value="${product.pName}"/>
            <input type="hidden" name="pCategory" value="${product.pCategory}"/>
            <input type="hidden" name="pPrice" value="${product.pPrice}"/>
            <input type="hidden" name="pBarcode" value="${product.pBarcode}"/>
            <input type="hidden" name="pManufacturer" value="${product.pManufacturer}"/>
            <img src="img/button/basket2.png" style="width:130px;height:40px;" onClick="basket()"/>
         <td width="130px">
            <img src="img/button/cancel.png" style="width:130px;height:40px;" onClick="cancel()"/>
         </td>
      </tr>
      </table>
      </form>
      </div>
      
      <div id="text2">
      <h3>솰라솰라솰라솰라</h3><br>
      1. 가나다라마바사아자차카타파하<br>
      2. 갸냐댜랴먀뱌샤야쟈챠캬탸퍄햐<br>
      2. 거너더러머버서어저처커터퍼허
      </div>


<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

        var pName = document.frm.pName.value;
         var pPrice = document.frm.pPrice.value;
        var localMediaStream = null;
        var interval = null
        var video = document.querySelector('video');
        var stream_canvas = document.getElementById('stream-canvas')
        var ctx = stream_canvas.getContext('2d')
        var overlay_ctx = document.getElementById('overlay-canvas').getContext('2d')
        var list = document.querySelector('ul#decoded');
        var modal = document.getElementById('overlay')
        var worker = new Worker('js/zbar-processor.js');
        start();
        worker.onmessage =  function(event) {
            if (event.data.length == 0) return;
            var d = event.data[0];
            location.href='?pageChange=doScan?barcode='+d[1];
           //async
            //var entry = document.createElement('li');
            //entry.appendChild(document.createTextNode(d[1] + ' (' + d[0] + ')'));
            //list.appendChild(entry);
            //drawPoly(overlay_ctx, d[2]);
            //renderData(overlay_ctx, d[1], d[2][0], d[2][1]);
            //await stop();
               // renderData(overlay_ctx, d[1], d[2][0], d[2][1] - 10)
        };

        function snapshot() {
            if (localMediaStream === null) return;
            ctx.imageSmoothingQuality = "high"
            ctx.filter = "brightness(98%)";
            ctx.drawImage(video, 0, 0, video.videoWidth, video.videoHeight,
                          0, 0, stream_canvas.width, stream_canvas.height);
            var data = ctx.getImageData(0, 0,stream_canvas.width, stream_canvas.height);
            worker.postMessage(data);

        }


        function start() {
            navigator.mediaDevices.getUserMedia(
                { video: 
                  {
                    facingMode: "environment"||"user",
                    width:{min:640, ideal:1280,},
                    height:{min:480,ideal:720,},
                    aspectRatio:2,
                    frameRate: { ideal: 25, max: 30 }
                  }, 
                audio:false,
                }
              ).then((stream)=>{
                video.srcObject = stream
                localMediaStream = true
                modal.style.width = "100%"
                video.onloadedmetadata = (e)=> {video.play();}
                    }).catch((error)=>alert(error))
           interval = setInterval(snapshot, 1000/3.777778);
        }

        function stop() {
              clearInterval(interval)
              localMediaStream = null
              video.srcObject.getTracks().forEach((track)=>{track.stop()})
              video.srcObject = null
              ctx.clearRect(0,0,stream_canvas.width, stream_canvas.height);
              modal.style.width = "0%"
              start()
        }

        function drawPoly(ctx, poly) {
            // drawPoly expects a flat array of coordinates forming a polygon (e.g. [x1,y1,x2,y2,... etc])
                ctx.beginPath();
                ctx.moveTo(poly[0], poly[1]);
                ctx.strokeStyle = "#00bfff";
                ctx.lineWidth = 2.3;
                // ctx.shadowColor = '#FFF';
                // ctx.shadowBlur = 3;
                for (item = 2; item < poly.length - 1; item += 2) { 
                  ctx.lineTo(poly[item], poly[item + 1]) 
                }
                ctx.closePath();
                ctx.stroke();

            }

            // render the string contained in the barcode as text on the canvas
        function renderData(ctx, data, x, y) {
                ctx.font = "15px Arial";
                ctx.fillStyle = "green";
                // ctx.fillText(data, x, y);
                setTimeout(()=>{
                  ctx.clearRect(0, 0, stream_canvas.width, stream_canvas.height)
                },100)
            }

        
            
        
        function basket(){
           if(pName==''){
            alert('상품을 스캔하세요.');
         }else{
        	 alert('장바구니에 추가합니다.');
           document.getElementById('frm').submit();
         }
        }    
        
        function up(val){
           if(pName==''){
            alert('상품을 스캔하세요.');
         }else{
              document.frm.amount.value=parseInt(val)+1;
              var tPrice = (parseInt(val)+1)*pPrice;
              $('#tPrice').text(tPrice+'원');
         }
           
        }  
      function down(val){
         if(pName==''){
            alert('상품을 스캔하세요.');
         }else{
               if (val<2){
                       document.frm.amount.value=1; }
               else{
                       document.frm.amount.value=val-1;
                       var tPrice = (parseInt(val)-1)*pPrice;
                       $('#tPrice').text(tPrice+'원');
                       }
         }
      }
      function cancel(){
    	  if(pName==''){
              alert('상품을 스캔하세요.');
           }else{
        	   location.href='?pageChange=scanBarcode';
           }
      }
      </script>

</body>
</html>