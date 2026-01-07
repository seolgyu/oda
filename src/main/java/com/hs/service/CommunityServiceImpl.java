package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.mapper.CommunityMapper;
import com.hs.model.CommunityDTO;
import com.hs.mybatis.support.MapperContainer;

public class CommunityServiceImpl implements CommunityService{
	private CommunityMapper mapper = MapperContainer.get(CommunityMapper.class);
	private MemberServiceImpl mservice = new MemberServiceImpl();
	
	@Override
	public void createCommunity(CommunityDTO dto) throws Exception {
		try {
			
			mapper.insertCommunity(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public CommunityDTO findById(Long community_id) {
		CommunityDTO dto = null;
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void isCommunityName(String com_name) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCommunity(CommunityDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCommunity(Long community_id) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void joinCommunity(Long community_id, Long user_num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void leaveCommunity(Long community_id, Long user_num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addFavorite(Long community_id, Long user_num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeFavorite(Long community_id, Long user_num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<CommunityDTO> searchCommunity(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
}
