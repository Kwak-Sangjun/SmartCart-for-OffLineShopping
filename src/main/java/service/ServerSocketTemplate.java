package service;

public interface ServerSocketTemplate {
	public void startServer();
	public void sendMessage(String message);
	public void close();
}
