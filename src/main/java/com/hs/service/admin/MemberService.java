package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.MemberDTO;

public interface MemberService {
	public List<MemberDTO> memberList(Map<String, Object> map);
	public int  userCount(Map<String, Object> map);
}
