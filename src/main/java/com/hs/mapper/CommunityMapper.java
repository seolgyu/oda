package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;

public interface CommunityMapper {
	
	public void insertCommunity(CommunityDTO dto) throws SQLException;
	public void updateCommunity(CommunityDTO dto) throws SQLException;
	public void deleteCommunity(Long community_id) throws SQLException;
	
	public void joinCommunity(Map<String, Object> map) throws SQLException;
	public void leaveCommunity(Map<String, Object> map) throws SQLException;
	public void addFavorite(Map<String, Object> map) throws SQLException;
	public void removeFavorite(Map<String, Object> map) throws SQLException;
	
	public CommunityDTO findById(Long community_id) throws SQLException;
	public CommunityDTO findByName(String com_name) throws SQLException;
	public List<CommunityDTO> selectAll(Map<String, Object> map);
	
	public List<CommunityDTO> searchCommunity(Map<String, Object> map);
}
