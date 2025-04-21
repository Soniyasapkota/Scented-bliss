<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminpassword.css" />
  
  <title>Password Section</title>
  
<body>
  <div class="password-section">
    <h2>Password</h2>
    <div class="input-group">
      <div class="input-wrapper">
        <input type="password" id="current-password" placeholder="ENTER CURRENT PASSWORD">
        <button onclick="togglePassword('current-password')">SHOW</button>
      </div>
      <div class="input-wrapper">
        <input type="password" id="new-password" placeholder="ENTER NEW PASSWORD">
        <button onclick="togglePassword('new-password')">SHOW</button>
      </div>
      <div class="input-wrapper">
        <input type="password" id="confirm-password" placeholder="RE-ENTER NEW PASSWORD">
        <button onclick="togglePassword('confirm-password')">SHOW</button>
      </div>
    </div>
    <button class="save-button" onclick="saveChanges()">Save Changes</button>
  </div>

  <script>
    function togglePassword(inputId) {
      const input = document.getElementById(inputId);
      const button = input.nextElementSibling;
      if (input.type === "password") {
        input.type = "text";
        button.textContent = "HIDE";
      } else {
        input.type = "password";
        button.textContent = "SHOW";
      }
    }

    function saveChanges() {
      const currentPassword = document.getElementById("current-password").value;
      const newPassword = document.getElementById("new-password").value;
      const confirmPassword = document.getElementById("confirm-password").value;

      if (newPassword !== confirmPassword) {
        alert("New password and confirmation do not match!");
        return;
      }

      if (!currentPassword || !newPassword || !confirmPassword) {
        alert("Please fill in all fields!");
        return;
      }

      alert("Password updated successfully!");
    }
  </script>
</body>
</head>
</html>