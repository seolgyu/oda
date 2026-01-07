package com.hs.service.admin;

import java.util.List;
import java.util.Map;

import com.hs.mapper.admin.NoticeMapper;
import com.hs.model.admin.NoticeDTO;
import com.hs.mybatis.support.MapperContainer;

public class NoticeServiceImpl implements NoticeService{
	private NoticeMapper mapper = MapperContainer.get(NoticeMapper.class);
	

	@Override
	public List<NoticeDTO> noticeListTop() {
		List<NoticeDTO> list = null;

		try {
			list = mapper.noticeListTop();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public List<NoticeDTO> noticeList(Map<String, Object> map) {
		List<NoticeDTO> list = null;
		
		try {
			list = mapper.noticeList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
