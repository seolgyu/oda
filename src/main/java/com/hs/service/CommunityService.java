package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.model.CommunityDTO;

public interface CommunityService {
	
	public void insertCommunity(CommunityDTO dto) throws Exception;
	public List<CommunityDTO> getCategoryList();
	public CommunityDTO findById(Map<String, Object> map);
	public CommunityDTO isCommunityName(String com_name);
	public void updateCommunity(CommunityDTO dto) throws Exception;
	public void deleteCommunity(Long community_id) throws Exception;
	
	public void checkJoinCommunity(Map<String, Object> map);
	public void joinCommunity(Map<String, Object> map) throws Exception;
	public void leaveCommunity(Map<String, Object> map) throws Exception;
	
	public String checkFavorite(Map<String, Object> map);
	public void addFavorite(Map<String, Object> map) throws Exception;
	public void removeFavorite(Map<String, Object> map) throws Exception;
	
	public List<CommunityDTO> managementList(Map<String, Object> map);
	public List<CommunityDTO> communityList(String keyword, String category_id);
	public List<CommunityDTO> getPopularCategoryList();
}
