package com.hs.model;

public class NotificationOptionDTO {

	private Long userNum;
	private boolean allowLike;
	private boolean allowComment;
	private boolean allowRepost;
	private boolean allowFollow;
	private boolean allowNotice;
	private boolean allowEvent;
	private String updatedDate;
	
	public Long getUserNum() {
		return userNum;
	}
	public void setUserNum(Long userNum) {
		this.userNum = userNum;
	}
	public boolean isAllowLike() {
		return allowLike;
	}
	public void setAllowLike(boolean allowLike) {
		this.allowLike = allowLike;
	}
	public boolean isAllowComment() {
		return allowComment;
	}
	public void setAllowComment(boolean allowComment) {
		this.allowComment = allowComment;
	}
	public boolean isAllowRepost() {
		return allowRepost;
	}
	public void setAllowRepost(boolean allowRepost) {
		this.allowRepost = allowRepost;
	}
	public boolean isAllowFollow() {
		return allowFollow;
	}
	public void setAllowFollow(boolean allowFollow) {
		this.allowFollow = allowFollow;
	}
	public boolean isAllowNotice() {
		return allowNotice;
	}
	public void setAllowNotice(boolean allowNotice) {
		this.allowNotice = allowNotice;
	}
	public boolean isAllowEvent() {
		return allowEvent;
	}
	public void setAllowEvent(boolean allowEvent) {
		this.allowEvent = allowEvent;
	}
	public String getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}
	
}
