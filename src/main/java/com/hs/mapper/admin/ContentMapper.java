package com.hs.mapper.admin;

import java.util.List;
import java.util.Map;

import com.hs.model.admin.ContentDTO;

public interface ContentMapper {
	public int postAllCount();
	public int postNormalCount();
	public int postDeclaCount();
	public int postProCount();
	public int userCount(Map<String, Object> map);
	public List<ContentDTO> memberList(Map<String, Object> map);
	public int updateMemberStatus(Map<String, Object> map) throws Exception;
}
