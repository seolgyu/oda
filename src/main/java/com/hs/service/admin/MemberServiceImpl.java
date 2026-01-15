package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.MemberMapper;
import com.hs.model.admin.MemberDTO;
import com.hs.mybatis.support.MapperContainer;

public class MemberServiceImpl implements MemberService{
	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);
	
	@Override
	public List<MemberDTO> memberList(Map<String, Object> map) {
		List<MemberDTO> meberList = null;
		
		try {
			meberList = mapper.memberList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return meberList;
	}

	@Override
	public int userCount(Map<String, Object> map) {
		int countDto = 0;
		try {
			countDto = mapper.userCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countDto;
	}

}
