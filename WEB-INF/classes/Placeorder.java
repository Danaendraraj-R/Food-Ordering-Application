import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/placeorder")
public class Placeorder extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderDataJson = request.getParameter("orderData");
        String username = (String) request.getSession().getAttribute("username");
        String email = (String) request.getSession().getAttribute("email");
        String phonenumber = (String) request.getSession().getAttribute("phonenumber");
        List<OrderItem> orderItems = convertJsonToList(orderDataJson);

        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Zomato",
                "postgres", "Rajdr039*")) {
            String sql = "INSERT INTO orders (restid, dishid, dishname, cost, username, email, status, phonenumber) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                for (OrderItem orderItem : orderItems) {
                    statement.setInt(1, orderItem.getRestid());
                    statement.setInt(2, orderItem.getDishid());
                    statement.setString(3, orderItem.getDishname());
                    statement.setInt(4, orderItem.getCost());
                    statement.setString(5, username);
                    statement.setString(6, email);
                    statement.setString(7, "Placed");
                    statement.setString(8, phonenumber);
                    statement.executeUpdate();
                }
            }
            response.getWriter().println("Orders placed successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error placing the orders");
        }
    }

    private List<OrderItem> convertJsonToList(String orderDataJson) {
        try {
            JSONArray jsonArray = new JSONArray(orderDataJson);
            List<OrderItem> orderItems = new ArrayList<>();

            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                OrderItem orderItem = new OrderItem(
                        jsonObject.getInt("restid"),
                        jsonObject.getInt("dishId"),
                        jsonObject.getString("dishName"),
                        jsonObject.getInt("price")
                );
                orderItems.add(orderItem);
            }

            return orderItems;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
