package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;

public interface CommunityMapper {
	
	public void insertCommunity(CommunityDTO dto) throws SQLException;
	public void updateCommunity(CommunityDTO dto) throws SQLException;
	public void deleteCommunity(Map<String, Object> map) throws SQLException;
	public void deleteFavorites(Map<String, Object> map) throws SQLException;
	public void deleteFollow(Map<String, Object> map) throws SQLException;
	
	public int checkJoinCommunity(Map<String, Object> map);
	public void joinCommunity(Map<String, Object> map) throws SQLException;
	public void leaveCommunity(Map<String, Object> map) throws SQLException;
	
	public int checkFavorite(Map<String, Object> map);
	public void addFavorite(Map<String, Object> map) throws SQLException;
	public void removeFavorite(Map<String, Object> map) throws SQLException;
	
	public List<CommunityDTO> getCategoryList();
	public List<CommunityDTO> getPopularCategoryList();
	public CommunityDTO findById(Map<String, Object> map) throws SQLException;
	public CommunityDTO findByName(String com_name) throws SQLException;
	
	public List<CommunityDTO> selectManagementList(Map<String, Object> map);
	public List<CommunityDTO> selectCommunityList(Map<String, Object> map);
	
	public void memberAddCount(Map<String, Object> map) throws SQLException;
	public void memberRemoveCount(Map<String, Object> map) throws SQLException;
}
