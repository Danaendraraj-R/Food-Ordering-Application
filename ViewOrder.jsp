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
        .accept {
            background-color:rgb(16, 108, 16);
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right:5px;
        }.update {
            background-color:#e8ec1b;
            color: black;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right:5px;
        }
    </style>
</head>

<body>

    <h2>Orders</h2>

    <div class="ordersContainer">
    </div>
    <%
    int restid=(Integer)session.getAttribute("restid");
    %>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>


        const restaurantId = <%=restid %>;

        if (restaurantId) {
            fetchAndDisplayOrders(restaurantId);
        } else {
            console.error('Restaurant ID not provided in the query parameter.');
        }

        function fetchAndDisplayOrders(restaurantId) {
            $.ajax({
                url: 'Orders',
                type: "GET",
                dataType: "json",
                success: function (data) {
                    var filterOrders = data.filter(function (order) {
                        return order.restId == restaurantId;
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
    if (order.status === "Placed") {
        buttonsHtml = "<button class='accept' onclick='acceptOrder("+order.orderId+")'>Accept</button>"+
        "<button class='decline' onclick='DeclineOrder("+order.orderId+")'>Decline</button>";
    } else if (order.status === "Dispatched" || order.staus ==="Declined" ) {
    
    } else {
        buttonsHtml = "<button class='update' onclick='DispatchOrder("+order.orderId+")'>Dispatch</button>";
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
function acceptOrder(orderId) {
    performOrderAction(orderId, "Accepted");
}

function DeclineOrder(orderId) {
    const userAction = confirm("Do you want to update or decline the order?");
    if (userAction) {
        performOrderAction(orderId, "Declined");
    }
}
function DispatchOrder(orderId)
{
    performOrderAction(orderId,"Dispatched");
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
