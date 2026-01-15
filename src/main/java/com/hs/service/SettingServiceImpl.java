package com.hs.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.mapper.SettingMapper;
import com.hs.model.PostDTO;
import com.hs.mybatis.support.MapperContainer;

public class SettingServiceImpl implements SettingService {

	private SettingMapper mapper = MapperContainer.get(SettingMapper.class);

	@Override
	public List<PostDTO> listLikedPost(Map<String, Object> map) throws SQLException {
		List<PostDTO> list = null;
		
		try {
			list = mapper.listLikedPost(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int totalCountLikedPost(Long userNum) throws SQLException {
		try {
			return mapper.totalCountLikedPost(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public String getFilePath(Long postId) throws SQLException {
		String filePath = null;
		
		try {
			filePath = mapper.getFilePath(postId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return filePath;
	}


}