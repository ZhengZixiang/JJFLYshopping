package me.zzx.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.Dataset;
import org.jfree.data.general.DefaultPieDataset;

import me.zzx.shopping.Category;
import me.zzx.shopping.Product;
import me.zzx.shopping.util.DB;

public class ProductMysqlDAO implements ProductDAO {

	public List<Product> getProducts() {
		List<Product> products = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from product";
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalPrice"));
				p.setMemberPrice(rs.getDouble("memberPrice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryId"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return products;
	}

	public List<Product> getProducts(int pageNo, int pageSize) {
		List<Product> products = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from product limit " + pageSize*(pageNo-1) + ", " + pageSize;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalPrice"));
				p.setMemberPrice(rs.getDouble("memberPrice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryId"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return products;
	}
	
	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCnt = null;
		int pageCnt = 0;
		try {
			conn = DB.getConn();
			rsCnt = DB.executeQuery(conn, "select count(*) from product");
			rsCnt.next();
			pageCnt = (rsCnt.getInt(1) + pageSize -1) / pageSize;
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid, " +
						 " category.id cid, category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade " + 
						 " from product join category on (product.categoryid = category.id) limit " + pageSize*(pageNo-1) + ", " + pageSize;
			rs = DB.executeQuery(conn, sql);
//System.out.println(sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf")==0? true : false);
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
				
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rsCnt);
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return pageCnt;
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
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCnt = null;
		int pageCnt = 0;
		try {
			conn = DB.getConn();
			String sql = "select * from product where 1=1";
			String strId = "";
			if(categoryId != null && categoryId.length>0) {
				strId += "(";
				for(int i=0; i<categoryId.length; i++) {
					if(i<categoryId.length - 1)
						strId += categoryId[i] + ",";
					else
						strId +=  categoryId[i] + ")";
				}
				sql += " and categoryid in " + strId;
			}
			if(keyword != null && !keyword.trim().equals("")) {
				sql += " and name like '%" + keyword + "%' or descr like '%" + keyword + "%'";
			}
			if(lowNormalPrice >= 0) {
				sql += " and normalprice > " + lowNormalPrice;
			}
			if(highNormalPrice > 0) {
				sql += " and normalprice < " + highNormalPrice;
			}
			if(lowMemberPrice >= 0) {
				sql += " and memberprice > " + lowMemberPrice;
			}
			if(highMemberPrice > 0) {
				sql += " and memberprice < " + highMemberPrice;
			}
			if(startDate != null) {
				sql += " and pdate > '" + new SimpleDateFormat("yyyy-MM-dd").format(startDate) + "'"; 
			}
			if(endDate != null) {
				sql += " and pdate < '" + new SimpleDateFormat("yyyy-MM-dd").format(endDate) + "'"; 
			}
			String sqlCnt = sql.replaceAll("\\*", "count(*)");
//System.out.println(sqlCnt);
			rsCnt = DB.executeQuery(conn, sqlCnt);
			rsCnt.next();
			pageCnt = (rsCnt.getInt(1) + pageSize -1) / pageSize;
			
			sql += " limit " + (pageNo-1)*pageSize + "," + pageSize;
System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalPrice"));
				p.setMemberPrice(rs.getDouble("memberPrice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryId"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rsCnt);
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return pageCnt;
	}
	
	public boolean deleteProductsById(int[] idArray) {
		Connection conn = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "delete from product where ";
			for(int i = 0; i < idArray.length; ++i) {
				sql += "id = " + idArray[i] + " or ";
			}
			sql += "1 = 0";
			DB.executeUpdate(conn,sql);
			conn.commit();
			conn.setAutoCommit(true);
		} catch(SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.closeConn(conn);
		}
		return true;
	}
	
	/**
	 * 该方法实现了通过类别ID删除其下产品，应用于类DAO里的删除类别操作
	 */
	public boolean deleteProductsByCategoryId(int categoryId) {
		Connection conn = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "delete from product where categoryid = " + categoryId;
			DB.executeUpdate(conn, sql);
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
		}
		return true;
	}
	
	public boolean updateProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn  = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "update product set name = ?, descr = ?, normalprice = ?, memberprice = ?, categoryid = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setInt(5, p.getCategoryId());
			pstmt.setInt(6, p.getId());
			pstmt.executeUpdate();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			return false;
		} finally {
			DB.closeConn(conn);
		}
		return true;
	}
	
	public Product loadById(int id) {
		Connection conn = null;
		ResultSet rs = null;
		Product p = null;
		try {
			conn = DB.getConn();
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid, " +
					 " category.id cid, category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade " + 
					 " from product join category on (product.categoryid = category.id) where product.id = " + id;
			rs = DB.executeQuery(conn, sql);
			if(rs.next()) {
				p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf")==0? true : false);
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return p;
	}

	public boolean addProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into product values (null, ?, ?, ?, ?, ?, ?)";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, p.getPdate());
			pstmt.setInt(6, p.getCategoryId());
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
		return true;
	}

	public List<Product> getLatestProducts(int count) {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> products = new ArrayList<Product>();
		try {
			conn = DB.getConn();
			String sql = "select * from product order by pdate desc limit 0, " + count;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				products.add(p);
			}
		} catch(SQLException e) {
			e.printStackTrace();
			return products;
		} finally {
			DB.closeConn(conn);
			DB.closeRS(rs);
		}
		return products;
	}

	public List<Dataset> getDatasets() {
		Connection conn = null;
		ResultSet rs = null;
		DefaultCategoryDataset cDataset = new DefaultCategoryDataset();
		DefaultPieDataset pDataset = new DefaultPieDataset();
		List<Dataset> datasets = new ArrayList<Dataset>();
		try {
			conn = DB.getConn();
			String sql = "select p.name, sum(pcount) from product p join salesitem si on (p.id = si.productid) group by p.id";
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
		        cDataset.addValue(rs.getInt(2), "", rs.getString(1));
		        pDataset.setValue(rs.getString(1), rs.getInt(2));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		datasets.add(cDataset);
		datasets.add(pDataset);
		return datasets;
	}
	
}
