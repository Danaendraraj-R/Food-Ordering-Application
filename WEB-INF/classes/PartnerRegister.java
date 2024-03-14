import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;

import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PartnerRegister")
public class PartnerRegister extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found " + e);
        }
        try {

            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Zomato", "postgres", "Rajdr039*");
            System.out.println("connection successful");


            PreparedStatement st = conn.prepareStatement("insert into deliverypartner(NAME, EMAIL, PASSWORD, LOCATION , STATUS) values(?, ?, ?, ?, ?)");
            st.setString(1, request.getParameter("Username"));
            st.setString(2, request.getParameter("Email"));
            st.setString(3, request.getParameter("Password"));
            st.setString(4, request.getParameter("Location"));
            st.setString(5, "Available");
            st.executeUpdate();


            st.close();
            conn.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
