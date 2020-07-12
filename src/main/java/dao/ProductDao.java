package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.Product;

@Repository
public class ProductDao {
	
	@Autowired
	private SqlSessionTemplate template;
	
	public Product selectProduct(String barcode) {
		Product product = template.selectOne("java.mapper.ProductMapper.selectProduct", barcode);
		return product;
	}
	
	public List<Product> selectProductList(String string){
		List<Product> list = template.selectList("java.mapper.ProductMapper.selectProductList",string);
		return list;
	}
	
}
