package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;

public interface CommunityMapper {
	
	public void insertCommunity(CommunityDTO dto) throws SQLException;
	public void selectById(Long communityId) throws SQLException;
	public void countByName(String name) throws SQLException;
	public void updateCommunity(CommunityDTO dto) throws SQLException;
	public void deleteCommunity(Long communityId) throws SQLException;
	
	public void joinCommunity(Long communityId, Long memberIdx) throws SQLException;
	public void leaveCommunity(Long communityId, Long memberIdx) throws SQLException;
	public void addFavorite(Long communityId, Long memberIdx) throws SQLException;
	public void removeFavorite(Long communityId, Long memberIdx) throws SQLException;
	
	public List<CommunityDTO> selectAll(Map<String, Object> map);
	
}
