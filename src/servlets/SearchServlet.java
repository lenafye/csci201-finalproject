

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
		log(searchTerm);
		
<<<<<<< HEAD
		String searchTerm = request.getParameter("search");
		
		if(searchTerm == null || searchTerm.equals("")) {
			
=======
		if(searchTerm == null || searchTerm.length() == 0 || searchTerm.isEmpty()) {
>>>>>>> branch 'master' of https://github.com/lenafye/csci201-finalproject
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
			return;
			
		}
		
		String cuisine = request.getParameter("cuisine");
		String price = request.getParameter("price");
		boolean dollars = true;
		if(request.getParameter("dollars") == null) dollars = false;
		boolean swipes = true;
		if(request.getParameter("swipes") == null) swipes = false;
		
		log("cuisine: "+ cuisine);
		log(price);
		log(Boolean.toString(dollars));
		log(Boolean.toString(swipes));
		
		if((cuisine == null || cuisine.length() == 0 || cuisine.isEmpty()) && 
				(price == null || price.length() == 0 || price.isEmpty()) &&
				(dollars == false && swipes == false)) {
					error = "Please enter restaurant name or search requirements.";
				}
		
		PrintWriter out = response.getWriter();
		out.println(error);		
		out.flush();
		out.close();
		
		ArrayList<Restaurant> r = new ArrayList<Restaurant>();
		r = DatabaseJDBC.search(searchTerm, cuisine, price, dollars, swipes);
		
		session.setAttribute("numResults", r.size());
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
