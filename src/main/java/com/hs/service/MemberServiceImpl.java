package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.mapper.MemberMapper;
import com.hs.model.MemberDTO;
import com.hs.mybatis.support.MapperContainer;

public class MemberServiceImpl implements MemberService {
	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);

	@Override
	public MemberDTO loginMember(Map<String, Object> map) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(MemberDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMember(MemberDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMemberLevel(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberDTO findById(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, Object>> listAgeSection() {
		// TODO Auto-generated method stub
		return null;
	}

}
