package com.hs.model;

import java.util.Date;

public class CommunityDTO {
	private Long community_id; // PK
	private String com_name;
	private String com_description; // CLOB
	private String category_id;
	private String category_name;
	private String icon_image;
	private String banner_image;
	private String is_private; // '0' or '1'
	private int today_visit;
	private int total_visit;
	private Long member_count;
	private Long post_count;
	private Long user_num; // FK (User)
	private Date created_date;
	private Date favorites_date;
	private Date follow_date;

	// 조인용 필드 (화면 표시용)
	private String creatorNickname;

	public Long getCommunity_id() {
		return community_id;
	}

	public void setCommunity_id(Long community_id) {
		this.community_id = community_id;
	}

	public String getCom_name() {
		return com_name;
	}

	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}

	public String getCom_description() {
		return com_description;
	}

	public void setCom_description(String com_description) {
		this.com_description = com_description;
	}

	public String getCategory_id() {
		return category_id;
	}

	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getIcon_image() {
		return icon_image;
	}

	public void setIcon_image(String icon_image) {
		this.icon_image = icon_image;
	}

	public String getBanner_image() {
		return banner_image;
	}

	public void setBanner_image(String banner_image) {
		this.banner_image = banner_image;
	}

	public String getIs_private() {
		return is_private;
	}

	public void setIs_private(String is_private) {
		this.is_private = is_private;
	}

	public Long getMember_count() {
		return member_count;
	}

	public void setMember_count(Long member_count) {
		this.member_count = member_count;
	}

	public Long getPost_count() {
		return post_count;
	}

	public void setPost_count(Long post_count) {
		this.post_count = post_count;
	}

	public Long getUser_num() {
		return user_num;
	}

	public void setUser_num(Long user_num) {
		this.user_num = user_num;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

	public String getCreatorNickname() {
		return creatorNickname;
	}

	public void setCreatorNickname(String creatorNickname) {
		this.creatorNickname = creatorNickname;
	}

	public int getToday_visit() {
		return today_visit;
	}

	public void setToday_visit(int today_visit) {
		this.today_visit = today_visit;
	}

	public int getTotal_visit() {
		return total_visit;
	}

	public void setTotal_visit(int total_visit) {
		this.total_visit = total_visit;
	}

	public Date getFavorites_date() {
		return favorites_date;
	}

	public void setFavorites_date(Date favorites_date) {
		this.favorites_date = favorites_date;
	}

	public Date getFollow_date() {
		return follow_date;
	}

	public void setFollow_date(Date follow_date) {
		this.follow_date = follow_date;
	}

	

}
