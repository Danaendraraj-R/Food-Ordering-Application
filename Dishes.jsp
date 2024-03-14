<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dishes</title>
    <style>
        .dish-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin: 10px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
            cursor: pointer;
        }

        .dish-card:hover {
            transform: scale(1.01);
        }

        .dish-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }

        .dish-details {
            display: flex;
            justify-content: space-between;
        }

        .dish-cost,
        .dish-preptime,
        .dish-category {
            flex: 1;
            text-align: left;
            font-size: 14px;
            color: #555;
        }

        ul{
            list-style-type: none;
        }
        li{
            margin-bottom:2px;
        }

        .dishesContainer{
            width:100%;
            transition: margin-bottom 0.3s ease-in-out;
            
        }
        
        
    </style>
</head>

<body>

    <h2>Dishes</h2>

    <div class="dishesContainer">
    </div>
    

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        
        const urlParams = new URLSearchParams(window.location.search);
        const restaurantId = urlParams.get('restaurantId');

        if (restaurantId) {
            fetchAndDisplayDishes(restaurantId);
        } else {
            console.error('Restaurant ID not provided in the query parameter.');
        }


        function fetchAndDisplayDishes(restaurantId) {
            $.ajax({
                url: `Dishes`,
                type: "GET",
                dataType: "json",
                success: function (dishesData) {
                    var filterDishes = dishesData.filter(function (dishesData) {
                        return dishesData.restId == restaurantId;
                    });
                    displayDishes(filterDishes);
                },
                error: function (error) {
                    console.log("Error fetching dishes data:", error);
                }
            });
        }

        function displayDishes(dishesData) {
            var dishesContainer = $(".dishesContainer");
            dishesContainer.empty();

            if (dishesData.length === 0) {
                dishesContainer.append("<p>No dishes available for this restaurant</p>");
            } else {
                var dishesList = dishesData.map(dish => getDishCard(dish));
                dishesContainer.append(dishesList);
            }
        }


        function getDishCard(dish) 
        {
             return "<div class='dish-card'>" +
            "<div class='dish-name'>" + dish.dishName + "</div>" +
            "<div class='dish-details'>" +
            "<div class='dish-cost'>Cost:" + dish.cost + "</div>" +
            "<div class='dish-preptime'>Preparation Time: " + dish.prepTime + " mins</div>" +
            "<div class='dish-category'>Category:" + dish.category + "</div>" +
            "</div>" +
            "</div>";
        }


    </script>
</body>

</html>
