package javamysql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectDB {

	private static ConnectDB instance = new ConnectDB();

	public static ConnectDB getInstance() {
		return instance;
	}

	public ConnectDB() {

	}


	Connection conn = null;
	PreparedStatement stmt = null;
	String returns = "a";


	public String connectionDB(String r_lat, String r_lng,String rme) {
		try {
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_C?useUnicode=true&characterEncoding=utf8", "root", "1234");
			
			stmt = conn.prepareStatement("insert into report(r_lat,r_lng,rme) value(?,?,?)");
			stmt.setString(1,r_lat );
			stmt.setString(2,r_lng );
			stmt.setString(3,rme );
			stmt.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (stmt != null)try {stmt.close();	} catch (SQLException ex) {}
			if (conn != null)try {conn.close();	} catch (SQLException ex) {	}
		}
		return returns;
	}

}


