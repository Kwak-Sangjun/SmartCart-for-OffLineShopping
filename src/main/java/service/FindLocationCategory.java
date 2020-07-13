package service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

public class FindLocationCategory {
	@Autowired 
	private ApplicationContext resourceLoader;


	private Map<String,String> map;
	
	
	public void init() {
		map= new HashMap<>();
		Properties pro = new Properties();
		FileInputStream f=null;
		try {
			 f=new FileInputStream(resourceLoader.getResource("classpath:whereCategory.properties").getURI().getPath());
			 InputStreamReader isr = new InputStreamReader(f, "UTF-8");
			 BufferedReader br = new BufferedReader(isr);
			 pro.load(br);
		} catch (FileNotFoundException e) {
			System.out.println("에러:->"+e);
		} catch (IOException e) {
			System.out.println("에러:->"+e);
		 }finally {
			 if(f!=null) {
				 try {
					 f.close();
				 }catch(IOException e) {
					 e.printStackTrace();
				 }
			 }
		 }
		Iterator<Object> keyIter = pro.keySet().iterator();
		while(keyIter.hasNext()) {
			String category = (String)keyIter.next();
			String location = pro.getProperty(category);
			map.put(category, location);
			System.out.println("료카이:"+ map.size()+category+" "+location);
		}
	}
	
	public Map<String,String> getMap() {
		return this.map;
	}

}
