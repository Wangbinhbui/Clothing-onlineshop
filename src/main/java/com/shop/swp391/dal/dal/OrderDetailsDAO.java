package com.shop.swp391.dal;

import com.shop.swp391.entity.OrderDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDetailsDAO extends DBContext {
    
    /**
     * Chèn thông tin chi tiết đơn hàng mới vào bảng orderdetails.
     * Lưu ý: Sử dụng tên cột trong database.
     * Các cột: ProductID, OrderID, Quantity, Price, VariationID
     */
    public int insert(OrderDetails orderDetails) {
        String sql = "INSERT INTO orderdetails (ProductID, OrderID, Quantity, Price, VariationID) "
                   + "VALUES (?, ?, ?, ?, ?)";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setInt(1, orderDetails.getProductID());
            statement.setInt(2, orderDetails.getOrderID());
            statement.setInt(3, orderDetails.getQuantity());
            statement.setInt(4, orderDetails.getPrice());
            statement.setInt(5, orderDetails.getVariationID());
            
            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order detail failed, no rows affected.");
            }
            
            resultSet = statement.getGeneratedKeys();
            if(resultSet.next()){
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating order detail failed, no ID obtained.");
            }
        } catch(SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, "Error inserting order detail", ex);
            return -1;
        } finally {
            closeResources();
        }
    }
    
    /**
     * Lấy chi tiết đơn hàng theo order_id.
     */
    public List<OrderDetails> getByOrderId(int orderId) {
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        String sql = "SELECT * FROM orderdetails WHERE OrderID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                orderDetailsList.add(getFromResultSet(resultSet));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, "Error getting order details by order ID", ex);
        } finally {
            closeResources();
        }
        
        return orderDetailsList;
    }
    
    /**
     * Chuyển đổi dữ liệu từ ResultSet thành đối tượng OrderDetails.
     */
    public OrderDetails getFromResultSet(ResultSet rs) throws SQLException {
        OrderDetails orderDetails = OrderDetails.builder()
                .orderDetailID(rs.getInt("OrderDetailID"))
                .productID(rs.getInt("ProductID"))
                .orderID(rs.getInt("OrderID"))
                .quantity(rs.getInt("Quantity"))
                .price(rs.getInt("Price"))
                .variationID(rs.getInt("VariationID"))
                .build();
        
        // Attempt to get order_date if it exists in the result set
        try {
            Date orderDate = rs.getDate("order_date");
            if (orderDate != null) {
                orderDetails.setOrderDate(orderDate);
            }
        } catch (SQLException ex) {
            // Column might not exist, ignore
        }
        
        return orderDetails;
    }
} 