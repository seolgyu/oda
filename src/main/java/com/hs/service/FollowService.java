package com.hs.service;

import java.sql.SQLException;
import java.util.Map;

public interface FollowService {
	public void followApply(Map<String, Object> map) throws SQLException;
}
