package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.MemberDTO;

public interface MemberMapper {
	
	// 로그인
	public MemberDTO loginMember(Map<String, Object> map);
	public MemberDTO loginMember1(Map<String, Object> map);
	
	// 회원가입
	public void insertMember(MemberDTO dto) throws Exception;
	public void insertMember1(MemberDTO dto) throws SQLException;
	
	
	public void insertMember2(MemberDTO dto) throws SQLException;
	public void insertMember12(MemberDTO dto) throws SQLException;
	public void updateMember1(MemberDTO dto) throws SQLException;
	public void updateMember2(MemberDTO dto) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	public void deleteProfilePhoto(Map<String, Object> map) throws SQLException;
	public void deleteMember1(Map<String, Object> map) throws SQLException;
	public void deleteMember2(Map<String, Object> map) throws SQLException;
	
	public MemberDTO findById(String userId);
	public MemberDTO findByIdx(Long userIdx);
	public List<Map<String, Object>> listAgeSection();
}
