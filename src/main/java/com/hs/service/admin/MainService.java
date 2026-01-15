package com.hs.service.admin;

import java.util.List;

import com.hs.model.admin.MainDTO;

public interface MainService {
	public List<MainDTO> memberCountList();
	public MainDTO memberDayCountList();
	public MainDTO memberInCount();
	public MainDTO memberDrewCount();
	public MainDTO memberDorCount();
	public MainDTO postCount();
	public MainDTO memberDorExpcount();
	public MainDTO recentpostcount();
	public MainDTO comCount();
	public MainDTO comDayCount();
	public List<MainDTO> selectWeeklyStats();
	public MainDTO reportPosts();
	public MainDTO reportpostcount();
	public MainDTO comPriCount();
	public MainDTO loginPercentage();
	public MainDTO stopMemberCount();
}

