package com.scentedbliss.controller;

import com.scentedbliss.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 23050320 Soniya Sapkota 
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ShopProduct", "/productDetail" })
public class ShopProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductService();

    public ShopProductController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/productDetail".equals(path)) {
            // Handle individual product page
            String productIdStr = request.getParameter("productId");
            try {
                int productId = Integer.parseInt(productIdStr);
                request.setAttribute("product", productService.getProductById(productId));
                request.getRequestDispatcher("/WEB-INF/pages/productDetail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            }
        } else {
            // Handle shop product page
            request.setAttribute("products", productService.getAllProducts());
            request.setAttribute("brands", productService.getAllBrands());
            request.getRequestDispatcher("/WEB-INF/pages/ShopProduct.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}