<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Us - Scented Bliss</title>
 <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/contactus.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
</head>
<body>
     <jsp:include page="header.jsp"/>
   
     
     <div class="Contact-us"> 

    <div class="contact-page">
      <h1 class="contact-title">Contact Us</h1>

      <div class="contact-box">
        <div class="form-section">
          <form action="https://formspree.io/f/yourformid" method="POST">
            <label for="name">Name</label>
            <input type="text" id="name" name="Name" required>

            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="Phone">

            <label for="email">Email</label>
            <input type="email" id="email" name="Email" required>

            <label for="message">Comment</label>
            <textarea id="message" name="Message" required></textarea>

            <button type="submit">Send</button>
          </form>
        </div>

        <div class="info-section">
          <h3>Our Contact Info</h3>
          <p><strong>Phone:</strong> +977 9811001173, +977 9739490002</p>
          <p><strong>Instagram:</strong> @scentedbliss</p>
          <p><strong>Facebook:</strong> Scented Bliss</p>
          <p><strong>Email:</strong> scentedbliss@gmail.com</p>
          <p><strong>Location:</strong> Kamalpokhari, Kathmandu</p>
        </div>
      </div>
    </div>

   
    </div>
        <jsp:include page="footer.jsp"/>
    
</body>

</html>
