package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import service.LedServerSocket;

@Controller
public class MenuController {

	
	@GetMapping("calculator")
	public String indexCaculator() {
		return "calculator";
	}
	
	@GetMapping("event")
	public String indexEvent() {
		return "event";
	}
	
	@GetMapping("scanBarcode")
	public String indexScanBarcode() {
		return "scanBarcode";
	}
	
	@GetMapping("searchProduct")
	public String indexSearchProduct() {
		return "searchProduct";
	}
	
	@GetMapping("viewMap")
	public String indexViewMap(Model model,@RequestParam(name="index", defaultValue="1") String index) {
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
	
	@GetMapping("basket")
	public String indexBasket() {
		return "basket";
	}
	
	
}
