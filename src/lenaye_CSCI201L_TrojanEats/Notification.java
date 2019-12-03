package lenaye_CSCI201L_TrojanEats;

public class Notification {
	private int notificationId;
	private String username;
	private boolean read;
	private String time;
	private String restaurant;
	private boolean upvote;
	private int restaurantId;
	
	public Notification(int notificationId, String username, boolean upvote, boolean read, String time, String restaurant, int restaurantId) {
		this.notificationId = notificationId;
		this.username = username;
		this.read = read;
		this.time = time;
		this.upvote = upvote;
		this.restaurant = restaurant;
		this.restaurantId = restaurantId;
	}
	
	public int getId() {
		return notificationId;
	}
	public String getUsername() {
		return username;
	}
	public String getTime() {
		return time;
	}
	public String getRestaurant() {
		return restaurant;
	}
	public String getUpvote() {
		if(upvote) {
			return "like";
		}
		else {
			return "dislike";
		}
	}
	public String checkRead() {
		if(read) {
			return "read";
		}
		else {
			return "new";
		}
	}
	public int getRestaurantId() {
		return restaurantId;
	}
}
