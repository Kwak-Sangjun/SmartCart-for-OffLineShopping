package controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.ProductDao;
import dto.BasketProduct;
import dto.Product;
import service.BuzzerServerSocket;
import service.FindLocationCategory;
import service.LedServerSocket;

@Controller
public class ProductController {

	@Autowired
	private ProductDao dao;
	@Autowired
	private FindLocationCategory svc;
	@Autowired
	private BuzzerServerSocket bcs;
	@Autowired
	private HttpSession session;
	@Autowired
	private LedServerSocket lcs;
	
	
	@GetMapping("whichMap")
	public String whichMap(Model model, @RequestParam(name="index", defaultValue="1") String index) {
		String src;
		
		if(index.equals("1")) {
			src="img/map/마트지도1.png";
		}else if(index.equals("2")) {
			src="img/map/마트지도2.png";
		}else { src="img/map/마트지도3.png"; }
		
		model.addAttribute("index", index);
		model.addAttribute("src",src);
		return "viewMap";
	}
	
	@GetMapping("doScan")
	public String doScan(Model model, @RequestParam(name="barcode", defaultValue="1") String barcode) {
		bcs.sendMessage("bbick");
		Product product;
		
		product = dao.selectProduct(barcode);
		model.addAttribute("product", product);
		return "scanBarcode";
	}
	
	@PostMapping("search")
	public String search(Model model, @RequestParam(name="search") String string) {
		List<Product> list;
		
		list = dao.selectProductList(string);
		model.addAttribute("list", list);
		return "searchProduct";
	}
	
	@GetMapping("where")
	public String where(Model model, @RequestParam(name="category") String category) {
		Map<String,String> map = svc.getMap();
		map.forEach((key,value)->{
			if(key.equals(category)) {
				String[] location=value.split(",");
				String left=location[0];
				String top=location[1];
				String index=location[2];
				String src;
				if(index.equals("1")) {
					src="img/map/마트지도1.png";
				}else if(index.equals("2")) {
					src="img/map/마트지도2.png";
				}else { src="img/map/마트지도3.png"; }
				model.addAttribute("width","20px");
				model.addAttribute("height","20px");
				model.addAttribute("src",src);
				model.addAttribute("left", left);
				model.addAttribute("top",top);
				model.addAttribute("index",index);
				model.addAttribute("src2","img/Category/point.png");
				//model.addAttribute("src2","img/Category/"+key+".jpg");
			}
		});
		return "viewMap";
	}
	
	@PostMapping("addBasket")
	public String addbasket(Model model, @RequestParam(name="amount", defaultValue="1")int amount, Product product) {
		if(product.getpName().equals("")||product.getpName()==null) return "scanBarcode";
		
		BasketProduct bp = new BasketProduct(amount, product);
		int totalPrice = (int)session.getAttribute("totalPrice");
		List<BasketProduct> list = (List<BasketProduct>)session.getAttribute("basket");
		totalPrice = totalPrice+(amount*product.getpPrice());
		session.setAttribute("totalPrice", totalPrice);
		
		checkBudget();
		
		if(list==null) {
			list = new ArrayList<>();
			list.add(bp);
			session.setAttribute("basket", list);
			model.addAttribute("product", null);
			return "scanBarcode";
		}else {
			for(int i=0; i<list.size(); i++) {
				if(list.get(i).getProduct().getpName().equals(product.getpName())) {
					list.get(i).addAmount(amount);
					break;
				}
				if(i==list.size()-1 && !list.get(i).getProduct().getpName().equals(product.getpName())) {
					list.add(bp);
					break;
				}
			}
			model.addAttribute("product", null);
			return "scanBarcode";
		}
	}
	
	@GetMapping("cancel")
	public String cancel(@RequestParam(name="numbers")String numbers) {
		if(numbers.equals("") || numbers==null) return "basket";
		String[] numStringArray = numbers.split(",");
		int[] numIntArray = Arrays.stream(numStringArray).mapToInt(Integer::parseInt).toArray();
		List<BasketProduct> list = (List<BasketProduct>)session.getAttribute("basket");
		for(int i=numIntArray.length-1; i>=0; i--) {
			list.remove(numIntArray[i]-1);
		}
		session.setAttribute("basket", list);
		if(list.size()==0) { session.removeAttribute("basket"); }
		return "basket";
	}
	
	@GetMapping("amount")
	public String amount(Model model, @RequestParam(name="num")int number, @RequestParam(name="amount")int amount) {
		int index=number-1;
		List<BasketProduct> list = (List<BasketProduct>)session.getAttribute("basket");
		list.get(index).setAmount(amount);
		return "basket";
	}
	
	
	@GetMapping("setTotalPrice")
	public String setTotalPrice(Model model, @RequestParam(name="totalPrice")int totalPrice) {
		session.setAttribute("totalPrice", totalPrice);
		checkBudget();
		
		return "basket";
	}
	
	@GetMapping("kakaopay")
	public String kakaopay(Model model, @RequestParam(name="totalPrice")int totalPrice) {
		model.addAttribute("totalPrice",totalPrice);
		
		return "kakaopay";
	}
	
	@GetMapping("paySuccess")
	public String paySuccess() {
		List<BasketProduct> list = (List<BasketProduct>)session.getAttribute("basket");
		session.setAttribute("bill", list);

		session.removeAttribute("basket");
		
		return "paySuccess";
	}
	
	@PostMapping("bill")
	public String bill() {
		return "bill";
	}
	
	@GetMapping("setBudget")
	public String setBudget(Model model, @RequestParam(name="budget", defaultValue="0") int budget) {
		int totalPrice=0;
		session.setAttribute("budget", budget);
		
		if(session.getAttribute("totalPrice")!=null)
		{	totalPrice = (int) session.getAttribute("totalPrice"); }
		
		checkBudget();
		
		model.addAttribute("budget", budget);
		model.addAttribute("totalPrice",totalPrice);
		
		return "calculator";
	}
	
	private void checkBudget() {
		int budget = (int)session.getAttribute("budget");
		int totalPrice = (int)session.getAttribute("totalPrice");
		lcs.sendMessage(lcs.whatColor(budget, totalPrice));
	}
	
	
}
