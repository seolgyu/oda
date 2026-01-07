package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;

public interface CommunityService {
	
	public void createCommunity(CommunityDTO dto) throws Exception;
	public CommunityDTO findById(Long community_id);
	public void isCommunityName(String com_name);
	public void updateCommunity(CommunityDTO dto) throws Exception;
	public void deleteCommunity(Long community_id) throws Exception;
	
	public void joinCommunity(Long community_id, Long user_num) throws Exception;
	public void leaveCommunity(Long community_id, Long user_num) throws Exception;
	public void addFavorite(Long community_id, Long user_num) throws Exception;
	public void removeFavorite(Long community_id, Long user_num) throws Exception;
	
	public List<CommunityDTO> searchCommunity(Map<String, Object> map);
}
