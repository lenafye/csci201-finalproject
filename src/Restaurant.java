package trojaneats;

public class Restaurant {
	private int restaurantId;
	private String name;
	private String cuisine;
	private boolean swipes;
	private boolean diningDollars;
	private int cost;
	private int[][] hours;
	private String address;
	private double avgRating;
	
	
	public Restaurant(int id, String name, String cuisine, boolean swipes, boolean diningDollars, int cost,
						int[][] hours, String address, double avgRating)
	{
		restaurantId = id;
		this.name = name;
		this.cuisine = cuisine;
		this.swipes = swipes;
		this.diningDollars = diningDollars;
		this.cost = cost;
		this.hours = hours;
		this.address = address;
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
	public int[][] getHours()
	{
		return hours;
	}
	public String hoursToString()
	{
		String s ="";
		for(int i=0; i<7; i++)
		{
			switch(i)
			{
				case(0):
					s+="Monday: ";
					break;
				case(1):
					s+="Tuesday: ";
					break;
				case(2):
					s+="Wednesday: ";
					break;
				case(3):
					s+="Thursday: ";
					break;
				case(4):
					s+="Friday: ";
					break;
				case(5):
					s+="Saturday: ";
					break;
				case(6):
					s+="Sunday: ";
					break;
			}
			if(hours[i][0] == -1)
			{
				s += "closed\n";
			} else {
				s += hours[i][0] + " - " + hours[i][1] + "\n";
			}
			
				
		}
		return s;
	}
	public String getAddress()
	{
		return address;
	}
	public double getRating()
	{
		return avgRating;
	}

}
