package com.hs.model;

public class ReplyDTO {
	private Long postId;
	private Long commentId;
	private Long userNum;
	private String content;
	private String createdDate;
	private int depth;
	private Long parentCommentId;
	private Long parentUserNum;
	private String parentUserNickname;
	private String parentCommentContent;
	private String parentCommentCreatedDate;
	private String parentThumbnail;
	
	private PostDTO item;
	
	public Long getPostId() {
		return postId;
	}
	public void setPostId(Long postId) {
		this.postId = postId;
	}
	public Long getCommentId() {
		return commentId;
	}
	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}
	public Long getUserNum() {
		return userNum;
	}
	public void setUserNum(Long userNum) {
		this.userNum = userNum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public Long getParentCommentId() {
		return parentCommentId;
	}
	public void setParentCommentId(Long parentCommentId) {
		this.parentCommentId = parentCommentId;
	}
	public Long getParentUserNum() {
		return parentUserNum;
	}
	public void setParentUserNum(Long parentUserNum) {
		this.parentUserNum = parentUserNum;
	}
	public String getParentCommentContent() {
		return parentCommentContent;
	}
	public void setParentCommentContent(String parentCommentContent) {
		this.parentCommentContent = parentCommentContent;
	}
	public String getParentCommentCreatedDate() {
		return parentCommentCreatedDate;
	}
	public void setParentCommentCreatedDate(String parentCommentCreatedDate) {
		this.parentCommentCreatedDate = parentCommentCreatedDate;
	}
	public PostDTO getItem() {
		return item;
	}
	public void setItem(PostDTO item) {
		this.item = item;
	}
	public String getParentThumbnail() {
		return parentThumbnail;
	}
	public void setParentThumbnail(String parentThumbnail) {
		this.parentThumbnail = parentThumbnail;
	}
	public String getParentUserNickname() {
		return parentUserNickname;
	}
	public void setParentUserNickname(String parentUserNickname) {
		this.parentUserNickname = parentUserNickname;
	}
	
}
