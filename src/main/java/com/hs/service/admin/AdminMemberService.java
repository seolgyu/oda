package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.MainDTO;
import com.hs.model.admin.MemberDTO;

public interface AdminMemberService {
	public List<MemberDTO> memberList(Map<String, Object> map);
	public int  userCount(Map<String, Object> map);
	public int updateMemberStatus(Map<String, Object> map) throws Exception;
	public MemberDTO memberInfo(Map<String, Object> map);
	public List<MemberDTO> selectWeeklyUser (Map<String, Object> map);
	public int updateMemberDetailStatus(Map<String, Object> map);
	public int deleteMember(Map<String, Object> map);
}
