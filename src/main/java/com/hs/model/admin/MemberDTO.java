package com.hs.model.admin;

public class MemberDTO {
	private String user_nickname;
	private String user_id;
	private String user_profile;
	private String user_email;
	private String user_created_date;
	private String user_updated_date;
	private String user_status;
	private int user_count; //전체 조회 건 수 
	
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
}
