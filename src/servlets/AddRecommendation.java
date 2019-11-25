package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lenaye_CSCI201L_TrojanEats.DatabaseJDBC;

/**
 * Servlet implementation class AddRecommendation
 */
@WebServlet("/AddRecommendation")
public class AddRecommendation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddRecommendation() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	// int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
    	int restaurantId = 1;
    	String sender = (String)session.getAttribute("username");
    	String receiver = (String)request.getParameter("usernames");
    	String text = (String)request.getParameter("text");
    	String error = "";
    	String hold = "";
    	ArrayList<String> receivers = new ArrayList<String>();
    	
    	for(int i = 0; i < receiver.length(); i++) {
    		if(receiver.charAt(i) == ',') {
    			receivers.add(hold);
    			hold = "";
    		}
    		else if(receiver.charAt(i) != ' ') {
    			hold += receiver.charAt(i);
    		}
    	}
    	if(receiver.isEmpty()) {
    		error += "Please add a recipient.";
    	}
    	if(text.isEmpty()) {
    		error += "Please add a message.";
    	}
    	if(error.isEmpty()) {
    		DatabaseJDBC.addRecommendation(sender, receivers, restaurantId);
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
