
package com.scentedbliss.controller;

import jakarta.servlet.ServletException;



import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;




/**
 * @author 23050320 Soniya Sapkota 
 */
/**
 * Servlet implementation class HomeController
 */
 
@WebServlet(asyncSupported = true, urlPatterns = {"/home","/"})
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	/**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String path = request.getServletPath(); // Get the requested path
		
		if (path.startsWith("/images/") || path.startsWith("/css/") || path.startsWith("/js/")) {
            request.getRequestDispatcher(path).forward(request, response);
            return;
        }
        
       
         if (path.equals("/aboutus")) {
            // Forward to products.jsp if the path is "/products"
            request.getRequestDispatcher("/WEB-INF/pages/aboutus.jsp").forward(request, response);
            }
        else if (path.equals("/contactus")) {
            // Forward to products.jsp if the path is "/products"
            request.getRequestDispatcher("/WEB-INF/pages/contactus.jsp").forward(request, response);
            }
        
        else if (path.equals("/shopProduct")) {
            // Forward to products.jsp if the path is "/products"
            request.getRequestDispatcher("/WEB-INF/pages/shopProduct.jsp").forward(request, response);
            }
        
        else if (path.equals("/dashboard")) {
            // Forward to products.jsp if the path is "/products"
            request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
            }
        
        else if (path.equals("/home")) {
            // Forward to products.jsp if the path is "/products"
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
            }
        else {
            // Default: Forward to home.jsp for "/home" or "/"
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
        }
        
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}