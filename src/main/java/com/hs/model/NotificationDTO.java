package com.hs.model;

import java.util.Date;

public class NotificationDTO {
	
	// Notification DB Attributes
	private Long notiId;
	private String type;
	private String content;
	private String target;
	private boolean checked;
	private Date createdDate;
	private Long toUserNum;
	private Long fromUserNum;
	
	// 좋아요 알림
	
	// 댓글 알림
	
	// 리포스트 알림
	
	// 신고 알림
	
	public Long getNotiId() {
		return notiId;
	}
	public void setNotiId(Long notiId) {
		this.notiId = notiId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Long getToUserNum() {
		return toUserNum;
	}
	public void setToUserNum(Long toUserNum) {
		this.toUserNum = toUserNum;
	}
	public Long getFromUserNum() {
		return fromUserNum;
	}
	public void setFromUserNum(Long fromUserNum) {
		this.fromUserNum = fromUserNum;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}

}