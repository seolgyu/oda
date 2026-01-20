package com.hs.model.admin;

public class EventReplyDTO {
	private long comment_id;
	private long event_num;
	private String user_id;
	private String user_nickname;
	private long user_num;
	private String userName;
	private String userLevel;
	private String content;
	private String created_date;
	private int hitCount;
	private long parent_comment_id;
	private int replyLike;
	private int showReply;
	private int block;
	private String profile_photo;
	
	private int answerCount;
	private int likeCount;
	private int userLikedReply;
	
	
	public long getComment_id() {
		return comment_id;
	}
	public void setComment_id(long getComment_id) {
		this.comment_id = getComment_id;
	}
	public long getEvent_num() {
		return event_num;
	}
	public void setEvent_num(long event_num) {
		this.event_num = event_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public long getParent_comment_id() {
		return parent_comment_id;
	}
	public void setParent_comment_id(long parent_comment_id) {
		this.parent_comment_id = parent_comment_id;
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
	public long getUser_num() {
		return user_num;
	}
	public void setUser_num(long user_num) {
		this.user_num = user_num;
	}
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	
	
	
}
