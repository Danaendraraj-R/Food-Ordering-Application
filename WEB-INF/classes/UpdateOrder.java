import java.io.*;
import java.sql.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;

@WebServlet("/UpdateOrder")
public class UpdateOrder extends HttpServlet {

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

            String action = request.getParameter("action");
            String orderId = request.getParameter("orderId");
            int oid = Integer.parseInt(orderId);

            String query = "UPDATE ORDERS SET status=? WHERE orderid=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, action);
                preparedStatement.setInt(2, oid);
                preparedStatement.executeUpdate();
                if ("Accepted".equals(action)) {
                    String restaurantLocationQuery = "SELECT restid FROM ORDERS WHERE orderid=?";
                    try (PreparedStatement restidStatement = connection.prepareStatement(restaurantLocationQuery)) {
                        restidStatement.setInt(1, oid);
                        try (ResultSet restidResultSet = restidStatement.executeQuery()) {
                            if (restidResultSet.next()) {
                                int restid = restidResultSet.getInt("restid");
                                allocateDeliveryPartner(restid, connection,oid);
                            }
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println(e);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
    }

   private void allocateDeliveryPartner(int restid, Connection connection,int oid) {
    try {
        String restaurantLocationQuery = "SELECT location FROM RESTAURANTS WHERE id=?";
        try (PreparedStatement locationStatement = connection.prepareStatement(restaurantLocationQuery)) {
            locationStatement.setInt(1, restid);
            try (ResultSet locationResultSet = locationStatement.executeQuery()) {
                if (locationResultSet.next()) {
                    String restaurantLocation = locationResultSet.getString("location");
                    String availablePartnerQuery = "SELECT id,name FROM deliverypartner WHERE location=? AND status='Available' LIMIT 1";
                    try (PreparedStatement availablePartnerStatement = connection.prepareStatement(availablePartnerQuery)) {
                        availablePartnerStatement.setString(1, restaurantLocation);
                        try (ResultSet availablePartnerResultSet = availablePartnerStatement.executeQuery()) {
                            if (availablePartnerResultSet.next()) {

                                int deliveryPartnerId = availablePartnerResultSet.getInt("id");
                                String deliveryPartnerName = availablePartnerResultSet.getString("name");

                                String updateOrderQuery = "UPDATE ORDERS SET did=?,dname=? WHERE orderid=?";
                                try (PreparedStatement updateOrderStatement = connection.prepareStatement(updateOrderQuery)) {
                                    updateOrderStatement.setInt(1, deliveryPartnerId);
                                    updateOrderStatement.setString(2, deliveryPartnerName);
                                    updateOrderStatement.setInt(3, oid);
                                    updateOrderStatement.executeUpdate();
                                }
                            } else {
                                allocateAnyAvailableDeliveryPartner(connection, restid,oid);
                            }
                        }
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}

private void allocateAnyAvailableDeliveryPartner(Connection connection, int restid,int oid) {
    try {
        String allocateAnyQuery = "SELECT id,name FROM deliverypartner WHERE status='Available' LIMIT 1";
        try (PreparedStatement allocateAnyStatement = connection.prepareStatement(allocateAnyQuery)) {
            try (ResultSet allocateAnyResultSet = allocateAnyStatement.executeQuery()) {
                if (allocateAnyResultSet.next()) {

                    int deliveryPartnerId = allocateAnyResultSet.getInt("id");
                    String deliveryPartnerName = allocateAnyResultSet.getString("name");

                    String updateOrderQuery = "UPDATE ORDERS SET did=?,dname=? WHERE orderid=?";
                    try (PreparedStatement updateOrderStatement = connection.prepareStatement(updateOrderQuery)) {
                        updateOrderStatement.setInt(1, deliveryPartnerId);
                        updateOrderStatement.setString(2, deliveryPartnerName);
                        updateOrderStatement.setInt(3, oid);
                        updateOrderStatement.executeUpdate();
                    }
                } else {
                    System.out.println("No available delivery partner for the location or in general.");
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    


}
