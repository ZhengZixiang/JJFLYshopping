package me.zzx.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import me.zzx.shopping.Cart;
import me.zzx.shopping.CartItem;
import me.zzx.shopping.Product;
import me.zzx.shopping.SalesItem;
import me.zzx.shopping.SalesOrder;
import me.zzx.shopping.User;
import me.zzx.shopping.util.DB;

public class OrderMysqlDAO implements OrderDAO{

	//important
	public boolean saveOrder(SalesOrder so) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			
			String sql = "insert into salesorder values (null, ?, ?, ?, ?)";
			pstmt = DB.getPstmt(conn, sql, true);
			pstmt.setInt(1, so.getUser().getId());
			pstmt.setString(2, so.getAddr());
			pstmt.setTimestamp(3, so.getOdate());
			pstmt.setInt(4, so.getStatus());
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			rs.next();
			int key = rs.getInt(1);
			DB.closeStmt(pstmt);
			
			String sqlItem = "insert into salesitem values(null, ?, ?, ?, ?)";
			pstmt = DB.getPstmt(conn, sqlItem);
			Cart c = so.getCart();
			List<CartItem> items = c.getItems();
			for(int i = 0; i < items.size(); i++) {
				CartItem ci = items.get(i);
				pstmt.setInt(1, ci.getProductId());
				pstmt.setDouble(2, ci.getPrice());
				pstmt.setInt(3, ci.getCount());
				pstmt.setInt(4, key);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			
			conn.setAutoCommit(true);
		} catch(SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
				conn.setAutoCommit(true);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false;
		} finally {
			DB.closeRS(rs);
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
		return true;
	}


	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCnt = null;
		int pageCnt = 0;
		try {
			conn = DB.getConn();
			rsCnt = DB.executeQuery(conn, "select count(*) from salesorder");
			rsCnt.next();
			pageCnt = (rsCnt.getInt(1) + pageSize -1) / pageSize;
			//左外连接的使用，则左边的数据较多，important！
			String sql = "select salesorder.id, salesorder.userid, salesorder.addr, salesorder.odate, salesorder.status, " + 
						 "ruser.id uid, ruser.username, ruser.password, ruser.phone, ruser.addr uaddr, ruser.rdate " +
						 "from salesorder left join ruser on (salesorder.userid = ruser.id) limit " + pageSize*(pageNo-1) + ", " + pageSize;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				SalesOrder so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setOdate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				
				User u  = new User();
				u.setId(rs.getInt("uid"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("uaddr"));
				u.setRdate(rs.getTimestamp("rdate"));
				so.setUser(u);
				
				orders.add(so);
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

	public SalesOrder loadById(int id) {
		Connection conn = null;
		ResultSet rs = null;
		SalesOrder so = null;
		try {
			conn = DB.getConn();
			String sql = "select salesorder.id, salesorder.userid, salesorder.addr, salesorder.odate, salesorder.status, " + 
					 "ruser.id uid, ruser.username, ruser.password, ruser.phone, ruser.addr uaddr, ruser.rdate " +
					 "from salesorder left join ruser on (salesorder.userid = ruser.id) where salesorder.id = " + id;

			rs = DB.executeQuery(conn, sql);
			if(rs.next()) {
				so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setOdate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				
				User u  = new User();
				u.setId(rs.getInt("uid"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("uaddr"));
				u.setRdate(rs.getTimestamp("rdate"));
				so.setUser(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return so;
	}



	public List<SalesItem> getItems(SalesOrder order) {
		Connection conn = null;
		ResultSet rs = null;
		List<SalesItem> items = new ArrayList<SalesItem>();
		try {
			conn = DB.getConn();
			String sql = "select salesitem.id, salesitem.productid, salesitem.unitprice, salesitem.pcount, salesitem.orderid, " + 
						 "product.id pid, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid " +
						 "from salesitem join product on (salesitem.productid = product.id) " +
						 "where salesitem.orderid = " + order.getId();
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				SalesItem item = new SalesItem();
				Product p = new Product();
				p.setId(rs.getInt("pid"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				item.setId(rs.getInt("id"));
				item.setProduct(p);
				item.setUnitPrice(rs.getDouble("unitprice"));
				item.setPcount(rs.getInt("pcount"));
				item.setOrder(order);
				
				items.add(item);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return items;
	}

	
	public void updateStatus(SalesOrder order) {
		Connection conn = null;
		try {
			conn = DB.getConn();
			String sql = "update salesorder set status = " + order.getStatus() + " where id = " + order.getId();
			DB.executeUpdate(conn, sql);
		} finally {
			DB.closeConn(conn);
		}
	}


	public List<SalesOrder> getOrders(User u) {
		Connection conn = null;
		ResultSet rs = null;
		List<SalesOrder> orders = new ArrayList<SalesOrder>();
		try {
			conn = DB.getConn();
			String sql = "select * from salesorder where userid = " + u.getId();
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				SalesOrder order = new SalesOrder();
				order.setId(rs.getInt("id"));
				order.setUser(u);
				order.setAddr(rs.getString("addr"));
				order.setOdate(rs.getTimestamp("odate"));
				order.setStatus(rs.getInt("status"));
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return orders;
	}

	
}
