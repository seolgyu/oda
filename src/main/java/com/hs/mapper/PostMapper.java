package com.hs.mapper;

import java.util.List;
import java.util.Map;

import com.hs.model.CommentDTO;
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

	public List<PostDTO> listPostMain(Map<String, Object> map);

	// [1] 게시글 좋아요
	void insertPostLike(Map<String, Object> map) throws Exception;

	void deletePostLike(Map<String, Object> map) throws Exception;

	int countPostLike(long postId) throws Exception;

	// 게시글 테이블의 like_count 컬럼 업데이트 (성능 최적화)
	void updatePostLikeCount(long postId) throws Exception;

	// 내가 좋아요 눌렀는지 확인
	int checkPostLiked(Map<String, Object> map) throws Exception;

	// [2] 댓글 (Comment)
	void insertComment(CommentDTO dto) throws Exception;

	void deleteComment(long commentId) throws Exception;

	// 댓글 리스트 (로그인 유저 번호를 같이 넘겨서 좋아요 여부 확인)
	List<CommentDTO> listComment(Map<String, Object> map) throws Exception;

	// [3] 댓글 좋아요
	void insertCommentLike(Map<String, Object> map) throws Exception;

	void deleteCommentLike(Map<String, Object> map) throws Exception;

	int countCommentLike(long commentId) throws Exception;
	
	int checkCommentLiked(Map<String, Object> map) throws Exception;
}