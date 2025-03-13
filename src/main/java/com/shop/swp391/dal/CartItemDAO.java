package com.shop.swp391.dal;

import com.shop.swp391.entity.CartItem;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;

public class CartItemDAO extends DBContext implements I_DAO<CartItem> {

   public List<CartItem> findByCartId(int cartId) {
       List<CartItem> items = new ArrayList<>();
       String sql = "SELECT * FROM cart_item WHERE cart_id = ?";
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

   public boolean updateQuantity(int cartItemId, int quantity) {
       String sql = "UPDATE cart_item SET quantity = ? WHERE cart_item_id = ?";
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

   @Override
   public List<CartItem> findAll() {
       // ... existing code similar to other DAOs ...
       return null;
   }

   @Override
   public boolean update(CartItem item) {
       // ... existing code similar to updateQuantity ...
       return false;
   }

   @Override
   public boolean delete(CartItem item) {
       String sql = "DELETE FROM cart_item WHERE cart_item_id = ?";
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

   @Override
   public int insert(CartItem item) {
       String sql = "INSERT INTO cart_item (cart_id, product_id, quantity, variation_id) VALUES (?, ?, ?, ?)";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
           statement.setInt(1, item.getCartId());
           statement.setInt(2, item.getProductId());
           statement.setInt(3, item.getQuantity());
           statement.setInt(4, item.getVariationId());
           statement.executeUpdate();
           
           ResultSet generatedKeys = statement.getGeneratedKeys();
           if (generatedKeys.next()) {
               return generatedKeys.getInt(1);
           }
       } catch (SQLException ex) {
           ex.printStackTrace();
       } finally {
           closeResources();
       }
       return -1;
   }

   @Override
   public CartItem getFromResultSet(ResultSet rs) throws SQLException {
       CartItem item = new CartItem();
       item.setCartItemId(rs.getInt("cart_item_id"));
       item.setCartId(rs.getInt("cart_id"));
       item.setProductId(rs.getInt("product_id"));
       item.setQuantity(rs.getInt("quantity"));
       item.setVariationId(rs.getInt("variation_id"));
       return item;
   }

   public CartItem findById(int cartItemId) {
       String sql = "SELECT * FROM cart_item WHERE cart_item_id = ?";
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
}