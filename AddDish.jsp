<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Task</title>
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

        .task-container {
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

        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }
        a{
            color:black;
        }
        body{
            background-image: linear-gradient(to left,#f74049,#f8a7cb);
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

<div class="task-container">
    <h2>Add Dish</h2>

    <form action="AddDish" method="post">

        <label>Rest ID</label>
        <input type="number" id="restId" name="restId" value='<%= session.getAttribute("restid") %>' readonly>
        
        <label>Dish Name:</label>
        <input type="text" name="dishName" required>

        <label>Preparation Time:</label>
        <input type="number" name="preptime" required>

        <label>Cost:</label>
        <input type="number" name="cost" required>

        <label>Category:</label>
        <select name="Category">
            <option value="Veg">Veg</option>
            <option value="Non Veg">Non Veg</option>
        </select>

        <button type="submit">Add Dish</button>
    </form>
<br>
    <a href="Restaurant.jsp">Back to Dashboard</a>
</div>

</body>
</html>
