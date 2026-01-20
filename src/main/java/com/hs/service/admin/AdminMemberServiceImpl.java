package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.AdminMemberMapper;
import com.hs.model.admin.MemberDTO;
import com.hs.mybatis.support.MapperContainer;

public class AdminMemberServiceImpl implements AdminMemberService{
	private AdminMemberMapper mapper = MapperContainer.get(AdminMemberMapper.class);
	
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

	@Override
	public List<MemberDTO> selectWeeklyUser(Map<String, Object> map) {
		List<MemberDTO> selectWeeklyUser = null;
		
		try {
			selectWeeklyUser = mapper.selectWeeklyUser(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectWeeklyUser;
	}
	@Override
	public int updateMemberDetailStatus(Map<String, Object> map) {
	    int result = 0;
	    try {
	        result = mapper.updateMemberDetailStatus(map);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}

	@Override
	public int deleteMember(Map<String, Object> map) {
	    int result = 0;
	    try {
	        result = mapper.deleteMember(map);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}

}
