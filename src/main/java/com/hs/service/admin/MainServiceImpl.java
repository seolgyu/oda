package com.hs.service.admin;

import java.util.List;

import com.hs.mapper.admin.MainMapper;

import com.hs.model.admin.MainDTO;
import com.hs.mybatis.support.MapperContainer;

public class MainServiceImpl implements MainService{
	private MainMapper mapper =  MapperContainer.get(MainMapper.class);
	
	@Override
	public List<MainDTO> mainList() {
		List<MainDTO> list = null;
		try {
			list = mapper.mainList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
