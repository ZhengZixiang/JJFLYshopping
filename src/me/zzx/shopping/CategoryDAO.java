 package me.zzx.shopping;

import java.sql.*;
import java.util.List;

import me.zzx.shopping.util.DB;

public class CategoryDAO {
	public static void save(Category c) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "";
			if(c.getId() == -1) {
				sql = "insert into category values (null, ?, ?, ?, ?, ?)";
			} else {
				sql = "insert into category values (" + c.getId() + ", ?, ?, ?, ?, ?)";
			}
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getDescr());
			pstmt.setInt(3, c.getPid());
			pstmt.setInt(4, c.isLeaf()? 0 : 1);
			pstmt.setInt(5, c.getGrade());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
	}
	
	private static void getCategories(Connection conn, List<Category> list, int id) {
		ResultSet rs = null;
		try {
			//conn = DB.getConn(); 每次连接，效率太低，故另外写一个方法，并将此方法设为private
			String sql = "select * from category where pid = " + id;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf")==0?true : false);
				c.setGrade(rs.getInt("grade"));
				list.add(c);
				if(!c.isLeaf()) {
					getCategories(conn, list, c.getId());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
		}
	}
	
	public static void getCategories(List<Category> list, int id) {
		Connection conn = DB.getConn();
		getCategories(conn, list, id);
		DB.closeConn(conn);
	}

	public static void addChildCategory(int pid, String name, String descr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			//存储新的category
			conn.setAutoCommit(false);
			rs = DB.executeQuery(conn, "select * from category where id = " + pid);
			int pgrade = 0;
			if(rs.next()){
				pgrade = rs.getInt("grade");
			}
			String sql = "insert into category values (null, ?, ?, ?, ?, ?)";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, name);
			pstmt.setString(2, descr);
			pstmt.setInt(3, pid);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, pgrade + 1);
			pstmt.executeUpdate();
			//更新父类的leaf，设置为非叶子
			DB.executeUpdate(conn, "update category set isleaf = 1 where id = " + pid);
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}		
	}

	public static Category loadById(int id) {
		Connection conn = null;
		ResultSet rs = null;
		Category c = null;
		try {
			conn = DB.getConn();
			String sql = "select * from category where id = " + id;
			rs = DB.executeQuery(conn, sql);
			if(rs.next()) {
				c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf")==0?true : false);
				c.setGrade(rs.getInt("grade"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return c;
	}

	/**
	 * 删除一个类别，同时利用递归删除其下的子类别。
	 * @param id 类别ID
	 * @param pid 父类别ID
	 */
	@SuppressWarnings("resource")
	public static void delete(int id, int pid) {
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select * from category where pid = " + id;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				delete(rs.getInt("id"), id);
			}
			DB.executeUpdate(conn, "delete from category where id = " + id);
			String cntSql = "select count(*) from category where pid = " + pid;
			rs = DB.executeQuery(conn, cntSql);
			rs.next();
			if(rs.getInt(1) <= 0) { 
				DB.executeUpdate(conn, "update category set isleaf = 0 where id = " + pid);
			}
			ProductMgr.getInstance().deleteProductsByCategoryId(id);
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
	}

	public static void modify(int id, String name, String descr) {
		Connection conn = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			DB.executeUpdate(conn, "update category set name = '" + name + "' where id = " + id);
			DB.executeUpdate(conn, "update category set descr = '" + descr + "' where id = " + id);
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DB.closeConn(conn);
		}
	}

}
