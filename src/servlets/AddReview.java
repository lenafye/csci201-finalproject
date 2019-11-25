package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lenaye_CSCI201L_TrojanEats.DatabaseJDBC;
import lenaye_CSCI201L_TrojanEats.Review;

/**
 * Servlet implementation class AddReview
 */
@WebServlet("/AddReview")
public class AddReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddReview() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//String restaurantName = request.getParameter("restaurantName");
    	String restaurantName = "Panda Express";
    	HttpSession session = request.getSession();
    	String username = (String)session.getAttribute("username");
    	Integer rating = Integer.parseInt((String)request.getParameter("rating").trim());
    	String text = request.getParameter("text");
    	String error = "";
    	String next = "/Profile.jsp";
    	
    	if(rating == null) {
    		error += "Please add a rating.";
    	}
    	if(text.isEmpty()) {
    		error += "Please add a review.";
    	}
    	if(error.isEmpty()) {
    		DatabaseJDBC.addReview(restaurantName, username, rating, text);
    	}
    	request.setAttribute("error", error);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
