package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;

public interface CommunityMapper {
	
	public void insertCommunity(CommunityDTO dto) throws SQLException;
	public void updateCommunity(CommunityDTO dto) throws SQLException;
	public void deleteCommunity(Long community_id) throws SQLException;
	
	public void joinCommunity(Long community_id, Long user_num) throws SQLException;
	public void leaveCommunity(Long community_id, Long user_num) throws SQLException;
	public void addFavorite(Long community_id, Long user_num) throws SQLException;
	public void removeFavorite(Long community_id, Long user_num) throws SQLException;
	
	public CommunityDTO findById(Long community_id) throws SQLException;
	public CommunityDTO findByName(String com_name) throws SQLException;
	public List<CommunityDTO> selectAll(Map<String, Object> map);
	
	public List<CommunityDTO> searchCommunity(Map<String, Object> map);
}
