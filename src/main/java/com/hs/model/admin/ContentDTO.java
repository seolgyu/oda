package com.hs.model.admin;

public class ContentDTO {
	private int postAllCount;
	private int postNormalCount;
	private int postDeclaCount;
	private int postProCount;
	private int countDto;
	
	private String postId;
	private String userNickname;
	private String title;
	private String content;
	private String postType;
	private String createdDate;
	private String state;
	private String postsUrl;
	
	public String getPostsUrl() {
		return postsUrl;
	}
	public void setPostsUrl(String postsUrl) {
		this.postsUrl = postsUrl;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
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
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}	
	public int getCountDto() {
		return countDto;
	}
	public void setCountDto(int countDto) {
		this.countDto = countDto;
	}
	public int getPostAllCount() {
		return postAllCount;
	}
	public void setPostAllCount(int postAllCount) {
		this.postAllCount = postAllCount;
	}
	public int getPostNormalCount() {
		return postNormalCount;
	}
	public void setPostNormalCount(int postNormalCount) {
		this.postNormalCount = postNormalCount;
	}
	public int getPostDeclaCount() {
		return postDeclaCount;
	}
	public void setPostDeclaCount(int postDeclaCount) {
		this.postDeclaCount = postDeclaCount;
	}
	public int getPostProCount() {
		return postProCount;
	}
	public void setPostProCount(int postProCount) {
		this.postProCount = postProCount;
	}
}
