package com.hs.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.FollowDTO;

public interface FollowService {
	public void followApply(Map<String, Object> map) throws SQLException;
	public void followDelApply(Map<String, Object> map) throws SQLException;
	public int followCount(Map<String, Object> map) throws SQLException;
	
	public int followerCount(Long userNum) throws SQLException;
	public int followingCount(Long userNum) throws SQLException;
	
	public List<FollowDTO> getUserFollowList(Map<String, Object> map) throws SQLException;
}
