package com.hs.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.mapper.SettingMapper;
import com.hs.model.PostDTO;
import com.hs.model.ReplyDTO;
import com.hs.mybatis.support.MapperContainer;

public class SettingServiceImpl implements SettingService {

	private SettingMapper mapper = MapperContainer.get(SettingMapper.class);
	private PostService postService = new PostServiceImpl();

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
	public int totalCountMyComment(Long userNum) throws SQLException {
		try {
			return mapper.totalCountMyComment(userNum);
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

	@Override
	public List<ReplyDTO> getMyReply(Map<String, Object> map) throws SQLException {
		List<ReplyDTO> list = null;
		
		try {
			list = mapper.getMyReply(map);
			
			for(ReplyDTO dto : list) {
				dto.setItem(postService.findById(dto.getPostId()));
				dto.setParentThumbnail(getFilePath(dto.getPostId()));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<PostDTO> listSavedPost(Map<String, Object> map) throws SQLException {
		List<PostDTO> list = null;
		
		try {
			list = mapper.listSavedPost(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int totalCountSavedPost(Long userNum) throws SQLException {
		try {
			return mapper.totalCountSavedPost(userNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}


}