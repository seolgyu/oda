package com.hs.service;

import java.util.List;

import com.hs.mapper.PostMapper;
import com.hs.model.FileAtDTO;
import com.hs.model.PostDTO;
import com.hs.mybatis.support.MapperContainer;

public class PostServiceImpl implements PostService {
	
	// MyBatis 매퍼 객체 가져오기 (Spring이 아니므로 Container 사용)
	private PostMapper mapper = MapperContainer.get(PostMapper.class);

	@Override
	public void insertPost(PostDTO dto) throws Exception {
		try {
			// 1. 게시글 저장 (여기서 dto.postId가 생성됨)
            mapper.insertPost(dto);
            
            // 2. 파일 목록이 있으면 저장
            List<FileAtDTO> files = dto.getFileList();
            if(files != null && !files.isEmpty()) {
                for(FileAtDTO fileDto : files) {
                    // 게시글 ID 연결
                    fileDto.setPostId(dto.getPostId());
                    // DB 저장
                    mapper.insertFileAt(fileDto);
                }
            }
			
			
			
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