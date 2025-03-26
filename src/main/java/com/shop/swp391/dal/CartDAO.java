package com.shop.swp391.dal;

import com.shop.swp391.entity.Cart;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.ArrayList;

public class CartDAO extends DBContext implements I_DAO<Cart> {

    /**
     * Lấy giỏ hàng theo userId.
     */
    public Cart findByUserId(int userId) {
        String sql = "SELECT * FROM cart WHERE userId = ?";
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

    /**
     * Alias method: Lấy giỏ hàng của người dùng theo userId.
     */
    public Cart getByUserID(int userId) {
        return findByUserId(userId);
    }

    /**
     * Lấy danh sách tất cả các giỏ hàng.
     */
    @Override
    public List<Cart> findAll() {
        List<Cart> carts = new ArrayList<>();
        String sql = "SELECT * FROM cart";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                carts.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }
        return carts;
    }

    /**
     * Cập nhật thông tin của một giỏ hàng.
     */
    @Override
    public boolean update(Cart cart) {
        String sql = "UPDATE cart SET userId = ? WHERE cartId = ?";
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

    /**
     * Xóa một giỏ hàng.
     */
    @Override
    public boolean delete(Cart cart) {
        String sql = "DELETE FROM cart WHERE cartId = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, cart.getCartId());
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
     * Thêm mới 1 giỏ hàng, trả về id được tạo (hoặc -1 nếu thất bại).
     */
    @Override
    public int insert(Cart cart) {
        String sql = "INSERT INTO cart (userId) VALUES (?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            statement.setInt(1, cart.getUserId());
            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating cart failed, no rows affected.");
            }
            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating cart failed, no ID obtained.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }
        return -1;
    }

    /**
     * Chuyển đổi dữ liệu từ ResultSet thành đối tượng Cart.
     */
    @Override
    public Cart getFromResultSet(ResultSet rs) throws SQLException {
        Cart cart = new Cart();
        cart.setCartId(rs.getInt("cartId"));
        cart.setUserId(rs.getInt("userId"));
        return cart;
    }

    /**
     * Tìm kiếm một giỏ hàng theo cartId.
     */
    public Cart findById(int cartId) {
        String sql = "SELECT * FROM cart WHERE cartId = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, cartId);
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