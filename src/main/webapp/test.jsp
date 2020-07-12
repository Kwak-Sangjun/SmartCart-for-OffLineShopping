<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%
	Product pro = (Product)session.getAttribute("product");
	if(pro == null)
	{ pro = new Product("1","1","1",1,"1","1"); }
%>
<html>
 <head>
    <meta name="viewport" content="width=device-width, initial-scale=0.85">
    <!-- <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" /> -->
    <title>JS in-browser barcode reader</title>
      <style type="text/css">
        video { position: absolute; 
        		top:50%; 
        		left:96%;
        		object-fit:fill;
        		width: 50%;
        		height: 80%;
        		transform:translate(-100%, -50%);
        }
        #overlay-canvas {
          position: absolute;
          top: 0;
          left: 0;
          height: 100%;
          width: 100%;
          z-index: 1003;
          background-color:rgba(0, 0, 0, 0.048);
        }
        div#inner {
          position: absolute;
          margin: 0 auto;
          top: 50%; left: 100%;
          width: 50%; height: 80%;/* width 82.8125% height 77.08334*/
          border: 3.36607em solid rgba(64,64,64, 0.5);/* 3.36607em */
          box-sizing: content-box;
          -webkit-box-align: stretch;
          transform:translate(-100%, -50%);
          
          /* z-index: 1000; */
        }
        div#inner::before{
          content: " ";
            position: absolute;
            /* z-index: -1; */
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
            border: 3.3em solid rgba(64,64,64, 0.5);
        }
        div#redline {
          position: absolute;
          left: 100%;
          top: 50%;
          width: 60%;
          height:0.3em;
          background-color: rgba(255, 0, 0, 0.3);
          transform:translate(-100%, -50%);
          /* z-index: 1001; */
        }
        
        #overlay {   
          height: 100%;
          width: 0;
          position: fixed; /* Stay in place */
          z-index: 1; /* Sit on top */
          left: 0;
          top: 0;
          background-color: rgb(0,0,0); /* Black fallback color */
          background-color: rgba(0,0,0, 0.1); /* Black w/opacity */
          overflow: hidden; /* Disable horizontal scroll */
          transition: 0.5s; /* 0.5 second transition effect to slide in or slide down the overlay (height or width, depending on reveal) */
        }

        .closebtn {
            position: absolute;
            top: 20px;
            right: 45px;
            font-size: 60px;
            z-index: 1008;
          }
          #overlay a:hover, #overlay a:focus {
            color: #f1f1f1;
          }
          #overlay a {
            /* padding: 8px; */
            text-decoration: none;
            /* font-size: 50px; */
            color:  rgba(255, 0, 0, 0.3);
            display: block; /* Display block instead of inline */
            transition: 0.3s; /* Transition effects on hover (color) */
            border:12px double;
            border-radius: 50%;
            padding: 0px;
            width: 50px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
          }
          #trigger_btn{
            background-image:url("Desktop196.jpg");
            width: 50px;
            height: 50px;
            background-clip: padding-box;
            background-size: contain;
            background-repeat: no-repeat;
            border: none;
            cursor: pointer;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
          }
          ::-webkit-media-controls {
              display:none !important;
            }
          ::-webkit-media-controls-enclosure {
              display:none !important;
            }
      </style>
    </head>
    <body>
      <h1>Barcode scanner</h1>
      <div id="overlay" class="video-wrapper">
        <video autoplay muted style="pointer-events: none;"></video>
        <div id="inner"></div>
        <div id="redline"></div>
        <canvas id="overlay-canvas" width=640 height=480></canvas>
      </div>
      
      <ul id="decoded" style="font-size:25px">
      	<li>이름 : <%=pro.getpName() %></li>
      	<li>가격 : <%=pro.getpPrice() %></li>
      	<li>제조사 : <%=pro.getpManufacturer() %></li>
      </ul>
      <canvas id="stream-canvas" width=640 height=480
       style="display:none;width: 640px;height: 480px;"></canvas>
      
      
      <script type="text/javascript">
        var localMediaStream = null;
        var interval = null
        var video = document.querySelector('video');
        var stream_canvas = document.getElementById('stream-canvas')
        var ctx = stream_canvas.getContext('2d')
        var overlay_ctx = document.getElementById('overlay-canvas').getContext('2d')
        var list = document.querySelector('ul#decoded');
        var modal = document.getElementById('overlay')
        var worker = new Worker('zbar-processor.js');
        start();
        worker.onmessage =  function(event) {
            if (event.data.length == 0) return;
            var d = event.data[0];
            location.href='/SmartCart/test.do?barcode='+d[1];
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

  
      </script>
    </body>
</html>
