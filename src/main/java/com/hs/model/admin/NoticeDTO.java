package com.hs.model.admin;

public class NoticeDTO {
	private int notice_num;
	private String user_nickname;
	private String state;
	private String noti_title;
	private String noti_content;
	private String noti_reg_date;
	private String update_date;
	private int hitCount;
	private String is_notice;
	
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getNoti_title() {
		return noti_title;
	}
	public void setNoti_title(String noti_title) {
		this.noti_title = noti_title;
	}
	public String getNoti_content() {
		return noti_content;
	}
	public void setNoti_content(String noti_content) {
		this.noti_content = noti_content;
	}
	public String getNoti_reg_date() {
		return noti_reg_date;
	}
	public void setNoti_reg_date(String noti_reg_date) {
		this.noti_reg_date = noti_reg_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getIs_notice() {
		return is_notice;
	}
	public void setIs_notice(String is_notice) {
		this.is_notice = is_notice;
	}
}
