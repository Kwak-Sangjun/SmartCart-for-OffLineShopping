package dto;

public class Product {
	private String pNumber;
	private String pName;
	private String pCategory;
	private int pPrice;
	private String pBarcode; 
	private String pManufacturer;
	
	public Product() {}
	public Product(String pNumber, String pName, String pCategory, int pPrice, String pBarcode, String pManufacturer) {
		super();
		this.pNumber = pNumber;
		this.pName = pName; 
		this.pCategory = pCategory;
		this.pPrice = pPrice;
		this.pBarcode = pBarcode;
		this.pManufacturer = pManufacturer;
	}
	
	public String getpNumber() {
		return pNumber;
	}
	public void setpNumber(String pNumber) {
		this.pNumber = pNumber;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpCategory() {
		return pCategory;
	}
	public void setpCategory(String pCategory) {
		this.pCategory = pCategory;
	}
	public int getpPrice() {
		return pPrice;
	}
	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}
	public String getpBarcode() {
		return pBarcode;
	}
	public void setpBarcode(String pBarcode) {
		this.pBarcode = pBarcode;
	}
	public String getpManufacturer() {
		return pManufacturer;
	}
	public void setpManufacturer(String pManufacturer) {
		this.pManufacturer = pManufacturer;
	}
	
	
	
}
