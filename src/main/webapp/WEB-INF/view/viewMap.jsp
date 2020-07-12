<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div#index {
   position: absolute;
   left:450px;
   top: 25px;
   font-family: "Cooper Black", bold;
}

div#map {
   position: absolute;
   left: 220px;
   top: 117px;
}

div#main {
   position: absolute;
   left: 190px;
   top: 93px;
}
.button-7{
  left:670px;
  top: 5px;
  font-size:30px;
  width:100px;
  height:50px;
  border:2px solid #34495e;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0px;
  padding: 0px;
}

.button-7 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-7{
  width:140px;
  height:50px;
  border:0px solid #34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
  box-sizing:border-box;
}
.button-7:hover .eff-7{
  border:70px solid #34495e;
}
.button-7:hover a{
  color:#fff;
}

</style>
</head>
<body>
            <div id="index">            
               <h2>${index} 층</h2><br><br>               
            </div>
            <div id="main">      
               <img src="img/index/middle2.png" width=790px height=490px top=200px>                        
            </div>      
            <div id="map">
               <img src="${src}" width="632" height="450" usemap="#mapsmap" />
               <img src="${src2}" width="${width}" height="${height}" border="0" style="position:absolute; left:${left}; top:${top};"/>
            </div>
            
      		<div class="button-7">
             <div class="eff-7"></div>
             <a href="?pageChange=whichMap?index=1" size="4"> 1층 </a>
            </div>
            <br>
            
            <div class="button-7">
             <div class="eff-7"></div>
             <a href="?pageChange=whichMap?index=2"> 2층 </a>
            </div>
            <br>
            
            <div class="button-7">
             <div class="eff-7" style= "vertical-align: bottom"></div>
             <a href="?pageChange=whichMap?index=3"> 3층 </a>
             </div>
</body>
</html>