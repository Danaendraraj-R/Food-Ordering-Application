<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Food Ordering App</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
 .restaurant-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        margin:50px;
    }

    .restaurant-card {
        border: 1px solid #ddd;
        border-radius: 8px;
        margin: 10px;
        overflow: hidden;
        width: calc(25% - 20px);
        height: 300px; 
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s ease-in-out;
        cursor: pointer;
    }

    .restaurant-card:hover {
        transform: scale(1.05);
    }

    .restaurant-image {
        height: 60%; 
        overflow: hidden;
    }

    .restaurant-image img {
        width: 100%;
        height: 90%;
        object-fit: cover; 
    }

    .restaurant-details {
        padding: 10px;
        text-align: center;
        height: 40%; 
        box-sizing: border-box;
    }

    .restaurant-name {
        font-size: 16px;
        font-weight: bold;
    }

    .restaurant-location {
        color: #777;
    }

    .restaurant-rating {
        color: #f90;
    }

    .restaurant-eta {
        color: #44c;
    }
    header{
        background-image: url("https://b.zmtcdn.com/web_assets/81f3ff974d82520780078ba1cfbd453a1583259680.png");
        background-size: cover;
        height:400px;
        width:100%;
        color: #fff;
        padding: 15px 0;
        text-align: center;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    h1{
        font-family: Okra;
        color:#ddd;
        margin: 0;
        font-size: 90px;
        font-weight: bold;
        margin-top:60px;
    }
    p {
        margin: 5px 0;
        font-size: 45px;
        width:50%;
        margin-left:25%;
        font-family: Arial, Helvetica, sans-serif;
    }
    .topnav {
  background-color: transparent;
  height: 55px;
  overflow: hidden;
  width:100%
}

.topnav a,h2,.logout-btn{
  float: right;
  height: 55px;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  font-weight: bold;
}
.logout-btn input[type="submit"] {
  margin-top: -20px;  
  background-color: transparent; 
  color: #f2f2f2;
  padding: 10px 15px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 17px;
  font-weight: bold;
}
.topnav a:hover {
  background-color: #ddd;
  height: 55px;
  color: black;
}

    </style>
</head>
<body>

    <header>
        <div class="topnav">
              
         <% if(session.getAttribute("username")==null) { %>  
            <a id="signupButton" href="Register.html"><b> Sign Up</b> </a>
            <a id="loginButton" href="Login.html"> <b>Login </b></a> 
           <!--<a href="AddRestaurant.jsp">Add Restaurant</a> -->
            <% } else { %>
            
           
            <div class="logout-btn">
                <form action="Logout" method="post">
                    <input type="submit" value="Logout">
                </form>
                
              </div>
              <a href="Orders.jsp">Your Orders</a>
              <h2 id="usernameDisplay"><%= session.getAttribute("username") %>  </h2>
          <% }  %>
          
            </div>
        <i><h1>Zomato</h1>
        <p>Find the best restaurants, cafés and bars in India</p></i>
    </header>
    <div class="container">
        <div class="search-bar">
            <img src="https://upload.wikimedia.org/wikipedia/commons/7/75/Zomato_logo.png" class="logo" onclick="window.location.reload()">
            <input type="text" id="search" placeholder="Search restaurant by names" title="Type in a name">
        </div>
        <div class="filters">
            <select name="dropown" id="sortby" onchange="sortby(event)">
                <option disabled>Sort By</option>
                <option value="rating">Sort By RATING</option>
                <option value="eta">Sort By ETA</option>
              </select>
        
        </div>
      
    </div>
    <center><div class="restaurants"></div></center>
    <div class="errorNotify"></div>

    <script>


    </script>
    <script src="app.js"> </script>
    
</body>
</html>