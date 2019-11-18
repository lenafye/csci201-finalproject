package lenaye_CSCI201L_TrojanEats;

public class Review {
	private int reviewId;
	//TODO: decide if necessary to have resId and userId
	
	private String username;
	private int restaurantId;
	private String restaurantName;
	private String date;
	private int rating;
	private String text;
	private int score;
	
	public Review(int reviewId, String username, int restaurantId, String restaurantName, String date, int rating, String text, int score)
	{
		this.reviewId = reviewId;
		this.username = username;
		this.restaurantId = restaurantId;
		this.restaurantName = restaurantName;
		this.date = date;
		this.rating = rating;
		this.text = text;
		this.score = score;
	}
	
	public int getId()
	{
		return reviewId;
	}
	public String getUsername()
	{
		return username;
	}
	public int getRestaurantId()
	{
		return restaurantId;
	}
	public String getRestaurantName()
	{
		return restaurantName;
	}
	public String getDate()
	{
		return date;
	}
	public int getRating()
	{
		return rating;
	}
	public String getText()
	{
		return text;
	}
	public int getScore()
	{
		return score;
	}
}
