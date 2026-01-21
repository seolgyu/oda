package com.hs.service.admin;

import java.util.List;

import com.hs.mapper.admin.MainMapper;

import com.hs.model.admin.MainDTO;
import com.hs.mybatis.support.MapperContainer;

public class MainServiceImpl implements MainService{
	private MainMapper mapper =  MapperContainer.get(MainMapper.class);
	
	@Override
	public List<MainDTO> memberCountList() {
		List<MainDTO> list = null;
		try {
			list = mapper.memberCountList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public MainDTO memberDayCountList() {
		MainDTO dayDto = null;
		try {
			dayDto = mapper.memberDayCountList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dayDto;
	}

	@Override
	public MainDTO memberInCount() {
		MainDTO inDto = null;
		try {
			inDto = mapper.memberInCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return inDto;
	}

	@Override
	public MainDTO memberDrewCount() {
		MainDTO drewDto = null;
		try {
			drewDto = mapper.memberDrewCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return drewDto;
	}

	@Override
	public MainDTO memberDorCount() {
		MainDTO berDto = null;
		try {
			berDto = mapper.memberDorCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return berDto;
	}

	@Override
	public MainDTO postCount() {
		MainDTO postDto = null;
		try {
			postDto = mapper.postCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postDto;
	}

	@Override
	public MainDTO memberDorExpcount() {
		MainDTO dorExpDto = null;
		try {
			dorExpDto = mapper.memberDorExpcount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dorExpDto;
	}

	@Override
	public MainDTO recentpostcount() {
		MainDTO recentDto = null;
		try {
			recentDto = mapper.recentPostCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return recentDto;
	}

	@Override
	public MainDTO comCount() {
		MainDTO comCount = null;
		try {
			comCount = mapper.communityCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return comCount;
	}

	@Override
	public MainDTO comDayCount() {
		MainDTO comDayCount = null;
		try {
			comDayCount = mapper.communityDayCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return comDayCount;
	}

	@Override
	public List<MainDTO> selectWeeklyStats() {
		List<MainDTO> chartLits = null;
		try {
			chartLits = mapper.selectWeeklyStats();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return chartLits;
	}

	@Override
	public MainDTO reportPosts() {
		MainDTO reportPosts = null;
		try {
			reportPosts = mapper.reportPosts();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reportPosts;
	}

	@Override
	public MainDTO reportpostcount() {
		MainDTO reportpostcount = null;
		try {
			reportpostcount = mapper.reportpostcount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reportpostcount;
	}

	@Override
	public MainDTO comPriCount() {
		MainDTO comPriCount = null;
		try {
			comPriCount = mapper.comPriCount();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return comPriCount;
	}

	@Override
	public MainDTO loginPercentage() {
		MainDTO loginPercentage = null;
		try {
			loginPercentage = mapper.loginPercentage();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loginPercentage;
	}

	@Override
	public MainDTO stopMemberCount() {
		MainDTO stopmembercount = null;
		try {
			stopmembercount = mapper.stopmembercount();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return stopmembercount;
	}

	@Override
	public List<MainDTO> declList() {
		List<MainDTO> declList = null;
		try {
			declList = mapper.declList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return declList;
	}
	
}
