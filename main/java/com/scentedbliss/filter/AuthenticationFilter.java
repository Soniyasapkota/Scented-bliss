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
    private static final String DASHBOARD = "/dashboard";

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

        // Allow access to public resources
        if (uri.contains("/css/") || uri.contains("/js/") || uri.contains("/images/") || uri.contains("/resources/")
                || uri.endsWith("/home") || uri.endsWith("/index.jsp") || uri.equals(req.getContextPath() + "/")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        String role = (String) SessionUtil.getAttribute(req, "role");
        boolean isLoggedIn = role != null;

        if (!isLoggedIn) {
            if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
                chain.doFilter(request, response); // Allow login/register pages
            } else {
                res.sendRedirect(req.getContextPath() + LOGIN); // Redirect to login
            }
        } else {
            // Role-based restriction: prevent customers from accessing admin dashboard
            if (uri.contains(DASHBOARD) && !"Admin".equals(role)) {
                res.sendRedirect(req.getContextPath() + HOME); // Redirect unauthorized user to home
                return;
            }

            // Prevent logged-in users from visiting login/register again
            if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER)) {
                res.sendRedirect(req.getContextPath() + HOME);
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
