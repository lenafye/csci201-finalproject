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
		Connection conn = null;
		;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			conn = DriverManager.getConnection(
					"jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT username FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			if (!rs.next()) {
				ps = conn.prepareStatement("INSERT INTO Users (username, password) VALUES (?,?)");
				ps.setString(1, username);
				ps.setString(2, password);
				ps.executeUpdate();
				return 1;
			} else {
				return 0;
			}
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
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
			conn = DriverManager.getConnection(
					"jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			// no user for that username
			if (!rs.next()) {
				return -1;
			} else {
				ps = conn.prepareStatement("SELECT * FROM Users WHERE username=? AND password=?");
				ps.setString(1, username);
				ps.setString(2, password);
				rs = ps.executeQuery();
				if (rs.next()) {
					return 1;
				} else {
					return 0;
				}
			}
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return 0;
	}

	// TODO
	public static ArrayList<Restaurant> search(String input, String cuisine, String price, boolean dollars, boolean swipes) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String query = "SELECT * FROM Restaurants WHERE";
		ArrayList<Restaurant> r = new ArrayList<Restaurant>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			if(!input.isEmpty()) {
				query += " name='" + input + "'";
			}
			if(cuisine.length() > 0) {
				if(query.length() > 32) {
					query += " AND ";
				}
				query += "cuisine='" + cuisine + "'";
			}
			if(price.length () > 0) {
				if(query.length() > 32) {
					query += " AND ";
				}
				if(price.contentEquals("one")) {
					query += "cost=1";
				} else if(price.contentEquals("two")) {
					query += "cost=2";
				} else {
					query += "cost=3";
				}
			}
			if(dollars) {
				if(query.length() > 32) {
					query += " AND ";
				}
				query += "diningDollars=1";
			}
			if(swipes) {
				if(query.length() > 32) {
					query += " AND ";
				}
				query += "swipes=1";
			}
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next()) {
				int restaurantId = rs.getInt("restaurantId");
				String name = rs.getString("name");
				String cuisine1 = rs.getString("cuisine");
				boolean swipes1  = rs.getBoolean("swipes");
				boolean diningDollars = rs.getBoolean("diningDollars");
				int cost = rs.getInt("cost");
				String hours = rs.getString("hours");
				String address = rs.getString("address");
				double avgRating  = rs.getDouble("avgRating");
				double latitude = rs.getDouble("latitude");
				double longitude = rs.getDouble("longitude");
				Restaurant rest = new Restaurant(restaurantId, name, cuisine1, swipes1, diningDollars, cost, hours, address, latitude, longitude, avgRating);
				r.add(rest);
			}
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return r;
	}

	// returns all reviews for a user
	// displayed on profile page
	public static ArrayList<Review> getReviewsForUser(String username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ArrayList<Review> reviews = new ArrayList<Review>();
		try {
			conn = DriverManager.getConnection(
					"jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			rs.next();
			int userId = rs.getInt("userId");
			ps = conn.prepareStatement("SELECT * FROM Reviews WHERE userId=?");
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			while (rs.next()) {
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

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return reviews;
	}

	// returns all reviews for a restaurant
	// displayed on restaurant details page
	public static ArrayList<Review> getReviewsForRes(int restaurantId, String restaurantName) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ArrayList<Review> reviews = new ArrayList<Review>();
		try {
			conn = DriverManager.getConnection(
					"jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT * FROM Reviews WHERE restaurantId=?");
			ps.setInt(1, restaurantId);
			rs = ps.executeQuery();
			while (rs.next()) {
				int reviewId = rs.getInt("reviewId");
				int userId = rs.getInt("userId");
				ps = conn.prepareStatement("SELECT username FROM Users WHERE userId=?");
				ps.setInt(1, userId);
				rs2 = ps.executeQuery();
				rs2.next();
				String username = rs2.getString("username");
				int rating = rs.getInt("rating");
				String text = rs.getString("text");
				int score = rs.getInt("score");
				Review r = new Review(reviewId, username, restaurantId, restaurantName, rating, text, score);
				reviews.add(r);

			}

		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return reviews;
	}

	public static void addReview(int restaurantId, String username, int rating, String text) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			while(rs.next()) {
				int userId = rs.getInt("userId");
				ps = conn.prepareStatement("INSERT INTO Reviews (userId, restaurantId, rating, text, score) VALUES (?,?,?,?,?)");
				ps.setInt(1, userId);
				ps.setInt(2, restaurantId);
				ps.setInt(3, rating);
				ps.setString(4, text);
				ps.setInt(5, 0);
				ps.executeUpdate();
			}
			ps = conn.prepareStatement("SELECT COUNT(*) FROM Reviews WHERE restaurantId=?");
			ps.setInt(1, restaurantId);
			rs = ps.executeQuery();
			rs.next();
			int numReviews = rs.getInt(1);
			ps = conn.prepareStatement("SELECT avgRating FROM Restaurants WHERE restaurantId=?");
			ps.setInt(1, restaurantId);
			rs2 = ps.executeQuery();
			rs2.next();
			double currRating = rs2.getDouble("avgRating");
			currRating = currRating * numReviews;
			double avgRating = (currRating + rating)/numReviews;
			ps = conn.prepareStatement("UPDATE Restaurants SET avgRating=? WHERE restaurantId=?");
			ps.setDouble(1, avgRating);
			ps.setInt(2, restaurantId);
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

	public static void interactReview(int reviewId, int react) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int score = 0;
		try {
			conn = DriverManager.getConnection(
					"jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT * FROM Reviews WHERE reviewId=?");
			ps.setInt(1, reviewId);
			rs = ps.executeQuery();
			int userId = rs.getInt("userId");
			while (rs.next()) {
				score = rs.getInt("score");
				score += react;
			}
			ps = conn.prepareStatement("UPDATE Reviews SET score=? WHERE reviewId=?");
			ps.setInt(1, score);
			ps.setInt(2, reviewId);
			ps.executeUpdate();
			
			ps = conn.prepareStatement("INSERT INTO Votes (userId, reviewId, upvote) VALUES (?, ?, ?, ?");
			ps.setInt(1, userId);
			ps.setInt(2, reviewId);
			if(react == 1) {
				ps.setBoolean(3, true);
			}
			else {
				ps.setBoolean(3, false);
			}
			ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
	}
	
	public static ArrayList<Notification> getNotifications(String username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ArrayList<Notification> notifications = new ArrayList<Notification>();
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT userId FROM Users WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			rs.next();
			int userId = rs.getInt("userId");
			ps = conn.prepareStatement("SELECT * FROM Votes WHERE userId=?");
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			while(rs.next()) {
				int notificationId = rs.getInt("voteId");
				boolean read = rs.getBoolean("read");
				String date = rs.getString("date");
				boolean upvote = rs.getBoolean("upvote");
				int restaurantId = rs.getInt("reviewId");
				
				ps = conn.prepareStatement("SELECT name FROM Restaurants WHERE restaurantId=?");
				ps.setInt(1, restaurantId);
				rs2 = ps.executeQuery();
				rs2.next();
				String name = rs2.getString("name");
				Notification n = new Notification(notificationId, username, upvote, read, date, name);
				notifications.add(n);
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
				if(rs3!=null) {
					rs3.close();
				}
				if (conn!=null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
		return notifications;
	}
	
	public static void readNotification(int notificationId) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			
			ps = conn.prepareStatement("UPDATE Votes SET read=1 WHERE voteId=?");
			ps.setInt(1, notificationId);
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

	public static Restaurant getRestaurant(int restaurantId)
	{
		Restaurant r = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://google/trojaneats?cloudSqlInstance=emunch-csci201-lab7:us-central1:trojaneatsproject&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=root&password=test");
			ps = conn.prepareStatement("SELECT * FROM Restaurants WHERE restaurantId=?");
			ps.setInt(1, restaurantId);
			rs = ps.executeQuery();
			if(rs.next()) {
				String name = rs.getString("name");
				String cuisine = rs.getString("cuisine");
				boolean swipes  = rs.getBoolean("swipes");
				boolean diningDollars = rs.getBoolean("diningDollars");
				int cost = rs.getInt("cost");
				String hours = rs.getString("hours");
				String address = rs.getString("address");
				double avgRating  = rs.getDouble("avgRating");
				double latitude = rs.getDouble("latitude");
				double longitude = rs.getDouble("longitude");
				r = new Restaurant(restaurantId, name, cuisine, swipes, diningDollars, cost, hours, address, latitude, longitude, avgRating);
			}
		} catch(SQLException sqle)
		{
			System.out.println(sqle.getMessage());}
		return r;
	}
}
