package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import database.Database;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    /**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String un = request.getParameter("username");
		String pw = request.getParameter("password");
		
		//boolean exists = Database.userExists(un);
		boolean exists = true;
		
		String next = "/HomePage.jsp";
		String error = "";
		
		if(exists)
		{
			next = "/Register.jsp";
			error += "Error! User already exists.";
		}
		else
		{
			//Database.addUser(un, pw);
			//Cookie user = new Cookie("username", un);
			//response.addCookie(user);
		}
		
		request.setAttribute("error", error);
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		
		try
		{
			dispatch.forward(request, response);
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		catch(ServletException e)
		{
			e.printStackTrace();
		}
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
