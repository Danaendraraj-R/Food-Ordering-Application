import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.ArrayList;


@WebServlet("/PartnerLogin")
@SuppressWarnings("unchecked")
public class PartnerLogin extends HttpServlet {
   

    public void doPost(HttpServletRequest req, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        String name = "name";
        String password = "password";
        String email = "email";
        String status = "status";
        String location="location";
        int id = 0;

        try {

            String user = req.getParameter("Email");
            String pass = req.getParameter("Password");

            Class.forName("org.postgresql.Driver");
            Connection conn = null;
            Statement stmt = null;
            conn = DriverManager
                    .getConnection("jdbc:postgresql://localhost:5432/Zomato", "postgres", "Rajdr039*");
            int allow = 0;
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM DELIVERYPARTNER;");
            while (rs.next()) {
                email = rs.getString("email");
                password = rs.getString("password");
                status= rs.getString("status");
                location= rs.getString("location");
                id=rs.getInt("id");

                if (email.equals(user) && password.equals(pass)) {
                    
                        allow++;
                    

                    name = rs.getString("name");


                    HttpSession httpSession = req.getSession(true);
                    httpSession.setAttribute("email", email);
                    httpSession.setAttribute("username", name);
                    httpSession.setAttribute("status", status);
                    httpSession.setAttribute("location", location);
                    httpSession.setAttribute("id",id);
                    break;
                }
            }

        
            rs.close();
            stmt.close();
            conn.close();
            if (allow == 1) {
                System.out.println("Login Successful!");
                response.sendRedirect("DeliveryPartner.jsp");
            } 
            else {
                response.sendRedirect("Error.jsp");
            }

        } catch (Exception e) {
            out.println(e);
        }
    }
}
