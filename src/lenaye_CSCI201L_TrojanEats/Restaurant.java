package lenaye_CSCI201L_TrojanEats;

public class Restaurant {
	private int restaurantId;
	private String name;
	private String cuisine;
	private boolean swipes;
	private boolean diningDollars;
	private int cost;
	private String hours;
	private String address;
	private double latitude;
	private double longitude;
	private double avgRating;
	
	
	public Restaurant(int id, String name, String cuisine, boolean swipes, boolean diningDollars, int cost,
						String hours, String address, double latitude, double longitude, double avgRating)
	{
		restaurantId = id;
		this.name = name;
		this.cuisine = cuisine;
		this.swipes = swipes;
		this.diningDollars = diningDollars;
		this.cost = cost;
		this.hours = hours;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.avgRating = avgRating;
		
	}
	
	public int getId()
	{
		return restaurantId;
	}
	
	public String getName()
	{
		return name;
	}
	public String getCuisine()
	{
		return cuisine;
	}
	public boolean getSwipes()
	{
		return swipes;
	}
	public boolean getDD()
	{
		return diningDollars;
	}
	public int getCost()
	{
		return cost;
	}
	public String getHours()
	{
		return hours;
	}
	
	public String getAddress()
	{
		return address;
	}
	public double getLatitude()
	{
		return latitude;
	}
	public double getLongitude()
	{
		return longitude;
	}
	public double getRating()
	{
		return avgRating;
	}

}
