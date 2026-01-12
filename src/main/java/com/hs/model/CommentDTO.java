package com.hs.model;

public class CommentDTO {
	// 1. COMMENTS 테이블 컬럼 매핑
	private long commentId;
	private long postId;
	private long userNum;
	private String userId; // 테이블의 user_id (작성자 ID)
	private String content;
	private String createdDate; // 포맷팅된 날짜 문자열
	private String updatedDate;
	private long parentCommentId; // 부모 댓글 ID (대댓글일 경우)
	private String isDeleted; // '0': 정상, '1': 삭제됨

	// 2. 화면 표시를 위한 추가 필드 (JOIN으로 가져옴)
	private String userNickName; // 작성자 닉네임
	private String profileImage; // 작성자 프로필 사진

	// 3. 좋아요/대댓글 기능용 필드
	private int likeCount; // 좋아요 개수
	private boolean likedByUser; // 현재 로그인한 유저가 좋아요 눌렀는지 여부

	// Getter & Setter 생성 (필수)
	public long getCommentId() {
		return commentId;
	}

	public void setCommentId(long commentId) {
		this.commentId = commentId;
	}

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public long getUserNum() {
		return userNum;
	}

	public void setUserNum(long userNum) {
		this.userNum = userNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public long getParentCommentId() {
		return parentCommentId;
	}

	public void setParentCommentId(long parentCommentId) {
		this.parentCommentId = parentCommentId;
	}

	public String getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public boolean isLikedByUser() {
		return likedByUser;
	}

	public void setLikedByUser(boolean likedByUser) {
		this.likedByUser = likedByUser;
	}

}