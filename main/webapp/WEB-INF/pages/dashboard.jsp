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


<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
 <title>Perfume Shop Dashboard</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productlist.css" />

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
 <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />
 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
 <div class="container">
   <aside class="sidebar">
     <h2>Admin</h2>
     <ul>
       <li> <a href="#">Dashboard</a></li>
       <li>Order List</li>
       <li> <a href="${pageContext.request.contextPath}/productlist">Product List</a></li>
       <li><a href="${pageContext.request.contextPath}/customerlist">Customer List</a></li>
       <li>Sales Reports</li>
       <li><a href="${pageContext.request.contextPath}/userProfile"></a>Account</li>
     </ul>
   </aside>

   <main class="main-content">
    
 <div id="header">
	<header class="header">
	
	
	
    <!-- Top Row: Logo on the left -->
     <div class="logo">
  <a href="${contextPath}" class="logo-text">Scented Bliss</a>

     

    
   
    
    
		
		<ul class="main-nav right-nav">
      <c:if test="${empty currentUser}">
        <li><a href="${contextPath}/register">Register</a></li>
      </c:if>
      <li>
        <c:choose>
          <c:when test="${not empty currentUser}">
            <form action="${contextPath}/logout" method="post">
              <input type="submit" class="nav-button" value="Logout" />
            </form>
          </c:when>
          <c:otherwise>
            <a href="${contextPath}/login">Login</a>
          </c:otherwise>
        </c:choose>
      </li>
    </ul>
    	</div>
    
   
	</header>
	</div>
	

     <div class="content-body">
       <section class="stats">
         <div class="card">Total Sales<br><strong>$1500</strong></div>
         <div class="card">Total Orders<br><strong>120</strong></div>
         <div class="card">New Customers<br><strong>35</strong></div>
         <div class="card">Products in Stock<br><strong>85</strong></div>
       </section>

       <section class="chart-section">
         <h3>Sales Overview</h3>
         <div class="toggle-buttons">
           <button class="active">Weekly</button>
           <button>Monthly</button>
         </div>
         <canvas id="salesChart"></canvas>
       </section>
     </div>

     
   </main>
 </div>

 <script>
   const ctx = document.getElementById('salesChart').getContext('2d');

   const weeklyData = [200, 300, 400, 500];
   const monthlyData = [850, 1200, 1450, 1800];

   const salesChart = new Chart(ctx, {
     type: 'line',
     data: {
       labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
       datasets: [{
         label: 'Sales',
         data: weeklyData,
         backgroundColor: 'rgba(138, 43, 226, 0.1)',
         borderColor: 'rgba(138, 43, 226, 1)',
         borderWidth: 2,
         fill: true,
         tension: 0.4,
       }]
     },
     options: {
       responsive: true,
       plugins: {
         legend: { display: true }
       },
       scales: {
         y: {
           beginAtZero: false
         }
       }
     }
   });

   const buttons = document.querySelectorAll('.toggle-buttons button');

   buttons.forEach((btn) => {
     btn.addEventListener('click', () => {
       buttons.forEach(b => b.classList.remove('active'));
       btn.classList.add('active');

       const type = btn.textContent.trim();
       salesChart.data.datasets[0].data = type === 'Weekly' ? weeklyData : monthlyData;
       salesChart.update();
     });
   });
 </script>
</body>
</html>
