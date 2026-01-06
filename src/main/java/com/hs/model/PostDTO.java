package com.hs.model;

import java.util.List;

public class PostDTO {
	private Long postId;
	private Long userNum;     
	private Long communityId;
	private String title;
	private String content;
	private String postType;
	private Long viewCount;
	private Long likeCount;
	private Long commentCount;
	private String isDeleted;
	private String createdDate; 
	
	private String updatedDate;
	private String state;      
	private String replyEnabled; 
	private String showCounts;   

	private List<FileAtDTO> fileList;

	// 조인용 필드 (작성자 닉네임 등)
	private String authorNickname;
	private String authorProfileImage;
	
	public Long getPostId() {
		return postId;
	}
	public void setPostId(Long postId) {
		this.postId = postId;
	}
	public Long getUserNum() {
		return userNum;
	}
	public void setUserNum(Long userNum) {
		this.userNum = userNum;
	}
	public Long getCommunityId() {
		return communityId;
	}
	public void setCommunityId(Long communityId) {
		this.communityId = communityId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	public Long getViewCount() {
		return viewCount;
	}
	public void setViewCount(Long viewCount) {
		this.viewCount = viewCount;
	}
	public Long getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(Long likeCount) {
		this.likeCount = likeCount;
	}
	public Long getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(Long commentCount) {
		this.commentCount = commentCount;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
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
	public String getReplyEnabled() {
		return replyEnabled;
	}
	public void setReplyEnabled(String replyEnabled) {
		this.replyEnabled = replyEnabled;
	}
	public String getShowCounts() {
		return showCounts;
	}
	public void setShowCounts(String showCounts) {
		this.showCounts = showCounts;
	}
	public List<FileAtDTO> getFileList() {
		return fileList;
	}
	public void setFileList(List<FileAtDTO> fileList) {
		this.fileList = fileList;
	}

}
