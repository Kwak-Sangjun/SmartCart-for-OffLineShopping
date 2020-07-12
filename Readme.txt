this. written by beginners (http://www.yc.ac.kr - SW student - Capstone Desing)

Demo vedio : https://www.youtube.com/watch?v=RthUDW8i9XI

Maven SpringFramework (on tomcat)
used zbarjs library to scan barcode

Smart cart project that can be mounted on an offline store cart
Providing services to consumers through browser as UI as web application

1.  import this maven project on your tool through pom.xml

2.  set your database source in config.AppCtx.java

3.  you need https protocol SSL key to using webcam on WebRTC (media access)
	if you have nothing idea, follow these step ( and if you also have JDK System Path ) - comfirm keyname, keypass, location ... are correct
		1. make new folder names TLS ( like c:\TLS )
		2. window+s - cmd - "%JAVA_HOME%\bin\keytool" -genkey -alias tomcat_https -keypass 123456 -storepass 123456 -keyalg RSA -keystore c:\TLS\.keystore
		3. input your info ~~ blabla finish than
		4. "%JAVA_HOME%\bin\keytool" -export -alias tomcat_https -storepass 123456 -file c:\TLS\server.cer -keystore c:\TLS\.keystore
		5. "%JAVA_HOME%\bin\keytool" -import -v -trustcacerts -alias subin -file c:\TLS\server.cer -keystore c:\TLS\.keystore -keypass 123456 -storepass 123456
		6. you have to notify your server ( using tomcat server case - ass follow sentence in server.xml )
		<Connector SSLEnabled="true" clientAuth="false" keyAlias="tomcat_https" keystoreFile="C:/TLS/.keystore" keystorePass="123456" maxThreads="150" port="443" protocol="HTTP/1.1" scheme="https" secure="true" sslProtocol="TLS"/> 

4. make database/table/product
	create table product(
	pNumber int(11) primary key,
	pName varchar(50),
	pCategory varchar(20),
	pPrice int(11),
	pBarcode varchar(20),
	pManufacturer varchar(20)
	);				and insert your barcode tuple

5. start index.jsp by entering address in the browser ( not programming tool like eclipse, to use WebRTC)
	adrress like : https://ooo.ooo.ooo.ooo:8443/SmartCart/index.jsp

6. don't forget running(F5) two python file in raspi-py
	if you have rasberrypi, buzzer, 3colorLED you don't need to change python code, just connect each other
	and if you have nothing or something you need to change python code ( eliminate GPIO code ) but connecting to the server socket is essential.