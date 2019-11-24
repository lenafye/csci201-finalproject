package lenaye_CSCI201L_TrojanEats;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DatabaseJDBC {
	
	public static final long serialVersionUID = 1;
	
	public static int register(String username, String password) {
		Connection conn = null;;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT username FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			if(!rs.next()) {
				ps = conn.prepareStatement("INSERT INTO Users (username, password) VALUES (?,?)");
				ps.setString(1, username);
				ps.setString(2, password);
				ps.executeUpdate();
				return 1;
			}
			else {
				return 0;
			}
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return 0;
	}
	
	public static int login(String username, String password) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			// Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			//no user for that username
			if(!rs.next()) {
				return -1;
			}
			else {
				ps = conn.prepareStatement("SELECT * FROM Users WHERE username=? AND password=?");
				ps.setString(1, username);
				ps.setString(2, password);
				rs = ps.executeQuery();
				if(rs.next()) {
					return 1;
				}
				else {
					return 0;
				}
			}
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return 0;
	}
	
	//TODO
	public static ArrayList<Restaurant> search(String input, int choice, String option) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Restaurant> r = new ArrayList<Restaurant>();
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT * FROM Restaurant");
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return r;
	}
	
	//returns all reviews for a user
	//displayed on profile page
	public static ArrayList<Review> getReviews(String username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ArrayList<Review> reviews = new ArrayList<Review>();
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			rs.next();
			int userId = rs.getInt("userId");
			ps = conn.prepareStatement("SELECT * FROM Reviews WHERE userId=?");
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			while(rs.next()) {
				int reviewId = rs.getInt("reviewId");
				int restaurantId = rs.getInt("restaurantId");
				int rating = rs.getInt("rating");
				String text = rs.getString("text");
				int score = rs.getInt("score");
				ps = conn.prepareStatement("SELECT name FROM Restaurants WHERE restaurantId = ?");
				ps.setInt(1, restaurantId);
				rs2 = ps.executeQuery();
				rs2.next();
				String restaurantName = rs2.getString("name");
				Review r = new Review(reviewId, username, restaurantId, restaurantName, rating, text, score);
				reviews.add(r);
				
			}
			
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if(rs2!=null) {
					rs2.close();
				}
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return reviews;
	}
	
	public static void addReview(String restaurantName, String username, int rating, String text) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT restaurantId FROM Restaurants WHERE name=?");
			ps.setString(1, restaurantName);
			rs = ps.executeQuery();
			while(rs.next()) {
				int resId = rs.getInt("restaurantId");
				ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
				ps.setString(1, username);
				rs2 = ps.executeQuery();
				while(rs2.next()) {
					int userId = rs2.getInt("userId");
					ps = conn.prepareStatement("INSERT INTO Reviews (userId, restaurantId, rating, text, score) VALUES (?,?,?,?,?)");
					ps.setInt(1, userId);
					ps.setInt(2, resId);
					ps.setInt(3, rating);
					ps.setString(4, text);
					ps.setInt(5, 0);
					ps.executeUpdate();
				}
			}
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if(rs2!=null) {
					rs2.close();
				}
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
	}
	
	public static void interactReview(int reviewId, int react) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int score = 0;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT * FROM Reviews WHERE reviewId=?");
			ps.setInt(1, reviewId);
			rs = ps.executeQuery();
			while(rs.next()) {
				score = rs.getInt("score");
				score += react;
			}
			ps = conn.prepareStatement("UPDATE Reviews SET score=? WHERE reviewId=?");
			ps.setInt(1, score);
			ps.setInt(2, reviewId);
			ps.executeUpdate();
		
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
	}
}

