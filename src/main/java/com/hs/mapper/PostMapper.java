package com.hs.mapper;

import java.util.List;

import com.hs.model.PostDTO;

public interface PostMapper {
	// 게시글 등록
	public void insertPost(PostDTO dto) throws Exception;
	
	// 게시글 수정
	public void updatePost(PostDTO dto) throws Exception;
	
	// 게시글 조회 (수정 폼 불러오기용)
	public PostDTO findById(long postId);
	
	// 목록 조회 추가
	public List<PostDTO> listPost();
}