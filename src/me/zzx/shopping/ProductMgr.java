package me.zzx.shopping;

import java.util.Date;
import java.util.List;

import me.zzx.shopping.dao.ProductDAO;
import me.zzx.shopping.dao.ProductMysqlDAO;

public class ProductMgr {
	
	private static ProductMgr pm = null;
	
	private ProductMgr() {
	}
	
	static {
		if(pm == null) {
			pm = new ProductMgr();
			//you should read the config file to set the specific dao object
			pm.setDao(new ProductMysqlDAO());
		}
	}
	
	public static ProductMgr getInstance() {
		return pm;
	}
	
	ProductDAO dao = null;
	
	public ProductDAO getDao() {
		return dao;
	}

	public void setDao(ProductDAO dao) {
		this.dao = dao;
	}

	public List<Product> getProducts() {
		return dao.getProducts();
	}
	
	public List<Product> getProducts(int pageNo, int pageSize) {
		return dao.getProducts(pageNo, pageSize);
	}
	
	/**
	 * 
	 * @param products
	 * @param pageNo
	 * @param pageSize
	 * @return page counts of the specified page size
	 */
	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		return dao.getProducts(products, pageNo, pageSize);
	}
	
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
							  int pageSize) {
		return dao.searchProducts(products, categoryId, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, pageSize);
	}
	
	public List<Product> searchProducts(String name) {
		return null;
	}
	
	public boolean deleteProductsById(int[] idArray) {
		return false;
	}
	
	public boolean deleteProductsByCategoryId(int categoryId) {
		return false;
	}
	
	public boolean updateProduct(Product p) {
		return false;
	}
	
	public boolean addProduct(Product p) {
		return dao.addProduct(p);
	}
}