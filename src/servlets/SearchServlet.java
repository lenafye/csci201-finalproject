package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lenaye_CSCI201L_TrojanEats.DatabaseJDBC;
import lenaye_CSCI201L_TrojanEats.Restaurant;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String searchTerm = request.getParameter("searchQuery");
		String error = "";
		String searchQuery = "";
		
		String cuisine = request.getParameter("cuisine");
		if(cuisine.trim().contentEquals("undefined")) {
			cuisine = "";
		}
		String price = request.getParameter("price");
		if(price.trim().contentEquals("undefined")) {
			price = "";
		}
		boolean dollars = Boolean.parseBoolean(request.getParameter("dollars"));
		boolean swipes = Boolean.parseBoolean(request.getParameter("swipes"));
		
		if(cuisine.length() == 0 && price.length() == 0 &&
				(dollars == false && swipes == false && searchTerm.length() == 0)) {
			error = "Please enter restaurant name or search requirements.";
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
			return;
		}
		
		PrintWriter out = response.getWriter();
		out.println(error);		
		out.flush();
		out.close();
		
		ArrayList<Restaurant> r = new ArrayList<Restaurant>();
		r = DatabaseJDBC.search(searchTerm, cuisine, price, dollars, swipes);
		
		if(searchTerm.length() > 0) {
			searchQuery += "'" + searchTerm + "' ";
		}
		if(cuisine.length() > 0) {
			if(searchQuery.length() > 0) {
				searchQuery += " with ";
			}
			searchQuery += "cuisine " + cuisine + " ";
		}
		if(price.length() > 0) {
			if(searchQuery.length() == 0) {
				searchQuery += "restaurants ";
			}
			searchQuery += "with price " + price + " ";
		}
		if(dollars) {
			if(searchQuery.length() == 0) {
				searchQuery += "restaurants ";
			}
			searchQuery += "that take dining dollars ";
		}
		if(swipes) {
			if(searchQuery.length() == 0) {
				searchQuery += "restaurants ";
			}
			searchQuery += "that take swipes ";
		}
		
		session.setAttribute("searchQuery", searchQuery);
		session.setAttribute("restaurantList", r);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("SearchResults.jsp");
		dispatcher.forward(request, response);
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
