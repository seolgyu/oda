package com.hs.model.admin;

public class EventDTO {
	private long user_num; 
	private long event_num;
	private String event_title;
	private String event_content;
	private String start_date;
	private String end_date;
	private int is_active;
	private String created_date;
	private String update_date;
	private String state; // 임시저장, 신고, 정상, 나만보기
	
	// 첨부파일
	private long file_at_id;
	private String file_name;
	private String file_path;
	private long file_size;
	private String file_type;
	private String file_order;
	private String uploaded_date;
	
	// 댓글	
	
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public long getFile_at_id() {
		return file_at_id;
	}
	public void setFile_at_id(long file_at_id) {
		this.file_at_id = file_at_id;
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
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public String getFile_order() {
		return file_order;
	}
	public void setFile_order(String file_order) {
		this.file_order = file_order;
	}
	public String getUploaded_date() {
		return uploaded_date;
	}
	public void setUploaded_date(String uploaded_date) {
		this.uploaded_date = uploaded_date;
	}
	

	
	
}
