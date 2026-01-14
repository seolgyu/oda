package com.hs.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.PostDTO;

public interface SettingService {
	
	public List<PostDTO> listLikedPost(Map<String, Object> map) throws SQLException;
	public int totalCountLikedPost(Long userNum) throws SQLException;
}