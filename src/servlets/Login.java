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

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Login() {
        // TODO Auto-generated constructor stub
    }
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String un = request.getParameter("username");
		String pw = request.getParameter("password");
		HttpSession session = request.getSession();
		
		int success = DatabaseJDBC.login(un, pw);
		
		String next = "/HomePage.jsp";
		String error = "";
		
		if(success == 0)
		{
			next = "/Login.jsp";
			error += "Error! Username and password do not match.";
		}
		else if(success == -1) {
			next = "/Login.jsp";
			error += "Error! Username does not exist!";
		}
		else
		{
			session.setAttribute("username", un);
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
