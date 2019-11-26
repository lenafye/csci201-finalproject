package lenaye_CSCI201L_TrojanEats;

public class Notification {
	private int notificationId;
	private String username;
	private int type;
	private boolean read;
	private String time;
	private String restaurant;
	
	public Notification(int notificationId, String username, int type, boolean read, String time, String restaurant) {
		this.notificationId = notificationId;
		this.username = username;
		this.type = type;
		this.read = read;
		this.time = time;
		this.restaurant = restaurant;
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
	public int getType() {
		return type;
	}
	public boolean checkRead() {
		return read;
	}
}

