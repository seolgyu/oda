package com.hs.mapper;

import java.sql.SQLException;
import java.util.Map;

public interface FollowMapper {
	public void followApply(Map<String, Object> map) throws SQLException;
}
