import java.lang.*;
import java.io.*;
import java.sql.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;

@WebServlet("/ChangeAvailability")

public class ChangeAvailability extends HttpServlet{

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,HttpServletResponse response)
     throws ServletException, IOException 
    {
   

   try {
       Class.forName("org.postgresql.Driver");
    } catch (ClassNotFoundException e) {
         e.printStackTrace();
    }

        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Zomato",
                "postgres", "Rajdr039*")) {
            Boolean action=Boolean.parseBoolean(request.getParameter("option"));
             System.out.println(action);
          //  int orderId=Integer.parseInt(request.getParameter("orderId"));
            String restId = request.getParameter("restid");
            System.out.println(restId);
            int oid= Integer.parseInt(restId);
           
            String query = "UPDATE RESTAURANTS SET availability=? WHERE id=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setBoolean(1, action);
                preparedStatement.setInt(2, oid);
                preparedStatement.executeUpdate();
            }
            catch(Exception e)
            {
                System.out.println(e);
            }

        }
        catch(Exception e)
        {
         System.out.println(e);
        }


    }
}