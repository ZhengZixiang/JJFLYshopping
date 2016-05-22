package me.zzx.shopping;

import java.sql.*;
import java.util.Date;

import me.zzx.shopping.util.DB;

public class User {

	private int id;
	private String username;
	private String password;
	private String phone;
	private String addr;
	private Date rdate;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	
	public void save() {
		Connection conn  = null;
		PreparedStatement pstmt = null;
		try{
			conn = DB.getConn();
			String sql = "insert into ruser values(null, ?, ?, ?, ?, ?)";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, phone);
			pstmt.setString(4, addr);
			pstmt.setTimestamp(5, new Timestamp(rdate.getTime()));
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.closeConn(conn);
			DB.closeStmt(pstmt);
		}
	}
	
	public void update() {
		Connection conn  = null;
		PreparedStatement pstmt = null;
		try{
			conn = DB.getConn();
			String sql = "update ruser set username = ?, phone = ?, addr = ? where id = " + this.id;
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, phone);
			pstmt.setString(3, addr);
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.closeConn(conn);
			DB.closeStmt(pstmt);
		}
	}
/*
	public static List<User> getUsers() {
		List<User> users = new ArrayList<User>();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from ruser";
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
*/
	
	public static User validate(String username, String password) throws UserNotFoundException, PasswordNotCorrectException{
		Connection conn = null;
		ResultSet rs = null;
		User u  = null;
		try {
			conn = DB.getConn();
			String sql = "select * from ruser where username = '" + username + "'";
			rs = DB.executeQuery(conn, sql);
			if(!rs.next()) {
				throw new UserNotFoundException();
			} else if(!rs.getString("password").equals(password)){
				throw new PasswordNotCorrectException();
			} else {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRS(rs);
			DB.closeConn(conn);
		}
		return u;
	}
}
