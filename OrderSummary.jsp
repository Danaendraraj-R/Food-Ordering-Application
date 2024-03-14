<% 
    String username=(String)session.getAttribute("username");
    String phonenumber=(String)session.getAttribute("phonenumber");
    String email=(String)session.getAttribute("email");
    String address=(String)session.getAttribute("address");

    if(username==null) {
        response.sendRedirect("Login.html");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

    <h2>Order Summary</h2>

    <table id="orderTable">
        <thead>
            <tr>
                <th>Restaurant ID</th>
                <th>Dish Id</th>
                <th>Dish Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4">Grand Total</td>
                <td id="grandTotal"></td>
            </tr>
        </tfoot>
    </table>

    <center><button onclick="confirmOrder()">Confirm Order</button></center>

    <script>
        var orderData = JSON.parse(localStorage.getItem('shoppingCart')) || [];

        var grandTotalElement = document.getElementById('grandTotal');

        var grandTotal = 0;

        var tableBody = document.querySelector('#orderTable tbody');

        orderData.forEach(function (item) {
            var row = tableBody.insertRow();
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);

            cell1.textContent = item.restid;
            cell2.textContent = item.dishId;
            cell3.textContent = item.dishName;
            cell4.textContent = item.quantity;
            cell5.textContent = item.price;

            grandTotal += item.price;
        });

        grandTotalElement.textContent = grandTotal.toFixed(2);

        function confirmOrder() {
        if (orderData) {
        $.ajax({
            url: 'placeorder',
            type: 'POST',
            data: { orderData: JSON.stringify(orderData) }, 
            success: function(response) {
                console.log('Order placed successfully:', response);
                localStorage.removeItem('shoppingCart');
                window.location.href="index.jsp";
            },
            error: function(error) {
                console.error('Error placing order:', error);
            }
        });
       } else {
        console.error('Order data is null');
       }
        }
    </script>

</body>
</html>
