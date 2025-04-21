<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String productId = request.getParameter("id");

    // Sample hardcoded product data
    class Product {
        String id, name, description, image, price, rating;
        Product(String id, String name, String description, String image, String price, String rating) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.image = image;
            this.price = price;
            this.rating = rating;
        }
    }

    Map<String, Product> products = new HashMap<>();
    products.put("1", new Product("1", "CHANEL - COCO", "COCO NOIR by CHANEL uses deep, elegant black to make a woman stand out, blending bold femininity with a warm, sensual, and modern amber scent.", "resources/images/system/Photo1.jpg", "$190", "4.5"));
    products.put("2", new Product("2", "DIOR - SAUVAGE", "Wild, fresh, and noble. Sauvage is inspired by wide-open spaces and a man who is true to himself.", "resources/images/system/Photo2.jpg", "$300", "4.7"));
    products.put("3", new Product("3", "LEGEND - Tsunami", "Bold and earthy, Legend Tsunami offers a lasting impression of masculine energy.", "resources/images/system/Photo3.jpg", "$215", "4.3"));
    products.put("4", new Product("4", "CK - FREE", "Light, free-spirited, and refreshing, CK Free is perfect for everyday casual wear.", "resources/images/system/Photo4.jpg", "$145", "4.1"));

    Product p = products.get(productId);
    if (p == null) {
        out.println("<h2>Product Not Found</h2>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= p.name %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productone.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
</head>
<body>
	<jsp:include page="header.jsp"/>

    <div class="container">
        <div class="product-main">
            <img src="<%= p.image %>" alt="<%= p.name %>" class="product-img" />
            <div class="product-info">
                <h1><%= p.name %></h1>
                <p class="desc"><%= p.description %></p>
                <p class="price"><%= p.price %></p>

                <div class="buttons">
                    <button class="btn">Add to Cart</button>
                    <button class="btn primary">Buy Now</button>
                </div>
                <p class="rating">Review: 
                    <%= p.rating %> 
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </p>
            </div>
        </div>

        <hr/>

        <h2 class="recommend-title">You May Also Like</h2>
        <div class="recommendations">
            <% for (Product related : products.values()) {
                if (!related.id.equals(p.id)) {
            %>
                <div class="recommend-card">
                    <img src="<%= related.image %>" alt="<%= related.name %>"/>
                    <h4><%= related.name %></h4>
                    <p><%= related.price %></p>
                    <a href="individualpages.jsp?id=<%= related.id %>" class="recommend-link">View</a>
                </div>
            <% }} %>
        </div>
    </div>
    	<jsp:include page="footer.jsp"/>
    
</body>
</html>
