<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
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

input ,textarea{
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
</head>
<body>
    
    <header>
        
        <i><h1>Zomato</h1></i>
    </header>

    <h2>Delivery Partner Sign Up</h2>
    <form id="registerForm" method="post" action="PartnerRegister">

        <label for="registerUsername">Name:</label>
        <input type="text" id="Username" name="Username" required>

        <label for="Email">Email:</label>
        <input type="text" id="Email" name="Email" required>
        
        <label for="registerPassword">Password:</label>
        <input type="password" id="Password" name="Password" required>
         
        <label for="Address">Location:</label>
        <input type="text" name="Location" required>
        
        <input type="submit" value="Sign Up">
         <center>
            <a href="PartnerLogin.html">Already have an account</a><br>
            <a href="index.html">Home</a>
        </center>
    </form>
    

    <div id="result"></div>
</body>
</html>
