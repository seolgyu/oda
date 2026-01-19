package com.hs.model.admin;

import java.util.List;

import com.hs.util.MyMultipartFile;

public class NoticeDTO {
	private long notice_num;
	private String user_nickname;
	private String state;
	private String noti_title;
	private String noti_content;
	private String noti_reg_date;
	private String update_date;
	private int noti_hitCount;
	private String is_notice;
	private String user_id;
	private Long user_num;
	private int user_level;
	
	private int replyCount;
	private int boardLikeCount;
	
	private List<MyMultipartFile> listFile;
	
	private long fileNum;
	private String saveFilename;
	private String originalFilename;
	private long fileSize;
    
    public List<MyMultipartFile> getListFile() {
		return listFile;
	}
	public void setListFile(List<MyMultipartFile> listFile) {
		this.listFile = listFile;
	}
	public long getFileNum() {
		return fileNum;
	}
	public void setFileNum(long fileNum) {
		this.fileNum = fileNum;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	public Long getUser_num() {
		return user_num;
	}
	public void setUser_num(Long user_num) {
		this.user_num = user_num;
	}
	public long getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(long notice_num) {
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
	public int getNoti_hitCount() {
		return noti_hitCount;
	}
	public void setNoti_hitCount(int noti_hitCount) {
		this.noti_hitCount = noti_hitCount;
	}
	public String getIs_notice() {
		return is_notice;
	}
	public void setIs_notice(String is_notice) {
		this.is_notice = is_notice;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getBoardLikeCount() {
		return boardLikeCount;
	}
	public void setBoardLikeCount(int boardLikeCount) {
		this.boardLikeCount = boardLikeCount;
	}
	public int getUser_level() {
		return user_level;
	}
	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}
}
