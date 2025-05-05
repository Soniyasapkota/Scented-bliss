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

@WebServlet(asyncSupported = true, urlPatterns = {"/productlist"})
public class ProductlistController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    @Override
	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
    	//send redirect || requestdispatcher
    	// load jsp design page
    	req.getRequestDispatcher("WEB-INF/pages/productlist.jsp").forward(req, response);
		
	} 

}