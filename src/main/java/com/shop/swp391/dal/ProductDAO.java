package com.shop.swp391.dal; 

import com.shop.swp391.entity.Color;
import com.shop.swp391.entity.Product;
import com.shop.swp391.entity.Size;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hung
 */
public class ProductDAO extends DBContext implements I_DAO<Product> {

    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE status = 1";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                products.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return products;
    }

    @Override
    public boolean update(Product product) {
        String sql = "UPDATE product SET CategoryID = ?, ProductName = ?, Price = ?, CollectionID = ?, description = ?, status = ? WHERE ProductID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, product.getCategoryID());
            statement.setString(2, product.getProductName());
            statement.setDouble(3, product.getPrice());
            statement.setInt(4, product.getCollectionID());
            statement.setString(5, product.getDescription());
            statement.setInt(6, product.getStatus());
            statement.setInt(7, product.getProductID());
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public boolean delete(Product product) {
        String sql = "DELETE FROM product WHERE ProductID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, product.getProductID());
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public int insert(Product product) {
        String sql = "INSERT INTO product (CategoryID, ProductName, Price, CollectionID, description, status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setInt(1, product.getCategoryID());
            statement.setString(2, product.getProductName());
            statement.setDouble(3, product.getPrice());
            statement.setInt(4, product.getCollectionID());
            statement.setString(5, product.getDescription());
            statement.setInt(6, product.getStatus());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                return 0;
            }
            
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    return 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        } finally {
            closeResources();
        }
    }

    @Override
    public Product getFromResultSet(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductID(rs.getInt("ProductID"));
        product.setCategoryID(rs.getInt("CategoryID"));
        product.setProductName(rs.getString("ProductName"));
        product.setPrice(rs.getDouble("Price"));
        product.setCollectionID(rs.getInt("CollectionID"));
        product.setDescription(rs.getString("description"));
        product.setStatus(rs.getInt("status"));
        return product;
    }

    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT * FROM product WHERE ProductID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                product = getFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return product;
    }

    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM product";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    public List<Product> searchWithPagination(String keyword, int pageNumber, int pageSize) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE productName LIKE ? LIMIT ? OFFSET ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            statement.setInt(2, pageSize);
            statement.setInt(3, (pageNumber - 1) * pageSize);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                products.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("Error in searchWithPagination: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return products;
    }

    public int countSearchResults(String keyword) {
        String sql = "SELECT COUNT(*) FROM Product WHERE productName LIKE ?";
        int count = 0;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println("Error in countSearchResults: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return count;
    }
    public List<Product> findFilteredProducts(Integer categoryId, Integer collectionId, Double minPrice, Double maxPrice, int page, int pageSize) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM product WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null) {
            sql.append(" AND CategoryID = ?");
            params.add(categoryId);
        }
        
        if (collectionId != null) {
            sql.append(" AND CollectionID = ?");
            params.add(collectionId);
        }
        
        if (minPrice != null) {
            sql.append(" AND Price >= ?");
            params.add(minPrice);
        }
        
        if (maxPrice != null) {
            sql.append(" AND Price <= ?");
            params.add(maxPrice);
        }
        
        sql.append(" ORDER BY ProductID LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                products.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return products;
    }

    public int getTotalFilteredProducts(Integer categoryId, Integer collectionId, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null) {
            sql.append(" AND CategoryID = ?");
            params.add(categoryId);
        }
        
        if (collectionId != null) {
            sql.append(" AND CollectionID = ?");
            params.add(collectionId);
        }
        
        if (minPrice != null) {
            sql.append(" AND Price >= ?");
            params.add(minPrice);
        }
        
        if (maxPrice != null) {
            sql.append(" AND Price <= ?");
            params.add(maxPrice);
        }
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return 0;
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
                Color color = new Color(resultSet.getInt("color_ID"), resultSet.getString("color_name"));
                colors.add(color);
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
                Size size = new Size(resultSet.getInt("size_ID"), resultSet.getString("size_name"));
                sizes.add(size);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return sizes;
    }

    public List<Product> findPagedProducts(int page, int pageSize, String sortBy, Double minPrice, Double maxPrice, Integer colorID) {
        List<Product> products = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT p.* FROM product p");
        if (colorID != null) {
            sql.append(" JOIN variation v ON p.ProductID = v.ProductID");
        }
        sql.append(" WHERE 1=1");
        if (minPrice != null) {
            sql.append(" AND p.Price >= ").append(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND p.Price <= ").append(maxPrice);
        }
        if (colorID != null) {
            sql.append(" AND v.color_ID = ").append(colorID);
        }
        sql.append(" GROUP BY p.ProductID");
        if (sortBy != null) {
            switch (sortBy) {
                case "name_asc":
                    sql.append(" ORDER BY p.ProductName ASC");
                    break;
                case "name_desc":
                    sql.append(" ORDER BY p.ProductName DESC");
                    break;
                case "price_asc":
                    sql.append(" ORDER BY p.Price ASC");
                    break;
                case "price_desc":
                    sql.append(" ORDER BY p.Price DESC");
                    break;
                default:
                    break;
            }
        }
        sql.append(" LIMIT ? OFFSET ?");
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            statement.setDouble(1, minPrice != null ? minPrice : 0.0);
            statement.setDouble(2, maxPrice != null ? maxPrice : 1000000.0);
            statement.setInt(1, pageSize);
            statement.setInt(2, offset);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                products.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching paged products", e);
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return products;
    }

    public int getTotalProductCount(Double minPrice, Double maxPrice, Integer colorID) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product p");

        if (colorID != null) {
            sql.append(" JOIN variation v ON p.ProductID = v.ProductID");
        }
        sql.append(" WHERE 1=1");

        if (minPrice != null) {
            sql.append(" AND p.Price >= ").append(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND p.Price <= ").append(maxPrice);
        }

        if (colorID != null) {
            sql.append(" AND v.color_ID = ").append(colorID);
        }
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching total product count", e);
        }
        return 0;
    }

    public List<Product> findWithFilters(String search, Integer categoryId, Integer collectionId,
                                       Double minPrice, Double maxPrice, Integer status) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM product WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.isEmpty()) {
            sql.append(" AND ProductName LIKE ?");
            params.add("%" + search + "%");
        }
        if (categoryId != null) {
            sql.append(" AND CategoryID = ?");
            params.add(categoryId);
        }
        if (collectionId != null) {
            sql.append(" AND CollectionID = ?");
            params.add(collectionId);
        }
        if (minPrice != null) {
            sql.append(" AND Price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND Price <= ?");
            params.add(maxPrice);
        }
        if (status != null) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());
            
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    statement.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    statement.setInt(i + 1, (Integer) param);
                } else if (param instanceof Double) {
                    statement.setDouble(i + 1, (Double) param);
                }
            }
            
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                products.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("Error in findWithFilters: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return products;
    }

    

}
