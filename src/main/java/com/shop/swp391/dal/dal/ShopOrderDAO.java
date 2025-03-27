package com.shop.swp391.dal;

import com.shop.swp391.entity.ShopOrder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ShopOrderDAO extends DBContext {
    
    // Use 6 as the cancelled status value to align with the UI (see order-history.jsp)
    // Make sure that the order_status table contains a row with id = 6 for "Cancelled"
    private static final int CANCELLED_STATUS = 6;
    
    /**
     * Chèn đơn hàng mới vào bảng shop_order.
     * Lưu ý: Sử dụng tên cột trong database.
     *  - Tổng tiền: Order_total
     *  - Trạng thái: Order_status
     *  - SĐT người nhận: recipent_phone
     */
    public int insert(ShopOrder shopOrder) {
        String sql = "INSERT INTO shop_order (UserID, AddressID, Order_total, Order_status, recipient, recipent_phone) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setInt(1, shopOrder.getUserID());
            // Nếu AddressID null hoặc bằng 0 thì truyền NULL để tránh lỗi ngoại khóa
            if (shopOrder.getAddressID() != null && shopOrder.getAddressID() != 0) {
                statement.setInt(2, shopOrder.getAddressID());
            } else {
                statement.setNull(2, Types.INTEGER);
            }
            statement.setInt(3, shopOrder.getOrderTotal());
            statement.setInt(4, shopOrder.getOrderStatus());
            statement.setString(5, shopOrder.getRecipient());
            statement.setString(6, shopOrder.getRecipientPhone());
            
            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }
            
            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error inserting shop order", ex);
            return -1;
        } finally {
            closeResources();
        }
    }
    
    /**
     * Lấy danh sách đơn hàng theo userId.
     */
    public List<ShopOrder> getOrdersByUserId(int userId) {
        List<ShopOrder> orders = new ArrayList<>();
        String sql = "SELECT * FROM shop_order WHERE UserID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                orders.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error getting orders by user ID", ex);
        } finally {
            closeResources();
        }
        
        return orders;
    }
    
    /**
     * Lấy danh sách đơn hàng theo userId với phân trang và lọc theo trạng thái.
     */
    public List<ShopOrder> getOrdersByUserIdWithPagination(int userId, String statusFilter, int page, int pageSize) {
        List<ShopOrder> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM shop_order WHERE UserID = ?");
        
        // Add status filter if provided
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND Order_status = ?");
        }
        
        // Add ordering and pagination
        sql.append(" ORDER BY shop_orderID DESC LIMIT ? OFFSET ?");
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            statement.setInt(paramIndex++, userId);
            
            if (statusFilter != null && !statusFilter.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(statusFilter));
            }
            
            statement.setInt(paramIndex++, pageSize);
            statement.setInt(paramIndex++, (page - 1) * pageSize);
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                orders.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error getting orders by user ID with pagination", ex);
        } finally {
            closeResources();
        }
        
        return orders;
    }
    
    /**
     * Lấy tổng số đơn hàng của một người dùng (có thể lọc theo trạng thái).
     */
    public int getTotalOrdersByUserId(int userId, String statusFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM shop_order WHERE UserID = ?");
        
        // Add status filter if provided
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND Order_status = ?");
        }
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            statement.setInt(paramIndex++, userId);
            
            if (statusFilter != null && !statusFilter.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(statusFilter));
            }
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error getting total orders by user ID", ex);
        } finally {
            closeResources();
        }
        
        return 0;
    }
    
    /**
     * Lấy đơn hàng theo shop_orderID.
     */
    public ShopOrder getById(int orderId) {
        String sql = "SELECT * FROM shop_order WHERE shop_orderID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error getting order by ID", ex);
        } finally {
            closeResources();
        }
        
        return null;
    }
    
    /**
     * Hủy đơn hàng. Chỉ hủy được đơn hàng có trạng thái Pending (1).
     * Nếu hủy thành công, Order_status sẽ được cập nhật thành CANCELLED_STATUS.
     */
    public boolean cancelOrder(int orderId) {
        String sql = "UPDATE shop_order SET Order_status = ? WHERE shop_orderID = ? AND Order_status = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            // Set the order status to CANCELLED_STATUS (0) instead of an invalid value.
            statement.setInt(1, CANCELLED_STATUS);
            statement.setInt(2, orderId);
            // Only cancel orders that are in Pending state (1)
            statement.setInt(3, 1);
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error cancelling order", ex);
            return false;
        } finally {
            closeResources();
        }
    }
    
    /**
     * Chuyển đổi dữ liệu từ ResultSet thành đối tượng ShopOrder.
     * Lưu ý: Tên cột trong database phải khớp với tên cột được sử dụng ở đây.
     */
    public ShopOrder getFromResultSet(ResultSet rs) throws SQLException {
        return ShopOrder.builder()
                .shopOrderID(rs.getInt("shop_orderID"))
                .userID(rs.getInt("UserID"))
                .addressID(rs.getInt("AddressID"))
                .orderTotal(rs.getInt("Order_total"))
                .orderStatus(rs.getInt("Order_status"))
                .recipient(rs.getString("recipient"))
                .recipientPhone(rs.getString("recipent_phone"))
                .build();
    }

    /**
     * Get all orders with pagination and multiple filters for admin.
     */
    public List<ShopOrder> getAllOrdersWithPagination(String statusFilter, String userIdFilter, String searchQuery, int page, int pageSize) {
        List<ShopOrder> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM shop_order WHERE 1=1");
        
        // Add filters if provided
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND Order_status = ?");
        }
        
        if (userIdFilter != null && !userIdFilter.isEmpty()) {
            sql.append(" AND UserID = ?");
        }
        
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND (shop_orderID LIKE ? OR recipient LIKE ? OR recipent_phone LIKE ?)");
        }
        
        // Add ordering and pagination
        sql.append(" ORDER BY shop_orderID DESC LIMIT ? OFFSET ?");
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            
            if (statusFilter != null && !statusFilter.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(statusFilter));
            }
            
            if (userIdFilter != null && !userIdFilter.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(userIdFilter));
            }
            
            if (searchQuery != null && !searchQuery.isEmpty()) {
                String searchPattern = "%" + searchQuery + "%";
                statement.setString(paramIndex++, searchPattern);
                statement.setString(paramIndex++, searchPattern);
                statement.setString(paramIndex++, searchPattern);
            }
            
            statement.setInt(paramIndex++, pageSize);
            statement.setInt(paramIndex++, (page - 1) * pageSize);
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                orders.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error getting all orders with pagination", ex);
        } finally {
            closeResources();
        }
        
        return orders;
    }

    /**
     * Get total number of orders for admin with filters.
     */
    public int getTotalOrders(String statusFilter, String userIdFilter, String searchQuery) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM shop_order WHERE 1=1");
        
        // Add filters if provided
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND Order_status = ?");
        }
        
        if (userIdFilter != null && !userIdFilter.isEmpty()) {
            sql.append(" AND UserID = ?");
        }
        
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND (shop_orderID LIKE ? OR recipient LIKE ? OR recipent_phone LIKE ?)");
        }
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            
            if (statusFilter != null && !statusFilter.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(statusFilter));
            }
            
            if (userIdFilter != null && !userIdFilter.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(userIdFilter));
            }
            
            if (searchQuery != null && !searchQuery.isEmpty()) {
                String searchPattern = "%" + searchQuery + "%";
                statement.setString(paramIndex++, searchPattern);
                statement.setString(paramIndex++, searchPattern);
                statement.setString(paramIndex++, searchPattern);
            }
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error getting total orders count", ex);
        } finally {
            closeResources();
        }
        
        return 0;
    }

    /**
     * Update order status by admin.
     */
    public boolean updateOrderStatus(int orderId, int status) {
        String sql = "UPDATE shop_order SET Order_status = ? WHERE shop_orderID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, status);
            statement.setInt(2, orderId);
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(ShopOrderDAO.class.getName()).log(Level.SEVERE, "Error updating order status", ex);
            return false;
        } finally {
            closeResources();
        }
    }
} 