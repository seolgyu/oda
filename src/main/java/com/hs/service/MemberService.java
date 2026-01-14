package com.hs.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.MemberDTO;

public interface MemberService {
	public MemberDTO loginMember(Map<String, Object> map);
	
	public void insertMember(MemberDTO dto) throws Exception;
	
	public void insertLoginlog(Long userNum) throws SQLException;
	
	public void updateMember(Map<String, Object> map) throws SQLException;
	
	public void updateMemberLevel(Map<String, Object> map) throws Exception;
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception;
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public void updatePwd(Map<String, Object> map) throws SQLException;
	public void updateLastLoginDate(Long userNum) throws SQLException;
	
	public void updateProfile(Map<String, Object> map) throws SQLException;
	public void updateBanner(Map<String, Object> map) throws SQLException;
	
	public MemberDTO findById(String userId);
	public MemberDTO findByIdx(Long userNum);
	
	public int checkId(String userId) throws SQLException;
	public int checkNickname(String userNickname) throws SQLException;
	
	public String findId(Map<String, Object> map) throws SQLException;
	public Long findUserNum(Map<String, Object> map) throws SQLException;
	
	public List<Map<String, Object>> listAgeSection();
}
