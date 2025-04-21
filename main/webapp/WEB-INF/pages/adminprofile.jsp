<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminprofile.css" />
    
    <title>User Profile - Scented Bliss</title>
    </head>
<body>
    <div class="container">
        <div class="sidebar">
            <a href="#"> User Information</a>
            <a href="#">Linked Account</a>
            <a href="#">Linked Social Account</a>
            <a href="${pageContext.request.contextPath}/adminpassword">Password</a>
            <a href="#">Subscription Type</a>
            <a href="#"> Transaction Status</a>
            <a href="#">Coupons</a>
            <a href="#">Preferences</a>
        </div>

        <div class="main-content">
            <div class="profile-header">
                <img src="https://via.placeholder.com/80" alt="User Profile">
               
            </div>

            <div class="profile-details">
                <div class="detail-item">
                    <label>Full Name</label>
                    <input type="text" value="Name">
                </div>
                <div class="detail-item">
                    <label>Nick Name</label>
                    <input type="text" value="Name">
                </div>
                <div class="detail-item">
                    <label>Email</label>
                    <input type="email" value="Email" readonly>
                    <span>This is your primary email address and will be used to send notification emails.</span>
                    <a href="#">Change Email Address</a>
                </div>
                <div class="detail-item">
                    <label>Phone Number</label>
                    <input type="tel" value="+977">
                </div>
               
                <div class="detail-item">
                    <label>Location</label>
                    <input type="text" value="">
                </div>
                <button onclick="saveChanges()">Save Changes</button>
            </div>
        </div>
    </div>

    <script>
        function saveChanges() {
            alert("Changes saved successfully!");
            // Implement save logic here
        }
    </script>
</body>
</html>