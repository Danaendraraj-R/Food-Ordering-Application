import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.ArrayList;


@WebServlet("/Login1")
@SuppressWarnings("unchecked")
public class Login1 extends HttpServlet {
   

    public void doPost(HttpServletRequest req, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        String username = "username";
        String password="password";
        String name = "name";
        String location = "location";
        String tag1 = "tag1";
        String tag2 = "tag2";
        int eta=0;
        int id=0;
        String img="img";


        int empno = 0;

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
            ResultSet rs = stmt.executeQuery("SELECT * FROM RESTAURANTS;");
            while (rs.next()) {
                username = rs.getString("username");
                password = rs.getString("password");
                location= rs.getString("location");
                tag1= rs.getString("tag1");
                tag2= rs.getString("tag2");
                img=rs.getString("img");
                eta=rs.getInt("eta");
                id=rs.getInt("id");
                name=rs.getString("name");

                //System.out.println(username+" "+password);


                if (username.equals(user) && password.equals(pass)) {
                    
                        allow++;
                    

                    username = rs.getString("username");


                    HttpSession httpSession = req.getSession(true);
                    httpSession.setAttribute("username", username);
                    httpSession.setAttribute("name", name);
                    httpSession.setAttribute("restid", id);
                    httpSession.setAttribute("location", location);
                    httpSession.setAttribute("tag1", tag1);
                    httpSession.setAttribute("tag2", tag2);
                    httpSession.setAttribute("img", img);
                    httpSession.setAttribute("eta", eta);
                    httpSession.setAttribute("role", "rest");
                    break;
                }
            }

        
            rs.close();
            stmt.close();
            conn.close();
            if (allow == 1) {
                System.out.println("Login Successful!");
                response.sendRedirect("Restaurant.jsp");
            } 
            else {
                response.sendRedirect("Error.jsp");
            }

        } catch (Exception e) {
            out.println(e);
        }
    }
}
