package com.hs.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class PostDTO {
	private Long postId;
	private Long userNum;
	private Long communityId;
	private String title;
	private String content;
	private String postType;
	private Long viewCount;
	private Long likeCount;
	private Long commentCount;
	private String isDeleted;
	private String createdDate;
	private String updatedDate;
	private String state;
	private String replyEnabled;
	private String showCounts;
	private List<FileAtDTO> fileList;
	private String thumbnail;
	private boolean likedByUser;

	// 조인용 필드 (작성자 닉네임 등)
	private String authorNickname;
	private String authorProfileImage;

	public Long getPostId() {
		return postId;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}

	public Long getUserNum() {
		return userNum;
	}

	public void setUserNum(Long userNum) {
		this.userNum = userNum;
	}

	public Long getCommunityId() {
		return communityId;
	}

	public void setCommunityId(Long communityId) {
		this.communityId = communityId;
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

	public Long getViewCount() {
		return viewCount;
	}

	public void setViewCount(Long viewCount) {
		this.viewCount = viewCount;
	}

	public Long getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(Long likeCount) {
		this.likeCount = likeCount;
	}

	public Long getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(Long commentCount) {
		this.commentCount = commentCount;
	}

	public String getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getAuthorNickname() {
		return authorNickname;
	}

	public void setAuthorNickname(String authorNickname) {
		this.authorNickname = authorNickname;
	}

	public String getAuthorProfileImage() {
		return authorProfileImage;
	}

	public void setAuthorProfileImage(String authorProfileImage) {
		this.authorProfileImage = authorProfileImage;
	}

	public String getReplyEnabled() {
		return replyEnabled;
	}

	public void setReplyEnabled(String replyEnabled) {
		this.replyEnabled = replyEnabled;
	}

	public String getShowCounts() {
		return showCounts;
	}

	public void setShowCounts(String showCounts) {
		this.showCounts = showCounts;
	}

	public List<FileAtDTO> getFileList() {
		return fileList;
	}

	public void setFileList(List<FileAtDTO> fileList) {
		this.fileList = fileList;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public boolean isLikedByUser() {
		return likedByUser;
	}

	public void setLikedByUser(boolean likedByUser) {
		this.likedByUser = likedByUser;
	}

	// 1. "n시간 전" 계산 로직
	public String getTimeAgo() {
		if (this.createdDate == null)
			return "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			// DB에서 TO_CHAR로 가져온 문자열을 날짜 객체로 변환
			Date date = sdf.parse(this.createdDate);
			long diff = new Date().getTime() - date.getTime();

			long hours = diff / (60 * 60 * 1000);
			long days = hours / 24;

			if (days == 0) {
				if (hours == 0) {
					long minutes = diff / (60 * 1000);
					if (minutes < 1)
						return "방금 전";
					return minutes + "분 전";
				}
				return hours + "시간 전";
			} else if (days < 7) {
				return days + "일 전";
			} else {
				return this.createdDate.substring(0, 10); // 2026-01-09 만 리턴
			}
		} catch (Exception e) {
			return this.createdDate; // 에러나면 그냥 원본 리턴
		}
	}

	// 2. 상세보기용 날짜 포맷팅 (초 단위 자르기)
	public String getDetailDate() {
		if (this.createdDate == null || this.createdDate.length() < 16)
			return this.createdDate;
		return this.createdDate.substring(0, 16); // "2026-01-09 17:25" 까지만 자름
	}

}
