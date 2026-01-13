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
	
	// 내 정보 수정 페이지에서 사용
	public void updateMember(Map<String, Object> map) throws SQLException;
	
	public void insertMember2(MemberDTO dto) throws SQLException;
	public void insertMember12(MemberDTO dto) throws SQLException;
	public void updateMember1(MemberDTO dto) throws SQLException;
	public void updateMember2(MemberDTO dto) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	public void deleteProfilePhoto(Map<String, Object> map) throws SQLException;
	public void deleteMember1(Map<String, Object> map) throws SQLException;
	public void deleteMember2(Map<String, Object> map) throws SQLException;
	
	public void updatePwd(Map<String, Object> map) throws SQLException;
	public void updateLastLoginDate(Long userNum) throws SQLException;
	
	public void updateProfile(Map<String, Object> map) throws SQLException;
	public void updateBanner(Map<String, Object> map) throws SQLException;
	
	public MemberDTO findById(String userId) throws SQLException;
	public MemberDTO findByIdx(Long userNum) throws SQLException;
	
	public int checkId(String userId) throws SQLException;
	public int checkNickname(String userId) throws SQLException;
	
	public String findId(Map<String, Object> map) throws SQLException;
	public Long findUserNum(Map<String, Object> map) throws SQLException;
	
	public List<Map<String, Object>> listAgeSection();
}
