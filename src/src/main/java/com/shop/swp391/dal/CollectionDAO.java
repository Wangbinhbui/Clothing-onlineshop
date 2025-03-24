package com.shop.swp391.dal;

import com.shop.swp391.entity.Collection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class CollectionDAO extends DBContext implements I_DAO<Collection> {

    @Override
    public List<Collection> findAll() {
        List<Collection> collections = new ArrayList<>();
        String sql = "SELECT * FROM collection";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                collections.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return collections;
    }

    @Override
    public boolean update(Collection t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean delete(Collection t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int insert(Collection t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Collection getFromResultSet(ResultSet rs) throws SQLException {
        Collection collection = new Collection();
        collection.setCollectionID(rs.getInt("CollectionID"));
        collection.setCollectionName(rs.getString("CollectionName"));
        collection.setCollectionImg(rs.getString("collectionImg"));
        collection.setCollectionDescription(rs.getString("collection_description"));
        collection.setCreateDate(rs.getDate("create_date"));
        collection.setPromotionID(rs.getInt("PromotionID"));
        return collection;
    }
    
    public Collection findById(int id) {
        Collection collection = null;
        String sql = "SELECT * FROM collection WHERE CollectionID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                collection = getFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return collection;
    }
} 