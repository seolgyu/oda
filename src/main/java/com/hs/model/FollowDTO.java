package com.hs.model;

public class FollowDTO {
	private long followId;
	private long reqId; //요청 user_num
	private long addId; //받는 user_num
	private String registerDate;
	
	private boolean followStatus; // 팔로잉 상태
	
	private String userId;
	private String userNickname;
	private String userProfile;
	
	public long getFollowId() {
		return followId;
	}
	public void setFollowId(long followId) {
		this.followId = followId;
	}
	public long getReqId() {
		return reqId;
	}
	public void setReqId(long reqId) {
		this.reqId = reqId;
	}
	public long getAddId() {
		return addId;
	}
	public void setAddId(long addId) {
		this.addId = addId;
	}
	public String getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}
	public boolean isFollowStatus() {
		return followStatus;
	}
	public void setFollowStatus(boolean followStatus) {
		this.followStatus = followStatus;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public String getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(String userProfile) {
		this.userProfile = userProfile;
	}
}
