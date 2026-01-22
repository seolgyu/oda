package com.hs.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.mapper.CommunityMapper;
import com.hs.model.CommunityDTO;
import com.hs.model.MemberDTO;
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
	public void deleteCommunity(Map<String, Object> map) throws Exception {
		try {
			mapper.deletePostsCommunity(map);
			mapper.deleteFavorites(map);
			mapper.deleteFollow(map);
			
			mapper.deleteCommunity(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public int checkJoinCommunity(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.checkJoinCommunity(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void joinCommunity(Map<String, Object> map) throws Exception {
		try {
			mapper.joinCommunity(map);
			mapper.memberAddCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void leaveCommunity(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteFavorites(map);
			mapper.leaveCommunity(map);
			mapper.memberRemoveCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
	
	@Override
	public void removeFavorite(Map<String, Object> map) {
		try {
			mapper.removeFavorite(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<CommunityDTO> managementList(Map<String, Object> map) {
		List<CommunityDTO> list = null;
		try {
			list = mapper.selectManagementList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<CommunityDTO> communityList(String keyword, String category_id, Long user_num) {
		List<CommunityDTO> list = null;
		try {
			Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("keyword", keyword);
			map.put("category_id", category_id);
			map.put("user_num", user_num);
			
			list = mapper.selectCommunityList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<CommunityDTO> getPopularCategoryList() {
		List<CommunityDTO> list = null;
		try {
			list = mapper.getPopularCategoryList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<CommunityDTO> getMyCommunity(Long userNum) throws SQLException {
		List<CommunityDTO> list = null;
		try {
			list = mapper.getMyCommunity(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateCommunityHitCount(Map<String, Object> map) throws Exception {
		try {
			mapper.updateCommunityHitCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public MemberDTO selectUserNum(Map<String, Object> map) {
		MemberDTO dto = null;
		try {
			dto = mapper.selectUserNum(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public CommunityDTO getCommunity(Long communityId) throws SQLException {
		CommunityDTO dto = null;
		try {
			dto = mapper.getCommunity(communityId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
}
