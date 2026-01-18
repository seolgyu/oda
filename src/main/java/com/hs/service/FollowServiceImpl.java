package com.hs.service;

import java.sql.SQLException;
import java.util.Map;

import com.hs.mapper.FollowMapper;
import com.hs.mybatis.support.MapperContainer;

public class FollowServiceImpl implements FollowService {
	private FollowMapper mapper = MapperContainer.get(FollowMapper.class);

	@Override
	public void followApply(Map<String, Object> map) throws SQLException {
	    try {
	        mapper.followApply(map);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
}
