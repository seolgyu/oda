package com.hs.mapper;

import java.util.List;

import com.hs.model.FileAtDTO;
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

	public void insertFileAt(FileAtDTO fileDto) throws Exception;

	// 조회수 증가
	public void updateHitCount(long postId) throws Exception;

	// 해당 게시글의 첨부파일 목록 조회
	public List<FileAtDTO> listFileAt(long postId);
}