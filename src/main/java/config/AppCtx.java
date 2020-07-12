package config;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.PlatformTransactionManager;

import dao.ProductDao;
import service.BuzzerServerSocket;
import service.FindLocationCategory;
import service.LedServerSocket;

@Configuration
public class AppCtx {
	
	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
		ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
		ds.setUrl("jdbc:mysql://127.0.0.1:3306/smartcart?serverTimezone=UTC");
		ds.setUsername("root");
		ds.setPassword("1234");
		return ds;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sb = new SqlSessionFactoryBean();
		sb.setDataSource(dataSource());
		sb.setTypeAliasesPackage("dto");
		sb.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:ProductMapper.xml"));
		 return (SqlSessionFactory) sb.getObject();
	}
	
	
	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager tm = new DataSourceTransactionManager();
		tm.setDataSource(dataSource());
		return tm;
	}
	
	@Bean(destroyMethod="close")
	public SqlSessionTemplate sqlSessionTemplate() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}
	
	@Bean
	public ProductDao productDao() {
		return new ProductDao();
	}
	
	@Bean(initMethod="init")
	public FindLocationCategory findLocationCategory() {
		return new FindLocationCategory();
	}
	
	@Bean(initMethod="startServer", destroyMethod="close")
	public BuzzerServerSocket buzzerClientSocket() {
		return new BuzzerServerSocket();
	}
	
	@Bean(initMethod="startServer", destroyMethod="close")
	public LedServerSocket ledClientSocket() {
		return new LedServerSocket();
	}
	
	@Bean
	public ExecutorService executorService() {
		ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());
		System.out.println(Runtime.getRuntime().availableProcessors());
		return executorService;
	}
	
}
