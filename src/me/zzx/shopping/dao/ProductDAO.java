package me.zzx.shopping.dao;

import java.util.Date;
import java.util.List;

import org.jfree.data.general.Dataset;

import me.zzx.shopping.Product;

//面向接口编程，也叫控制反转
public interface ProductDAO {
	public List<Product> getProducts();
	
	
	public List<Product> getProducts(int pageNo, int pageSize);
	
	public int searchProducts(List<Product> products,
							  int[] categoryId, 
							  String keyword,
							  double lowNormalPrice, 
							  double highNormalPrice, 
							  double lowMemberPrice,
							  double highMemberPrice,
							  Date startDate,
							  Date endDate,
							  int pageNo,
							  int pageSize);
	
	public boolean deleteProductsById(int[] idArray);
	
	public boolean deleteProductsByCategoryId(int categoryId);
	
	public boolean updateProduct(Product p);
	
	public Product loadById(int id);
	
	public boolean addProduct(Product p);

	public int getProducts(List<Product> products, int pageNo, int pageSize);

	public List<Product> getLatestProducts(int count);


	public List<Dataset> getDatasets();
	
}
