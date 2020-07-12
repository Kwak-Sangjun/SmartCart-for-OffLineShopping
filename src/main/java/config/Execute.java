package config;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;

public class Execute {
	public static void main(String[] args) {
		
		getRaspi();
	}
	
	
	public static void callRaspi() {
		Socket socket=null;
		try {
			System.out.println("[연결요청]");
			socket = new Socket("192.168.0.29",8115);
			System.out.println("[연결성공]");
			
			byte[] bytes = null;
			String message = null;
			
			OutputStream os = socket.getOutputStream();
			message = "bbick";
			bytes = message.getBytes("UTF-8");
			os.write(bytes);
			os.flush();
			System.out.println("[데이터보내기성공]");
			
			os.close();
		}catch(IOException e) { System.out.println("*******************************************************");
		e.printStackTrace();}
			if(!socket.isClosed()) {
				try {
					socket.close();
				}catch(IOException e) {}
			}
	}
	
	public static void getRaspi() {
		ServerSocket serverSocket = null;
		
		try {
			serverSocket = new ServerSocket();
			serverSocket.bind(new InetSocketAddress(8112));
			while(true) {
				System.out.println("연결기다림");
				Socket socket = serverSocket.accept();
				InetSocketAddress isa = (InetSocketAddress) socket.getRemoteSocketAddress();
				System.out.println("연결을 수락함"+isa.getHostName()+" "+isa.getPort()+" "+isa.toString());
				byte[] bytes = null;
				String message = null;
				
				OutputStream os = socket.getOutputStream();
				message = "green";
				bytes = message.getBytes("UTF-8");
				os.write(bytes);
				os.flush();
				System.out.println("green 성공");
	
				/*message = "Hello Client2";
				bytes = message.getBytes("UTF-8");
				System.out.println("1");
				os.write(bytes);
				System.out.println("2");
				os.flush();
				System.out.println("데이터보내기 성공");*/
			
			}
		}catch(IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(!serverSocket.isClosed()) {
			try {
				serverSocket.close();
			}catch(IOException e) {}
		}
		
	}

}
