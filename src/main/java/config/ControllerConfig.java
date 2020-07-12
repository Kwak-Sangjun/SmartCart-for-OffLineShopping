package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.MenuController;
import controller.ProductController;

@Configuration
public class ControllerConfig {

	@Bean
	public MenuController indexController() {
		return new MenuController();
	}
	
	@Bean
	public ProductController productController() {
		return new ProductController();
	}
}
