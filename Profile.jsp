<%@ page import="javax.xml.bind.DatatypeConverter" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Base64" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .profile-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #4caf50;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #4caf50;
            color: #fff;
        }

        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-top: 10px;
        }

        p {
            margin: 5px 0;
            color: #666;
        }

        a {
            text-decoration: none;
            color: #4caf50;
            font-weight: bold;
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #fff;
            border: 2px solid #4caf50;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        a:hover {
            background-color: #4caf50;
            color: #fff;
        }

        .avatar-container {
            position: relative;
            display: inline-block;
        }

        .avatar {
            width: 100px; /* Adjust the width as needed */
            height: 100px; /* Adjust the height as needed */
            border-radius: 50%;
            margin-bottom: 7px;
        }
        .available:hover {
            background-color: #117f15;
            color: #fff;
        }
        .unavailable:hover {
            background-color: #c61916;
            color: #fff;
        }

        .available {
            text-decoration: none;
            color: #0a820e;
            font-weight: bold;
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #fff;
            border: 2px solid #0e4a10;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .unavailable {
            text-decoration: none;
            color: #d74113;
            font-weight: bold;
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #fff;
            border: 2px solid #e42e05;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        
        body{
            background-image: linear-gradient(to left,#6ff6b3e2,#69e0f8);
        }
    </style>
</head>
<body>

<div class="profile-container">

    <h2>User Profile</h2>

    <div class="avatar-container">

    <img class="avatar" src=<%=session.getAttribute("img") %> alt="User Avatar">

    </div>

    <table>
        
        <tr>
            <td><label>Restaurant ID:</label></td>
            <td><p><%= session.getAttribute("restid") %></p></td>
        </tr> 
        <tr>
            <td><label>Restaurant Name:</label></td>
            <td><p><%= session.getAttribute("name") %></p></td>
        </tr> 
        <tr>
            <td><label>Email:</label></td>
            <td><p><%= session.getAttribute("username") %></p></td>    
        </tr> 
        <tr>
            <td><label>Featured Tags:</label></td>
            <td><p><%= session.getAttribute("tag1") %></p>
            <p><%= session.getAttribute("tag2") %></p></td>
        </tr> 
        <tr>
            <td><label>Location:</label></td>
            <td><p><%= session.getAttribute("location") %></p></td>
        </tr> 
        
    </table>

    <div class="Availability">
        <button class="available" onclick="MakeAvailable()">Available</button>
        <button class="unavailable" onclick="MakeNotAvailable()">Not Serving Now</button>
    </div>
        <a href="Restaurant.jsp">Back</a>
        
    
</div>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    function MakeAvailable()
    {
     var restid= '<%=session.getAttribute("restid")%>';
     ChangeAvailability(restid,'true');
    }
    function MakeNotAvailable()
    {
    var restid= '<%=session.getAttribute("restid")%>';
    ChangeAvailability(restid,'false');
    }
    function ChangeAvailability(restid,option)
    {
        $.ajax({
        url: "ChangeAvailability",
        type: "POST",
        data: { restid: restid, option:option },
        success: function (response) {
            window.location.reload();
        },
        error: function (error) {
            console.log(`Error ${action.toLowerCase()}ing order:`, error);
        }
    });
    }
</script>

</body>
</html>
