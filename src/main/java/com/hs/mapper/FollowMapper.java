package com.hs.mapper;

import java.sql.SQLException;
import java.util.Map;

public interface FollowMapper {
	public void followApply(Map<String, Object> map) throws SQLException;
	public int followCount(Map<String, Object> map);
	public void followDelApply(Map<String, Object> map) throws SQLException;
	
	public int followerCount(Long userNum) throws SQLException;
	public int followingCount(Long userNum) throws SQLException;
}
