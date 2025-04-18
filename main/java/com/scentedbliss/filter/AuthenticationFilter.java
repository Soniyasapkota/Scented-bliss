package com.scentedbliss.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.scentedbliss.util.SessionUtil;

@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter implements Filter {

	private static final String LOGIN = "/login";
	private static final String REGISTER = "/register";
	private static final String HOME = "/home";
	private static final String ROOT = "/";
	

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// Initialization logic, if required
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String uri = req.getRequestURI();
		
		// Allow access to resources
		if (uri.endsWith(".css") || uri.endsWith(".jpg") || uri.endsWith(".png")
			    || uri.endsWith("/home") || uri.endsWith("/index.jsp") || uri.endsWith("/")) {
			    chain.doFilter(request, response);
			    return;
			}

		
		

		// Get the session and check if user is logged in
		boolean isLoggedIn = SessionUtil.getAttribute(req, "role") != null;

		if (!isLoggedIn) {
		    if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
		        chain.doFilter(request, response); // Allow login/register pages
		    } else {
		        res.sendRedirect(req.getContextPath() + LOGIN); // Redirect to login
		    }
		} else {
		    if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
		        res.sendRedirect(req.getContextPath() + HOME); // Already logged in, redirect to home
		    } else {
		        chain.doFilter(request, response); // Allow access to other pages
		    }
		}

		
	}
	

	@Override
	public void destroy() {
		// Cleanup logic, if required
	}
}
