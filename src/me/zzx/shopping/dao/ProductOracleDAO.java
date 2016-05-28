package me.zzx.shopping.dao;

import java.util.Date;
import java.util.List;

import org.jfree.data.general.Dataset;

import me.zzx.shopping.Product;

public class ProductOracleDAO implements ProductDAO {

	@Override
	public List<Product> getProducts() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> getProducts(int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int searchProducts(List<Product> products, int[] categoryId, String keyword, double lowNormalPrice,
			double highNormalPrice, double lowMemberPrice, double highMemberPrice, Date startDate, Date endDate,
			int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		return -1;
	}

	@Override
	public boolean deleteProductsById(int[] idArray) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteProductsByCategoryId(int categoryId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateProduct(Product p) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Product loadById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addProduct(Product p) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public List<Product> getLatestProducts(int count) {
		return null;
	}

	@Override
	public List<Dataset> getDatasets() {
		// TODO Auto-generated method stub
		return null;
	}
}
