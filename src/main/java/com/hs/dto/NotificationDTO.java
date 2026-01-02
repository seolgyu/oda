package com.hs.dto;

import java.util.Date;

public class NotificationDTO {
	private Long notificationId; // PK
	private Long userId; // 수신자
	private String type; // COMMENT, LIKE...
	private String content;
	private String relatedType; // POST, COMMENT...
	private Long relatedId;
	private String isRead; // '0', '1'
	private Date createdAt;

	public Long getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(Long notificationId) {
		this.notificationId = notificationId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
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

	public String getRelatedType() {
		return relatedType;
	}

	public void setRelatedType(String relatedType) {
		this.relatedType = relatedType;
	}

	public Long getRelatedId() {
		return relatedId;
	}

	public void setRelatedId(Long relatedId) {
		this.relatedId = relatedId;
	}

	public String getIsRead() {
		return isRead;
	}

	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

}