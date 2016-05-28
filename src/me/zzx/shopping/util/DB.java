package me.zzx.shopping.util;

import java.sql.*;

public class DB {

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private DB() {

	}
	
	public static Connection getConn() {
		Connection conn  = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/shopping?useSSL=false&user=root&password=root");
		} catch(SQLException e) {
			e.printStackTrace();
		}		
		return conn;
	}
	
	public static void closeConn(Connection conn) {
		if(conn != null) {
			try {
				conn.close();
				conn = null;
			} catch(SQLException e) {
				e.printStackTrace();
			} finally {
				conn = null;
			}
		}
	}
	
	public static Statement getStmt(Connection conn) {
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return stmt;
	}
	
	public static void closeStmt(Statement stmt) {
		try {
			if(stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			stmt = null;
		}
	}
	
	public static PreparedStatement getPstmt(Connection conn, String sql) {
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return pstmt;
	}
	
	//important
	public static PreparedStatement getPstmt(Connection conn, String sql, boolean generatedKey) {
		PreparedStatement pstmt = null;
		if(generatedKey) {
			try {
				pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return pstmt;
	}
	
	public static ResultSet executeQuery(Statement stmt, String sql) {
		ResultSet rs = null;
		try {
			rs = stmt.executeQuery(sql);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	//÷ÿ‘ÿexecuteQuery()∑Ω∑® 
	public static ResultSet executeQuery(Connection conn, String sql) {
		ResultSet rs = null;
		try {
			rs = conn.createStatement().executeQuery(sql);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public static void closeRS(ResultSet rs) {
		try {
			if(rs != null) {
				rs.close();
				rs = null;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			rs = null;
		}
	}

	public static void executeUpdate(Connection conn, String sql) {
		try {
			conn.createStatement().executeUpdate(sql);
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

}
