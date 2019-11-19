

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	
		//for determining login status
		//String isLoggedIn = request.getParameter("login");
		
		//request.setAttribute("loggedIn", isLoggedIn);
		
		if(searchTerm.equals("") || searchTerm == null) {
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
			return;
			
		}
		
		String searchBy = request.getParameter("searchBy");
		
		
		//receive the database input from searching "searchTerm" via "searchBy"
		//
		//
		//
		
		
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
