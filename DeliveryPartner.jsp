<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <style>
        .order-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin: 10px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
            cursor: pointer;
        }

        .order-card:hover {
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

        ul {
            list-style-type: none;
        }

        li {
            margin-bottom: 2px;
        }

        .ordersContainer {
            width: 100%;
            transition: margin-bottom 0.3s ease-in-out;
        }
        .decline {
            background-color:#da2222;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right:5px;
        }
        .deliver {
            background-color:rgb(16, 108, 16);
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right:5px;
        }.pickup {
            background-color:#e8ec1b;
            color: black;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right:5px;
        }


            .navbar {
             background-color: #a00a0a;
             padding:2px;
             text-align: left;
             height:20%;
             justify-content: space-between;
             color:white;
             width:100%;
            }




.logout-btn {
  float: right;
  padding: 15px;
}
.logout-btn form {
  margin-top: -65px; /* Remove default form margin */
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

    </style>
</head>

<body>
    <div class="navbar">
        <h2>Orders</h2>
          <div class="logout-btn">
              <form action="Logout" method="post">
                  <input type="submit" value="Logout">
              </form>
        </div>
    </div>

    

    <div class="ordersContainer">
    </div>
    <%
    int id=(Integer)session.getAttribute("id");
    %>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>


        var did = '<%=id%>';

        if (did) {
            fetchAndDisplayOrders(did);
        } else {
            console.error('Restaurant ID not provided in the query parameter.');
        }

        function fetchAndDisplayOrders(did) {
            $.ajax({
                url: 'Orders',
                type: "GET",
                dataType: "json",
                success: function (data) {
                    var filterOrders = data.filter(function (order) {
                        return order.did == did;
                    });
                    displayOrders(filterOrders);
                },
                error: function (error) {
                    console.log("Error fetching orders data:", error);
                }
            });
        }

        function displayOrders(data) {
            var ordersContainer = $(".ordersContainer");
            ordersContainer.empty();

            if (data.length === 0) {
                ordersContainer.append("<p>No Orders available for this restaurant</p>");
            } else {
                var orderList = data.map(order => getOrderCard(order));
                ordersContainer.append(orderList);
            }
        }
        function getOrderCard(order) {
    let buttonsHtml = "";
     if (order.status === "Cancelled" || order.status ==="Declined" || order.status ==="Delivered") {
        
    } 
    else if(order.status === "Picked")
    {
        buttonsHtml = "<button class='deliver' onclick='DeliverOrder("+order.orderId+")'>Deliver</button>";   
    }
    else if(order.status === "Dispatched") 
    {
        buttonsHtml = "<button class='pickup' onclick='PickupOrder("+order.orderId+")'>Pickup</button>";
    }

    return "<div class='order-card'>" +
        "<div class='dish-name'>" + order.dishName + "</div>" +
        "<div class='dish-details'>" +
        "<div class='dish-cost'>Cost: " + order.cost + "</div>" +
        "<div class='dish-category'>Status: " + order.status + "</div>" +
        "<div class='button'>" + buttonsHtml + "</div>" +
        "</div>" +
        "</div>";
}


function DeliverOrder(orderId) {
    const userAction = confirm("Do you want to deliver the order?");
    if (userAction) {
        performOrderAction(orderId, "Delivered");
    }
}
function PickupOrder(orderId) {
    const userAction = confirm("Do you want to pickup the order?");
    if (userAction) {
        performOrderAction(orderId, "Picked");
    }
}

function performOrderAction(orderId, action) {
    $.ajax({
        url: "UpdateOrder",
        type: "POST",
        data: { orderId: orderId, action: action },
        success: function (response) {
            window.location.reload();
            console.log(`Order ${action.toLowerCase()}ed successfully`);
        },
        error: function (error) {
            console.log(`Error ${action.toLowerCase()}ing order:`, error);
        }
    });
}

    </script>
</body>

</html>
