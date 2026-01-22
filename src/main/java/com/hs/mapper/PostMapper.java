package com.hs.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hs.model.CommentDTO;
import com.hs.model.FileAtDTO;
import com.hs.model.PostDTO;
import com.hs.model.ReportDTO;

public interface PostMapper {

	public void insertPost(PostDTO dto) throws Exception;
	public void updatePost(PostDTO dto) throws Exception;
	public void deletePost(long postId) throws Exception;
	public PostDTO findById(long postId);
	public List<PostDTO> listPost();
	
	public List<PostDTO> listUserPost(Map<String, Object> map) throws SQLException;
	public List<PostDTO> listUserRepost(Map<String, Object> map) throws SQLException;
	
	public void insertFileAt(FileAtDTO fileDto) throws Exception;
	public void updateHitCount(long postId) throws Exception;
	public List<FileAtDTO> listFileAt(long postId);
	public List<PostDTO> listPostMain(Map<String, Object> map);
	void insertPostLike(Map<String, Object> map) throws Exception;
	void deletePostLike(Map<String, Object> map) throws Exception;
	int countPostLike(long postId) throws Exception;
	void updatePostLikeCount(long postId) throws Exception;
	int checkPostLiked(Map<String, Object> map) throws Exception;
	void insertComment(CommentDTO dto) throws Exception;
	void deleteComment(long commentId) throws Exception;
	void updateComment(CommentDTO dto) throws Exception;
	List<CommentDTO> listComment(Map<String, Object> map) throws Exception;
	void insertCommentLike(Map<String, Object> map) throws Exception;
	void deleteCommentLike(Map<String, Object> map) throws Exception;
	int countCommentLike(long commentId) throws Exception;
	int checkCommentLiked(Map<String, Object> map) throws Exception;
	void deleteFileAt(long fileAtId) throws Exception;
	public void updatePostCommentCount(long postId) throws Exception;
	public long getPostIdByCommentId(long commentId);
	public void insertReport(ReportDTO dto) throws Exception;
    public void updatePostReportCount(long postId) throws Exception;
    public int checkReportHistory(Map<String, Object> map);
	public PostDTO findTempPost(long userNum);
	public List<PostDTO> listCommunityPost(Map<String, Object> map);
	public int checkPostSaved(Map<String, Object> map) throws Exception;
	public void insertPostSave(Map<String, Object> map) throws Exception;
	public void deletePostSave(Map<String, Object> map) throws Exception;
	public int checkPostReposted(Map<String, Object> map) throws Exception;
	public void insertPostRepost(Map<String, Object> map) throws Exception;
	public void deletePostRepost(Map<String, Object> map) throws Exception;
	public List<PostDTO> listSavedPost(Map<String, Object> map);
    public List<PostDTO> listRepostedPost(Map<String, Object> map);
    
    public Long getPostAuthorNum(Long postId) throws Exception;
    public Long getComId(Long postId) throws Exception;
    public Long getCommentWriterNum(Long commentId) throws Exception;
    
    public CommentDTO getCommentInfo(Long commentId) throws Exception;
}