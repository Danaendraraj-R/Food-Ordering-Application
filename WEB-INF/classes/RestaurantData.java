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

@WebServlet("/RestaurantData")
public class RestaurantData extends HttpServlet {

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

            String query = "SELECT * FROM restaurants where availability='true'";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                    ResultSet resultSet = preparedStatement.executeQuery()) {

                List<Restaurant> restaurants = new ArrayList<>();

                while (resultSet.next()) {
                    Restaurant restaurant = new Restaurant();
                    restaurant.setId(resultSet.getInt("id"));
                    restaurant.setName(resultSet.getString("name"));
                    restaurant.setLocation(resultSet.getString("location"));
                    restaurant.setRating(resultSet.getDouble("rating"));
                    restaurant.setEta(resultSet.getInt("eta"));
                    restaurant.setTag1(resultSet.getString("tag1"));
                    restaurant.setTag2(resultSet.getString("tag2"));
                    restaurant.setImg(resultSet.getString("img"));

                    restaurants.add(restaurant);
                }

                StringBuilder jsonBuilder = new StringBuilder("[");
                for (Restaurant restaurant : restaurants) {
                    jsonBuilder.append(restaurant.toJsonString()).append(",");
                }
                if (restaurants.size() > 0) {
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

    private static class Restaurant {
        private int id;
        private String name;
        private String location;
        private double rating;
        private int eta;
        private String tag1;
        private String tag2;
        private String img;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public int getEta() {
        return eta;
    }

    public void setEta(int eta) {
        this.eta = eta;
    }

    public String getTag1() {
        return tag1;
    }

    public void setTag1(String tag1) {
        this.tag1 = tag1;
    }

    public String getTag2() {
        return tag2;
    }

    public void setTag2(String tag2) {
        this.tag2 = tag2;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }


        public String toJsonString() {
            return String.format(
                    "{\"id\":%d,\"name\":\"%s\",\"location\":\"%s\",\"rating\":%.1f,\"eta\":%d,\"tag1\":\"%s\",\"tag2\":\"%s\",\"img\":\"%s\"}",
                    id, name, location, rating, eta, tag1, tag2, img);
        }
    }
}
