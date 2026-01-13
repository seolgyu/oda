package com.hs.model.admin;

public class EventReplyDTO {
	private long replyNum;
	private long event_num;
	private String userId;
	private String userName;
	private String content;
	private String update;
	private int hitCount;
	private long parentNum;
	private int replyLike;
	private int showReply;
	private int block;
	private String profile_photo;
	
	private int answerCount;
	private int likeCount;
	private int disLikeCount;
	private int userLikedReply;
	
	
	public long getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(long replyNum) {
		this.replyNum = replyNum;
	}
	public long getEvent_num() {
		return event_num;
	}
	public void setEvent_num(long event_num) {
		this.event_num = event_num;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getupdate() {
		return update;
	}
	public void setReg_date(String update) {
		this.update = update;
	}
	public long getParentNum() {
		return parentNum;
	}
	public void setParentNum(long parentNum) {
		this.parentNum = parentNum;
	}
	public int getReplyLike() {
		return replyLike;
	}
	public void setReplyLike(int replyLike) {
		this.replyLike = replyLike;
	}
	public int getShowReply() {
		return showReply;
	}
	public void setShowReply(int showReply) {
		this.showReply = showReply;
	}
	public int getBlock() {
		return block;
	}
	public void setBlock(int block) {
		this.block = block;
	}
	public String getProfile_photo() {
		return profile_photo;
	}
	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
	}
	public int getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getDisLikeCount() {
		return disLikeCount;
	}
	public void setDisLikeCount(int disLikeCount) {
		this.disLikeCount = disLikeCount;
	}
	public int getUserLikedReply() {
		return userLikedReply;
	}
	public void setUserLikedReply(int userLikedReply) {
		this.userLikedReply = userLikedReply;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	
	
	
}
