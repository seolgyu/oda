package com.hs.service;

import java.util.List;
import java.util.Map;

import com.hs.model.CommentDTO;
import com.hs.model.PostDTO;

public interface PostService {
	
	public void insertPost(PostDTO dto) throws Exception;
	public void updatePost(PostDTO dto) throws Exception;
	public void deletePost(long postId) throws Exception;
	public PostDTO findById(long postId);
	public List<PostDTO> listPost();
	public List<PostDTO> listPostMain(Map<String, Object> map);
    List<CommentDTO> listComment(long postId, long currentUserNum);
    void insertComment(CommentDTO dto) throws Exception;
    void updateComment(CommentDTO dto) throws Exception;
    void deleteComment(long commentId, long userNum) throws Exception;
    boolean insertPostLike(long postId, long userNum) throws Exception;
    boolean insertCommentLike(long commentId, long userNum) throws Exception;
    int countPostLike(long postId);
    int countCommentLike(long commentId) throws Exception;
    boolean isLiked(long postId, long userNum);
    void deleteFileAt(long fileAtId) throws Exception;
}