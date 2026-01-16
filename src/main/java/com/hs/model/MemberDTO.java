package com.hs.model;

public class MemberDTO {
   private Long userIdx;
   private String userId;
   private String userPwd;
   private String userName;
   private String userNickname;
   private int userLevel;
   private String createdDate;
   private String updatedDate;
   private String lastLoginDate;
   private String birth;
   private String email;
   private String addr1;
   private String addr2;
   private String tel;
   private String profile_photo;
   private String banner_photo;
   private int status;
   private String zip;
   
   private int postCount;
   private int replyCount;
   private int totalContribution;
   
   public int getPostCount() {
	return postCount;
}
   public void setPostCount(int postCount) {
	this.postCount = postCount;
   }
   public int getReplyCount() {
	return replyCount;
   }
   public void setReplyCount(int replyCount) {
	this.replyCount = replyCount;
   }
   public Long getUserIdx() {
      return userIdx;
   }
   public void setUserIdx(Long userIdx) {
      this.userIdx = userIdx;
   }
   public String getUserId() {
      return userId;
   }
   public void setUserId(String userId) {
      this.userId = userId;
   }
   public String getUserPwd() {
      return userPwd;
   }
   public void setUserPwd(String userPwd) {
      this.userPwd = userPwd;
   }
   public String getUserName() {
      return userName;
   }
   public void setUserName(String userName) {
      this.userName = userName;
   }
   public String getUserNickname() {
      return userNickname;
   }
   public void setUserNickname(String userNickname) {
      this.userNickname = userNickname;
   }
   public int getUserLevel() {
      return userLevel;
   }
   public void setUserLevel(int userLevel) {
      this.userLevel = userLevel;
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
   public String getLastLoginDate() {
      return lastLoginDate;
   }
   public void setLastLoginDate(String lastLoginDate) {
      this.lastLoginDate = lastLoginDate;
   }
   public String getBirth() {
      return birth;
   }
   public void setBirth(String birth) {
      this.birth = birth;
   }
   public String getEmail() {
      return email;
   }
   public void setEmail(String email) {
      this.email = email;
   }
   public String getAddr1() {
      return addr1;
   }
   public void setAddr1(String addr1) {
      this.addr1 = addr1;
   }
   public String getAddr2() {
      return addr2;
   }
   public void setAddr2(String addr2) {
      this.addr2 = addr2;
   }
   public String getTel() {
      return tel;
   }
   public void setTel(String tel) {
      this.tel = tel;
   }
   public String getProfile_photo() {
      return profile_photo;
   }
   public void setProfile_photo(String profile_photo) {
      this.profile_photo = profile_photo;
   }
   public String getBanner_photo() {
      return banner_photo;
   }
   public void setBanner_photo(String banner_photo) {
      this.banner_photo = banner_photo;
   }
   public int getStatus() {
      return status;
   }
   public void setStatus(int status) {
      this.status = status;
   }
   public String getZip() {
	return zip;
   }
   public void setZip(String zip) {
	this.zip = zip;
   }
   public int getTotalContribution() {
	return totalContribution;
   }
   public void setTotalContribution(int totalContribution) {
	this.totalContribution = totalContribution;
   }
   
}
