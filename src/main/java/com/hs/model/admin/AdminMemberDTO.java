package com.hs.model.admin;

public class AdminMemberDTO {
	private String user_nickname;
	private String user_id;
	private String user_profile;
	private String user_email;
	private String user_created_date;
	private String user_updated_date;
	private String user_status;
	private int user_count; //전체 조회 건 수
	
	private String user_name;
	private String user_level;
	private int user_num;
	private String user_tel;
	private String user_birth;
	private String last_login_date;
	private int login_count;
	private int posts_count;
	private int replycount;
	private int total_like_count;
	
	private String dayName;
	private int noticeCount;
	private int commentCount;
	
	public String getDayName() {
		return dayName;
	}
	public void setDayName(String dayName) {
		this.dayName = dayName;
	}
	public int getNoticeCount() {
		return noticeCount;
	}
	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public int getUser_count() {
		return user_count;
	}
	public void setUser_count(int user_count) {
		this.user_count = user_count;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_profile() {
		return user_profile;
	}
	public void setUser_profile(String user_profile) {
		this.user_profile = user_profile;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_created_date() {
		return user_created_date;
	}
	public void setUser_created_date(String user_created_date) {
		this.user_created_date = user_created_date;
	}
	public String getUser_updated_date() {
		return user_updated_date;
	}
	public void setUser_updated_date(String user_updated_date) {
		this.user_updated_date = user_updated_date;
	}
	public String getUser_status() {
		return user_status;
	}
	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}
	public String getUser_level() {
		return user_level;
	}
	public void setUser_level(String user_level) {
		this.user_level = user_level;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}
	public String getLast_login_date() {
		return last_login_date;
	}
	public void setLast_login_date(String last_login_date) {
		this.last_login_date = last_login_date;
	}
	public int getLogin_count() {
		return login_count;
	}
	public void setLogin_count(int login_count) {
		this.login_count = login_count;
	}
	public int getPosts_count() {
		return posts_count;
	}
	public void setPosts_count(int posts_count) {
		this.posts_count = posts_count;
	}
	public int getReplycount() {
		return replycount;
	}
	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}
	public int getTotal_like_count() {
		return total_like_count;
	}
	public void setTotal_like_count(int total_like_count) {
		this.total_like_count = total_like_count;
	}
}
