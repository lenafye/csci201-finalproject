package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		String searchTerm = request.getParameter("search");
		
		if(searchTerm == null || searchTerm.equals("")) {
			
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
		
		ArrayList<Restaurant> r = new ArrayList<Restaurant>();
		r = DatabaseJDBC.search(searchTerm, cuisine, price, dollars, swipes);
		
		request.setAttribute("numResults", r.size());
		request.setAttribute("restaurantList", r);
		
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
