package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.MemberMapper;
import com.hs.model.admin.MainDTO;
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
	
	@Override
	public int updateMemberStatus(Map<String, Object> map) throws Exception {
	    int result = 0;
	    
	    try {
	        result = mapper.updateMemberStatus(map);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
	    return result;
	}

	@Override
	public MemberDTO memberInfo(Map<String, Object> map) {
		MemberDTO memberDto = null;
		try {
			memberDto = mapper.memberInfo(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberDto;
	}

}
