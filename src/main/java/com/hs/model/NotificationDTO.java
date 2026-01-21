package com.hs.model;

public class NotificationDTO {
	
	// Notification DB Attributes
	private Long notiId;
	private String type;
	private String content;
	private String target;
	private boolean checked;
	private String createdDate;
	private Long toUserNum;
	private Long fromUserNum;
	
	// 게시글 좋아요 알림
	private MemberDTO toUserInfo;
	private MemberDTO fromUserInfo;
	
	private PostDTO targetPost;
	
	private CommentDTO commentInfo;
	private CommentDTO replyInfo;
	
	// 댓글 알림
	
	// 리포스트 알림
	
	// 신고 알림
	
	public MemberDTO getToUserInfo() {
		return toUserInfo;
	}
	public void setToUserInfo(MemberDTO toUserInfo) {
		this.toUserInfo = toUserInfo;
	}
	public CommentDTO getCommentInfo() {
		return commentInfo;
	}
	public void setCommentInfo(CommentDTO commentInfo) {
		this.commentInfo = commentInfo;
	}
	public CommentDTO getReplyInfo() {
		return replyInfo;
	}
	public void setReplyInfo(CommentDTO replyInfo) {
		this.replyInfo = replyInfo;
	}
	
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
	
	public String getCreatedDate() {
		return com.hs.util.DateUtil.calculateTimeAgo(createdDate);
	}
	public void setCreatedDate(String createdDate) {
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
	public MemberDTO getFromUserInfo() {
		return fromUserInfo;
	}
	public void setFromUserInfo(MemberDTO fromUserInfo) {
		this.fromUserInfo = fromUserInfo;
	}
	public PostDTO getTargetPost() {
		return targetPost;
	}
	public void setTargetPost(PostDTO targetPost) {
		this.targetPost = targetPost;
	}

}