package com.hs.service;

import java.sql.SQLException;
import java.util.Map;

public interface FollowService {
	public void followApply(Map<String, Object> map) throws SQLException;
	public void followDelApply(Map<String, Object> map) throws SQLException;
	public int followCount(Map<String, Object> map);
}
