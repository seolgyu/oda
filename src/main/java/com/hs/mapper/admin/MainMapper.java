package com.hs.mapper.admin;

import java.util.List;

import com.hs.model.admin.MainDTO;

public interface MainMapper {
	public List<MainDTO> memberCountList();
	public MainDTO memberDayCountList();
	public MainDTO memberInCount();
	public MainDTO memberDrewCount();
	public MainDTO memberDorCount();
	public MainDTO postCount();
	public MainDTO memberDorExpcount();
	public MainDTO recentPostCount();
	public MainDTO communityCount();
	public MainDTO communityDayCount();
	public List<MainDTO> selectWeeklyStats();
	public MainDTO reportPosts();
	public MainDTO reportpostcount();
	public MainDTO comPriCount();
}
