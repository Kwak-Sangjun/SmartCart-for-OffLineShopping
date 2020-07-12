package service;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;

import org.springframework.beans.factory.annotation.Autowired;

public class LedServerSocket implements ServerSocketTemplate {
	
	@Autowired
	private ExecutorService executorService;
	private ServerSocket serverSocket;
	private Socket socket;
	private OutputStream os;
	

	@Override
	public void startServer() {	
		try {
			serverSocket = new ServerSocket();
			serverSocket.bind(new InetSocketAddress(8112));
			}catch(IOException e) {}
		
		Runnable runnable = new Runnable() {
			@Override
			public void run() {
				try {
						System.out.println("LED 연결기다림");
						socket = serverSocket.accept();
						os = socket.getOutputStream();
						
						InetSocketAddress isa = (InetSocketAddress) socket.getRemoteSocketAddress();
						System.out.println("LED 연결을 수락함"+isa.getHostName()+" "+isa.getPort()+" "+isa.toString());
					}	
				catch(IOException e1) {}
			}
		};
		
		executorService.submit(runnable);
		
	}
	
	@Override
	public void close() {
		sendMessage("close");
		
		try {
			os.close();
		} catch (IOException e) {}
		
		if(!serverSocket.isClosed()) {
			try {
				serverSocket.close();
			}catch(IOException e) {}
		}	
		
		if(executorService!=null && !executorService.isShutdown()) {
			executorService.shutdownNow();
		}
		
	}
	
	public String whatColor(int budget, int totalPrice) {
		double _80perOfBudget = budget * (0.8);
		String color=null;
		if(budget==0) return "off";
		
		
		if(totalPrice<budget && totalPrice<_80perOfBudget) {
			color="green";
		}else if(totalPrice<=budget && totalPrice>=_80perOfBudget) {
			color="violet";
		}else if(totalPrice>budget) {
			color="red";
		}
		
		return color;
	}
	
	@Override
	public void sendMessage(String message) {
		try {
			
			byte[] bytes = null;
			
			bytes = message.getBytes("UTF-8");
			os.write(bytes);
			os.flush();
			System.out.println("[LED 데이터보내기성공]");
			
		}catch(IOException e) {
			System.out.println("*******************************************************");
			e.printStackTrace();	}	
	}
	
	
	
}
