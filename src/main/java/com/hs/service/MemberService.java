package com.hs.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.MemberDTO;

public interface MemberService {
	public MemberDTO loginMember(Map<String, Object> map);
	
	public void insertMember(MemberDTO dto) throws Exception;
	public void updateMember(MemberDTO dto) throws Exception;	
	public void updateMemberLevel(Map<String, Object> map) throws Exception;
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception;
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public MemberDTO findById(String userId);
	public MemberDTO findByIdx(Long userIdx);
	
	public int checkId(String userId) throws SQLException;
	public int checkNickname(String userNickname) throws SQLException;
	
	public String findId(Map<String, Object> map) throws SQLException;
	public int isValidAccount(Map<String, Object> map) throws SQLException;
	
	public List<Map<String, Object>> listAgeSection();
}
