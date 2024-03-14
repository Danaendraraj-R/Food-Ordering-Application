import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/AddDish")
public class AddDish extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Zomato",
                "postgres", "Rajdr039*")) {

            int restId = Integer.parseInt(request.getParameter("restId"));
            String dishName = request.getParameter("dishName");
            int preptime = Integer.parseInt(request.getParameter("preptime"));
            int cost = Integer.parseInt(request.getParameter("cost"));
            String Category = request.getParameter("Category");


            String query = "INSERT INTO dishes (restid, dishname, cost, preptime, category) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, restId);
                preparedStatement.setString(2, dishName);
                preparedStatement.setInt(3, cost);
                preparedStatement.setInt(4, preptime);
                preparedStatement.setString(5, Category);
                preparedStatement.executeUpdate();
            }
        

            response.sendRedirect("Restaurant.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
