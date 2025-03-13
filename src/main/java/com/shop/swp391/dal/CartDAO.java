package com.shop.swp391.dal;

import com.shop.swp391.entity.Cart;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.sql.PreparedStatement;
public class CartDAO extends DBContext implements I_DAO<Cart> {

   public Cart findByUserId(int userId) {
       String sql = "SELECT * FROM cart WHERE user_id = ?";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           statement.setInt(1, userId);
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

   @Override
   public List<Cart> findAll() {
       // ... existing code similar to other DAOs ...
       return null;
   }

   @Override
   public boolean update(Cart cart) {
       String sql = "UPDATE cart SET user_id = ? WHERE cart_id = ?";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql);
           statement.setInt(1, cart.getUserId());
           statement.setInt(2, cart.getCartId());
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
   public boolean delete(Cart cart) {
       // ... existing code similar to other DAOs ...
       return false;
   }

   @Override
   public int insert(Cart cart) {
       String sql = "INSERT INTO cart (user_id) VALUES (?)";
       try {
           connection = getConnection();
           statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
           statement.setInt(1, cart.getUserId());
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
   public Cart getFromResultSet(ResultSet rs) throws SQLException {
       Cart cart = new Cart();
       cart.setCartId(rs.getInt("cart_id"));
       cart.setUserId(rs.getInt("user_id"));
       return cart;
   }
}