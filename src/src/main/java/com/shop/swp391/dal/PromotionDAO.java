package com.shop.swp391.dal;

import com.shop.swp391.entity.Promotion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PromotionDAO extends DBContext implements I_DAO<Promotion> {

    public Promotion findByPromotionCode(String promotionCode) {
        String sql = "SELECT * FROM promotion WHERE promotion_name = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, promotionCode);
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
    public List<Promotion> findAll() {
        // ... existing code similar to other DAOs ...
        return null;
    }

    @Override
    public boolean update(Promotion promotion) {
        // ... implementation similar to other DAOs ...
        return false;
    }

    @Override
    public boolean delete(Promotion promotion) {
        // ... implementation similar to other DAOs ...
        return false;
    }

    @Override
    public int insert(Promotion promotion) {
        // ... implementation similar to other DAOs ...
        return -1;
    }

    @Override
    public Promotion getFromResultSet(ResultSet rs) throws SQLException {
        Promotion promotion = new Promotion();
        promotion.setPromotionId(rs.getInt("promotion_id"));
        promotion.setPromotionName(rs.getString("promotion_name"));
        promotion.setPromotionDescription(rs.getString("promotion_description"));
        promotion.setDiscountRate(rs.getDouble("discount_rate"));
        promotion.setStartDate(rs.getDate("start_date"));
        promotion.setEndDate(rs.getDate("end_date"));
        promotion.setBackgroundColor(rs.getString("background_color"));
        return promotion;
    }
}