package com.hs.model;

public class FollowDTO {
	private long followId;
	private long reqId; //요청 user_num
	private long addId; //받는 user_num
	private int count;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
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
}
