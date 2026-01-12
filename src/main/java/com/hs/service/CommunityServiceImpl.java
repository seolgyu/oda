package com.hs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.mapper.CommunityMapper;
import com.hs.model.CommunityDTO;
import com.hs.mybatis.support.MapperContainer;

public class CommunityServiceImpl implements CommunityService{
	private CommunityMapper mapper = MapperContainer.get(CommunityMapper.class);
	
	@Override
	public void insertCommunity(CommunityDTO dto) throws Exception {
		try {
			mapper.insertCommunity(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public CommunityDTO findById(Map<String, Object> map) {
		CommunityDTO dto = null;
		try {
			dto = mapper.findById(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public List<CommunityDTO> getCategoryList() {
		List<CommunityDTO> list = null;
		try {
			list = mapper.getCategoryList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public CommunityDTO isCommunityName(String com_name) {
		CommunityDTO dto = null;
		try {
			dto = mapper.findByName(com_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateCommunity(CommunityDTO dto) throws Exception {
		try {
			mapper.updateCommunity(dto);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_id", dto.getCommunity_id());
			map.put("user_num", dto.getUser_num());
			dto = mapper.findById(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteCommunity(Long community_id) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void joinCommunity(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void leaveCommunity(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addFavorite(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeFavorite(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<CommunityDTO> searchCommunity(Map<String, Object> map) {
		List<CommunityDTO> list = null;
		try {
			list = mapper.searchCommunity(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void checkJoinCommunity(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String checkFavorite(Map<String, Object> map) {
		try {
			int result = mapper.checkFavorite(map);
			
			if(result > 0) {
				mapper.removeFavorite(map);
				return "removed";
			} else {
				mapper.addFavorite(map);
				return "added";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	
}
