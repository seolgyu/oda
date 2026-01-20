package com.hs.mapper.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.MemberDTO;

public interface AdminMemberMapper {
	public List<MemberDTO> memberList(Map<String, Object> map);
	public int userCount(Map<String, Object> map);
	public int updateMemberStatus(Map<String, Object> map);
	public MemberDTO memberInfo(Map<String, Object> map);
	public List<MemberDTO> selectWeeklyUser(Map<String, Object> map);
	public int updateMemberDetailStatus(Map<String, Object> map);
	public int deleteMember(Map<String, Object> map);
}
