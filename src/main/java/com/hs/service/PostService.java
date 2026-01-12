package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.model.CommentDTO;
import com.hs.model.PostDTO;

public interface PostService {
	// 게시글 등록
	public void insertPost(PostDTO dto) throws Exception;
	
	// 게시글 수정
	public void updatePost(PostDTO dto) throws Exception;
	
	// 게시글 상세 조회 (PK로 찾기)
	public PostDTO findById(long postId);
	
	// 게시글 리스트
	public List<PostDTO> listPost();
	
	public List<PostDTO> listPostMain(Map<String, Object> map);
	
	// [게시글]
    // 좋아요 토글 (리턴: true=좋아요 됨, false=취소됨)
    boolean insertPostLike(long postId, long userNum) throws Exception;
    
    // [댓글]
    void insertComment(CommentDTO dto) throws Exception;
    List<CommentDTO> listComment(long postId, long currentUserNum); // 로그인한 유저 정보도 필요(좋아요 여부 확인용)
    void deleteComment(long commentId) throws Exception;
    
    // [댓글 좋아요]
    boolean insertCommentLike(long commentId, long userNum) throws Exception;
    int countPostLike(long postId);
    int countCommentLike(long commentId) throws Exception;

    boolean isLiked(long postId, long userNum);

	
	
	
	
	
}