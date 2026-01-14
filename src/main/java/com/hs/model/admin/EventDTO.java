package com.hs.model.admin;

import java.util.List;

import com.hs.util.MyMultipartFile;

public class EventDTO {
	private long user_num;
	private long event_num;
	private int events;
	private String event_title;
	private String event_content;
	private String start_date;
	private String end_date;
	private int is_active; // 강제종료
	private String active_status; // 진행, 진행예정, 종료 담는 가성 컬럼
	private String created_date;
	private String update_date;
	private int ev_hitcount;
	private int showEvent;
	private String user_name;

	private List<MyMultipartFile> listFile;
	
	// 첨부파일
	private long file_at_id;
	private String file_name;
	private String file_path;
	private long file_size;	
	
	public long getUser_num() {
		return user_num;
	}
	public void setUser_num(long user_num) {
		this.user_num = user_num;
	}
	public long getEvent_num() {
		return event_num;
	}
	public void setEvent_num(long event_num) {
		this.event_num = event_num;
	}
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public String getEvent_content() {
		return event_content;
	}
	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public int getIs_active() {
		return is_active;
	}
	public void setIs_active(int is_active) {
		this.is_active = is_active;
	}
	public String getActive_status() {
		return active_status;
	}
	public void setActive_status(String active_status) {
		this.active_status = active_status;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	public int getShowEvent() {
		return showEvent;
	}
	public void setShowEvent(int showEvent) {
		this.showEvent = showEvent;
	}

	public List<MyMultipartFile> getListFile() {
		return listFile;
	}
	public void setListFile(List<MyMultipartFile> listFile) {
		this.listFile = listFile;
	}
	public long getFile_at_id() {
		return file_at_id;
	}
	public void setFile_at_id(long file_at_id) {
		this.file_at_id = file_at_id;
	}

	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public int getEvents() {
		return events;
	}
	public void setEvents(int events) {
		this.events = events;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getEv_hitcount() {
		return ev_hitcount;
	}
	public void setEv_hitcount(int ev_hitcount) {
		this.ev_hitcount = ev_hitcount;
	}

}
