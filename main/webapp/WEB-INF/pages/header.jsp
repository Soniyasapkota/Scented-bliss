<!--  <div id="header">
	<header class="header">
		<h1 class="logo">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/system/Newlogo.png"/></a>
	</h1>

		<ul class="main-nav">
			<li><a href="#">Home</a></li>
			<li><a href="#">Product</a></li>
			<li><a href="#">About Us</a></li>
			<li><a href="#">Contact Us</a></li>
			<li><a href="#">Reference</a></li>
			<li><a href="${pageContext.request.contextPath}/login" class="button">Login</a></li> 
			<li><a href="${pageContext.request.contextPath}/cart" class="button">Cart</a></li> 
			
		</ul>
	</header>
</div>-->


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>

<%
// Initialize necessary objects and variables
HttpSession userSession = request.getSession(false);
String currentUser = (String) (userSession != null ? userSession.getAttribute("role") : null);
// need to add data in attribute to select it in JSP code using JSTL core tag
pageContext.setAttribute("currentUser", currentUser);
%>

<!-- Set contextPath variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet">


<div id="header">
	<header class="header">
		<h1 class="logo-text">
    <a href="${contextPath}">Scented Bliss</a>
</h1>

		<ul class="main-nav">
			<li><a href="${contextPath}/home">Home</a></li>
			<li><a href="${contextPath}/product">Product</a></li>
			<li><a href="${contextPath}/Aboutus">About Us</a></li>
			<li><a href="${contextPath}/contactus">Contact Us</a></li>
			
			<c:if test="${empty currentUser}">
				<li><a href="${contextPath}/register">Register</a></li>
			</c:if>
			<li><c:choose>
					<c:when test="${not empty currentUser}">
						<form action="${contextPath}/logout" method="post">
							<input type="submit" class="nav-button" value="Logout" />
						</form>
					</c:when>
					<c:otherwise>
						<a href="${contextPath}/login">Login</a>
					</c:otherwise>
				</c:choose></li>
		</ul>
	</header>
</div>
