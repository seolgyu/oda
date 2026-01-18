package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.NotificationOptionDTO;
import com.hs.model.PostDTO;
import com.hs.model.ReplyDTO;

public interface SettingMapper {
	
	public List<PostDTO> listLikedPost(Map<String, Object> map) throws SQLException;
	public int totalCountLikedPost(Long userNum) throws SQLException;
	
	public List<PostDTO> listSavedPost(Map<String, Object> map) throws SQLException;
	public int totalCountSavedPost(Long userNum) throws SQLException;
		
	public int totalCountMyComment(Long userNum) throws SQLException;
	public String getFilePath(Long postId) throws SQLException;
	public List<ReplyDTO> getMyReply(Map<String, Object> map) throws SQLException;
	
	public void updateNotiOption(Map<String, Object> map) throws SQLException;
	public NotificationOptionDTO getNotiOption(Long userNum) throws SQLException;

}
