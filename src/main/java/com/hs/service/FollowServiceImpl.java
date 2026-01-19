package com.hs.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.mapper.FollowMapper;
import com.hs.model.FollowDTO;
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
	public int followCount(Map<String, Object> map) throws SQLException{
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

	@Override
	public int followerCount(Long userNum) throws SQLException {
		try {
			return mapper.followerCount(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int followingCount(Long userNum) throws SQLException {
		try {
			return mapper.followingCount(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<FollowDTO> getUserFollowList(Map<String, Object> map) throws SQLException {
		List<FollowDTO> list = null;
		String type = (String) map.get("type");
		
		try {
			list = mapper.getUserFollowList(map);
			for(FollowDTO item : list) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("reqId", item.getReqId());
				Long loginUserNum = (Long) map.get("userNum"); 
	            
	            param.put("reqId", loginUserNum);

	            if ("follower".equals(type)) {
	                param.put("addId", item.getReqId()); 
	            } else {
	                param.put("addId", item.getAddId());
	            }
				item.setFollowStatus(followCount(param) > 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
