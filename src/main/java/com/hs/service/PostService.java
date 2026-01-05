package com.hs.service;

import java.util.List;

import com.hs.model.PostDTO;

public interface PostService {
	// 게시글 등록
	public void insertPost(PostDTO dto) throws Exception;
	
	// 게시글 수정
	public void updatePost(PostDTO dto) throws Exception;
	
	// 게시글 상세 조회 (PK로 찾기)
	public PostDTO findById(long postId);
	
	public List<PostDTO> listPost();
}