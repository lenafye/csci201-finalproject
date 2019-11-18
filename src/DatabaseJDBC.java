package trojaneats;

package lenaye_CSCI201L_TrojanEats;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DatabaseJDBC {
	
	public static final long serialVersionUID = 1;
	private static int currentUserId;
	private static String currentUsername;
	
	public DatabaseJDBC() {
		currentUserId = 0;
		currentUsername = "";
	}
	
	public static int getUser()
	{
		return currentUserId;
	}
	
	public static String getUsername() {
		return currentUsername;
	}
	
	public static int register(String username, String password)
	{
		Connection conn = null;;
		ResultSet rs = null;
		PreparedStatement ps = null;
		int success = 0;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneats201&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=emma&password=trojaneats");
			ps = conn.prepareStatement("SELECT username FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			if(!rs.next())
			{
				ps = conn.prepareStatement("INSERT INTO Users (username, password) VALUES (?,?)");
				ps.setString(1, username);
				ps.setString(2, password);
				ps.executeUpdate();
				success = 1;
				currentUsername = username;
				// update currentUserId -- is there a better way than to do another search
			}
		} catch (SQLException sqle)
		{
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) { rs.close(); }
				if (conn!=null) { conn.close(); }
			} catch (SQLException sqle)
			{
				System.out.println(sqle.getMessage());
			}
		}
		return success;
	}
	
	public static int login(String username, String password)
	{
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		int success = -1;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneats201&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=emma&password=trojaneats");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			//no user for that username
			boolean cont = true;
			if(!rs.next())
			{
				cont = false;
			}
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=? AND password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			if(!rs.next() && cont)
			{
				cont = false;
				success = 0;
			}
			else if(cont){
				success = 1;
				currentUserId = rs.getInt("userId");
				currentUsername = username;
			}
		} catch(SQLException sqle)
		{
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) { rs.close(); }
				if (conn!=null) { conn.close(); }
			} catch (SQLException sqle)
			{
				System.out.println(sqle.getMessage());
			}
		}
		return success;
	}
	
	public static void logout() {
		currentUserId = 0;
	}
	
	//TODO
	public static ArrayList<Restaurant> search()
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Restaurant> r = new ArrayList<Restaurant>();
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneats201&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=emma&password=trojaneats");
			ps = conn.prepareStatement("SELECT * FROM Restaurant");
		} catch(SQLException sqle)
		{
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) { rs.close(); }
				if (conn!=null) { conn.close(); }
			} catch (SQLException sqle)
			{
				System.out.println(sqle.getMessage());
			}
		}
		return r;
	}
	
	//returns all reviews for a user
	//displayed on profile page
	public static ArrayList<Review> getReviews(String username)
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Review> reviews = new ArrayList<Review>();
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneats201&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=emma&password=trojaneats");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			rs.next();
			int userId = rs.getInt("userId");
			ps = conn.prepareStatement("SELECT * FROM Reviews WHERE userId = ?");
			while(rs.next())
			{
				int reviewId = rs.getInt("reviewId");
				int restaurantId = rs.getInt("restaurantId");
				//TODO: check that this is right datatype for sql datetime data type?
				String date = rs.getString("date");
				int rating = (int) rs.getFloat("rating");
				String text = rs.getString("text");
				int score = rs.getInt("score");
				ps = conn.prepareStatement("SELECT name FROM Restaurants WHERE restaurantId = ?");
				ps.setInt(1, restaurantId);
				rs = ps.executeQuery();
				rs.next();
				String restaurantName = rs.getString("name");
				Review r = new Review(reviewId, userId, restaurantId, restaurantName, date, rating, text, score);
				reviews.add(r);
			}
		} catch(SQLException sqle)
		{
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) { rs.close(); }
				if (conn!=null) { conn.close(); }
			} catch (SQLException sqle)
			{
				System.out.println(sqle.getMessage());
			}
		}
		return reviews;
	}
	
	public static void addReview(String restaurantName, String username, int rating, String text)
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneats201&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=emma&password=trojaneats");
			ps = conn.prepareStatement("SELECT restaurantId FROM Restaurants WHERE name=?");
			ps.setString(1, restaurantName);
			rs = ps.executeQuery();
			rs.next();
			int resId = rs.getInt("restaurantId");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			rs.next();
			int userId = rs.getInt("userId");
			ps = conn.prepareStatement("INSERT INTO Reviews (userId, restaurantId, rating, text, score) VALUES (?,?,?,?,?)");
			ps.setInt(1, userId);
			ps.setInt(2, resId);
			ps.setInt(3, rating);
			ps.setString(4, text);
			ps.setInt(4, 0);
			ps.executeUpdate();
			
		} catch (SQLException sqle)
		{
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) { rs.close(); }
				if (conn!=null) { conn.close(); }
			} catch (SQLException sqle)
			{
				System.out.println(sqle.getMessage());
			}
		}
	}
	
	public static void interactReview(int reviewId, int react)
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneats201&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=emma&password=trojaneats");
			//TODO: make sure updates correctly
			ps = conn.prepareStatement("UPDATE Reviews SET score=score+? WHERE reviewId=?");
			ps.setInt(1, react);
			ps.setInt(2, reviewId);
			ps.executeUpdate();
		
		} catch (SQLException sqle)
		{
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs!=null) { rs.close(); }
				if (conn!=null) { conn.close(); }
			} catch (SQLException sqle)
			{
				System.out.println(sqle.getMessage());
			}
		}
	}
}
