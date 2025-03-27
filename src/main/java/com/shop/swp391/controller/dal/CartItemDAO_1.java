package com.shop.swp391.dal;

import com.shop.swp391.entity.CartItem;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;

public class CartItemDAO extends DBContext implements I_DAO<CartItem> {

    /**
     * Lấy danh sách CartItem theo CartID
     */
    public List<CartItem> findByCartId(int cartId) {
       List<CartItem> items = new ArrayList<>();
       String sql = "SELECT * FROM cart_item WHERE CartID = ?";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           statement.setInt(1, cartId);
           resultSet = statement.executeQuery();
           while (resultSet.next()) {
               items.add(getFromResultSet(resultSet));
           }
       } catch (SQLException ex) {
           ex.printStackTrace();
       } finally {
           closeResources();
       }
       return items;
    }

    /**
     * Cập nhật số lượng cho 1 cart item
     */
    public boolean updateQuantity(int cartItemId, int quantity) {
       String sql = "UPDATE cart_item SET Quantity = ? WHERE cart_itemID = ?";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           statement.setInt(1, quantity);
           statement.setInt(2, cartItemId);
           int affectedRows = statement.executeUpdate();
           return affectedRows > 0;
       } catch (SQLException ex) {
           ex.printStackTrace();
           return false;
       } finally {
           closeResources();
       }
    }

    /**
     * Lấy toàn bộ các CartItem có trong bảng cart_item
     */
    @Override
    public List<CartItem> findAll() {
       List<CartItem> items = new ArrayList<>();
       String sql = "SELECT * FROM cart_item";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           resultSet = statement.executeQuery();
           while(resultSet.next()){
               items.add(getFromResultSet(resultSet));
           }
       } catch (SQLException ex) {
           ex.printStackTrace();
       } finally {
           closeResources();
       }
       return items;
    }

    /**
     * Cập nhật thông tin của một CartItem
     */
    @Override
    public boolean update(CartItem item) {
       String sql = "UPDATE cart_item SET CartID = ?, ProductID = ?, Quantity = ?, VariationID = ? WHERE cart_itemID = ?";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           statement.setInt(1, item.getCartId());
           statement.setInt(2, item.getProductId());
           statement.setInt(3, item.getQuantity());
           statement.setInt(4, item.getVariationId());
           statement.setInt(5, item.getCartItemId());
           int affectedRows = statement.executeUpdate();
           return affectedRows > 0;
       } catch (SQLException ex) {
           ex.printStackTrace();
           return false;
       } finally {
           closeResources();
       }
    }

    /**
     * Xóa một CartItem
     */
    @Override
    public boolean delete(CartItem item) {
       String sql = "DELETE FROM cart_item WHERE cart_itemID = ?";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           statement.setInt(1, item.getCartItemId());
           int affectedRows = statement.executeUpdate();
           return affectedRows > 0;
       } catch (SQLException ex) {
           ex.printStackTrace();
           return false;
       } finally {
           closeResources();
       }
    }

    /**
     * Thêm mới 1 CartItem, trả về id được tạo (hoặc -1 nếu thất bại)
     */
    @Override
    public int insert(CartItem item) {
       String sql = "INSERT INTO cart_item (CartID, ProductID, Quantity, VariationID) VALUES (?, ?, ?, ?)";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
           statement.setInt(1, item.getCartId());
           statement.setInt(2, item.getProductId());
           statement.setInt(3, item.getQuantity());
           statement.setInt(4, item.getVariationId());
           int affectedRows = statement.executeUpdate();
           if (affectedRows == 0) {
              throw new SQLException("Inserting cart item failed, no rows affected.");
           }
           resultSet = statement.getGeneratedKeys();
           if (resultSet.next()) {
               return resultSet.getInt(1);
           } else {
               throw new SQLException("Inserting cart item failed, no ID obtained.");
           }
       } catch (SQLException ex) {
           ex.printStackTrace();
       } finally {
           closeResources();
       }
       return -1;
    }

    /**
     * Chuyển đổi dữ liệu từ ResultSet thành đối tượng CartItem
     */
    @Override
    public CartItem getFromResultSet(ResultSet rs) throws SQLException {
       CartItem item = new CartItem();
       item.setCartItemId(rs.getInt("cart_itemID"));
       item.setCartId(rs.getInt("CartID"));
       item.setProductId(rs.getInt("ProductID"));
       item.setQuantity(rs.getInt("Quantity"));
       item.setVariationId(rs.getInt("VariationID"));
       return item;
    }

    /**
     * Tìm kiếm 1 CartItem theo cart_itemID
     */
    public CartItem findById(int cartItemId) {
       String sql = "SELECT * FROM cart_item WHERE cart_itemID = ?";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           statement.setInt(1, cartItemId);
           resultSet = statement.executeQuery();
           if (resultSet.next()) {
               return getFromResultSet(resultSet);
           }
       } catch (SQLException ex) {
           ex.printStackTrace();
       } finally {
           closeResources();
       }
       return null;
    }

    /**
     * Alias method: Lấy danh sách CartItem theo CartID.
     */
    public List<CartItem> getByCartId(int cartId) {
        return findByCartId(cartId);
    }

    /**
     * Xóa một CartItem theo ID (int).
     */
    public boolean delete(int cartItemId) {
        String sql = "DELETE FROM cart_item WHERE cart_itemID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, cartItemId);
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    /**
     * Alias method: Tìm kiếm một CartItem theo ID.
     */
    public CartItem getById(int cartItemId) {
        return findById(cartItemId);
    }
}