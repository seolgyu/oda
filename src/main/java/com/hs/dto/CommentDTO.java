package com.hs.dto;

import java.util.Date;

public class CommentDTO {
	private Long commentId; // PK
	private Long postId; // FK
	private Long authorId; // FK
	private Long parentCommentId; // FK (대댓글)
	private String content; // CLOB
	private Long likeCount;
	private String isDeleted;
	private Date createdAt;
	private Date updatedAt;

	// 조인용 필드
	private String authorNickname;
	private String authorProfileImage;
	private int depth; // depth = 0: 원본 댓글 (들여쓰기 없음) depth = 1: 댓글의 댓글 (한 번 들여쓰기)

	public Long getCommentId() {
		return commentId;
	}

	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}

	public Long getPostId() {
		return postId;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}

	public Long getAuthorId() {
		return authorId;
	}

	public void setAuthorId(Long authorId) {
		this.authorId = authorId;
	}

	public Long getParentCommentId() {
		return parentCommentId;
	}

	public void setParentCommentId(Long parentCommentId) {
		this.parentCommentId = parentCommentId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(Long likeCount) {
		this.likeCount = likeCount;
	}

	public String getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getAuthorNickname() {
		return authorNickname;
	}

	public void setAuthorNickname(String authorNickname) {
		this.authorNickname = authorNickname;
	}

	public String getAuthorProfileImage() {
		return authorProfileImage;
	}

	public void setAuthorProfileImage(String authorProfileImage) {
		this.authorProfileImage = authorProfileImage;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

}
