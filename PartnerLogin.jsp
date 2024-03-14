<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
   /* background-image: linear-gradient(to left, #fe0606, #f2caca);*/
}

form {
    background-color:transparent;
    padding: 20px;
    border-radius: 20px;
    border: 1px solid black;
    box-shadow: 60px 60px 60px rgba(231, 61, 61, 0.1);
    margin-bottom: 20px;
    width: 300px;
}

h2 {
    text-align: center;
    color: #EF4F5F;
}

label {
    display: block;
    margin: 10px 0 5px;
    color: black;
}

input {
    width: calc(100% - 12px);
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid black;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=submit] {
    width: 100%;
    padding: 10px;
    background-color: #EF4F5F;
    color: black;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #EF4F5F;
}

a{
    color: black;
}
h1{
        font-family: Okra;
        color:#9F000F;
        margin: 0;
        font-size: 90px;
        font-weight: bold;
    }
</style>
</style>
</head>
<body>
    <header>      
        <i><h1>Zomato</h1></i>
    </header>
    <h2>Login</h2>
    <form id="loginForm" action="PartnerLogin" method="post">
        <label for="loginUsername">Email:</label>
        <input type="text" id="loginUsername" name="Email"required>
        
        <label for="loginPassword">Password:</label>
        <input type="password" id="loginPassword" name="Password" required>
        
        <input type="submit" value="Login">

        <center>
            <a href="PartnerRegister.jsp">Don't have an account... Register Now</a><br><br>
            <a href="index.jsp">Home</a>
            <a href="RestaurantLogin.html">Restaurant Login</a>
        </center>
    </form>
    
    

    <div id="result"></div>
</body>
</html>
