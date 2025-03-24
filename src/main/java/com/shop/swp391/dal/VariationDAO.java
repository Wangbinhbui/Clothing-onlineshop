/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.entity.Color;
import com.shop.swp391.entity.Size;
import com.shop.swp391.entity.Variation;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

/**
 *
 * @author hung
 */
public class VariationDAO extends DBContext implements I_DAO<Variation> {

    @Override
    public List<Variation> findAll() {
        List<Variation> variations = new ArrayList<>();
        String sql = "SELECT * FROM variation";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                variations.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return variations;
    }

    @Override
    public boolean update(Variation t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean delete(Variation t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int insert(Variation variation) {
        String sql = "INSERT INTO variation (ProductID, color_ID, size_ID, qty_in_stock, product_img_ID) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setInt(1, variation.getProductID());
            statement.setInt(2, variation.getColorID());
            statement.setInt(3, variation.getSizeID());
            statement.setInt(4, variation.getQtyInStock());
            statement.setInt(5, variation.getProductImgID());
            
            int affectedRows = statement.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Return generated variation ID
                    }
                }
            }
            return -1;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            closeResources();
        }
    }

    @Override
    public Variation getFromResultSet(ResultSet rs) throws SQLException {
        return new Variation(
                rs.getInt("VariationID"),
                rs.getInt("ProductID"),
                rs.getInt("color_ID"),
                rs.getInt("size_ID"),
                rs.getInt("qty_in_stock"),
                rs.getInt("product_img_ID")
        );
    }

    public List<Color> getAvailableColors(int productId) {
        List<Color> colors = new ArrayList<>();
        String sql = "SELECT DISTINCT c.color_ID, c.color_name FROM variation v "
                + "JOIN color c ON v.color_ID = c.color_ID "
                + "WHERE v.ProductID = ?";

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                colors.add(new Color(resultSet.getInt("color_ID"), resultSet.getString("color_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return colors;
    }

    public List<Size> getAvailableSizes(int productId) {
        List<Size> sizes = new ArrayList<>();
        String sql = "SELECT DISTINCT s.size_ID, s.size_name FROM variation v "
                + "JOIN size s ON v.size_ID = s.size_ID "
                + "WHERE v.ProductID = ?";

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                sizes.add(new Size(resultSet.getInt("size_ID"), resultSet.getString("size_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return sizes;
    }

    public Variation findById(int variationId) {
        Variation variation = null;
        String sql = "SELECT * FROM variation WHERE variationID = ?";
        try {
            connection = new DBContext().connection;
            statement = connection.prepareStatement(sql);
            statement.setInt(1, variationId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                variation = new Variation(
                    resultSet.getInt("variationID"),
                    resultSet.getInt("ProductID"),
                    resultSet.getInt("color_ID"),
                    resultSet.getInt("size_ID"),
                    resultSet.getInt("qty_in_stock"),
                    resultSet.getInt("product_img_ID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return variation;
    }

    public Variation findByColorIdAndSizeId(int colorId, int sizeId) {
        Variation variation = null;
        String sql = "SELECT * FROM variation WHERE color_ID = ? AND size_ID = ?";
        try {
            connection = new DBContext().connection;
            statement = connection.prepareStatement(sql);
            statement.setInt(1, colorId);
            statement.setInt(2, sizeId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                variation = new Variation(
                    resultSet.getInt("variationID"),
                    resultSet.getInt("ProductID"),
                    resultSet.getInt("color_ID"),
                    resultSet.getInt("size_ID"),
                    resultSet.getInt("qty_in_stock"),
                    resultSet.getInt("product_img_ID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return variation;
    }

    public boolean addVariation(int productId, int colorId, int sizeId, int quantity) {
        String sql = "INSERT INTO variation (ProductID, color_ID, size_ID, qty_in_stock) VALUES (?, ?, ?, ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, colorId);
            statement.setInt(3, sizeId);
            statement.setInt(4, quantity);
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    private boolean variationExists(int productId, int colorId, int sizeId) {
        String sql = "SELECT COUNT(*) FROM variation WHERE ProductID = ? AND color_ID = ? AND size_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, colorId);
            statement.setInt(3, sizeId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    private int getProductImgIdForColor(int productId, int colorId) {
        String sql = "SELECT DISTINCT product_img_ID FROM variation WHERE ProductID = ? AND color_ID = ? LIMIT 1";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, colorId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("product_img_ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return -1;
    }

    private int getDefaultProductImgId(int productId) {
        String sql = "SELECT DISTINCT product_img_ID FROM variation WHERE ProductID = ? LIMIT 1";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("product_img_ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        // If no product image exists, return a default value
        return 1;
    }

    public boolean removeVariationsByColor(int productId, int colorId) {
        // Check if this color is used in any orders
        if (isColorUsedInOrders(productId, colorId)) {
            return false;
        }
        
        String sql = "DELETE FROM variation WHERE ProductID = ? AND color_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, colorId);
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    public boolean removeVariationsBySize(int productId, int sizeId) {
        // Check if this size is used in any orders
        if (isSizeUsedInOrders(productId, sizeId)) {
            return false;
        }
        
        String sql = "DELETE FROM variation WHERE ProductID = ? AND size_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, sizeId);
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    private boolean isColorUsedInOrders(int productId, int colorId) {
        String sql = "SELECT COUNT(*) FROM orderdetails od " +
                     "JOIN variation v ON od.VariationID = v.VariationID " +
                     "WHERE v.ProductID = ? AND v.color_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, colorId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    private boolean isSizeUsedInOrders(int productId, int sizeId) {
        String sql = "SELECT COUNT(*) FROM orderdetails od " +
                     "JOIN variation v ON od.VariationID = v.VariationID " +
                     "WHERE v.ProductID = ? AND v.size_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, sizeId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    // NEW: Tìm kiếm và phân trang variation với bộ lọc search, color và size
    public List<Variation> findBySearchAndPaging(String search, String color, String size, int offset, int limit) {
        List<Variation> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM variation WHERE 1=1");
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (CAST(VariationID AS CHAR) LIKE ? OR CAST(ProductID AS CHAR) LIKE ?)");
        }
        if (color != null && !color.trim().isEmpty()) {
            sql.append(" AND color_ID = ?");
        }
        if (size != null && !size.trim().isEmpty()) {
            sql.append(" AND size_ID = ?");
        }
        sql.append(" LIMIT ? OFFSET ?");
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                String pattern = "%" + search.trim() + "%";
                statement.setString(index++, pattern);
                statement.setString(index++, pattern);
            }
            if (color != null && !color.trim().isEmpty()) {
                statement.setInt(index++, Integer.parseInt(color));
            }
            if (size != null && !size.trim().isEmpty()) {
                statement.setInt(index++, Integer.parseInt(size));
            }
            statement.setInt(index++, limit);
            statement.setInt(index++, offset);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }
    
    // NEW: Đếm tổng số variation theo search, color và size
    public int getTotalVariationsCount(String search, String color, String size) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM variation WHERE 1=1");
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (CAST(VariationID AS CHAR) LIKE ? OR CAST(ProductID AS CHAR) LIKE ?)");
        }
        if (color != null && !color.trim().isEmpty()) {
            sql.append(" AND color_ID = ?");
        }
        if (size != null && !size.trim().isEmpty()) {
            sql.append(" AND size_ID = ?");
        }
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                String pattern = "%" + search.trim() + "%";
                statement.setString(index++, pattern);
                statement.setString(index++, pattern);
            }
            if (color != null && !color.trim().isEmpty()) {
                statement.setInt(index++, Integer.parseInt(color));
            }
            if (size != null && !size.trim().isEmpty()) {
                statement.setInt(index++, Integer.parseInt(size));
            }
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return count;
    }
    
    // NEW: Lấy tên màu theo color_ID
    public String getColorNameById(int colorId) {
        String colorName = "";
        String sql = "SELECT color_name FROM color WHERE color_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, colorId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                colorName = resultSet.getString("color_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return colorName;
    }
    
    // NEW: Lấy tên kích cỡ theo size_ID
    public String getSizeNameById(int sizeId) {
        String sizeName = "";
        String sql = "SELECT size_name FROM size WHERE size_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, sizeId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                sizeName = resultSet.getString("size_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return sizeName;
    }
    
    // NEW: Lấy đường dẫn thumbnail theo product_img_ID
    public String getThumbnailById(int productImgId) {
        String thumbnail = "";
        String sql = "SELECT thumbnail FROM product_img WHERE product_img_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productImgId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                thumbnail = resultSet.getString("thumbnail");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return thumbnail;
    }

    public String getProductNamebyId(int productID) {
        ProductDAO pDAO = new ProductDAO();
        return pDAO.getProductById(productID).getProductName();
    }
}
