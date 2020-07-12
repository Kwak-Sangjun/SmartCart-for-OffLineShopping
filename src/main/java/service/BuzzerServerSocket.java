package service;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;

import org.springframework.beans.factory.annotation.Autowired;

public class BuzzerServerSocket implements ServerSocketTemplate{
	
	@Autowired
	private ExecutorService executorService;
	private ServerSocket serverSocket;
	private Socket socket;
	private OutputStream os;
	
	
	@Override
	public void startServer() {	
		try {
		serverSocket = new ServerSocket();
		serverSocket.bind(new InetSocketAddress(8115));
		}catch(IOException e) {}
		
		Runnable runnable = new Runnable() {
			@Override
			public void run() {
					try {
							System.out.println("버저 연결기다림");
							socket = serverSocket.accept();
							os = socket.getOutputStream();
							
							InetSocketAddress isa = (InetSocketAddress) socket.getRemoteSocketAddress();
							System.out.println("버저 연결을 수락함"+isa.getHostName()+" "+isa.getPort()+" "+isa.toString());
						}catch(IOException e) {}
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
	
	@Override
	public void sendMessage(String message) {
		try {		
			byte[] bytes = null;
			
			bytes = message.getBytes("UTF-8");
			os.write(bytes);
			os.flush();
			System.out.println("[버저 데이터보내기성공]");
			
		}catch(IOException e) { 
			System.out.println("*******************************************************");
			e.printStackTrace();	}
			
	}
	

	
}
