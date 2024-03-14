<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
// Retrieve values from the session
String email = (String) session.getAttribute("email");
String username = (String) session.getAttribute("username");
String role=(String) session.getAttribute("role");

if ((email == null || username == null) && role==null) {
    response.sendRedirect("Login.html");
}

%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Restaurant Dashboard</title>
  <style>
    body {
  margin: 0;
  font-family: 'Arial', sans-serif;
  background-image: url("https://www.gloriafood.com/wp-content/uploads/2022/09/free-restaurant-management-software-Facebook.png");
  background-size: cover;
}


.container {
  position: relative;
  width: 100%;
  height: 100vh;
}

.navbar {
  background-color: #a00a0a;
  padding: 15px;
  text-align: left;
}

.toggle-btn {
  background-color: #a00a0a;
  color: white;
  border: none;
  font-size: 16px;
  cursor: pointer;
}

.overlay {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(147, 11, 11, 0.97);
}

.content {
  padding: 20px;
}

/* Sidebar Navigation Styles */
.sidebar {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #a00a0a;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidebar a {
  padding: 15px 15px 15px 32px;
  text-decoration: none;
  font-size: 17px;
  color: white;
  display: block;
  transition: 0.3s;
}

.sidebar a:hover {
  color: #f1f1f1;
}

.sidebar .close-btn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 25px;
  margin-left: 50px;
}

/* Animation for the sidebar */
.container.change .sidebar {
  width: 250px;
}

.container.change .overlay {
  display: block;
}
.logout-btn {
  float: right;
  padding: 15px;
}
.logout-btn form {
  margin-top: -20px; /* Remove default form margin */
}

.logout-btn input[type="submit"] {
  margin-top: 0px;  
  background-color: #f1f1f1; 
  color: #000;
  padding: 10px 15px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

ul
{
  list-style-type: none;
}
header{
       /* background-image: url("https://b.zmtcdn.com/web_assets/81f3ff974d82520780078ba1cfbd453a1583259680.png");*/
        background-size: cover;
        height:300px;
        width:100%;
        color:#d90a0a;
        padding: 15px 0;
        text-align: center;
    }
    h1{
        font-family: Okra;
        color: #a00a0a;
        margin: 0;
        font-size: 90px;
        font-weight: bold;
        
    }
    p {
        margin: 5px 0;
        font-size: 45px;
        width:50%;
        margin-left:25%;
        font-family: Arial, Helvetica, sans-serif;
    }
    img{
        width:100%;
        height:400px;
    }

  </style>
  <script>
    function toggleNav() {
  var container = document.querySelector('.container');
  container.classList.toggle('change');
}

  </script>

</head>
<body>

<div class="overlay"></div>

<div class="container">
  <div class="navbar">
    <button class="toggle-btn" onclick="toggleNav()">&#9776; Menu</button>
    <div class="logout-btn">
        <form action="Logout" method="post">
            <input type="submit" value="Logout">
        </form>
      </div>
  </div>

<header>
    <i><h1>Zomato</h1>
    <p>We are happy that you are here to serve us the most delicious recipes</p></i>
</header>

  <div class="sidebar">
    <a href="javascript:void(0)" class="close-btn" onclick="toggleNav()">&#10005;</a>
    <ul>
      <li><a href="Dishes.jsp?restaurantId=<%= session.getAttribute("restid") %>">Manage Dishes</a></li>
      <li><a href="AddDish.jsp">Add Dish</a></li>
      <li><a href="ViewOrder.jsp">View Orders</a></li>
      <li><a href="Profile.jsp">View Profile</a></li>
    </ul>
  </div>
<!-- <img src="https://www.foodiv.com/wp-content/uploads/2022/07/Online-Food-Ordering-System-Work.jpg"> -->

</div>

</body>
</html>