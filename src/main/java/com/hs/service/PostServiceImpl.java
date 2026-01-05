package com.hs.service;

import java.util.List;

import com.hs.mapper.PostMapper;
import com.hs.model.PostDTO;
import com.hs.mybatis.support.MapperContainer;

public class PostServiceImpl implements PostService {
	
	// MyBatis 매퍼 객체 가져오기 (Spring이 아니므로 Container 사용)
	private PostMapper mapper = MapperContainer.get(PostMapper.class);

	@Override
	public void insertPost(PostDTO dto) throws Exception {
		try {
			// 나중에 HTML 태그 제어(특수문자 변환) 등이 필요하면 여기서 처리
			
			// Mapper를 통해 DB에 저장
			mapper.insertPost(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e; // 에러를 Controller로 던져서 알림
		}
	}

	@Override
	public void updatePost(PostDTO dto) throws Exception {
		try {
			mapper.updatePost(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public PostDTO findById(long postId) {
		PostDTO dto = null;
		
		try {
			dto = mapper.findById(postId);
			
			// 만약 줄바꿈(\n)을 <br>로 바꿔서 보여줘야 한다면 
			// 여기서 dto.getContent()를 가공하면 됩니다.
			// (수정 폼에서는 원본 텍스트가 필요하므로 지금은 그대로 둡니다)
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public List<PostDTO> listPost() {
	    List<PostDTO> list = null;
	    try {
	        list = mapper.listPost();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}