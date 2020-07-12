package dto;

public class BasketProduct {
	private Product product;
	private int amount;
	
	public BasketProduct(int amount, Product product) {
		this.product=product;
		this.amount=amount;	
	}
	
	public Product getProduct() {
		return product;
	}
	
	public int getAmount() {
		return amount;
	}
	
	public void addAmount(int amount) {
		this.amount=this.amount+amount;
	}
	
	public void setAmount(int amount) {
		this.amount=amount;
	}
	
	
}
