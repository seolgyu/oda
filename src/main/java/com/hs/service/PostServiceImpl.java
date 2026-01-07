package com.hs.service;

import java.util.List;

import com.hs.mapper.PostMapper;
import com.hs.model.FileAtDTO;
import com.hs.model.PostDTO;
import com.hs.mybatis.support.MapperContainer;

public class PostServiceImpl implements PostService {
	
	// MyBatis 매퍼 객체 가져오기
	private PostMapper mapper = MapperContainer.get(PostMapper.class);

	@Override
	public void insertPost(PostDTO dto) throws Exception {
		try {
			// 1. 게시글 저장 (게시글 번호 생성)
			mapper.insertPost(dto);
			
			// 2. 파일이 있다면 파일 테이블에 저장
			List<FileAtDTO> files = dto.getFileList();
			if(files != null && !files.isEmpty()) {
				for(FileAtDTO fileDto : files) {
					fileDto.setPostId(dto.getPostId()); 
					mapper.insertFileAt(fileDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
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
			// 1. 조회수 증가 (상세 보기 시에만 증가)
			mapper.updateHitCount(postId);
			
			// 2. 게시글 상세 정보 가져오기
			dto = mapper.findById(postId);
			
			// 3. 첨부파일 리스트 가져오기 및 DTO에 설정
			if(dto != null) {
				List<FileAtDTO> files = mapper.listFileAt(postId);
				dto.setFileList(files);
			}
			
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