package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.PostDTO;

public interface SettingMapper {
	
	public List<PostDTO> listLikedPost(Map<String, Object> map) throws SQLException;
	public int totalCountLikedPost(Long userNum) throws SQLException;

}
