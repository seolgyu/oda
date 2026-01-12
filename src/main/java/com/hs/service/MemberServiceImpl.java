package com.hs.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.mapper.MemberMapper;
import com.hs.model.MemberDTO;
import com.hs.mybatis.support.MapperContainer;

public class MemberServiceImpl implements MemberService {
	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);

	@Override
	public MemberDTO loginMember(Map<String, Object> map) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(MemberDTO dto) throws Exception {
		
		try {
			mapper.insertMember(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMember(MemberDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMemberLevel(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberDTO findById(String userId) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.findById(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public List<Map<String, Object>> listAgeSection() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberDTO findByIdx(Long userNum) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.findByIdx(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int checkId(String userId) throws SQLException {
		
		try {
			return mapper.checkId(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public int checkNickname(String userNickname) throws SQLException {
		
		try {
			return mapper.checkNickname(userNickname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public String findId(Map<String, Object> map) throws SQLException {
		String userId = null;
		
		try {
			userId = mapper.findId(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return userId;
	}

	@Override
	public Long findUserNum(Map<String, Object> map) throws SQLException {
		Long userNum = null;
		
		try {
			userNum = mapper.findUserNum(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return userNum;
	}

	@Override
	public void updatePwd(Map<String, Object> map) throws SQLException {
		try {
			mapper.updatePwd(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateLastLoginDate(Long userNum) throws SQLException {
		try {
			mapper.updateLastLoginDate(userNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
