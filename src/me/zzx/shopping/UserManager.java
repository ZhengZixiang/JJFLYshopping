package me.zzx.shopping;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import me.zzx.shopping.util.DB;

public class UserManager {
	public static List<User> getUsers() {
		List<User> users = new ArrayList<User>();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from ruser order by id desc";
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setRdate(rs.getTimestamp("rdate"));
				users.add(u);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return users;
	}
	
	public static void deleteUser(int id) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConn();
			stmt = DB.getStmt(conn);
			String sql = "delete from ruser where id = " + id;
			stmt.executeUpdate(sql);
		}  catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
	} 
	
}
