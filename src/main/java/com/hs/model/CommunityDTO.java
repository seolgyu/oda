package com.hs.model;

import java.util.Date;

public class CommunityDTO {
	private Long community_id; // PK
	private String com_name;
	private String com_description; // CLOB
	private String community_kate_id;
	private String icon_image;
	private String banner_image;
	private String is_private; // '0' or '1'
	private Long member_count;
	private Long post_count;
	private Long user_num; // FK (User)
	private Date created_date;

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

	public String getCommunity_kate_id() {
		return community_kate_id;
	}

	public void setCommunity_kate_id(String community_kate_id) {
		this.community_kate_id = community_kate_id;
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

	

}
