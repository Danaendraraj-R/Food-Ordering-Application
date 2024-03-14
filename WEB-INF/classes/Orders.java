import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Orders")
public class Orders extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Zomato",
                "postgres", "Rajdr039*")) {

            String query = "SELECT * FROM orders";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                 ResultSet resultSet = preparedStatement.executeQuery()) {

                List<Order> orders = new ArrayList<>();

                while (resultSet.next()) {
                    Order order = new Order();
                    order.setOrderId(resultSet.getInt("orderid"));
                    order.setRestId(resultSet.getInt("restid"));
                    order.setDishId(resultSet.getInt("dishid"));
                    order.setDishName(resultSet.getString("dishname"));
                    order.setCost(resultSet.getInt("cost"));
                    order.setUsername(resultSet.getString("username"));
                    order.setEmail(resultSet.getString("email"));
                    order.setStatus(resultSet.getString("status"));
                    order.setDid(resultSet.getInt("did"));
                    order.setDname(resultSet.getString("dname"));

                    orders.add(order);
                }

                StringBuilder jsonBuilder = new StringBuilder("[");
                for (Order order : orders) {
                    jsonBuilder.append(order.toJsonString()).append(",");
                }
                if (orders.size() > 0) {
                    jsonBuilder.deleteCharAt(jsonBuilder.length() - 1);
                }
                jsonBuilder.append("]");

                try (PrintWriter out = response.getWriter()) {
                    out.print(jsonBuilder.toString());
                    out.flush();
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static class Order {
        private int orderId;
        private int restId;
        private int dishId;
        private String dishName;
        private int cost;
        private String username;
        private String email;
        private String status;
        private int did;
        private String dname;

        public int getOrderId() {
            return orderId;
        }

        public void setOrderId(int orderId) {
            this.orderId = orderId;
        }

        public int getRestId() {
            return restId;
        }

        public void setRestId(int restId) {
            this.restId = restId;
        }

        public int getDishId() {
            return dishId;
        }

        public void setDishId(int dishId) {
            this.dishId = dishId;
        }

        public String getDishName() {
            return dishName;
        }

        public void setDishName(String dishName) {
            this.dishName = dishName;
        }

        public int getCost() {
            return cost;
        }

        public void setCost(int cost) {
            this.cost = cost;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }
        
        public int getDid() {
        return did;
       }

       public void setDid(int did) {
         this.did = did;
       }

       public String getDname() {
          return dname;
       }

       public void setDname(String dname) {
           this.dname = dname;
        }

      public String toJsonString() {
        return String.format("{\"orderId\":%d,\"restId\":%d,\"dishId\":%d,\"dishName\":\"%s\",\"cost\":%d,\"username\":\"%s\",\"email\":\"%s\",\"status\":\"%s\",\"did\":%d,\"dname\":\"%s\"}",
                orderId, restId, dishId, dishName, cost, username, email, status, did, dname);
       }
    }
}
