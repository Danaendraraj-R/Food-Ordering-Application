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

@WebServlet("/Dishes")
public class Dishes extends HttpServlet {

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

            String query = "SELECT * FROM dishes";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                 ResultSet resultSet = preparedStatement.executeQuery()) {

                List<Dish> dishes = new ArrayList<>();

                while (resultSet.next()) {
                    Dish dish = new Dish();
                    dish.setDishId(resultSet.getInt("dishid"));
                    dish.setRestId(resultSet.getInt("restid"));
                    dish.setDishName(resultSet.getString("dishname"));
                    dish.setCost(resultSet.getInt("cost"));
                    dish.setPrepTime(resultSet.getInt("preptime"));
                    dish.setCategory(resultSet.getString("category"));

                    dishes.add(dish);
                }

                StringBuilder jsonBuilder = new StringBuilder("[");
                for (Dish dish : dishes) {
                    jsonBuilder.append(dish.toJsonString()).append(",");
                }
                if (dishes.size() > 0) {
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

    private static class Dish {
        private int dishId;
        private int restId;
        private String dishName;
        private int cost;
        private int prepTime;
        private String category;

        public int getDishId() {
            return dishId;
        }

        public void setDishId(int dishId) {
            this.dishId = dishId;
        }

        public int getRestId() {
            return restId;
        }

        public void setRestId(int restId) {
            this.restId = restId;
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

        public int getPrepTime() {
            return prepTime;
        }

        public void setPrepTime(int prepTime) {
            this.prepTime = prepTime;
        }

        public String getCategory() {
            return category;
        }

        public void setCategory(String category) {
            this.category = category;
        }

        public String toJsonString() {
            return String.format("{\"dishId\":%d,\"restId\":%d,\"dishName\":\"%s\",\"cost\":%d,\"prepTime\":%d,\"category\":\"%s\"}",
                    dishId, restId, dishName, cost, prepTime, category);
        }
    }
}
