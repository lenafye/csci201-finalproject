package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lenaye_CSCI201L_TrojanEats.DatabaseJDBC;

/**
 * Servlet implementation class Login
 */
@WebServlet("/LikeDislike")
public class LikeDislike extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public LikeDislike() {
        // TODO Auto-generated constructor stub
    }
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String likeDislike = request.getParameter("value");
		String idString = request.getParameter("id");
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		String responseText = "";
		if(username==null || username.isEmpty())
		{
			responseText +="Must sign in to vote";
		}
		else {
			int upvote;
			int id = Integer.parseInt(idString);
			if(likeDislike.contentEquals("like")) {
				upvote = 1;
			}
			else {
				upvote = -1;
			}
			DatabaseJDBC.interactReview(id, upvote);
			int score  = DatabaseJDBC.getScore(id);
			responseText += score;
		}
		PrintWriter out = response.getWriter();
		
		System.out.println(responseText);
		out.println(responseText);		
		out.flush();
		out.close();
		
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
