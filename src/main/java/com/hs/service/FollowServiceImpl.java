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

	@Override
	public int followCount(Map<String, Object> map) {
		int count = 0;
		try {
			count = mapper.followCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public void followDelApply(Map<String, Object> map) throws SQLException {
		 try {
		        mapper.followDelApply(map);
		    } catch (Exception e) {
		        e.printStackTrace();
		        throw e;
		    }
	}
}
