package trojaneats;

public class Review {
	private int reviewId;
	//TODO: decide if necessary to have resId and userId
	
	private int userId;
	private int restaurantId;
	private String restaurantName;
	private String date;
	private int rating;
	private String text;
	private int score;
	
	public Review(int reviewId, int userId, int restaurantId, String restaurantName, String date, int rating, String text, int score)
	{
		this.reviewId = reviewId;
		this.userId = userId;
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
	public int getUserId()
	{
		return userId;
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
